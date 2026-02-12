
/*
import Combine
import SwiftData



    
   
let stories: [Story] = [
//1.
    Story(
        title: "You Can Never Please Everyone",
        cover: "Juha'sSon",
        assets: ["Juha's Son"],
        //genre: .wisdom/comedy,
        englishStory: [
            "Juha had a son who disobeyed him whenever he asked him to do something. The boy would always reply, 'What will people say about us if we do that?'",
            
            "Juha decided to teach his son a lesson — one that would help him understand that pleasing people is an impossible goal. So he mounted his donkey and asked his son to walk beside him.",
            
            "They had not gone far when they passed a group of women who scolded him, saying, 'Have you no mercy? You ride while the poor boy walks behind you!' Juha immediately got off the donkey and told his son to ride instead.",
            
            "After a short distance, they passed a group of old men who disapproved. Juha then suggested they both ride the donkey. Soon after, others criticized them for overloading the animal.",
            
            "They decided to both walk and let the donkey go ahead. Yet even then, young men mocked them. Finally, Juha tied the donkey to a branch and carried it with his son.",
            
            "The town gathered at the strange sight. A policeman cleared the crowd and led them away. On the way, Juha said to his son, 'This is the result of listening to every opinion and trying to please everyone.'"
        ],
        progress: 0,
        currentPage:0,
        
        summary: """
        In a simple journey that quickly turns unexpected, Juha and his son try to please everyone they meet — only to face criticism at every turn. This humorous tale delivers a timeless lesson about the danger of living by others’ opinions, reminding readers that pleasing everyone is impossible.
        """,
       
        
    ),
    //2.
    Story(
        title: "Juha’s Nail",
        cover: "Juha'sNail",
        assets: ["Juha’s Nail"],
       // genre: .comedy,
        englishStory: [
            "One day, Juha owned a house and decided to sell it, but he did not truly want to leave it. So he set a condition: one nail in the wall would remain his.",
            
            "The buyer agreed. A few days later, Juha knocked on the door, saying he came to check on his nail.",
            
            "After staying for a long time, Juha said he wanted to rest under the shade of his nail. This kept happening again and again.",
            
            "Eventually, the buyer became frustrated and could no longer tolerate Juha’s repeated visits and excuses.",
            
            "Finally, he abandoned the house completely. Since then, the expression 'Juha’s Nail' has been used to describe weak or false excuses used to gain something unfairly."
        ],
        progress: 0,
        currentPage:0,
        summary: """
        Juha sells his house but keeps ownership of a single nail in the wall. He repeatedly uses it as an excuse to return until the new owner gives up. The story became a proverb describing people who use weak justifications to achieve unfair goals.
        """
    ),
    //3.
    Story(
        title: "The Mystery of the City of Brass",
        cover: "cityOfBrass",
        assets: ["cityOfBrass"],
       // genre: .mystery,
        englishStory: [
            "After a long journey across the desert, a group of travelers finally reached the legendary city said to be built from shining brass. Its walls still reflected the sun, untouched by time.",
            
            "As they entered, something felt wrong. The streets were orderly, the houses intact, but there was no sign of life. There were no signs of battle or escape — only silence, as if life had suddenly stopped.",
            
            "In the center stood a grand palace covered with writings warning against pride and greed. The inscriptions told of people who believed their power would last forever.",
            
            "Inside, they discovered a hall filled with statues whose faces seemed frozen in fear. Slowly, the travelers realized the city had not been abandoned willingly — something had ended everything at once.",
            
            "They left quietly, understanding that its greatest treasure was not gold, but the lesson it left behind: when power turns into arrogance, it becomes the beginning of the end."
        ],
        progress: 0,
        currentPage:0,
        summary: "Deep in the desert stands an abandoned city whose people disappeared without explanation, leaving behind silent streets and a warning that time never erased."
    ),
    //4.
    Story(
        title: "The Fisherman and the Jinn",
        cover: "fishermanJinn",
        assets: ["storyCover4"],
        //genre: .mystery,
        englishStory: [
            "An old fisherman struggled daily to catch enough food, until one morning his net pulled up a heavy sealed jar. Hoping for treasure, he opened it.",
            
            "Thick smoke rose and formed into a giant jinn who declared he would kill whoever set him free. The fisherman asked why, and the jinn explained that centuries of imprisonment had turned hope into anger.",
            
            "Realizing he could neither fight nor escape, the fisherman pretended disbelief. He claimed such a large creature could never have fit inside a small jar.",
            
            "Offended, the jinn returned into the jar to prove it. At that moment, the fisherman sealed it shut again.",
            
            "The jinn begged for release, promising kindness instead of revenge. After hesitation, the fisherman freed him, having learned that wisdom can save a life when strength cannot."
        ],
        progress: 0,
        currentPage:0,
        summary: "A poor fisherman opens an ancient jar and faces a danger that cannot be defeated by strength — only by wisdom."
    ),
    //5.
    Story(
        title: "The Mystery of the Wise Judge",
        cover: "wiseJudge",
        assets: ["storyCover4"],
        //genre: .mystery,
        englishStory: [
            "Two men came before a judge, each claiming ownership of a bag of money. There were no witnesses and no clear proof.",
            
            "The judge listened quietly, paying attention not only to their words but to their behavior. Instead of deciding immediately, he asked them to return the next day.",
            
            "When they did, he placed the bag between them and asked each man to describe its contents in detail.",
            
            "One spoke confidently, while the other hesitated. The judge then asked a simple question that unsettled one of them completely.",
            
            "In that moment, the truth became clear. The real owner remembered naturally, while the liar struggled to maintain a story he did not truly know."
        ],
        progress: 0,
        currentPage:0,
        summary: "A case without witnesses or evidence is solved through careful observation and a single revealing moment."
    ),
    //6.
    Story(
        title: "The Secret of the Missing Merchant",
        cover: "missingMerchant",
        assets: ["storyCover4"],
       // genre: .mystery,
        englishStory: [
            "A well-known merchant vanished during a trading journey, and when the caravan returned without him, no one could explain what had happened.",
            
            "Rumors spread quickly. Some believed he had been robbed, others thought he had fled. Each traveler told a slightly different story.",
            
            "As time passed, small details surfaced — a sudden change of route, unusual silence, and a message he had left behind unnoticed.",
            
            "The message revealed no danger, only quiet words suggesting a desire to start over.",
            
            "Eventually, people understood that the merchant had planned his disappearance. The mystery was never about where he went, but why no one had seen his struggle before he left."
        ],
        progress: 0,
        currentPage:0,
        summary: "A merchant’s sudden disappearance raises suspicion, until the truth reveals that the mystery was shaped by choice rather than accident."
    ),
    //7.
    Story(
        title: "The Abandoned House",
        cover: "abandonedHouse",
        //genre: .mystery,
        englishStory: [
            "At the edge of the village stood an abandoned house surrounded by stories of whispers and strange noises at night.",
            
            "One curious young man decided to spend a night inside to prove the stories wrong. As darkness fell, he began hearing footsteps and soft knocking sounds.",
            
            "Fear grew, but instead of running, he investigated. The sounds seemed to repeat at certain times.",
            
            "Searching carefully, he discovered broken openings in the walls where the wind passed through, creating the eerie noises.",
            
            "When morning came, he left with a new understanding: fear often grows where answers are missing, and mystery is sometimes born from misunderstanding rather than magic."
        ],
        progress: 0,
        currentPage:0,
        summary: "A house feared by everyone for its strange sounds hides a truth that challenges the power of fear itself."
    ),
    //8.
    Story(
            title: "Sinbad the Sailor",
            cover: "sinbad",
            assets: ["sinbad"],
           // genre: "wisdom/adventure",
            englishStory: [
                "The Beginning: A Restless Spirit",
                "Sinbad was a young man in Baghdad who inherited a fortune from his father but quickly spent it all on a lavish lifestyle.",
                "Realizing he was becoming poor, he sold his remaining possessions and set out to sea to trade goods and rebuild his wealth.",
                "The Seven Voyages",
                "Over the course of seven dangerous voyages, Sinbad encountered wonders and horrors that tested his bravery and wit.",
                "The Living Island:",
                "In his first voyage, Sinbad and his crew landed on what they thought was an island. When they lit a fire, the island shook — it was actually a giant whale.",
                "The Roc:",
                "He was once abandoned on a deserted island where he found a massive white dome, which turned out to be the egg of a Roc, a legendary giant bird. He escaped by tying himself to the bird’s leg.",
                "The Sea Monster and the Giant:",
                "He faced a terrifying giant who ate his crew members and escaped by blinding the creature.",
                "The Valley of Diamonds:",
                "Sinbad discovered a valley filled with massive diamonds guarded by giant vipers. He used raw meat so the diamonds would stick to it, allowing the Rocs to carry him out.",
                "The Final Return",
                "After years of being shipwrecked, enslaved, and nearly killed many times, Sinbad always managed to return to Baghdad.",
                "Each time, he returned wealthier and wiser, gaining treasures from distant lands and kings.",
                "Eventually, Sinbad realized that peace and faith were more valuable than gold, so he settled down in Baghdad and shared his stories and wealth with others."
            ],
            progress: 0,
            currentPage:0,
            summary: "Sinbad the Sailor is a timeless story from the legendary collection One Thousand and One Nights. It tells the story of adventure, courage, and perseverance through dangerous seas and unknown lands. Through his journeys, Sinbad learns that wisdom, faith, and experience are more valuable than wealth."
        ),
//9.
        Story(
            title: "Juha and the Lost Donkey",
            cover: "lostDonkey",
            assets: ["storyCover4"],
          //  genre: "comedy",
            englishStory: [
                "Juha and the Lost Donkey",
                "It is said that Juha was walking in the market looking very sad, and people asked him:",
                "What’s wrong, Juha?",
                "He said, My donkey is lost!",
                "They asked him, Then why are you smiling?",
                "Juha replied, I thank God that I was not riding it, otherwise I would have been lost with it!",
                "People laughed at his strange logic, but Juha said:",
                "Sometimes we should look at the half-full side of the cup; the problem could have been worse."
            ],
            progress: 0,
            currentPage:0,
            summary: "It is said that Juha was walking through the market looking very sad, and people asked him, What's wrong, Juha? He replied that his donkey was lost. When they asked why he was smiling, Juha said he thanked God he was not riding it, otherwise he would have been lost as well. People laughed, but Juha reminded them that sometimes we should look at the positive side because things could have been worse."
        ),
//10
        Story(
            title: "The Merchant and the Parrot",
            cover: "storyMerchant and Parrot",
            assets: ["storyCover4"],
           // genre: "comedy",
            englishStory: [
                "The Merchant and the Parrot",
                "A merchant had a beautiful parrot that could talk. Every day, the parrot greeted customers and made them smile. The merchant loved his parrot very much.",
                "One day, the merchant had to travel to another city for work. Before leaving, he asked the parrot, \"Do you want me to bring you anything?\"",
                "The parrot replied, \"Yes. If you see parrots in the forest, tell them I live in a cage and ask how they stay happy.\"",
                "When the merchant reached the forest, he told the wild parrots the message. Suddenly, one of the parrots fell from the tree and did not move. The merchant became sad and thought he had said something wrong.",
                "When he returned home, he told his parrot what had happened. As soon as the parrot heard the story, it fell down in the cage and stopped moving. The merchant thought the parrot had died, so he opened the cage door.",
                "Suddenly, the parrot flew out and sat on a tree. It said, \"The wild parrot was teaching me the secret of freedom.\""
            ],
            progress: 0,
            currentPage:0,
            summary: "A delightful story about a merchant and his clever parrot, told in a simple and humorous way. The story shows how wisdom can come from unexpected places and teaches a gentle lesson about freedom and understanding."
        ),
  //11
    Story(
        title: "The Fisherman and the Shining Pearl",
        cover: "storyCover2",
        assets: ["storyCover2"],
        //genre: .wisdom,
        englishStory: [
            "Once upon a time, there was a kind and hardworking fisherman. Every morning before sunrise, he sailed his small wooden boat into the vast blue sea. He was not only searching for fish, but for a precious pearl that could give his wife and children a better life.",
            
            "He was a brave diver. Taking a deep breath, he would plunge into the cool, clear water and swim past colorful coral reefs and curious schools of fish. For hours, he searched the ocean floor, opening shell after shell, hoping one might hide a treasure.",
            
            "Many days brought disappointment. Dozens of shells were empty, and he often sat in his boat feeling tired and discouraged. But he never allowed himself to quit. Thinking of his family’s smiles, he would whisper, 'Maybe the next shell will be the one.'",
            
            "One sunny afternoon, just as he was about to return home, he noticed a large, unusual oyster resting near a bright coral reef. He carefully brought it aboard and opened it slowly.",
            
            "A brilliant light sparkled from inside. There lay the most beautiful pearl he had ever seen — perfectly round, glowing like a tiny moon. He rushed back to shore where his family greeted him with joy, and the entire village celebrated his success.",
            
            "His achievement was not the result of luck alone, but of patience and relentless effort. From that day forward, he and his family lived happily, always remembering that hope is the greatest treasure of all."
        ],
        progress: 0,
        currentPage:0,
        summary: "An inspiring tale about patience, perseverance, and hope. A determined fisherman faces repeated failure in his search for pearls, yet refuses to give up. His unwavering effort eventually leads to a life-changing discovery, proving that hard work and belief can lead to success."
    ),
   //12
    Story(
        title: "The Honest Merchant",
        cover: "storyCover4",
        assets: ["storyCover4"],
        //genre: .wisdom,
        englishStory: [
            "In a bustling city lived a merchant named Zaid, known for his honesty and integrity. While others chased profit at any cost, Zaid believed that a small, honest gain was better than a fortune earned through deception.",
            
            "One day, he purchased an old warehouse to store his silks and spices. As he cleaned a dusty corner, his shovel struck something hard. Beneath the floor, he uncovered a heavy iron chest.",
            
            "Inside were sparkling jewels, ancient gold coins, and priceless pearls — a treasure that could make him the richest man in the kingdom.",
            
            "His assistant whispered eagerly, 'Master, this treasure is yours. No one knows about it. You can live like a king.' But Zaid calmly replied, 'This gold does not belong to me. I bought the warehouse to store goods, not to claim what was hidden by another. Wealth must be earned, not taken.'",
            
            "Determined to do what was right, Zaid researched the history of the warehouse and found an old, impoverished man — the descendant of the original owner.",
            
            "When Zaid returned the chest, the old man wept with gratitude and asked why he would give away such wealth. Zaid simply smiled and said, 'I may be a merchant of goods, but I am also a merchant of truth. I cannot sell my conscience for any price.'"
        ],
        progress: 0,
        currentPage:0,
        summary: "Zaid, a merchant known for his integrity, discovers a hidden treasure beneath his warehouse. Faced with a choice between sudden wealth and an honest conscience, he proves that integrity is the greatest investment of all."
    ),
    //13
    Story(
        title: "Juha and the Judge’s Trick",
        cover: "juhaGotSlaped",
        assets: ["juhaGotSlaped"],
        //genre: .comedy,
        englishStory: [
            "One day, a man slapped Juha on the back of his head in the middle of the street, trying to mock him. Juha immediately grabbed the man and dragged him to the judge, refusing to accept his excuse that he had mistaken him for a friend.",
            
            "The man happened to be an acquaintance of the judge. Wanting to spare him punishment, the judge ruled that the man must either allow Juha to slap him back or pay him ten silver coins as compensation.",
            
            "Juha preferred the money and quickly asked the man, 'Do you have the coins with you?' The man, understanding the judge’s intention, replied, 'No, but I will go home and bring them shortly.'",
            
            "The judge permitted him to leave. The man went — and never returned. Juha waited for a long time until he realized the judge’s trick.",
            
            "Suddenly, Juha stepped closer to the judge as if to whisper something in his ear. Without warning, he gave the judge a strong slap and walked away, saying, 'When the man returns with the money, you may keep it on my behalf.'"
        ],
        progress: 0,
        currentPage:0,
        summary: "After being mocked and slapped in public, Juha seeks justice in court. When the judge attempts to protect his acquaintance with a clever trick, Juha responds with a clever move of his own — proving that wit can outmatch favoritism."
    ),
    //14
    Story(
        title: "The Wise Man and the Same Joke",
        cover: "notFuny",
        assets: ["storyCover4"],
        //genre: .wisdom,
        englishStory: [
            "There once was a wise man whom people traveled from far and wide to consult. Yet every time they visited him, they complained about the same problems and repeated the same struggles.",
            
            "Eventually, the wise man grew tired of hearing the same complaints. One day, he gathered them all together and told a funny joke. Everyone burst into laughter.",
            
            "After a few minutes, he told the exact same joke again. This time, only a few people smiled.",
            
            "Then he repeated the joke a third time. No one laughed.",
            
            "The wise man smiled and said, 'You cannot laugh at the same joke more than once. So why do you continue to cry and complain about the same problems again and again?'"
        ],
        progress: 0,
        currentPage:0,
        summary: "A wise man teaches a powerful lesson by repeating the same joke three times. Through a simple example, he reminds people that dwelling on the same problems repeatedly will not change them — only action will."
    ),
    //15
    Story(
        title: "The Old Man in the Village",
        cover: "happyMan",
        assets: ["happyMan"],
        //genre: .wisdom,
        englishStory: [
            "In a distant village lived an old man who was considered the unhappiest person anyone had ever known. He complained constantly and was always in a bad mood.",
            
            "As he grew older, his negativity only increased. The villagers avoided him because his sadness seemed contagious. No one could stay happy around him for long.",
            
            "He spread frustration and gloom wherever he went, and people believed he would remain miserable for the rest of his life.",
            
            "But one day, when he turned eighty years old, something strange happened. Rumors spread quickly: 'The old man is happy today! He is not complaining, and he is even smiling.'",
            
            "The villagers gathered and asked him what had changed. The old man replied, 'Nothing important. For eighty years, I chased happiness and never found it. Then I decided to stop chasing it and simply live my life. That is why I am happy now.'"
        ],
        progress: 0,
        currentPage:0,
        summary: "A lifelong pessimist surprises his village when he suddenly becomes happy at the age of eighty. His unexpected transformation reveals a powerful truth about the difference between chasing happiness and choosing to live peacefully."
    )
    ]
    

    
    // comedy = 5
    // wisdom = 5
    //mystery = 5