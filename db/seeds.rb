# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Reminder.destroy_all

################ USER SEED ################

user_seed = [
  { email: 'public@public.com',
    username: 'public',
    password: 12345678 },
  { email: 'jrnld@jrnld.com',
    username: 'jrnld',
    password: 12345678 },
  { email: 'test@test.com',
    username: 'test',
    password: 12345678 }
]

user_seed.each do |user|
  @user = User.new(user)
  @user.save!
end

################ REMINDER SEED ################

reminder_seed = [
  { user_id: User.first.id, title: 'cat' },
  { user_id: User.first.id, title: 'food' },
  { user_id: User.first.id, title: 'culture' },
  { user_id: User.first.id, title: 'love' },
  { user_id: User.first.id, title: 'wildlife' },
  { user_id: User.first.id, title: 'adventure' },
  { user_id: User.first.id, title: 'beer' },
  { user_id: User.second.id, title: 'school' },
  { user_id: User.second.id, title: 'friends' },
  { user_id: User.second.id, title: 'love' },
  { user_id: User.second.id, title: 'fashion' },
  { user_id: User.third.id, title: 'excercise' },
  { user_id: User.third.id, title: 'food' },
  { user_id: User.third.id, title: 'family' },
  { user_id: User.third.id, title: 'play' },
  { user_id: User.third.id, title: 'beauty' },
  { user_id: User.third.id, title: 'love' }
]

reminder_seed.each do |reminder|
  @reminder = Reminder.new(reminder)
  @reminder.save!
end

################ ENTRY SEED ################

entry_seed = [
  { user_id: User.first.id,
    created_at: '2012-04-11',
    title: 'Spring in Mexico: a Heated Experience',
    content:  'A week of incredible heat has been the setting for Mandy and her cats Mexican orientation.  We have seen the hottest temperatures since we have moved here(over 35 degrees) and it did not rain for 1 month!  That dry spell was broken with rain over the last couple of days and a return to a more comfortable temperature range of 29-33 degrees celsius (+30 almost seems chilly by comparison).  The cats having been loving their new friends and their new location so the interaction between the five cats and the 16 turtles has been priceless.  All the cats have been getting along and that is good because we have been out of the house a lot.  We have been finding apartments with Mandy, introducing her to our friends and preparing for more friends to visit as well as our eventual departure.  We are enjoying our remaining time here as much as possible by diving and taking advantage of  the local food, drink and cheer. It is still hard to believe that we will be returning soon but we are looking forward to another amazing road trip, and our reunion with friends and family.  After all our adventures and with all our amazing friends my roots have been firmly anchored here in Cozumel.  There will always be more adventures in the future but my heart will  reside in this island paradise.' },
  { user_id: User.first.id,
    created_at: '2012-04-03',
    title: 'Five Cats and a Birthday.',
    content:  'After arriving last night, Loretta, Mandy and her three cats are waking up to a Mexican sunrise.  For Homer, Froggy, and Mini Mew the sights, sounds, and stress of a 12 hour travel day has melted away and now they are left with tropical paradise to explore.  So far all is well between all five of the cats!  We introduced them last night and there was not much drama at all. The were lucky enough to arrive on Liz’s birthday so after unloading at our place, we had some island cheer and closed down El Moro.  This birthday dinner was the summation of a full day of diving and having birthday fun.  Even though the day was long we still celebrated late and the staff at El Moro was more than accommodating by keeping the restaurant open an extra hour just for us.  Today we will allow our guests to settle in somewhat and the we will have to prepare for Liz’s birthday party tonight.  We have been very busy the last week planning for Liz’s birthday, preparing for Mandy’s arrival, planning our return, finishing our taxes, turning on our services at home, servicing the car, etc.  In between the work we have been visiting friends and diving when we can.  Now that most of the work is done we can enjoy our last month here and spend time with our last few visitors before having to face the frigid spring temperatures in the North once again.' },
  { user_id: User.first.id,
    created_at: '2012-03-23',
    title: 'Hasta Luego Amigos!',
    content:  'It has been a bit quiet the last couple days.  Daryl and Nakita are back in Canada, and probably already back at work.  We had lots of great times their last week here including going to the ruins, a few great dives, fun at cantinas, and goodbye parties.//
    On the 17th, we went with Wilberth, Nakita and Daryl on  two boat dives.  It would be there last two dives from a boat so we decided to do reef that we had not yet done.  The first dive was on San Francisco Wall.  The wall starts at around 50 feet of depth, and carries on over 1000 feet to the bottom of the ocean.  We followed Wilberth down, and went to a max depth of 150 feet!  The currents have been a bit odd the last few days which led to cold water from the deep to come into shallower water.  The current changed during the dive, so we ascended a bit and drifted with the current.  It worked out great because we saw some really cool things we would have otherwise missed.  There was a rare sea cucumber that rolls (slowly) away if it feels threatened.  Also we saw another Flying Gunard!  We were lucky this time Daryl and Nakita were able to get pictures and video.  The second dive we went to Yucab Reef.  When descending, we could see the point in the water where the cold and warm water mixes.  The water here is normally about 79F, but on this dive it was a frigid 75F.  Might not sound like a huge difference, but when your deep under water it is like a wall of ice!  The reef loves the cold currents that carry nutrients to them and both reefs were bursting with life.  We still were able to see lobster, eel, lion fish and a splendid toadfish as well as hundreds of various other species.  For Nakita and Daryls last dive, we did a shore dive off of Del Mar and went to the plane wreck.  There is lots of fish life, and since it is spawning season there are little fish everywhere.//
    Daryl, Nakita, Larry, Charlotte, Tim and I all went to the San Gervasio Ruins one day.  It was hot, and always seems to be hotter in the jungle.  We got a tour guide this trip, and while they don’t take you to all the ruins, they are full of great information.  After the tour was over Tim, Nakita, Daryl and I walked out to the large ruin in the back.  We went back to the area Tim had found on our first trip there to look around.  We took some pictures, and headed for a beer to cool off.//
    On the 20th everyone got together at El Piques for the going away party.  Lots of people made it out and we all ate, drank and had a great time!  After we headed back to our place for a few more drinks.  It was a great night with friends!  The next day, we made it to Primas for breakfast before dropping Daryl and Nakita off at the ferry.  See you guys in Edmonton soon!' },
  { user_id: User.second.id,
    created_at: '2016-03-03',
    title: 'What a day',
    content:  'Dear Diary, //
    I’m so upset!! I don’t even know where to begin!//
    To start off, I think I completely failed my geometry quiz, which I know I should’ve studied more for...my dad’s not gonna be happy about that. :( Then, we had a pop quiz in history on the reading homework from last night, and I completely forgot most of what I read, which made me even more upset because I actually did the reading! But what really made me mad was the note that Sarah slipped into my locker during passing period. She said she was sad that I’ve been hanging out with Jane more lately and thinks that I don’t want to be her friend anymore. I can’t believe she thinks that, especially after talking with her on the phone for hours and hours last month while she was going through her breakup with Nick! Just because I’ve been hanging out with Jane a little more than usual doesn’t mean I’m not her friend anymore. She completely blew me off at lunch, and when I told Jane, she thought that Sarah was being a “drama queen.”//
    This is just what I need! My parents are getting on my case about doing more extracurricular activities, I have a huge paper due for AP English soon, and I can’t understand a thing in advanced Spanish! The last thing I need is for my best friend to think I hate her and barely text me back anymore.//
    Uggh! I can’t concentrate on anything right now because of it. I hope she gets over it!!!//
    Love,//
    Kate' },
  { user_id: User.second.id,
    created_at: '2016-03-04',
    title: 'Getting better',
    content:  'Dear Diary,//
    Today was a little better. I texted Sarah last night asking if she wanted to have lunch with me today, just the two of us, and she said sure. I told her that just because I’m hanging out with Jane, it doesn’t change anything about our friendship. After all, we’ve been friends since first grade! She said that she knows that, but she just felt like the third wheel because she doesn’t think that Jane likes her and because Jane and I have a lot of classes together. I told her not to worry about what Jane thought and that I’d talk to her about it. Sarah felt a lot better, and after we both cried a little, we spent the rest of lunch catching up on the latest gossip, which I missed!  //
    During English, I talked to Jane about what Sarah said. She said that it’s not that she doesn’t like Sarah; she just thinks that she gets too worked up about things sometime, like her breakup with Nick. I explained why Sarah was so upset about it and how Nick had cheated on her, which Jane didn’t know, and she felt bad for saying mean things about Sarah. I think Jane’s really cool, but I wish she wouldn’t assume things about people. I’m worried she was saying mean things about Sarah to our other friends when she didn’t know the truth. She sometimes likes to spread rumors even when she doesn’t know if they’re true.  //
    I thought it would be fun for the three of us to get some coffee after school and try to make everything better. I’m not sure how well that worked, because even though Jane was trying really hard to be nice to Sarah, I could tell that Sarah was being really fake with Jane. When I texted Sarah later, she said everything was fine, but I know her well enough to know that’s not completely true.//
    ::Sigh:: Oh well. I’m not her mom, and I can’t force her to feel anything. It just frustrates me because I don’t want things to change between us...//
    We’ll see what happens. I have to get some math homework done now! //
    Night!//
    Kate' },
  { user_id: User.second.id,
    created_at: '2016-03-06',
    title: 'Busy busy',
    content:  'Dear Diary,//
    Sorry I didn’t get to write last night! It was such a busy day, and I was too tired to write anything...//
    I was right about Sarah not being okay. Yesterday, she barely spoke to me, and anything she did say was a “yes” or “no” answer.  I tried so hard to get her to cheer up, but of course she just kept saying, “I’m fine, I’m fine.” Uggh! I wish she would just be honest with me! I’m always honest with her! It’s not fair!//
    Jane also seemed mad all day because she could tell that Sarah was being fake nice to her. I hate being in the middle of all of this. What am I supposed to do? Sarah’s been my friend since forever, and Jane is my new friend, and I don’t want to hurt anyone’s feelings! But I think that Jane is right about Sarah. I think Sarah sometimes gets too dramatic about things. She’s being kind of a brat about all of this, but I don’t want to tell her that to her face, she’d never forgive me.//
    I wish things were simple like they were in elementary school.  :( :( :(//
    <3,//
    Kate' },
  { user_id: User.third.id,
    created_at: '2018-11-27',
    title: 'What About MY Good Times?',
    content: 'I KNOW that Daisy is ALWAYS saying that I RUIN her Good Times.  But from MY point of view... She NEVER wants to have any FUN with me.  That ruins MY Good Times!' },
  { user_id: User.third.id,
    created_at: '2018-11-26',
    title: 'Proof That I\'m a Genius!',
    content: 'My Mommeh always says that I am very, very smart (of course she\'s proud of me). Here is a little bit of proof that I might be a genius! I was playing around in the bathtub while she was changing the litter box...//
    And I came right up to the faucet. Now I should tell you that this shower/tub has never been used except to keep the litter box in an out-of-the-way place. I have never seen any water come out of this faucet.//
    But I came right up to it and tried to drink from it!' },
  { user_id: User.third.id,
    created_at: '2018-11-22',
    title: 'The REAL Mac Daddy',
    content: 'You know Harley thought he was the big Mac Daddy in his Halloween costume last month. But I have news for him... //
    I can wear that stylish hat much better than Harley. See? I even have the fur coat.' },
  { user_id: User.third.id,
    created_at: '2018-11-21',
    title: 'Da Bird is da bomb!',
    content: 'I FOUND this GREAT toy in my TOYBOX the other day.  Who wants to play with DA BIRD?!?! I do, I DO!!!!!//
    What could be BETTER than a WAND toy with FEATHERS!?!? Nothing! Let\'s PLAY!//
    WHEEEEEEE! This is a great WORKOUT!//
    When I get the BIRD in my JAWS, I have LEARNED to SPREAD my legs and PULL! This is a GOOD trick.//
    I will NEVER let GO!//
    I\'ve GOT you in my GRASP now, BIRD!' },
  { user_id: User.third.id,
    created_at: '2018-11-19',
    title: 'I\'m Curious!',
    content: 'One thing about me that you might or might not know is that I am a very curious cat.  I must be a part of everything, especially when I see the camera (because treats could be involved!)//
    If you pay attention, there are still many interesting and exciting things to see and do and experience!//
    As Voltaire said, "Judge a cat by her questions rather than by her answers" (or something like that).' },
  { user_id: User.third.id,
    created_at: '2018-11-15',
    title: 'Blue is pretty!',
    content: 'Isn\'t  this suit a pretty color? I never knew blue could look so nice! I especially like the matching satin bow that shows off my waistline.//
    Here, let me lift my arm so you can see it better. Oh, and the sea-quinns, too!//
    It was close to suppertime when I was modeling, so those treats tasted extra-delicious. My Mommeh thought it would be funny to get a close-up of my drool face.//
    Hey! How did this silly picture get here?' },
  { user_id: User.third.id,
    created_at: '2018-11-12',
    title: 'Sheet monster!',
    content: 'You MIGHT not realize it but I am VERY, VERY BRAVE! See, MONSTERS live actually INSIDE the sheets. I don\'t mean to SCARE you, but it is the TRUTH. I am on the ALERT at ALL TIMES. In fact, I hear one NOW!!!!!//
    GOTCHA!!!//
    Are you IMPRESSED?' }
]

entry_seed.each do |entry|
  @entry = Entry.new(entry)
  @entry.save!
end

################ TAG SEED ################

tag_seed = [
  { title: 'cat' },
  { title: 'food' },
  { title: 'culture' },
  { title: 'love' },
  { title: 'wildlife' },
  { title: 'adventure' },
  { title: 'beer' },
  { title: 'school' },
  { title: 'friends' },
  { title: 'love' },
  { title: 'fashion' },
  { title: 'family' },
  { title: 'play' },
  { title: 'beauty' },
  { title: 'career' },
  { title: 'flowers' },
  { title: 'love' },
  { title: 'love' },
  { title: 'love' },
  { title: 'ocean' },
  { title: 'fitness' },
  { title: 'boys' },
  { title: 'nature' }
]

tag_seed.each do |tag|
  @tag = Tag.new(tag)
  @tag.save!
end

################ ENTRY_TAG SEED ################

Entry.all.each do |entry|
  rand(3..6).times do
    @entry_tag = EntryTag.new(entry_id: entry.id, tag_id: Tag.all.sample.id)
    @entry_tag.save!
  end
end
