
import Combine
import SwiftData



    /*
    let stories: [Story] = [
        //1.
        Story(
            title: "Layla and Majnun (Qays and Layla)",
            cover: "storyCover1",
            assets: ["storyCover1"],
            arabicStory: [
                "قصة قصيرة عن مفتاح ضائع يقود صاحبه لاكتشاف نفسه.",
                "استيقظ سامي في صباح هادئ، لكنه لم يجد مفتاحه في المكان المعتاد.",
                "نستكمل لاحقا"
            ],
            englishStory: [
                "Long ago in the Arabian desert, there lived a young boy named Qays ibn al-Mulawwah. When he was a child, he met a girl named Layla, and they studied together. As they grew older, a deep love formed between them. Qays loved Layla sincerely and expressed his feelings through poetry, mentioning her name in his verses.",
                "In their society, openly speaking about love was considered shameful. When Layla’s family heard about Qays’s poems, they refused to allow him to marry her. Despite his strong love and good intentions, her father rejected him. Later, Layla was married to another man.",
                "The separation broke Qays’s heart. He wandered alone in the desert, writing poems and calling Layla’s name. People noticed how deeply he suffered and began calling him “Majnun Layla,” which means “Layla’s mad lover.” His love became so intense that he lost interest in normal life, choosing instead to live among nature, animals, and memories of Layla.",
                "Although years passed, Qays never stopped loving her. Layla, too, loved him but remained bound by her circumstances. They rarely met again, and when they did, it was only briefly and from a distance.",
                "In the end, Qays died alone in the desert, still devoted to Layla. Soon after, Layla also passed away. Their story remained alive in poetry and literature, becoming one of the most famous love stories in Arabic culture — a symbol of pure, eternal, and tragic love."
            ],
            progress: 0,
            currentPage: 0,
            summary: "Layla and Majnun is one of the most famous love stories in Arabic literature. It tells the story of Qays ibn al-Mulawwah and Layla, whose love began in childhood but was separated by social traditions and family refusal. As time passed, Qays’s deep love turned into poetry and longing, earning him the name “Majnun,” meaning the mad lover. Their story became a timeless symbol of pure, faithful, and tragic love that lives on through generations."
            
        ),
        //2.
        Story(
            title: "The Fisherman and the Shining Pearl",
            cover: "storyCover2",
            assets: ["storyCover2"],
            arabicStory: [
                "قصة عن مكتبة هادئة تخفي أسرارًا غير متوقعة.",
                "دخلت ليلى المكتبة القديمة وشعرت أن الكتب تراقبها."
            ],
            englishStory: [
                "Once upon a time, there was a kind and hardworking fisherman. Every morning, before the sun came up, he would sail his small wooden boat into the vast blue sea. He wasn't just looking for fish; he was searching for a precious pearl to provide a better life for his wife and children. Even though he was poor, his heart was full of hope.",
                
                "The fisherman was a brave diver. He would take a deep breath and dive down into the cool, clear water. Under the sea, he swam past colorful coral reefs and schools of curious fish. He spent hours searching the ocean floor, picking up shells and hoping to find a treasure hidden inside.",
                "Not every day was easy. Many times, the fisherman opened dozens of shells only to find them empty. He would sit in his boat, feeling tired and a little bit sad. But he never gave up. He would look at the horizon, think of his family’s smiles, and say to himself,\"Maybe the next shell will be the one.\"",
                "One sunny afternoon, just as he was about to head back, he spotted a large, unique oyster tucked away near a bright coral. He brought it up to his boat and carefully pried it open. Suddenly, a brilliant light sparkled! Inside was the most beautiful, glowing pearl he had ever seen. It was perfect, round, and shining like a tiny moon.",
                "The fisherman sailed back to the shore as fast as he could. His children ran to meet him on the sand, and his wife welcomed him with a big smile. When he showed them the shining pearl, the whole village cheered! He had succeeded not just because of luck, but because of his incredible patience and hard work. From that day on, the fisherman and his family lived happily, always remembering that hope is the greatest treasure of all."
                
            ],
            progress: 0,
            currentPage: 0,
            summary: "The Fisherman and the Shining Pearl is an inspiring tale about patience, perseverance, and hope. It tells the story of a determined fisherman who faces many challenges in his daily quest for pearls. Despite numerous failures, he never loses faith. His unwavering effort eventually leads him to a beautiful discovery that changes his life. This story reminds us that hard work and determination can indeed lead to great success."
            
        ),
        //3.
        Story(
            title: "A Little Journey in the Great Desert",
            cover: "storyCover3",
            assets: ["storyCover3"],
            arabicStory: [
                "قصة بسيطة عن الروتين والمعنى الخفي فيه.",
                "جلس ناصر في المقهى يراقب الناس وهو يحتسي قهوته."
            ],
            englishStory: [
                "One sunny morning, a little traveler named Leo decided to go on an adventure! He put on his favorite hat and packed a small bag. His journey was to the big, golden desert. The sun was warm, and the sand stretched out like a giant, soft carpet. Leo felt excited and a little bit small in the huge world. He met his friendly camel, Sandy, who had kind, wise eyes. \"Hello, Sandy!\" Leo whispered, ready for their journey.",
                
                "As Leo and Sandy walked, the desert showed them amazing things. Big dunes looked like sleeping giants under the bright sky. The air was warm and quiet, and Leo listened to the soft sound of Sandy's feet on the sand. After a long walk, they saw something wonderful: a small oasis! Green palm trees stood tall, giving cool shade, and a clear pool of water sparkled in the sunlight. Leo and Sandy drank the cool water and rested, feeling refreshed and happy in this peaceful, secret place.",
                
                "When the sun began to set, the desert changed. The sky turned pink and orange, then slowly became a deep, dark blue. Suddenly, tiny lights appeared everywhere! The stars filled the sky, shining brighter than Leo had ever seen. He made a small campfire, and its orange light danced in the dark. Leo sat by the fire with Sandy, looking up at the amazing stars. He felt so happy and calm, thinking about how beautiful and big the world was.",
                
                "The next morning, the sun rose, painting the desert in gentle, warm colors again. Leo knew it was time to go home. His journey in the desert taught him many things. He learned to be patient, to be brave, and to see the simple beauty in nature. He would always remember the golden sands, the quiet oasis, and the sky full of shining stars. His heart was full of happy memories, and he knew he would always love the great desert."
            ],
            progress: 0,
            currentPage: 0,
            summary: "Our story follows a young, curious traveler who sets off on an extraordinary journey across the boundless desert. Accompanied by a gentle camel, the traveler experiences the desert's shifting moods: from the intense warmth of the golden daylight, where endless dunes stretch as far as the eye can see, to the serene tranquility of a hidden oasis. As night falls, the desert reveals its true splendor under a sky ablaze with countless stars, offering moments of quiet contemplation around a flickering campfire. This journey is more than just travel; it's a path to inner discovery, teaching valuable lessons about patience, courage, and the profound beauty found in the simplest moments of nature. It's a tale that reminds us to look beyond the surface and find wonder in the world around us."
        ),
        //4
        Story(
            title: "The Honest Merchant",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "هاتف قديم يعيد ذكريات منسية.",
                "عندما شغلت ريم الهاتف القديم، وصلتها رسالة غير متوقعة."
            ],
            englishStory: [
                "Once upon a time, in a bustling city, lived a merchant named Zaid. Unlike many others who sought profit at any cost, Zaid was known throughout the land for his unwavering honesty and integrity. He believed that a small, honest profit was better than a mountain of gold gained through deception.",
                
                "One day, Zaid purchased a large, old warehouse to store his silks and spices. While he was cleaning a dusty corner of the building, his shovel hit something hard. He dug deeper and discovered a heavy iron chest buried beneath the floor.",
                
                "When he opened it, his eyes widened in surprise. The chest was filled with sparkling jewels, ancient gold coins, and priceless pearls. Zaid was now holding a fortune that could make him the richest man in the kingdom.",
                
                "Zaid’s assistant, seeing the gold, whispered,\"Master, you are lucky! This treasure is yours. No one knows it exists. You can live like a king for the rest of your days.\"",
                
                "\"This gold does not belong to me. I bought the warehouse to store my goods, not to own what was hidden beneath it by someone else. My wealth must be earned, not taken.\"",
                
                "Zaid spent weeks researching the history of the warehouse. He eventually found an old, impoverished man who was the descendant of the original owner. Zaid called him and presented the iron chest",
                
                "The old man was moved to tears. \"I am a poor man, and this treasure belonged to my ancestors who lost everything. Why are you giving it back? You could have kept it, and I would have never known.\"",
                
                "Zaid smiled and said, \"I may be a merchant of goods, but I am also a merchant of truth. I cannot sell my conscience for any price.\""
                
                
            ],
            progress: 0,
            currentPage: 0,
            summary: " who traded in truth as much as he traded in goods. In a world obsessed with quick profits, Zaid faces a life-changing test when he discovers a hidden treasure beneath his warehouse. Will he choose instant wealth, or will he choose the peace of an honest conscience? This is a tale that proves integrity is the greatest investment one can ever make.",
        ),
        
        Story(
            title: "Desert Wind",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "قصة عن الصحراء والصوت الذي لا يسمعه الجميع.",
                "وقف خالد وسط الصحراء يستمع لصوت الرياح."
            ],
            englishStory: [
                
            ],
            progress: 0,
            currentPage: 0,
            summary: "The story follows Zaid, a merchant who traded in truth as much as he traded in goods. In a world obsessed with quick profits, Zaid faces a life-changing test when he discovers a hidden treasure beneath his warehouse. Will he choose instant wealth, or will he choose the peace of an honest conscience? This is a tale that proves integrity is the greatest investment one can ever make."
        ),
        
        Story(
            title: "The Small Shop",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "متجر صغير يحمل قصص سكان الحي.",
                "فتح العم حسن متجره كعادته قبل شروق الشمس."
            ],
            englishStory: [
                "A small shop that holds the neighborhood’s stories.",
                "Uncle Hassan opened his shop before sunrise, as usual."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "Rainy Afternoon",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "بعد ظهر ماطر يغير قرارًا مهمًا.",
                "جلست سارة قرب النافذة تراقب المطر."
            ],
            englishStory: [
                "A rainy afternoon that changes an important decision.",
                "Sarah sat by the window, watching the rain."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "The Empty Seat",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "مقعد فارغ يطرح أسئلة كثيرة.",
                "لاحظ يوسف المقعد الفارغ بجانبه في كل مرة."
            ],
            englishStory: [
                "An empty seat that raises many questions.",
                "Yousef noticed the empty seat beside him every time."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "Night Walk",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "نزهة ليلية تكشف حقيقة مخفية.",
                "خرجت مريم في نزهة قصيرة تحت ضوء القمر."
            ],
            englishStory: [
                "A night walk reveals a hidden truth.",
                "Maryam went for a short walk under the moonlight."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "The First Lesson",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "درس أول لا يُنسى.",
                "دخل أحمد الفصل وهو يشعر بالتوتر."
            ],
            englishStory: [
                "A first lesson that is never forgotten.",
                "Ahmed entered the classroom feeling nervous."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "The Letter",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "رسالة تصل في وقت غير متوقع.",
                "وجدت نورة رسالة قديمة بين كتبها."
            ],
            englishStory: [
                "A letter arrives at an unexpected time.",
                "Noura found an old letter between her books."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "The Long Road",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "طريق طويل يحمل أكثر من معنى.",
                "بدأت الرحلة مع شروق الشمس."
            ],
            englishStory: [
                "A long road with more than one meaning.",
                "The journey began at sunrise."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "Silent Friend",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "صديق صامت لكنه حاضر دائمًا.",
                "كان القط يجلس بجانبها كل مساء."
            ],
            englishStory: [
                "A silent friend who is always there.",
                "The cat sat beside her every evening."
            ],
            progress: 0,
            currentPage: 0,
            summary: "bla bla bla"
        ),
        
        Story(
            title: "The Open Window",
            cover: "storyCover4",
            assets: ["storyCover4"],
            arabicStory: [
                "نافذة مفتوحة على احتمالات جديدة.",
                "فتحت هناء النافذة وشعرت بالهواء البارد."
            ],
            englishStory: [
                "An open window to new possibilities.",
                "Hana opened the window and felt the cold air."
            ],
            progress: 0,
            currentPage: 1,
            summary: "bla bla bla"
        )
    ]

*/
