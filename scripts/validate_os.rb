#!/usr/bin/env ruby

require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).parent.expand_path
errors = []

def relative(path)
  path.relative_path_from(ROOT).to_s
end

begin
  index_path = ROOT.join("OS-INDEX.yaml")
  index = if YAML.respond_to?(:safe_load_file)
            YAML.safe_load_file(index_path, aliases: false)
          else
            YAML.safe_load(File.read(index_path), [], [], false)
          end
rescue StandardError => e
  errors << "OS-INDEX.yaml parse error: #{e.message}"
  index = {}
end

Array(index["boot_sequence"]).each do |entry|
  errors << "Boot path does not exist: #{entry}" unless ROOT.join(entry).exist?
end

Hash(index["revenue_runtime"]).each do |name, entry|
  errors << "Revenue runtime path does not exist (#{name}): #{entry}" unless ROOT.join(entry).exist?
end

["knowledge_refresh", "organizational_learning"].each do |section|
  Hash(index[section]).each do |name, entry|
    next unless entry.is_a?(String) && entry.include?("/")

    errors << "#{section} path does not exist (#{name}): #{entry}" unless ROOT.join(entry).exist?
  end
end

learning = Hash(index["organizational_learning"])
unless learning["status"] == "ACTIVE"
  errors << "OS-INDEX.yaml: organizational_learning must be ACTIVE after DEC-0011 approval"
end

Array(learning["enforcement"]).each do |contract|
  contract = Hash(contract)
  id = contract["id"] || "unnamed"
  source = contract["source"]
  consumer = contract["consumer"]
  marker = contract["marker"]

  errors << "Learning enforcement #{id}: missing source" if source.to_s.empty?
  errors << "Learning enforcement #{id}: missing consumer" if consumer.to_s.empty?
  errors << "Learning enforcement #{id}: missing marker" if marker.to_s.empty?
  next if source.to_s.empty? || consumer.to_s.empty? || marker.to_s.empty?

  source_path = ROOT.join(source)
  consumer_path = ROOT.join(consumer)
  errors << "Learning enforcement #{id}: source does not exist: #{source}" unless source_path.exist?
  errors << "Learning enforcement #{id}: consumer does not exist: #{consumer}" unless consumer_path.exist?
  next unless source_path.exist? && consumer_path.exist?

  unless File.read(consumer_path).include?(marker)
    errors << "Learning enforcement #{id}: consumer missing marker #{marker.inspect}: #{consumer}"
  end
end

expected_journey = [
  "Customer Acquisition",
  "Customer Activation",
  "Customer Conversion",
  "Customer Retention",
  "Customer Referral"
]

unless Array(index["customer_journey"]) == expected_journey
  errors << "OS-INDEX.yaml: customer_journey must preserve the five Revenue First stages"
end

Dir[ROOT.join("**/*.md")].sort.each do |file_name|
  file = Pathname.new(file_name)
  text = File.read(file)

  errors << "#{relative(file)}: missing H1 title" unless text.match?(/\A#\s+\S/)

  text.scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |link|
    next if link.match?(/\A(?:https?:|mailto:|#)/)

    local_path = link.split("#", 2).first
    next if local_path.nil? || local_path.empty?

    target = file.dirname.join(local_path).cleanpath
    errors << "#{relative(file)}: broken link #{link}" unless target.exist?
  end
end

id_files = Dir[ROOT.join("**/{DEC,SOP,WF,AUT}-*.md")]
ids = id_files.group_by do |file_name|
  File.basename(file_name)[/\A(?:DEC|SOP|WF|AUT)-\d+/]
end

ids.each do |id, files|
  next if id.nil? || files.length == 1

  names = files.map { |file| relative(Pathname.new(file)) }.join(", ")
  errors << "Duplicate document ID #{id}: #{names}"
end

contracts = {
  "LEVEL-4_AI-EXECUTION/AGENTS/AGENT-*.md" => {
    exclude: ["AGENT-ARCHITECTURE.md"],
    fields: {
      "Document status" => /-\s*문서 상태:/,
      "Runtime status" => /-\s*Runtime 상태:/,
      "Responsibilities" => /## Responsibilities/i,
      "Inputs" => /## Inputs/i,
      "Outputs" => /## Outputs/i,
      "References" => /## Required References/i,
      "Authority" => /## Authority Boundary/i,
      "Approval" => /## Approval Required/i,
      "Relationships" => /## Relationships and Handoffs/i,
      "Failure" => /## Failure and Escalation/i,
      "Success" => /## Success Measures/i
    }
  },
  "LEVEL-4_AI-EXECUTION/WORKFLOW/WF-*.md" => {
    exclude: [],
    fields: {
      "Status" => /-\s*상태:/,
      "Purpose" => /## (?:목적|Purpose)/i,
      "Trigger" => /## Trigger and Completion/i,
      "SOP reference" => /SOP-\d+/,
      "Knowledge feedback" => /## Knowledge Feedback/i,
      "KPI" => /## KPI/i
    }
  },
  "LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-*.md" => {
    exclude: [],
    fields: {
      "Status" => /-\s*상태:/,
      "Trigger" => /## Trigger/i,
      "Inputs" => /## (?:Inputs|입력)/i,
      "Outputs" => /## (?:Outputs|출력)/i,
      "Approval" => /## (?:Authority and Approval|승인)/i,
      "Failure" => /## (?:Failure|실패)/i,
      "Audit" => /## (?:Audit|보안과 감사)/i
    }
  }
}

contracts.each do |pattern, rule|
  Dir[ROOT.join(pattern)].sort.each do |file_name|
    next if rule[:exclude].include?(File.basename(file_name))

    text = File.read(file_name)
    rule[:fields].each do |field, matcher|
      errors << "#{relative(Pathname.new(file_name))}: missing #{field}" unless text.match?(matcher)
    end
  end
end

Dir[ROOT.join("LEVEL-4_AI-EXECUTION/WORKFLOW/WF-*.md")].sort.each do |file_name|
  text = File.read(file_name)
  next unless text.match?(/-\s*상태:\s*ACTIVE/)

  unless text.include?("Learning-Ref: DEC-0011")
    errors << "#{relative(Pathname.new(file_name))}: ACTIVE Workflow missing DEC-0011 Learning-Ref"
  end
end

Dir[ROOT.join("LEVEL-4_AI-EXECUTION/AGENTS/AGENT-*.md")].sort.each do |file_name|
  next if File.basename(file_name) == "AGENT-ARCHITECTURE.md"

  text = File.read(file_name)
  next unless text.match?(/-\s*Runtime 상태:\s*ACTIVE/)

  unless text.include?("Learning-Ref: DEC-0011")
    errors << "#{relative(Pathname.new(file_name))}: ACTIVE Runtime Agent missing DEC-0011 Learning-Ref"
  end
end

marketing_path = ROOT.join(
  "LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md"
)

if marketing_path.exist?
  marketing_text = File.read(marketing_path)
  marketing_agents = [
    "Growth Orchestrator Agent",
    "SmartStore Growth Agent",
    "Idus Growth Agent",
    "Content Agent",
    "CRM Retention Agent",
    "Review & Referral Agent",
    "Revenue Analytics Agent"
  ]
  marketing_fields = [
    "Mission",
    "Customer Journey",
    "역할",
    "Input",
    "Output",
    "참조 문서",
    "Workflow",
    "SOP",
    "KPI",
    "승인 지점",
    "Runtime 상태"
  ]

  marketing_agents.each do |agent|
    section = marketing_text[
      /^### #{Regexp.escape(agent)}\n(.*?)(?=^### |^## |\z)/m,
      1
    ]

    if section.nil?
      errors << "Marketing Agent contract missing: #{agent}"
      next
    end

    marketing_fields.each do |field|
      marker = /-\s+\*\*#{Regexp.escape(field)}:\*\*/
      errors << "#{agent}: missing #{field}" unless section.match?(marker)
    end
  end
end

manifest = File.readlines(ROOT.join("FILE-MANIFEST.txt"), chomp: true).reject(&:empty?).sort
actual = IO.popen(
  ["git", "-C", ROOT.to_s, "ls-files", "--cached", "--others", "--exclude-standard"],
  &:read
).lines.map(&:chomp).reject(&:empty?).sort

(actual - manifest).each { |path| errors << "FILE-MANIFEST.txt missing: #{path}" }
(manifest - actual).each { |path| errors << "FILE-MANIFEST.txt stale: #{path}" }

if errors.empty?
  puts "GP Company OS validation passed."
  exit 0
end

warn "GP Company OS validation failed:"
errors.each { |error| warn "- #{error}" }
exit 1
