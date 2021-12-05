(define-map voters { id: uint } { voter_name: (string-ascii 50)} )

(define-map candidates { id: uint}  { candidate_name: (string-ascii 50), symbol: (string-ascii 50), candidate_count: uint }  )

(define-map vote_casted { id: uint } { voter_name: (string-ascii 50)} )

(define-public (add_voter (voter_id uint) (votername (string-ascii 50))  )
(begin
    (map-insert voters {id: voter_id} {voter_name: votername} )
    (ok "voter added")
)
)

(define-public (add_candidate (c_id uint) (c_name (string-ascii 50 ) ) (c_symbol (string-ascii 50)))
(begin
    (map-insert candidates {id: c_id} {candidate_name: c_name, symbol: c_symbol, 0})
    (ok "candidate added")
)

)

(define-public (cast_vote (v_id: uint) (v_name (string-ascii 50) ) (c_id uint) (c_name (string-ascii 50 ) ) (c_symbol (string-ascii 50))  )
(begin
     ;;getting id from voters list if not present returs error
     (voter_id (get id (unwrap! (map-get? voters { id: v_id }) (err non-existingid))))
     ;;geting casted id and if not presnt inserts it and increase counter of candidate
     (casted_id (get id (unwrap! (map-get? vote_casted { id: v_id }) (map set vote_casted v_id v_name))))
     ;;if casted id is present then prevent from casting again
     (asserts (is-eq casted_id voter_id) (err can't cast vote again))

     
)
)


