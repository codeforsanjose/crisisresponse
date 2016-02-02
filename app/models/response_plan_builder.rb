class ResponsePlanBuilder
  def self.build(data)
    data = data.to_h

    action_plan_steps = [
      data.fetch("Step #1 (of action plan)"),
      data.fetch("Step #2 (of action plan)"),
      data.fetch("Step #3 (of action plan)"),
      data.fetch("Step #4 (of action plan)"),
      data.fetch("Step #5 (of action plan)"),
    ].compact

    past_encounters = (1..5).map do |n|
      data.fetch("Descriptions of Past Encounter (##{n})")
    end.compact

    preparer = {
      name: data.fetch("What is your name?"),
      phone: data.fetch("What is the best phone number to reach you?"),
      team: data.fetch("Which team at SPD are you a part of?"),
    }

    ResponsePlan.new(
      action_plan_steps: action_plan_steps,
      dob: data.fetch("Date of Birth"),
      eyes: data.fetch("Eye Color"),
      hair: data.fetch("Hair Color"),
      height: data.fetch("Height"),
      image: data.fetch("Image"),
      license: data.fetch("License Number"),
      name: data.fetch("Full Name"),
      past_encounters: past_encounters,
      preparer: preparer,
      race: data.fetch("Race"),
      sex: data.fetch("Gender"),
      timestamp: data.fetch("Timestamp").split.first,
      type: data.fetch("What prompts you to write this plan?"),
      veteran: data.fetch("Veteran?"),
      weight: data.fetch("Weight"),
    )
  end
end
