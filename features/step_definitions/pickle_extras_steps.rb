Given /#{capture_model} is one of #{capture_model}'s (\w+)/ do |owned,owner, assoc| 
   model!(owner).send(assoc) << model!(owned) 
end 
