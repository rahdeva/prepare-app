//
//  TopicData.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation

enum TopicData {
    static let categoryOrder = ["CAREER", "PERSONAL GROWTH", "EDUCATION"]

    static let topics: [Topic] = [
        // CAREER
        Topic(id: "job_interview", title: "Job Interview", icon: "briefcase.fill", category: "CAREER", categoryOrder: 0),
        Topic(id: "teamwork", title: "Teamwork", icon: "person.3.fill", category: "CAREER", categoryOrder: 0),
        Topic(id: "career_goals", title: "Career Goals", icon: "flag.fill", category: "CAREER", categoryOrder: 0),
        Topic(id: "leadership", title: "Leadership", icon: "star.fill", category: "CAREER", categoryOrder: 0),
        Topic(id: "work_life_balance", title: "Work-Life Balance", icon: "heart.circle.fill", category: "CAREER", categoryOrder: 0),

        // PERSONAL GROWTH
        Topic(id: "personal_growth", title: "Personal Growth", icon: "leaf.fill", category: "PERSONAL GROWTH", categoryOrder: 1),
        Topic(id: "communication", title: "Communication Skills", icon: "bubble.left.and.bubble.right.fill", category: "PERSONAL GROWTH", categoryOrder: 1),
        Topic(id: "problem_solving", title: "Problem Solving", icon: "lightbulb.fill", category: "PERSONAL GROWTH", categoryOrder: 1),

        // EDUCATION
        Topic(id: "public_speaking", title: "Public Speaking", icon: "mic.fill", category: "EDUCATION", categoryOrder: 2),
        Topic(id: "learning", title: "Learning & Study", icon: "book.fill", category: "EDUCATION", categoryOrder: 2),
    ]

    static let questions: [Question] = [
        // MARK: - Job Interview (10)
        Question(id: "ji_1", topicId: "job_interview", text: "What is your greatest weakness?"),
        Question(id: "ji_2", topicId: "job_interview", text: "Tell me about yourself."),
        Question(id: "ji_3", topicId: "job_interview", text: "Why should we hire you?"),
        Question(id: "ji_4", topicId: "job_interview", text: "Where do you see yourself in five years?"),
        Question(id: "ji_5", topicId: "job_interview", text: "Why are you leaving your current job?"),
        Question(id: "ji_6", topicId: "job_interview", text: "What motivates you at work?"),
        Question(id: "ji_7", topicId: "job_interview", text: "Describe a challenging situation you faced at work and how you handled it."),
        Question(id: "ji_8", topicId: "job_interview", text: "What are your salary expectations?"),
        Question(id: "ji_9", topicId: "job_interview", text: "Why do you want to work for this company?"),
        Question(id: "ji_10", topicId: "job_interview", text: "What makes you unique compared to other candidates?"),

        // MARK: - Teamwork (10)
        Question(id: "tw_1", topicId: "teamwork", text: "Describe a time you worked effectively as part of a team."),
        Question(id: "tw_2", topicId: "teamwork", text: "How do you handle conflicts with coworkers?"),
        Question(id: "tw_3", topicId: "teamwork", text: "What role do you usually take in a team?"),
        Question(id: "tw_4", topicId: "teamwork", text: "How do you deal with a team member who isn't pulling their weight?"),
        Question(id: "tw_5", topicId: "teamwork", text: "Describe a successful team project you contributed to."),
        Question(id: "tw_6", topicId: "teamwork", text: "How do you build trust with new team members?"),
        Question(id: "tw_7", topicId: "teamwork", text: "What do you do when you disagree with a team decision?"),
        Question(id: "tw_8", topicId: "teamwork", text: "How do you ensure effective communication within a team?"),
        Question(id: "tw_9", topicId: "teamwork", text: "Describe a time you had to compromise for the team's benefit."),
        Question(id: "tw_10", topicId: "teamwork", text: "What makes a great team in your opinion?"),

        // MARK: - Career Goals (10)
        Question(id: "cg_1", topicId: "career_goals", text: "What are your long-term career goals?"),
        Question(id: "cg_2", topicId: "career_goals", text: "How do you plan to achieve your professional goals?"),
        Question(id: "cg_3", topicId: "career_goals", text: "What skills do you want to develop in the next year?"),
        Question(id: "cg_4", topicId: "career_goals", text: "Where do you see your career heading in the next decade?"),
        Question(id: "cg_5", topicId: "career_goals", text: "What professional achievement are you most proud of?"),
        Question(id: "cg_6", topicId: "career_goals", text: "How do you stay current in your field?"),
        Question(id: "cg_7", topicId: "career_goals", text: "What would your ideal career path look like?"),
        Question(id: "cg_8", topicId: "career_goals", text: "How do you measure success in your career?"),
        Question(id: "cg_9", topicId: "career_goals", text: "What role does mentorship play in your career development?"),
        Question(id: "cg_10", topicId: "career_goals", text: "What industry trends excite you the most?"),

        // MARK: - Leadership (10)
        Question(id: "ld_1", topicId: "leadership", text: "Describe your leadership style."),
        Question(id: "ld_2", topicId: "leadership", text: "How do you motivate others?"),
        Question(id: "ld_3", topicId: "leadership", text: "Tell me about a time you led a team through a difficult situation."),
        Question(id: "ld_4", topicId: "leadership", text: "How do you handle underperforming team members?"),
        Question(id: "ld_5", topicId: "leadership", text: "What qualities make an effective leader?"),
        Question(id: "ld_6", topicId: "leadership", text: "How do you make tough decisions as a leader?"),
        Question(id: "ld_7", topicId: "leadership", text: "Describe a time you had to lead by example."),
        Question(id: "ld_8", topicId: "leadership", text: "How do you balance authority with approachability?"),
        Question(id: "ld_9", topicId: "leadership", text: "What is the most important lesson you learned as a leader?"),
        Question(id: "ld_10", topicId: "leadership", text: "How do you develop future leaders within your team?"),

        // MARK: - Work-Life Balance (10)
        Question(id: "wlb_1", topicId: "work_life_balance", text: "How do you maintain work-life balance?"),
        Question(id: "wlb_2", topicId: "work_life_balance", text: "What do you do to manage stress at work?"),
        Question(id: "wlb_3", topicId: "work_life_balance", text: "How do you prioritize tasks when everything feels urgent?"),
        Question(id: "wlb_4", topicId: "work_life_balance", text: "Describe your ideal work environment."),
        Question(id: "wlb_5", topicId: "work_life_balance", text: "How do you set boundaries between work and personal life?"),
        Question(id: "wlb_6", topicId: "work_life_balance", text: "What hobbies or activities help you recharge?"),
        Question(id: "wlb_7", topicId: "work_life_balance", text: "How do you handle working overtime or tight deadlines?"),
        Question(id: "wlb_8", topicId: "work_life_balance", text: "What does a healthy work culture look like to you?"),
        Question(id: "wlb_9", topicId: "work_life_balance", text: "How do you stay productive without burning out?"),
        Question(id: "wlb_10", topicId: "work_life_balance", text: "What strategies do you use to manage your time effectively?"),

        // MARK: - Personal Growth (10)
        Question(id: "pg_1", topicId: "personal_growth", text: "What is the most important lesson you've learned in life?"),
        Question(id: "pg_2", topicId: "personal_growth", text: "How do you handle failure?"),
        Question(id: "pg_3", topicId: "personal_growth", text: "What personal quality are you most proud of?"),
        Question(id: "pg_4", topicId: "personal_growth", text: "Describe a time you stepped out of your comfort zone."),
        Question(id: "pg_5", topicId: "personal_growth", text: "How do you set and achieve personal goals?"),
        Question(id: "pg_6", topicId: "personal_growth", text: "What book or experience has had the biggest impact on you?"),
        Question(id: "pg_7", topicId: "personal_growth", text: "How do you handle criticism?"),
        Question(id: "pg_8", topicId: "personal_growth", text: "What does success mean to you personally?"),
        Question(id: "pg_9", topicId: "personal_growth", text: "How do you stay motivated during difficult times?"),
        Question(id: "pg_10", topicId: "personal_growth", text: "What is one thing you would change about yourself and why?"),

        // MARK: - Communication Skills (10)
        Question(id: "cs_1", topicId: "communication", text: "How do you adapt your communication style for different audiences?"),
        Question(id: "cs_2", topicId: "communication", text: "Describe a time you had to deliver bad news."),
        Question(id: "cs_3", topicId: "communication", text: "How do you ensure your message is clearly understood?"),
        Question(id: "cs_4", topicId: "communication", text: "What role does active listening play in your communication?"),
        Question(id: "cs_5", topicId: "communication", text: "How do you handle misunderstandings in conversation?"),
        Question(id: "cs_6", topicId: "communication", text: "Describe a time your communication skills helped resolve a problem."),
        Question(id: "cs_7", topicId: "communication", text: "How do you prepare for an important presentation?"),
        Question(id: "cs_8", topicId: "communication", text: "What makes someone an effective communicator?"),
        Question(id: "cs_9", topicId: "communication", text: "How do you give constructive feedback to others?"),
        Question(id: "cs_10", topicId: "communication", text: "How do you handle communication in a remote work setting?"),

        // MARK: - Problem Solving (10)
        Question(id: "ps_1", topicId: "problem_solving", text: "Describe your approach to solving complex problems."),
        Question(id: "ps_2", topicId: "problem_solving", text: "Tell me about a time you solved a problem creatively."),
        Question(id: "ps_3", topicId: "problem_solving", text: "How do you handle a situation where you don't have all the information?"),
        Question(id: "ps_4", topicId: "problem_solving", text: "What steps do you take to analyze a problem before acting?"),
        Question(id: "ps_5", topicId: "problem_solving", text: "Describe a time you had to make a quick decision under pressure."),
        Question(id: "ps_6", topicId: "problem_solving", text: "How do you evaluate whether a solution is effective?"),
        Question(id: "ps_7", topicId: "problem_solving", text: "What do you do when your initial solution doesn't work?"),
        Question(id: "ps_8", topicId: "problem_solving", text: "How do you involve others in the problem-solving process?"),
        Question(id: "ps_9", topicId: "problem_solving", text: "Describe a time you identified a problem before it became critical."),
        Question(id: "ps_10", topicId: "problem_solving", text: "What is the most challenging problem you have ever solved?"),

        // MARK: - Public Speaking (10)
        Question(id: "psp_1", topicId: "public_speaking", text: "How do you prepare for a public speaking engagement?"),
        Question(id: "psp_2", topicId: "public_speaking", text: "What techniques do you use to manage stage fright?"),
        Question(id: "psp_3", topicId: "public_speaking", text: "Describe a memorable presentation you gave."),
        Question(id: "psp_4", topicId: "public_speaking", text: "How do you engage your audience during a speech?"),
        Question(id: "psp_5", topicId: "public_speaking", text: "What do you do when you lose your train of thought while speaking?"),
        Question(id: "psp_6", topicId: "public_speaking", text: "How do you handle tough questions from the audience?"),
        Question(id: "psp_7", topicId: "public_speaking", text: "What makes a speech truly impactful?"),
        Question(id: "psp_8", topicId: "public_speaking", text: "How do you tailor your presentation to your audience?"),
        Question(id: "psp_9", topicId: "public_speaking", text: "Describe a time public speaking helped you achieve a goal."),
        Question(id: "psp_10", topicId: "public_speaking", text: "What advice would you give to someone afraid of public speaking?"),

        // MARK: - Learning & Study (10)
        Question(id: "ls_1", topicId: "learning", text: "What is your preferred method of learning new things?"),
        Question(id: "ls_2", topicId: "learning", text: "How do you stay disciplined with your study routine?"),
        Question(id: "ls_3", topicId: "learning", text: "Describe a time you had to learn something quickly."),
        Question(id: "ls_4", topicId: "learning", text: "What role does curiosity play in your learning?"),
        Question(id: "ls_5", topicId: "learning", text: "How do you handle subjects or topics that you find difficult?"),
        Question(id: "ls_6", topicId: "learning", text: "What is the most valuable thing you've learned outside of school?"),
        Question(id: "ls_7", topicId: "learning", text: "How do you apply what you learn in real life?"),
        Question(id: "ls_8", topicId: "learning", text: "What motivates you to keep learning?"),
        Question(id: "ls_9", topicId: "learning", text: "How do you balance learning new skills with mastering existing ones?"),
        Question(id: "ls_10", topicId: "learning", text: "Describe a learning experience that changed your perspective."),
    ]
}
