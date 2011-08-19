Description
===========

Videos Engine for Refinery CMS

Requirements
============

* FFMPEG 0.6.3
    
Adding the Resque Front-End to your app
=======================================

Edit your config.ru and replace the run EnmasseOnline::Aplication line with the following:

    require 'resque/server'

    run Rack::URLMap.new(
      "/" => EnmasseOnline::Application, 
      "/resque" => Resque::Server.new
    )

LICENSE and AUTHOR
==================

Author:: Jamie Winsor (<jamie@enmasse.com>)

Copyright:: 2011, En Masse Entertainment, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
