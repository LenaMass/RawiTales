import Foundation
import SwiftData
import Combine

struct StoriesLibrary {
    static func syncLibrary(in context: ModelContext) {
        let masterList = [
            // 1. You Can Never Please Everyone
            Story(title: "You Can Never Please Everyone",
                  genre: "Romance",
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
                  genre: "Romance",
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
                  genre: "Romance",
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
                  genre: "Comedy",
                  storycover: "notFuny",
                  pages: [
                    "A wise man gathered people who always complained about the same problems. He told a funny joke and everyone laughed.",
                    "After a few minutes, he told the exact same joke again. This time, only a few people smiled.",
                    "Then he repeated the joke a third time. No one laughed.",
                    "He said: 'You cannot laugh at the same joke twice. So why do you cry about the same problems again and again?'"
                  ], isFavorite: false),

            // 8. The Old Man in the Village
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
