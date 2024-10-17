# Bird song classification using a custom filterbank combined with machine learning on audio segmentation 

I have together with Sara Elmgart, Linnea Sartorius och Theo Tatidis created a model to classify bird songs as a course project in mathematical modelling. Our final paper is located as a pdf in the repository. 

### Abstract

In this report we have developed a method to distinguish between chaffinches, house sparrows and barn owls by analyzing their chirps in the time and frequency domain. In previous studies, the Mel filter bank has been used for this purpose, but we intended to investigate whether a more specific filter bank, designed for the three birds mentioned, would be more suitable. Our method was constructed by identifying syllables of bird calls and the spaces between them, and then creating an average syllable for each species. Next, we developed a filter bank that puts the most weight on the frequencies that differed most between species, and then applied it to the average syllables and the unknown syllables we wanted to identify. Then, principal component analysis (PCA), Naive Bayes classifiers and a Matchat filter are used to determine which species the bird is likely to be. Finally, the reliability of the method is evaluated compared to if Mel filters had been used.



