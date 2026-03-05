import Foundation
import SwiftData
import Combine


struct StoriesLibrary {
    static func syncLibrary(in context: ModelContext) {
        let masterList = [
            // 1. You Can Never Please Everyone
            Story(title: "You Can Never Please Everyone",
                  genre: "Comedy",
                  storycover: "Juha'sSon",
                  pages: [
                    "Juha had a son who disobeyed him whenever he asked him to do something. The boy would always reply, 'What will people say about us if we do that?'",
                    "Juha decided to teach his son a lesson — one that would help him understand that pleasing people is an impossible goal. So he mounted his donkey and asked his son to walk beside him.",
                    "They had not gone far when they passed a group of women who scolded him, saying, 'Have you no mercy? You ride while the poor boy walks behind you!' Juha immediately got off the donkey and told his son to ride instead.",
                    "After a short distance, they passed a group of old men who disapproved. Juha then suggested they both ride the donkey. Soon after, others criticized them for overloading the animal.",
                    "They decided to both walk and let the donkey go ahead. Yet even then, young men mocked them. Finally, Juha tied the donkey to a branch and carried it with his son.",
                    "The town gathered at the strange sight. A policeman cleared the crowd and led them away. On the way, Juha said to his son, 'This is the result of listening to every opinion and trying to please everyone.'"
                  ], isFavorite: false),

            // 2. Juha’s Nail
            Story(title: "Juha’s Nail",
                  genre: "Comedy",
                  storycover: "Juha'sNail",
                  pages: [
                    "One day, Juha owned a house and decided to sell it, but he did not truly want to leave it. So he set a condition: one nail in the wall would remain his.",
                    "The buyer agreed. A few days later, Juha knocked on the door, saying he came to check on his nail.",
                    "After staying for a long time, Juha said he wanted to rest under the shade of his nail. This kept happening again and again.",
                    "Eventually, the buyer became frustrated and could no longer tolerate Juha’s repeated visits and excuses.",
                    "Finally, he abandoned the house completely. Since then, the expression 'Juha’s Nail' has been used to describe weak or false excuses used to gain something unfairly."
                  ], isFavorite: false),

            // 3. The Mystery of the City of Brass
            Story(title: "The Mystery of the City of Brass",
                  genre: "Mystery",
                  storycover: "cityOfBrass",
                  pages: [
                    "After a long journey across the desert, a group of travelers finally reached the legendary city said to be built from shining brass. Its walls still reflected the sun, untouched by time.",
                    "As they entered, something felt wrong. The streets were orderly, the houses intact, but there was no sign of life. There were no signs of battle or escape — only silence, as if life had suddenly stopped.",
                    "In the center stood a grand palace covered with writings warning against pride and greed. The inscriptions told of people who believed their power would last forever.",
                    "Inside, they discovered a hall filled with statues whose faces seemed frozen in fear. Slowly, the travelers realized the city had not been abandoned willingly — something had ended everything at once.",
                    "They left quietly, understanding that its greatest treasure was not gold, but the lesson it left behind: when power turns into arrogance, it becomes the beginning of the end."
                  ], isFavorite: false),

            // 4. The Fisherman and the Jinn
            Story(title: "The Fisherman and the Jinn",
                  genre: "Mystery",
                  storycover: "fishermanJinn",
                  pages: [
                    "An old fisherman struggled daily to catch enough food, until one morning his net pulled up a heavy sealed jar. Hoping for treasure, he opened it.",
                    "Thick smoke rose and formed into a giant jinn who declared he would kill whoever set him free. The fisherman asked why, and the jinn explained that centuries of imprisonment had turned hope into anger.",
                    "Realizing he could neither fight nor escape, the fisherman pretended disbelief. He claimed such a large creature could never have fit inside a small jar.",
                    "Offended, the jinn returned into the jar to prove it. At that moment, the fisherman sealed it shut again.",
                    "The jinn begged for release, promising kindness instead of revenge. After hesitation, the fisherman freed him, having learned that wisdom can save a life when strength cannot."
                  ], isFavorite: false),

            // 5. Sinbad the Sailor
            Story(title: "Sinbad the Sailor",
                  genre: "Adventure",
                  storycover: "sinbad",
                  pages: [
                    "Sinbad was a young man in Baghdad who inherited a fortune from his father but quickly spent it all on a lavish lifestyle.",
                    "Realizing he was becoming poor, he sold his remaining possessions and set out to sea to trade goods and rebuild his wealth.",
                    "Over the course of seven dangerous voyages, Sinbad encountered wonders and horrors that tested his bravery and wit.",
                    "In his first voyage, Sinbad and his crew landed on what they thought was an island. When they lit a fire, the island shook — it was actually a giant whale.",
                    "He escaped the Valley of Diamonds by using raw meat so the diamonds would stick to it, allowing the Rocs to carry him out.",
                    "Eventually, Sinbad realized that peace and faith were more valuable than gold, so he settled down in Baghdad and shared his stories."
                  ], isFavorite: false),

            // 6. Juha and the Lost Donkey
            Story(title: "Juha and the Lost Donkey",
                  genre: "Comedy",
                  storycover: "lostDonkey",
                  pages: [
                    "It is said that Juha was walking in the market looking very sad. People asked: 'What’s wrong, Juha?'",
                    "He said, 'My donkey is lost!' They asked, 'Then why are you smiling?'",
                    "Juha replied, 'I thank God that I was not riding it, otherwise I would have been lost with it!'",
                    "Sometimes we should look at the half-full side of the cup; the problem could have been worse."
                  ], isFavorite: false),

            // 7. The Wise Man and the Same Joke
            Story(title: "The Wise Man and the Same Joke",
                  genre: "Wisdom",
                  storycover: "notFuny",
                  pages: [
                    "A wise man gathered people who always complained about the same problems. He told a funny joke and everyone laughed.",
                    "After a few minutes, he told the exact same joke again. This time, only a few people smiled.",
                    "Then he repeated the joke a third time. No one laughed.",
                    "He said: 'You cannot laugh at the same joke twice. So why do you cry about the same problems again and again?'"
                  ], isFavorite: false),
            
            // 8. The Mystery of the wise Judge
            Story(title: "The Mystery of the wise Judge",
                  genre: "Mystery",
                  storycover: "wiseJudge",
                  pages: [
                    "Two men came before a judge, each claiming ownership of a bag of money. There were no witnesses and no clear proof.",
                               
                    "The judge listened quietly, paying attention not only to their words but to their behavior. Instead of deciding immediately, he asked them to return the next day.",
                               
                    "When they did, he placed the bag between them and asked each man to describe its contents in detail.",
                               
                    "One spoke confidently, while the other hesitated. The judge then asked a simple question that unsettled one of them completely.",
                               
                    "In that moment, the truth became clear. The real owner remembered naturally, while the liar struggled to maintain a story he did not truly know."

                  ], isFavorite: false),
            
            // 9. The secret of the Missing Mansion
            Story(title: "The secret of the Missing Merchant",
                  genre: "Mystery",
                  storycover: "missingMerchant",
                  pages: [
                    "A well-known merchant vanished during a trading journey, and when the caravan returned without him, no one could explain what had happened.",
                               
                    "Rumors spread quickly. Some believed he had been robbed, others thought he had fled. Each traveler told a slightly different story.",
                               
                    "As time passed, small details surfaced — a sudden change of route, unusual silence, and a message he had left behind unnoticed.",
                               
                    "The message revealed no danger, only quiet words suggesting a desire to start over.",
                               
                    "Eventually, people understood that the merchant had planned his disappearance. The mystery was never about where he went, but why no one had seen his struggle before he left."


                  ], isFavorite: false),
            
            
            // 10. The Abandoned House
            Story(title: "The Abandoned House",
                  genre: "Mystery",
                  storycover: "AbandonedHouse 1",
                  pages: [
                    "At the edge of the village stood an abandoned house surrounded by stories of whispers and strange noises at night.",
                               
                    "One curious young man decided to spend a night inside to prove the stories wrong. As darkness fell, he began hearing footsteps and soft knocking sounds.",
                               
                    "Fear grew, but instead of running, he investigated. The sounds seemed to repeat at certain times.",
                               
                    "Searching carefully, he discovered broken openings in the walls where the wind passed through, creating the eerie noises.",
                               
                    "When morning came, he left with a new understanding: fear often grows where answers are missing, and mystery is sometimes born from misunderstanding rather than magic."

                  ], isFavorite: false),
            
            
            // 11. The Honest Merchant
            Story(title: "The Honest Merchant",
                  genre: "Wisdom",
                  storycover: "HonestMerchant",
                  pages: [
                    
                             "He was a brave diver. Taking a deep breath, he would plunge into the cool, clear water and swim past colorful coral reefs and curious schools of fish. For hours, he searched the ocean floor, opening shell after shell, hoping one might hide a treasure.",
                             
                             "Many days brought disappointment. Dozens of shells were empty, and he often sat in his boat feeling tired and discouraged. But he never allowed himself to quit. Thinking of his family’s smiles, he would whisper, 'Maybe the next shell will be the one.'",
                             
                             "One sunny afternoon, just as he was about to return home, he noticed a large, unusual oyster resting near a bright coral reef. He carefully brought it aboard and opened it slowly.",
                             
                             "A brilliant light sparkled from inside. There lay the most beautiful pearl he had ever seen — perfectly round, glowing like a tiny moon. He rushed back to shore where his family greeted him with joy, and the entire village celebrated his success.",
                             
                             "His achievement was not the result of luck alone, but of patience and relentless effort. From that day forward, he and his family lived happily, always remembering that hope is the greatest treasure of all."

                  ], isFavorite: false),
            
            // 12. The Fisherman and the Shining Pearl
            Story(title: "The Fisherman and the Shining Pearl",
                  genre: "Adventure",
                  storycover: "storyCover2",
                  pages: [
                    
                    "The Merchant and the Parrot",
                    "A merchant had a beautiful parrot that could talk. Every day, the parrot greeted customers and made them smile. The merchant loved his parrot very much.",
                    "One day, the merchant had to travel to another city for work. Before leaving, he asked the parrot, \"Do you want me to bring you anything?\"",
                    "The parrot replied, \"Yes. If you see parrots in the forest, tell them I live in a cage and ask how they stay happy.\"",
                    "When the merchant reached the forest, he told the wild parrots the message. Suddenly, one of the parrots fell from the tree and did not move. The merchant became sad and thought he had said something wrong.",
                    "When he returned home, he told his parrot what had happened. As soon as the parrot heard the story, it fell down in the cage and stopped moving. The merchant thought the parrot had died, so he opened the cage door.",
                    "Suddenly, the parrot flew out and sat on a tree. It said, \"The wild parrot was teaching me the secret of freedom.\""


                  ], isFavorite: false),
            
            // 14. Juha Got Slapped
            Story(title: "Juha Got Slapped",
                  genre: "Comedy",
                  storycover: "juhagotslapped",
                  pages: [
                    "One day, a man slapped Juha on the back of his head in the middle of the street, trying to mock him. Juha immediately grabbed the man and dragged him to the judge, refusing to accept his excuse that he had mistaken him for a friend.",
                               
                    "The man happened to be an acquaintance of the judge. Wanting to spare him punishment, the judge ruled that the man must either allow Juha to slap him back or pay him ten silver coins as compensation.",
                               
                    "Juha preferred the money and quickly asked the man, 'Do you have the coins with you?' The man, understanding the judge’s intention, replied, 'No, but I will go home and bring them shortly.'",
                               
                    "The judge permitted him to leave. The man went — and never returned. Juha waited for a long time until he realized the judge’s trick.",
                               
                    "Suddenly, Juha stepped closer to the judge as if to whisper something in his ear. Without warning, he gave the judge a strong slap and walked away, saying, 'When the man returns with the money, you may keep it on my behalf.'"

                  ], isFavorite: false),
            
            // 13. The Merchant and the Parrot
            Story(title: "The Merchant and the Parrot",
                  genre: "Wisdom",
                  storycover: "Parrot",
                  pages: [
                    "The Merchant and the Parrot",
                    "A merchant had a beautiful parrot that could talk. Every day, the parrot greeted customers and made them smile. The merchant loved his parrot very much.",
                    "One day, the merchant had to travel to another city for work. Before leaving, he asked the parrot, \"Do you want me to bring you anything?\"",
                    "The parrot replied, \"Yes. If you see parrots in the forest, tell them I live in a cage and ask how they stay happy.\"",
                    "When the merchant reached the forest, he told the wild parrots the message. Suddenly, one of the parrots fell from the tree and did not move. The merchant became sad and thought he had said something wrong.",
                    "When he returned home, he told his parrot what had happened. As soon as the parrot heard the story, it fell down in the cage and stopped moving. The merchant thought the parrot had died, so he opened the cage door.",
                    "Suddenly, the parrot flew out and sat on a tree. It said, \"The wild parrot was teaching me the secret of freedom.\""


                  ], isFavorite: false),
            
            
            
           
            

            // 15. The Old Man in the Village
            Story(title: "The Old Man in the Village",
                  genre: "Wisdom",
                  storycover: "happyMan",
                  pages: [
                    "In a village lived an old man who was the unhappiest person anyone knew. He complained constantly and spread gloom.",
                    "But on his 80th birthday, he started smiling. The villagers were shocked and asked what happened.",
                    "The old man replied, 'For 80 years, I chased happiness and never found it. Then I decided to stop chasing it and simply live. That is why I am happy now.'"
                  ], isFavorite: false)
        ]

        // SYNC LOGIC
        for item in masterList {
            guard let coverToSearch = item.storycover else { continue }
            
            let descriptor = FetchDescriptor<Story>(predicate: #Predicate { $0.storycover == coverToSearch })
            
            do {
                let existing = try context.fetch(descriptor)
                if existing.isEmpty {
                    context.insert(item)
                }
            } catch {
                print("Failed to fetch/sync story: \(error)")
            }
        }
        
        try? context.save()
    }
}
