#!/usr/bin/env ruby

require 'bio'

fas_ff = Bio::FlatFile.auto(ARGV[0])
gbk_ff = Bio::GenBank.open(ARGV[1])
genbank_hash = {}

gbk_ff.each_entry do |gb|
  #puts gb.locus.entry_id
#  genbank_hash[gb.locus.entry_id] = gb
  genbank_hash[gb.definition] = gb
end

puts "\n***************\nEntering the fasta file\n****************\n"

fas_ff.each_entry do |f|
  matching_entry = ''
  genbank_hash.keys.each_entry do |gk|
    matching_entry = gk if genbank_hash[gk].definition.match(f.definition)
  end
  puts genbank_hash[matching_entry].to_biosequence.output(:genbank)
end
