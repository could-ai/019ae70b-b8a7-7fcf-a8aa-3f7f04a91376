class StudySheet {
  final String id;
  final String title;
  final String subject;
  final String content;

  StudySheet({
    required this.id,
    required this.title,
    required this.subject,
    required this.content,
  });
}

class Flashcard {
  final String id;
  final String question;
  final String answer;
  final String subject;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.subject,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class Quiz {
  final String id;
  final String title;
  final String subject;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.subject,
    required this.questions,
  });
}

// --- DONNÉES DE DÉMONSTRATION (MOCK DATA) ---

final List<StudySheet> mockSheets = [
  StudySheet(
    id: '1',
    title: 'La Révolution Française',
    subject: 'Histoire',
    content: 'La Révolution française est une période de bouleversements sociaux et politiques radicaux en France...\n\nDates clés :\n- 1789 : Prise de la Bastille\n- 1792 : Proclamation de la République\n- 1799 : Coup d\'État de Napoléon Bonaparte',
  ),
  StudySheet(
    id: '2',
    title: 'Théorème de Pythagore',
    subject: 'Mathématiques',
    content: 'Dans un triangle rectangle, le carré de la longueur de l\'hypoténuse est égal à la somme des carrés des longueurs des deux autres côtés.\n\nFormule : a² + b² = c²',
  ),
  StudySheet(
    id: '3',
    title: 'Le Verbe Être',
    subject: 'Anglais',
    content: 'Conjugaison du verbe "To Be" au présent :\n\nI am\nYou are\nHe/She/It is\nWe are\nYou are\nThey are',
  ),
];

final List<Flashcard> mockFlashcards = [
  Flashcard(id: '1', question: 'Quelle est la capitale de la France ?', answer: 'Paris', subject: 'Géographie'),
  Flashcard(id: '2', question: 'Combien font 7 x 8 ?', answer: '56', subject: 'Mathématiques'),
  Flashcard(id: '3', question: 'Traduction de "Hello" ?', answer: 'Bonjour', subject: 'Anglais'),
  Flashcard(id: '4', question: 'Formule de l\'eau ?', answer: 'H2O', subject: 'Chimie'),
];

final List<Quiz> mockQuizzes = [
  Quiz(
    id: '1',
    title: 'Quiz Culture Générale',
    subject: 'Divers',
    questions: [
      QuizQuestion(
        question: 'Qui a peint la Joconde ?',
        options: ['Van Gogh', 'Léonard de Vinci', 'Picasso', 'Monet'],
        correctIndex: 1,
      ),
      QuizQuestion(
        question: 'Quelle planète est la plus proche du soleil ?',
        options: ['Vénus', 'Mars', 'Mercure', 'Terre'],
        correctIndex: 2,
      ),
    ],
  ),
  Quiz(
    id: '2',
    title: 'Quiz Mathématiques',
    subject: 'Maths',
    questions: [
      QuizQuestion(
        question: 'Racine carrée de 144 ?',
        options: ['10', '11', '12', '14'],
        correctIndex: 2,
      ),
      QuizQuestion(
        question: 'Quel est le nombre PI (approx) ?',
        options: ['3.14', '2.14', '4.12', '3.41'],
        correctIndex: 0,
      ),
    ],
  ),
];
