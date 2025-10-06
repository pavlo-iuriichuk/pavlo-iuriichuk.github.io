module Jekyll
  class EnvironmentVariablesGenerator< Generatorpriority:high
def generate(site)site.config['env']= {}
      # Add the desired environment variables to site.config['env']
      site.config['env']['GTM_CONTAINER_ID'] = ENV['GTM_CONTAINER_ID']
      # Add other environment variables as needed
    end
  end
end
