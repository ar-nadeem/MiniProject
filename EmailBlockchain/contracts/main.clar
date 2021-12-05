(define-map voters { id: uint } { voter_name: (string-ascii 50)} )

(define-map candidates { id: uint}  { candidate_name: (string-ascii 50), symbol: (string-ascii 50), candidate }  )

(define-public (add_voter (voter_id uint) (votername (string-ascii 50))  )
(begin
    (map-insert voters {id: voter_id} {voter_name: votername} )
    (ok "voter added")
)
)

(define-public (add_candidate (c_id uint) (c_name (string-ascii 50 ) ) (c_symbol (string-ascii 50)))
(begin
    (map-insert candidates {id: c_id} {candidate_name: c_name, symbol: c_symbol})
    (ok "candidate added")
)

)



