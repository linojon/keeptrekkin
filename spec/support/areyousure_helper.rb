RSpec.configure do |config|
  # prevent Selenium::WebDriver::Error::UnhandledAlertError when leaving a form thats been edited
  config.after(:each, areyousure: true) do
    visit '/'
    title = "This page is asking you to confirm that you want to leave - data you have entered may not be saved."
    if page.driver.class == Capybara::Selenium::Driver
      begin
        if page.driver.browser.switch_to.alert 
          if page.driver.browser.switch_to.alert.text == title
            page.driver.browser.switch_to.alert.accept
          end
        end
      rescue Selenium::WebDriver::Error::NoAlertPresentError #Selenium::WebDriver::Error::NoAlertOpenError
      end
    elsif page.driver.class == Capybara::Webkit::Driver
      #sleep 1 # prevent test from failing by waiting for popup
      if page.driver.browser.confirm_messages == title
        page.driver.browser.accept_js_confirms
      end
    end
  end
end
