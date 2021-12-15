(define-map voters { id: uint } { voter_name: (string-ascii 50)} )

(define-map candidates { id: uint}  { candidate_name: (string-ascii 50), symbol: (string-ascii 50), candidate_count: uint })

(define-data-var max_votes uint u0)

(define-map vote_casted { id: uint } { voter_name: (string-ascii 50)})

(define-data-var name_of_winner (string-ascii 50) "Blank" )

(define-public (add_voter (voter_id uint) (votername (string-ascii 50))  )
(begin
    (map-insert voters {id: voter_id} {voter_name: votername} )
    (ok "voter added")
)
)
;;defining error 
(define-constant castvoteagain u200)
;; variable for ids
(define-data-var candidate_ids uint u0)

;;making list for no.of counts
(list 20 votes uint)

;;filter the data of candidate from map
(define-private (my_winner_filter (temp  { id: uint}  { candidate_name: (string-ascii 50), symbol: (string-ascii 50), candidate_count: uint }))
    (begin
    (if (< (var-get max_votes) (get candidate_count temp))
        (ok (var-set max_votes (get candidate_count temp))
            (var-set name_of_winner (get candidate_name temp)) 
        )
    )
    
    (ok true)
    )
)


(define-public (add_candidate (c_name (string-ascii 50 ) ) (c_symbol (string-ascii 50)))
(begin 
    (map-insert candidates {id: candidate_ids} {candidate_name: c_name, symbol: c_symbol, candidate_count: 0})
    (var-set candidate_ids (+ candidate_ids u1 ))
    (ok true)
)

)   

(define-private (increment_count_voters (v_id uint) (candidate_name (string-ascii 50) ) (c_symbol (string-ascii 50)) )
;;let allows us to create local variable in a function
    (begin 
    (let  
    (
       (current_count (default-to u0 ( get candidate_count ( map-get? candidates {id: v_id}))))
    )
    )
    (var-set current_count (+ current_count u1))
    ((map-set candidates { id: v_id}  { candidate_name: candidate_name} {symbol: c_symbol} {candidate_count: current_count}))
    )
)

(define-public (cast_vote (v_id uint) (v_name (string-ascii 50) ) (c_id uint) (c_name (string-ascii 50 ) ) (c_symbol (string-ascii 50))  )
(begin
     ;;getting id from voters list if not present returs error
     (voter_id (get id (unwrap! (map-get? voters { id: v_id }) (err non-existingid))))
     ;;geting casted id and if not presnt inserts it and increase counter of candidate
     (casted_id (get id (unwrap! (map-get? vote_casted { id: v_id }) (map-set vote_casted v_id v_name))))
     ;;if casted id is present then prevent from casting again
     (asserts (is-eq casted_id voter_id) (err castvoteagain))
    ;;(increment_count_voters ((c_id) (c_name) (c_symbol)) )
)
)

(define-public (get_winner)
    (let 
        (test (filter my_winner_filter candidates))
    )
    (ok "Election Over!")
)

 ;;getwinner
 ;;indivial party vote counts
 ;;lowest voted party
 ;; study fold function