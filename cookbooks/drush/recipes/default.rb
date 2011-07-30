# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Cookbook Name::  drush
# Recipe:: head
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'php'

php_pear "Console_Table" do
  action :install
end

case node[:platform]
when "debian", "ubuntu"
  git "/usr/share/drush" do
    repository "git://git.drupal.org/project/drush.git"
    reference "7.x-4.4"
    action :sync
  end
  
  link "/usr/bin/drush" do
    to "/usr/share/drush/drush"
    not_if { File.exists?("/usr/bin/drush") }
    only_if { File.exists?("/usr/share/drush/drush") }
  end
end