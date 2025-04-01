
;;; ==== Шаблоны ====

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

;;; ==== База оружия ====

(deffacts weapons
   (weapon (name "AK-15")
           (category "Assault Rifle")
           (playstyle tactical)
           (range medium)
           (damage-type bullet)
           (description "Классический автомат с высоким уроном и хорошей универсальностью."))

   (weapon (name "SVD")
           (category "Sniper Rifle")
           (playstyle sniper)
           (range long)
           (damage-type bullet)
           (description "Полуавтоматическая снайперская винтовка для дальнего боя."))

   (weapon (name "Remington 870")
           (category "Shotgun")
           (playstyle aggressive)
           (range close)
           (damage-type pellet)
           (description "Надёжный дробовик для ближнего боя против мутантов."))

   (weapon (name "Gauss Gun")
           (category "Energy Rifle")
           (playstyle sniper)
           (range long)
           (damage-type energy)
           (description "Футуристическое энергетическое оружие с высокой точностью."))

   (weapon (name "AMB-17")
           (category "Assault Rifle")
           (playstyle agressive)
           (range close)
           (damage-type bullet)
           (description "Компактный автомат для скрытного боя на ближней дистанции.")))

;;; ==== Ввод игрока ====

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

;;; ==== Подбор оружия ====

(defrule match-weapon
   (player (playstyle ?p) (range ?r) (damage-type ?d))
   ?w <- (weapon (name ?n)
                 (category ?c)
                 (playstyle ?p)
                 (range ?r)
                 (damage-type ?d)
                 (description ?desc))
   =>
   (printout t crlf "?? Подходит: " ?n " (" ?c ")" crlf ?desc crlf crlf)
   (assert (recommendation-made)))

;;; ==== Нет подходящего оружия ====

(defrule no-match
   (player (playstyle ?p) (range ?r) (damage-type ?d))
   (not (recommendation-made))
   =>
   (printout t crlf "?? Не найдено подходящего оружия по указанным критериям." crlf)
   (printout t "Либо в базе его пока нет, либо оно несовместимо с выбранными параметрами." crlf))
