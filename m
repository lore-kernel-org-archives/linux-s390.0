Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019815B5B3
	for <linux-s390@vger.kernel.org>; Fri, 12 Jan 2024 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeCGgIpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705035801; x=1736571801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BEnMykRj0gfQ2uvwNbjSOsgkj/yi+JkdtVey25I3rHo=;
  b=VeCGgIpnn5yFqRmCNkGV8IZUOQxkDiTF43kNLhGUdTMWqpxmBaCQSRw8
   MWD79Ua0XN9XVp8aB5CGmUHo5pNJ4iGaolMo5RtjSaAMESJx3DeBDlRqr
   8i/fAI1w58RMVO3qUJuUnEcxYosd1bfNhyqCBg/O6WIz2AnIeKBR5xIas
   ukEPi7l+ej2uwXKQHT/Kgwq4KnoNW54/Xe00mz3I3eTWnYj+G21/bhCE1
   r8NLUt1HMy5Vzhk69ZkmonPeEvdWZ2jxS/Z5U1uVPP3CDjPr8U0PUTBJg
   UVlP+xANfrfX5/6P+uWa0T5t00yerYHuEM7+/DVvBeE4t4HnxgM13EFLx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5846060"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="5846060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 21:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="926274324"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="926274324"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2024 21:03:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO9hL-000954-29;
	Fri, 12 Jan 2024 05:03:15 +0000
Date: Fri, 12 Jan 2024 13:03:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, david@redhat.com,
	linux-s390@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 08/10] mm: Convert to should_zap_page() to
 should_zap_folio()
Message-ID: <202401121250.A221BL2D-lkp@intel.com>
References: <20240111152429.3374566-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111152429.3374566-9-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Add-pfn_swap_entry_folio/20240111-232757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111152429.3374566-9-willy%40infradead.org
patch subject: [PATCH v3 08/10] mm: Convert to should_zap_page() to should_zap_folio()
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121250.A221BL2D-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memory.c:1451:8: warning: variable 'folio' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                           if (page)
                               ^~~~
   mm/memory.c:1454:44: note: uninitialized use occurs here
                           if (unlikely(!should_zap_folio(details, folio)))
                                                                   ^~~~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   mm/memory.c:1451:4: note: remove the 'if' if its condition is always true
                           if (page)
                           ^~~~~~~~~
   mm/memory.c:1438:22: note: initialize the variable 'folio' to silence this warning
                   struct folio *folio;
                                      ^
                                       = NULL
   1 warning generated.


vim +1451 mm/memory.c

  1414	
  1415	static unsigned long zap_pte_range(struct mmu_gather *tlb,
  1416					struct vm_area_struct *vma, pmd_t *pmd,
  1417					unsigned long addr, unsigned long end,
  1418					struct zap_details *details)
  1419	{
  1420		struct mm_struct *mm = tlb->mm;
  1421		int force_flush = 0;
  1422		int rss[NR_MM_COUNTERS];
  1423		spinlock_t *ptl;
  1424		pte_t *start_pte;
  1425		pte_t *pte;
  1426		swp_entry_t entry;
  1427	
  1428		tlb_change_page_size(tlb, PAGE_SIZE);
  1429		init_rss_vec(rss);
  1430		start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
  1431		if (!pte)
  1432			return addr;
  1433	
  1434		flush_tlb_batched_pending(mm);
  1435		arch_enter_lazy_mmu_mode();
  1436		do {
  1437			pte_t ptent = ptep_get(pte);
  1438			struct folio *folio;
  1439			struct page *page;
  1440	
  1441			if (pte_none(ptent))
  1442				continue;
  1443	
  1444			if (need_resched())
  1445				break;
  1446	
  1447			if (pte_present(ptent)) {
  1448				unsigned int delay_rmap;
  1449	
  1450				page = vm_normal_page(vma, addr, ptent);
> 1451				if (page)
  1452					folio = page_folio(page);
  1453	
  1454				if (unlikely(!should_zap_folio(details, folio)))
  1455					continue;
  1456				ptent = ptep_get_and_clear_full(mm, addr, pte,
  1457								tlb->fullmm);
  1458				arch_check_zapped_pte(vma, ptent);
  1459				tlb_remove_tlb_entry(tlb, pte, addr);
  1460				zap_install_uffd_wp_if_needed(vma, addr, pte, details,
  1461							      ptent);
  1462				if (unlikely(!page)) {
  1463					ksm_might_unmap_zero_page(mm, ptent);
  1464					continue;
  1465				}
  1466	
  1467				delay_rmap = 0;
  1468				if (!folio_test_anon(folio)) {
  1469					if (pte_dirty(ptent)) {
  1470						folio_set_dirty(folio);
  1471						if (tlb_delay_rmap(tlb)) {
  1472							delay_rmap = 1;
  1473							force_flush = 1;
  1474						}
  1475					}
  1476					if (pte_young(ptent) && likely(vma_has_recency(vma)))
  1477						folio_mark_accessed(folio);
  1478				}
  1479				rss[mm_counter(page)]--;
  1480				if (!delay_rmap) {
  1481					folio_remove_rmap_pte(folio, page, vma);
  1482					if (unlikely(page_mapcount(page) < 0))
  1483						print_bad_pte(vma, addr, ptent, page);
  1484				}
  1485				if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
  1486					force_flush = 1;
  1487					addr += PAGE_SIZE;
  1488					break;
  1489				}
  1490				continue;
  1491			}
  1492	
  1493			entry = pte_to_swp_entry(ptent);
  1494			if (is_device_private_entry(entry) ||
  1495			    is_device_exclusive_entry(entry)) {
  1496				page = pfn_swap_entry_to_page(entry);
  1497				folio = page_folio(page);
  1498				if (unlikely(!should_zap_folio(details, folio)))
  1499					continue;
  1500				/*
  1501				 * Both device private/exclusive mappings should only
  1502				 * work with anonymous page so far, so we don't need to
  1503				 * consider uffd-wp bit when zap. For more information,
  1504				 * see zap_install_uffd_wp_if_needed().
  1505				 */
  1506				WARN_ON_ONCE(!vma_is_anonymous(vma));
  1507				rss[mm_counter(page)]--;
  1508				if (is_device_private_entry(entry))
  1509					folio_remove_rmap_pte(folio, page, vma);
  1510				folio_put(folio);
  1511			} else if (!non_swap_entry(entry)) {
  1512				/* Genuine swap entry, hence a private anon page */
  1513				if (!should_zap_cows(details))
  1514					continue;
  1515				rss[MM_SWAPENTS]--;
  1516				if (unlikely(!free_swap_and_cache(entry)))
  1517					print_bad_pte(vma, addr, ptent, NULL);
  1518			} else if (is_migration_entry(entry)) {
  1519				folio = pfn_swap_entry_folio(entry);
  1520				if (!should_zap_folio(details, folio))
  1521					continue;
  1522				rss[mm_counter(&folio->page)]--;
  1523			} else if (pte_marker_entry_uffd_wp(entry)) {
  1524				/*
  1525				 * For anon: always drop the marker; for file: only
  1526				 * drop the marker if explicitly requested.
  1527				 */
  1528				if (!vma_is_anonymous(vma) &&
  1529				    !zap_drop_file_uffd_wp(details))
  1530					continue;
  1531			} else if (is_hwpoison_entry(entry) ||
  1532				   is_poisoned_swp_entry(entry)) {
  1533				if (!should_zap_cows(details))
  1534					continue;
  1535			} else {
  1536				/* We should have covered all the swap entry types */
  1537				pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
  1538				WARN_ON_ONCE(1);
  1539			}
  1540			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
  1541			zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
  1542		} while (pte++, addr += PAGE_SIZE, addr != end);
  1543	
  1544		add_mm_rss_vec(mm, rss);
  1545		arch_leave_lazy_mmu_mode();
  1546	
  1547		/* Do the actual TLB flush before dropping ptl */
  1548		if (force_flush) {
  1549			tlb_flush_mmu_tlbonly(tlb);
  1550			tlb_flush_rmaps(tlb, vma);
  1551		}
  1552		pte_unmap_unlock(start_pte, ptl);
  1553	
  1554		/*
  1555		 * If we forced a TLB flush (either due to running out of
  1556		 * batch buffers or because we needed to flush dirty TLB
  1557		 * entries before releasing the ptl), free the batched
  1558		 * memory too. Come back again if we didn't do everything.
  1559		 */
  1560		if (force_flush)
  1561			tlb_flush_mmu(tlb);
  1562	
  1563		return addr;
  1564	}
  1565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
