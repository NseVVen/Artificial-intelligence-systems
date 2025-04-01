
;;; ==== ������� ====

(deftemplate player
   (slot playstyle)
   (slot range)
   (slot damage-type))

(deftemplate weapon
   (slot name)
   (slot category)
   (slot playstyle)
   (slot range)
   (slot damage-type)
   (slot description))

;;; ==== ���� ������ ====

(deffacts weapons
   (weapon (name "AK-15")
           (category "Assault Rifle")
           (playstyle tactical)
           (range medium)
           (damage-type bullet)
           (description "������������ ������� � ������� ������ � ������� ����������������."))

   (weapon (name "SVD")
           (category "Sniper Rifle")
           (playstyle sniper)
           (range long)
           (damage-type bullet)
           (description "������������������ ����������� �������� ��� �������� ���."))

   (weapon (name "Remington 870")
           (category "Shotgun")
           (playstyle aggressive)
           (range close)
           (damage-type pellet)
           (description "������� �������� ��� �������� ��� ������ ��������."))

   (weapon (name "Gauss Gun")
           (category "Energy Rifle")
           (playstyle sniper)
           (range long)
           (damage-type energy)
           (description "��������������� �������������� ������ � ������� ���������."))

   (weapon (name "AMB-17")
           (category "Assault Rifle")
           (playstyle agressive)
           (range close)
           (damage-type bullet)
           (description "���������� ������� ��� ��������� ��� �� ������� ���������.")))

;;; ==== ���� ������ ====

(defrule initialize
   (declare (salience 100))
   =>
   (printout t "Choose a style of play (aggressive, tactical, sniper): " crlf)
   (bind ?playstyle (read))

   (printout t "Preferred distance (close, medium, long): " crlf)
   (bind ?range (read))

   (printout t "Type of ammunition (bullet, pellet, energy): " crlf)
   (bind ?damage (read))

   (assert (player (playstyle ?playstyle)
                   (range ?range)
                   (damage-type ?damage))))

;;; ==== ������ ������ ====

(defrule match-weapon
   (player (playstyle ?p) (range ?r) (damage-type ?d))
   ?w <- (weapon (name ?n)
                 (category ?c)
                 (playstyle ?p)
                 (range ?r)
                 (damage-type ?d)
                 (description ?desc))
   =>
   (printout t crlf "?? ��������: " ?n " (" ?c ")" crlf ?desc crlf crlf)
   (assert (recommendation-made)))

;;; ==== ��� ����������� ������ ====

(defrule no-match
   (player (playstyle ?p) (range ?r) (damage-type ?d))
   (not (recommendation-made))
   =>
   (printout t crlf "?? �� ������� ����������� ������ �� ��������� ���������." crlf)
   (printout t "���� � ���� ��� ���� ���, ���� ��� ������������ � ���������� �����������." crlf))
