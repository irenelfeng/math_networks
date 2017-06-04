% load('all_images_users.mat')
% im = unique(images);
% countries = {};
% geography_map = containers.Map('KeyType','char', 'ValueType','any'); %maps from country -> index
% feature_imageID_map = containers.Map('KeyType','int64', 'ValueType','any'); %maps from index -> imageID
% field_count=0;
% image_count=0;
% for i=1:length(im)
%     country = meta_data(int2str(im(i)));
%     if(~isempty(country))
%        image_count = image_count +1;
%        feature_imageID_map(image_count) = im(i); %index -> imageID 
%        if (ismember(country, countries)) == 0
%             if it is in not yet in the countries, add it.
%             field_count = field_count + 1;
%             geography_map(country) = field_count;
%             countries = [countries country];
%         end
%         adds the field to feature matrix for this image
%         country_num = geography_map(country);
%         country_vector(image_count) = country_num; 
%     end
% end
%     
% save country_vector country_vector

% gets all continents for all countries
continent_vector = zeros(1, length(country_vector));
continents = containers.Map();
count = 0;
for i=1:length(country_vector);
   country = countries{country_vector(i)};
   continent = countryToContinent(country);
   if ~isKey(continents, continent)
       count = count +1;
       continents(continent) = count;
   end
   continent_vector(i) = continents(continent); %returns index
end

% then fill in random things
for i=1:17178
    country_images(i) =country_imageID_map(i);
end
for i=1:17187
    field_images(i) = feature_imageID_map(i);
end

field_images_not_country = setdiff(field_images, country_images);

% add them by splicing
for i=1:length(field_images_not_country)
    idx = find(field_images == field_images_not_country(i), 1);
    continent_vector = [continent_vector(1:idx-1) 0 continent_vector(idx:end)];
end

save continent_vector continent_vector
