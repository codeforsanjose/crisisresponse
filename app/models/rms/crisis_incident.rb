# frozen_string_literal: true

module RMS
  class CrisisIncident < ActiveRecord::Base
    belongs_to :rms_person, class_name: "RMS::Person"

    BEHAVIORS = [
      :suicide_threat_attempt,
      :excited_delirium,
      :halluc_delusion,
      :belligerent_uncooperative,
      :mania,
      :disorderly_disruptive,
      :hopeless_depressed,
      :bizarre_unusual_behavior,
      :out_of_touch_reality,
      :disorganize_communication,
      :disoriented_confused,
      :unusual_fright_scared,
      :neglect_self_care,
    ].freeze

    OTHER = [
      :threaten_violence,
      :weapon,
    ].freeze

    NATURE_OF_CRISIS = [
      :biologically_induced,
      :medically_induced,
      :chemically_induced,
      :unknown_crisis_nature,
    ].freeze

    DISPOSITIONS = [
      :treatment_referral,
      :chronic,
      :resource_declined,
      :mobile_crisis_team,
      :grat,
      :shelter,
      :no_action_poss_necc,
      :casemanager_notice,
      :dmhp_refer,
      :crisis_clinic,
      :emergent_ita,
      :voluntary_commit,
      :arrested,
    ].freeze

    def self.frequent_behaviors
      behaviors_by_incident = pluck(*BEHAVIORS)

      BEHAVIORS.map.with_index do |behavior, index|
        [
          behavior,
          behaviors_by_incident.count { |incident| incident[index] },
        ]
      end.reject { |_, count| count.zero? }.to_h
    end

    def behaviors
      BEHAVIORS.select { |behavior| public_send(behavior) }
    end

    def dispositions
      DISPOSITIONS.select { |disposition| public_send(disposition) }
    end

    def formatted_go_number
      "#{go_number[0...4]}-#{go_number[4..-1]}"
    end
  end
end
