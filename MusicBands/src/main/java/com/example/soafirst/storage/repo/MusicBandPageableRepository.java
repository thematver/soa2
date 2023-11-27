package com.example.soafirst.storage.repo;

import com.example.soafirst.storage.entity.*;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;
import javax.persistence.criteria.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class MusicBandPageableRepository extends SimpleJpaRepository<MusicBand, Long> {
    @PersistenceContext(type = PersistenceContextType.EXTENDED)
    private final EntityManager entityManager;

    public MusicBandPageableRepository(EntityManager em) {
        super(MusicBand.class, em);
        this.entityManager = em;
    }

    public List<MusicBand> getAllFilterPageable(Map<String, String> fields, Integer page, Integer limit) {
        CriteriaBuilder builder = entityManager.getCriteriaBuilder();
        CriteriaQuery<MusicBand> musicBandQuery = builder.createQuery(MusicBand.class);
        Root<MusicBand> root = musicBandQuery.from(MusicBand.class);
        musicBandQuery.select(root);
        musicBandQuery.where(preparePredicatesFromFilter(builder, fields, root));
        return entityManager.createQuery(musicBandQuery)
                .setFirstResult((page - 1) * limit)
                .setMaxResults(limit)
                .getResultList();
    }

    public List<MusicBand> getAllFilterSortedPageable(Map<String, String> fields, Integer page, Integer limit, String sortParam, String direction) {
        if (direction == null) {
            direction = "DESC";
        }
        CriteriaBuilder builder = entityManager.getCriteriaBuilder();
        CriteriaQuery<MusicBand> musicBandQuery = builder.createQuery(MusicBand.class);
        Root<MusicBand> root = musicBandQuery.from(MusicBand.class);
        musicBandQuery.select(root);
        if (direction.equals("ASC")) {
            if (sortParam.equals("x")) {
                musicBandQuery.orderBy(builder.asc(root.get("coordinates").get("x")));
            }
            else if (sortParam.equals("y")) {
                musicBandQuery.orderBy(builder.asc(root.get("coordinates").get("y")));
            }
            else if (sortParam.equals("studio")) {
                musicBandQuery.orderBy(builder.asc(root.get("studio").get("name")));
            }
            else {
                musicBandQuery.orderBy(builder.asc(root.get(sortParam)));
            }
        }
        else {
            if (sortParam.equals("x")) {
                musicBandQuery.orderBy(builder.desc(root.get("coordinates").get("x")));
            }
            else if (sortParam.equals("y")) {
                musicBandQuery.orderBy(builder.desc(root.get("coordinates").get("y")));
            }
            else if (sortParam.equals("studio")) {
                musicBandQuery.orderBy(builder.desc(root.get("studio").get("name")));
            }
            else {
                musicBandQuery.orderBy(builder.desc(root.get(sortParam)));
            }
        }
        musicBandQuery.where(preparePredicatesFromFilter(builder, fields, root));
        return entityManager.createQuery(musicBandQuery)
                .setFirstResult((page - 1) * limit)
                .setMaxResults(limit)
                .getResultList();
    }

    private Predicate[] preparePredicatesFromFilter(CriteriaBuilder builder, Map<String, String> fields, Root<MusicBand> root) {
        List<Predicate> predicates = new ArrayList<>();
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            if (entry.getKey().equals("creationDate")) {
                predicates.add(builder.equal(root.get(entry.getKey()), LocalDateTime.parse(entry.getValue())));
            }
            else if (entry.getKey().equals("musicGenre")) {
                predicates.add(builder.equal(root.get(entry.getKey()), MusicGenre.valueOf(entry.getValue())));
            }
            else if (entry.getKey().equals("id")) {
                predicates.add(builder.equal(root.get(entry.getKey()), Long.parseLong(entry.getValue())));
            }
            else if (entry.getKey().equals("x")) {
                predicates.add(builder.equal(root.get("coordinates").get("x"), Float.parseFloat(entry.getValue())));
            }
            else if (entry.getKey().equals("y")) {
                predicates.add(builder.equal(root.get("coordinates").get("y"), Long.parseLong(entry.getValue())));
            }
            else if (entry.getKey().equals("studio")) {
                predicates.add(builder.equal(root.get("studio").get("name"), entry.getValue()));
            }
            else if (entry.getKey().equals("numberOfParticipants")) {
                predicates.add(builder.equal(root.get(entry.getKey()), Long.parseLong(entry.getValue())));
            }
            else {
                predicates.add(builder.equal(root.get(entry.getKey()), entry.getValue()));
            }
        }
        return predicates.toArray(new Predicate[0]);
    }
}
