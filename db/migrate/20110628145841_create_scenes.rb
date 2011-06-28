class CreateScenes < ActiveRecord::Migration
  def self.up
    create_table :scenes do |t|
      t.integer :story_id
      t.string :name
      t.text :scene_text
      t.integer :order
      t.string :scene_audio
      t.string :scene_audio_duration
      t.text :choice_text
      t.string :choice_audio
      t.string :choice_audio_duration
      t.integer :option_one
      t.integer :option_two

      t.timestamps
    end
  end

  def self.down
    drop_table :scenes
  end
end
