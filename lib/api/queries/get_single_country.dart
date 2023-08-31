const getSingleCountry = r'''
         query GetCountryById($code:ID!){
         country(code: $code) {
         name native
         continent{ code }
         capital
         emoji
         currency
         emojiU
         awsRegion
         phones
         languages {
            code
           name
         }
       }
      }
        ''';
