package xyz.anomatver.grammy;

import java.util.List;

public class Page<T> {
    private List<T> objects;
    private Integer page;
    private Integer pageSize;
    private Integer totalPages;
    private Long totalCount;
}
