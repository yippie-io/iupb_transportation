# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Station.create(name: "Uni/Südring", query_name: "Uni Suedring", lat: 51.706283, long: 8.773098)
Station.create(name: "Uni/Schöne Aussicht", query_name: "Uni Schoene Aussicht", lat: 51.710295, long: 8.77416)
Station.create(name: "MuseumsForum", query_name: "Museumsforum", lat: 51.732142, long: 8.737064)