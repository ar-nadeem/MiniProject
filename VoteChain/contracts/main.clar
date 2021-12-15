;; Hold voter name
(define-map voters { id: uint } { voter_name: (string-ascii 50)} )

;; Holds Candidate Information
(define-map candidates { id: uint}  { candidate_name: (string-ascii 50), symbol: (string-ascii 50), candidate_count: uint })

;; Variable for max_votes
(define-data-var max_votes uint u0)

;; Vote Casted by voters
(define-map vote_casted { id: uint } { voter_name: (string-ascii 50)})

;; Variable Stored name of the winner
(define-data-var name_of_winner (string-ascii 50) "Blank" )

;;defining error 
(define-constant castvoteagain u200)
(define-constant non-existingid u300)
(define-constant vote_casted_err u310)

;; variable for ids
(define-data-var candidate_ids uint u0)

;; Function adds a voter to the Map
(define-public (add_voter (voter_id uint) (votername (string-ascii 50))  )
(begin
    (map-insert voters {id: voter_id} {voter_name: votername} )
    (ok "voter added")
)
)

;; Function adds Candidate to the map
(define-public (add_candidate (c_name (string-ascii 50)) (c_symbol (string-ascii 50)))
(begin 
    (map-insert candidates {id: (var-get candidate_ids)} {candidate_name: c_name, symbol: c_symbol, candidate_count: u0})
    (var-set candidate_ids (+ (var-get candidate_ids) u1 ))
    (ok true)
)
)   

(define-public (cast_vote (v_id uint) (v_name (string-ascii 50) ) (c_id uint) (c_name (string-ascii 50 ) ) (c_symbol (string-ascii 50))  )
(begin
(let
    (
        ;; Throws error of non existing-id 
        (voter_name_Throw (get voter_name (unwrap! (map-get? voters { id: v_id }) (err non-existingid))))
        ;; Throws error of recasting vote
        (casted_id_Throw (get voter_name (unwrap! (map-get? vote_casted { id: v_id }) (err vote_casted_err))))
        
    )
    ;; If No errors then cast the vote
    (map-set vote_casted {id: c_id} {voter_name: v_name})

    (ok "Done")
)
)
)

(define-private (increment_count_voters (c_id uint) (c_candidate_name (string-ascii 50) ) (c_symbol (string-ascii 50)) )
;;let allows us to create local variable in a function
(begin
    (let
    (
        ;; Get Existing count and +1 it
        (current_count (+ (get candidate_count (unwrap! (map-get? candidates { id: c_id }) (err non-existingid))) u1))
        
    )

    ;; Set it with given ids and count from let
    (map-set candidates {id: c_id} {candidate_name: c_candidate_name, symbol: c_symbol, candidate_count: current_count})
    (ok "Done")
)
)
)

;;filter the data of candidate from map
;; (define-private (my_winner_filter (temp  { id: uint}  { candidate_name: (string-ascii 50), symbol: (string-ascii 50), candidate_count: uint }))
;;     (begin
;;     (if (< (var-get max_votes) (get candidate_count temp))
;;         (ok (var-set max_votes (get candidate_count temp))
;;             (var-set name_of_winner (get candidate_name temp)) 
;;         )
;;     )
    
;;     (ok true)
;;     )
;; )

;; (define-public (get_winner)
;;     (let 
;;         (test (filter my_winner_filter candidates))
;;     )
;;     (ok "Election Over!")
;; )