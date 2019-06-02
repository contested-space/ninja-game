\include "articulate.ly"
\version "2.18.2"
#(set-global-staff-size 16)

\header {
  title = "Move In Ninja: Attack of the Evil JPS"
  subtitle = "Mini Game Jam 29: Ninjas @ itch.io"
  composer = "Simon Symeonidis"
}

taiko_verse = \repeat volta 2 {
  c8 c4 c8 c4~ c4 |
  c8 c4 c8 c8 c8~ c4 |
  c8 c4 c8 c4~ c4 |
  c8 c4 c8 c8 c8 <c c'>16 <c c'> <c c'> <c c'> |
}

bass_verse =  \repeat volta 2 {
  \relative c {
  \repeat unfold 2 { a8 a'16 a16 a,8 a'8 } |
  \repeat unfold 2 { f,8 f'16 f16 f,8 f'8 } |
  \repeat unfold 2 { g,8 g'16 g16 g,8 g'8 } |
  a,8 a'16 a16 a,8 a'8 c,8 c'16 c16 b,8 b'8 |
  }
}

music = {
  <<
  \new RhythmicStaff \with {
    instrumentName = #"taik"
    midiInstrument = #"taiko drum"
  }
  {
    \time 4/4
    \tempo 4 = 140

    \relative c' {
      c4\ffff c2. |

      %% verse
      \taiko_verse
      \taiko_verse

      %% chorus
      \repeat volta 2 {
        c4 c4 c4 c4 |
        c4 c4 c4 c8 c8 |
        c4 c4 c4 c4 |
        c4 c4 c16 c c c c c c c|
      }

      \repeat volta 2 {
        c4 c4 c4 c4 |
        c4 c4 c4 c8 c8 |
        c4 c4 c4 c4 |
        c4 c4 c16 c c c c c c c|
      }
    }
  }


  \new RhythmicStaff \with {
    instrumentName = #"bells"
    midiInstrument = #"tubular bells"
  }{
    r1 |
    \repeat volta 2 { r1 | r1 | r1 | r1 | }
    \repeat volta 2 { r1 | r1 | r1 | r1 | }
    \repeat volta 2 { r1 | r1 | <a a'>1 | r1 | }
    \repeat volta 2 { r1 | r1 | r1 | r1 | }
  }

  \new Staff \with {
    instrumentName = #"orc.hit"
    midiInstrument = #"orchestra hit"
  }{
    \relative c'' {
      g4 a4~ a2 |

      %% verse
      \repeat volta 2 { r1 | r1 | r1 | r1| }
      %% verse
      \repeat volta 2 { r1 | r1 | r1 | r1| }
      %% chorus
      a1 | r1 | r1 | r2. g4 |
      a1 | r1 | r1 | r2. g4 |
    }
  }

  \new Staff \with {
    instrumentName = #"elec.bass"
    midiInstrument = #"electric bass (pick)"
  }{
    \clef bass
    \time 4/4

    \relative c {
      \mark \default
      g4 a4~ a8 a16 a a8 a16 a |

      \mark \default
      \bass_verse
      \bass_verse

      \repeat volta 2 {
        a8.\staccato a16 g' fis d a16\staccato~ a16  a8\staccato  a16 g'16 fis16 d8 |
        a8.\staccato a16 g' fis d a16\staccato~ a16  a8\staccato  a16 g'16 fis16 d8 |
        a8.\staccato a16 g' fis d a16\staccato~ a16  a8\staccato  a16 g'16 fis16 d8 |
        a8. a16 g' fis d r16  c8 g'16 g fis8 d8 |
      }

      \repeat volta 2 {
        a8.\staccato a16 g' fis d a16\staccato~ a16  a8\staccato  a16 g'16 fis16 d8 |
        a8.\staccato a16 g' fis d a16\staccato~ a16  a8\staccato  a16 g'16 fis16 d8 |
        a8.\staccato a16 g' fis d a16\staccato~ a16  a8\staccato  a16 g'16 fis16 d8 |
        a8. a16 g' fis d r16  c8 g'16 g fis8 d8 |
      }
    }
  }

  \new Staff \with {
    instrumentName = #"sham"
    midiInstrument = #"shamisen"
  }{
    \clef treble
    \time 4/4

    r1 |

    \repeat volta 2 { r1 | r1 | r1 | r1 | }
    \repeat volta 2 {
      \relative c' {
        a8 a8 r8 g'16 e d c a c d8 e8 |
        a,8 a8 r8 g'16 e d c a c d4 |
        a8 a8 r8 g'16 e d c a c d8 e8 |

        a,8 a8
        g'16 a g e
        c' a c e
        c a g8 |
      }
    }

    \repeat volta 2 { r1 | r1 | r1 | r1 | }

    \repeat volta 2 {
      \relative c' {
        g'8 e d c a c d e |
        g8 e g a g fis d4 |
        g8 e d c a c d e |
        g8 e g a c g e' g, |
      }
    }
  }

  \new Staff \with {
    instrumentName = #"strings"
    midiInstrument = #"string ensemble 1"
  }{
    \clef treble
    \time 4/4

    \relative c'' {
      r1

      %% verse
      \repeat volta 2 { a1\fff | f1 | g1 | a1 |}
      %% verse
      \repeat volta 2 { r1 | r1 | r1 | r1 |}

      %% chorus
      \repeat volta 2 { r1 | r1 | r1 | r1 |}

      \ottava #+1
      \repeat volta 2 { <a' e >1~\ppp | <a e>~ | <a e> | <d, g g,>2 <d fis g,>2 |}
    }
  }
  >>
}

\score {
  \music
  \layout { }
}

\score {
  \unfoldRepeats { \music }
  \midi { }
}