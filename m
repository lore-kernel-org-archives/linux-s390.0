Return-Path: <owner-linux-mm@kvack.org>
Date: Mon, 17 Dec 2018 16:59:22 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [-next] lots of messages due to "mm, memory_hotplug: be more verbose
 for memory offline failures"
MIME-Version: 1.0
Message-Id: <20181217155922.GC3560@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Michal,

with linux-next as of today on s390 I see tons of messages like

[   20.536664] page dumped because: has_unmovable_pages
[   20.536792] page:000003d081ff4080 count:1 mapcount:0 mapping:000000008ff88600 index:0x0 compound_mapcount: 0
[   20.536794] flags: 0x3fffe0000010200(slab|head)
[   20.536795] raw: 03fffe0000010200 0000000000000100 0000000000000200 000000008ff88600
[   20.536796] raw: 0000000000000000 0020004100000000 ffffffff00000001 0000000000000000
[   20.536797] page dumped because: has_unmovable_pages
[   20.536814] page:000003d0823b0000 count:1 mapcount:0 mapping:0000000000000000 index:0x0
[   20.536815] flags: 0x7fffe0000000000()
[   20.536817] raw: 07fffe0000000000 0000000000000100 0000000000000200 0000000000000000
[   20.536818] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000

bisect points to b323c049a999 ("mm, memory_hotplug: be more verbose for memory offline failures")
which is the first commit with which the messages appear.

Note: there is _no_ memory hotplug involved when these messages appear.

I don't know if it helps, but this is the contents of /proc/zoneinfo:

Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 8
      nr_active_anon 8389
      nr_inactive_file 43418
      nr_active_file 22655
      nr_unevictable 0
      nr_slab_reclaimable 8192
      nr_slab_unreclaimable 11368
      nr_isolated_anon 0
      nr_isolated_file 0
      workingset_nodes 0
      workingset_refault 0
      workingset_activate 0
      workingset_restore 0
      workingset_nodereclaim 0
      nr_anon_pages 7088
      nr_mapped    16328
      nr_file_pages 66132
      nr_dirty     0
      nr_writeback 0
      nr_writeback_temp 0
      nr_shmem     55
      nr_shmem_hugepages 0
      nr_shmem_pmdmapped 0
      nr_anon_transparent_hugepages 4
      nr_unstable  0
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   20723
      nr_written   18227
      nr_kernel_misc_reclaimable 0
  pages free     519834
        min      1899
        low      2419
        high     2939
        spanned  524288
        present  524288
        managed  520562
        protection: (0, 3988, 3988)
      nr_free_pages 519834
      nr_zone_inactive_anon 0
      nr_zone_active_anon 0
      nr_zone_inactive_file 0
      nr_zone_active_file 0
      nr_zone_unevictable 0
      nr_zone_write_pending 0
      nr_mlock     0
      nr_page_table_pages 0
      nr_kernel_stack 0
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  0
      numa_hit     40
      numa_miss    0
      numa_foreign 0
      numa_interleave 12
      numa_local   40
      numa_other   0
  pagesets
    cpu: 0
              count: 336
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 1
              count: 60
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 2
              count: 60
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 3
              count: 0
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 4
              count: 62
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 5
              count: 0
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 6
              count: 59
              high:  378
              batch: 63
  vm stats threshold: 40
    cpu: 7
              count: 0
              high:  378
              batch: 63
  vm stats threshold: 40
  node_unreclaimable:  0
  start_pfn:           0
Node 0, zone   Normal
  pages free     912587
        min      3732
        low      4754
        high     5776
        spanned  1048576
        present  1048576
        managed  1022150
        protection: (0, 0, 0)
      nr_free_pages 912587
      nr_zone_inactive_anon 8
      nr_zone_active_anon 8389
      nr_zone_inactive_file 43418
      nr_zone_active_file 22655
      nr_zone_unevictable 0
      nr_zone_write_pending 0
      nr_mlock     0
      nr_page_table_pages 548
      nr_kernel_stack 3072
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  1024
      numa_hit     3115288
      numa_miss    0
      numa_foreign 0
      numa_interleave 6865
      numa_local   3115288
      numa_other   0
  pagesets
    cpu: 0
              count: 86
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 1
              count: 80
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 2
              count: 76
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 3
              count: 53
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 4
              count: 81
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 5
              count: 18
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 6
              count: 73
              high:  90
              batch: 15
  vm stats threshold: 48
    cpu: 7
              count: 63
              high:  90
              batch: 15
  vm stats threshold: 48
  node_unreclaimable:  0
  start_pfn:           524288
Node 0, zone  Movable
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0)
