# frozen_string_literal: true

# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module Selenium
  module WebDriver
    module DriverExtensions
      module HasDevTools

        #
        # Retrieves connection to DevTools.
        #
        # @return [DevTools]
        #

        def devtools
          require 'selenium/devtools/v89'

          @devtools ||= DevTools.new(url: devtools_url)
        end

        private

        def devtools_version
          return Firefox::DEVTOOLS_VERSION if browser == :firefox

          Integer(capabilities.browser_version.split('.').first)
        end

        def devtools_url
          return devtools_address if devtools_address.include?('/session/')

          uri = URI(devtools_address)
          response = Net::HTTP.get(uri.hostname, '/json/version', uri.port)

          JSON.parse(response)['webSocketDebuggerUrl']
        end

      end # HasDevTools
    end # DriverExtensions
  end # WebDriver
end # Selenium
