Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE340242C;
	Thu, 30 Apr 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551150; cv=none; b=TYvBrCYEb7PC/GgixPvi6jNXliFR/xyUh4mfPeeri7pH7/iU89cvMXS34D6yGrHnThmDSupz3BlnipLR4bmPuOmzv7/7m7u8GkKUVKXebfg8lrmXg94t1lt8CCN67BWRg9N5dLpeKMytBTfNgWu+0iRGq1mTDwzcU3rvpudkq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551150; c=relaxed/simple;
	bh=egPFU7xhA88lBAq519bT9HYe8a4c+pVY/6MihkNd9Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZlCinGQvw8v0iN1CW9AGGQEAO20pi1pxrZhbSJJgCcD6rvBSJlVR+/cTSDtw7TsRINMWNOpFUolJ4nzz3/tJBtkJ/qqOMbyifrjxacLzmxWjervPyFewwnjUh5kpeZiYZQvxOBoTc5FSxDc8lsCXJvhfr3nS4W1Dx73lF0SQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBwqGcS2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBwqGcS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777551148; x=1809087148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egPFU7xhA88lBAq519bT9HYe8a4c+pVY/6MihkNd9Ls=;
  b=RBwqGcS2Np7Z8qrvlrwfBY9vuJWxvpdIfaUQqyzTHNK7nTYO4nbdGyYz
   ZBwqkQwmgkXwa1NdBIXyVSTi0p1obfTlZbdSOPnd6D4DxiXIeJyPMWpeM
   FIHlW5pYvRBnYSf1txamIJthlzN5CkWyvla0YTSmDMjkyx60eJF39eX3y
   cSxerqspYC86WkEIgrJY8+OCAJ5mB8O1/J+7K4XVkgyY0cQDGv6IL4BGt
   WG/yk1M/k/Dvqmk8l704tVGxfuiXflHJ3TM2XBqb10iEIuZqNapXGcvnc
   CUX1kCKKzVU0CvolqhbLgda9GAn1cpGa+mwxxwMqa6MbNtZUd4mxQSZvw
   Q==;
X-CSE-ConnectionGUID: +ouMxe7hTHCAI0/vjlk9rg==
X-CSE-MsgGUID: iKVrwxjsQIC/Ao9xro1c8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77664023"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="77664023"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:12:27 -0700
X-CSE-ConnectionGUID: ZxgXd7DlSKCSNgbVzm2Psg==
X-CSE-MsgGUID: u0hvwTPbSL+4imX9slDRJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="258143800"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2026 05:12:23 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIQFg-00000000CNY-3Cyc;
	Thu, 30 Apr 2026 12:12:20 +0000
Date: Thu, 30 Apr 2026 20:11:21 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
Message-ID: <202604302041.gNPhRRxL-lkp@intel.com>
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427052000.196402-1-agordeev@linux.ibm.com>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/mm-page_vma_mapped_walk-add-missing-pgtable-entry-accessors/20260429-030409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260427052000.196402-1-agordeev%40linux.ibm.com
patch subject: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry accessors
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260430/202604302041.gNPhRRxL-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604302041.gNPhRRxL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604302041.gNPhRRxL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:36: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   mm/page_vma_mapped.c:186:9: note: 'pgd' declared here
     186 |         pgd_t *pgd;
         |                ^
>> mm/page_vma_mapped.c:222:20: error: passing 'const volatile pmdval_t *' (aka 'const volatile unsigned int *') to parameter of type 'pmdval_t *' (aka 'unsigned int *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:25: note: expanded from macro 'pgdp_get'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                 ^~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:47:28: note: expanded from macro 'READ_ONCE'
      47 | #define READ_ONCE(x)                                                    \
         |                                                                         ^
      48 | ({                                                                      \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      50 |         __READ_ONCE(x);                                                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      51 | })
         | ~~
   include/asm-generic/pgtable-nop4d.h:23:37: note: passing argument to parameter 'pgd' here
      23 | static inline int pgd_present(pgd_t pgd)        { return 1; }
         |                                     ^
   8 errors generated.


vim +222 mm/page_vma_mapped.c

   155	
   156	/**
   157	 * page_vma_mapped_walk - check if @pvmw->pfn is mapped in @pvmw->vma at
   158	 * @pvmw->address
   159	 * @pvmw: pointer to struct page_vma_mapped_walk. page, vma, address and flags
   160	 * must be set. pmd, pte and ptl must be NULL.
   161	 *
   162	 * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
   163	 * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
   164	 * adjusted if needed (for PTE-mapped THPs).
   165	 *
   166	 * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
   167	 * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
   168	 * a loop to find all PTEs that map the THP.
   169	 *
   170	 * For HugeTLB pages, @pvmw->pte is set to the relevant page table entry
   171	 * regardless of which page table level the page is mapped at. @pvmw->pmd is
   172	 * NULL.
   173	 *
   174	 * Returns false if there are no more page table entries for the page in
   175	 * the vma. @pvmw->ptl is unlocked and @pvmw->pte is unmapped.
   176	 *
   177	 * If you need to stop the walk before page_vma_mapped_walk() returned false,
   178	 * use page_vma_mapped_walk_done(). It will do the housekeeping.
   179	 */
   180	bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
   181	{
   182		struct vm_area_struct *vma = pvmw->vma;
   183		struct mm_struct *mm = vma->vm_mm;
   184		unsigned long end;
   185		spinlock_t *ptl;
   186		pgd_t *pgd;
   187		p4d_t *p4d;
   188		pud_t *pud;
   189		pmd_t pmde;
   190	
   191		/* The only possible pmd mapping has been handled on last iteration */
   192		if (pvmw->pmd && !pvmw->pte)
   193			return not_found(pvmw);
   194	
   195		if (unlikely(is_vm_hugetlb_page(vma))) {
   196			struct hstate *hstate = hstate_vma(vma);
   197			unsigned long size = huge_page_size(hstate);
   198			/* The only possible mapping was handled on last iteration */
   199			if (pvmw->pte)
   200				return not_found(pvmw);
   201			/*
   202			 * All callers that get here will already hold the
   203			 * i_mmap_rwsem.  Therefore, no additional locks need to be
   204			 * taken before calling hugetlb_walk().
   205			 */
   206			pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
   207			if (!pvmw->pte)
   208				return false;
   209	
   210			pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
   211			if (!check_pte(pvmw, pages_per_huge_page(hstate)))
   212				return not_found(pvmw);
   213			return true;
   214		}
   215	
   216		end = vma_address_end(pvmw);
   217		if (pvmw->pte)
   218			goto next_pte;
   219	restart:
   220		do {
   221			pgd = pgd_offset(mm, pvmw->address);
 > 222			if (!pgd_present(pgdp_get(pgd))) {
   223				step_forward(pvmw, PGDIR_SIZE);
   224				continue;
   225			}
   226			p4d = p4d_offset(pgd, pvmw->address);
   227			if (!p4d_present(p4dp_get(p4d))) {
   228				step_forward(pvmw, P4D_SIZE);
   229				continue;
   230			}
   231			pud = pud_offset(p4d, pvmw->address);
   232			if (!pud_present(pudp_get(pud))) {
   233				step_forward(pvmw, PUD_SIZE);
   234				continue;
   235			}
   236	
   237			pvmw->pmd = pmd_offset(pud, pvmw->address);
   238			/*
   239			 * Make sure the pmd value isn't cached in a register by the
   240			 * compiler and used as a stale value after we've observed a
   241			 * subsequent update.
   242			 */
   243			pmde = pmdp_get_lockless(pvmw->pmd);
   244	
   245			if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
   246				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
   247				pmde = pmdp_get(pvmw->pmd);
   248				if (!pmd_present(pmde)) {
   249					softleaf_t entry;
   250	
   251					if (!thp_migration_supported() ||
   252					    !(pvmw->flags & PVMW_MIGRATION))
   253						return not_found(pvmw);
   254					entry = softleaf_from_pmd(pmde);
   255	
   256					if (!softleaf_is_migration(entry) ||
   257					    !check_pmd(softleaf_to_pfn(entry), pvmw))
   258						return not_found(pvmw);
   259					return true;
   260				}
   261				if (likely(pmd_trans_huge(pmde))) {
   262					if (pvmw->flags & PVMW_MIGRATION)
   263						return not_found(pvmw);
   264					if (!check_pmd(pmd_pfn(pmde), pvmw))
   265						return not_found(pvmw);
   266					return true;
   267				}
   268				/* THP pmd was split under us: handle on pte level */
   269				spin_unlock(pvmw->ptl);
   270				pvmw->ptl = NULL;
   271			} else if (!pmd_present(pmde)) {
   272				const softleaf_t entry = softleaf_from_pmd(pmde);
   273	
   274				if (softleaf_is_device_private(entry)) {
   275					pvmw->ptl = pmd_lock(mm, pvmw->pmd);
   276					return true;
   277				}
   278	
   279				if ((pvmw->flags & PVMW_SYNC) &&
   280				    thp_vma_suitable_order(vma, pvmw->address,
   281							   PMD_ORDER) &&
   282				    (pvmw->nr_pages >= HPAGE_PMD_NR))
   283					sync_with_folio_pmd_zap(mm, pvmw->pmd);
   284	
   285				step_forward(pvmw, PMD_SIZE);
   286				continue;
   287			}
   288			if (!map_pte(pvmw, &pmde, &ptl)) {
   289				if (!pvmw->pte)
   290					goto restart;
   291				goto next_pte;
   292			}
   293	this_pte:
   294			if (check_pte(pvmw, 1))
   295				return true;
   296	next_pte:
   297			do {
   298				pvmw->address += PAGE_SIZE;
   299				if (pvmw->address >= end)
   300					return not_found(pvmw);
   301				/* Did we cross page table boundary? */
   302				if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) == 0) {
   303					if (pvmw->ptl) {
   304						spin_unlock(pvmw->ptl);
   305						pvmw->ptl = NULL;
   306					}
   307					pte_unmap(pvmw->pte);
   308					pvmw->pte = NULL;
   309					pvmw->flags |= PVMW_PGTABLE_CROSSED;
   310					goto restart;
   311				}
   312				pvmw->pte++;
   313			} while (pte_none(ptep_get_lockless(pvmw->pte)));
   314	
   315			if (!pvmw->ptl) {
   316				spin_lock(ptl);
   317				if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
   318					pte_unmap_unlock(pvmw->pte, ptl);
   319					pvmw->pte = NULL;
   320					goto restart;
   321				}
   322				pvmw->ptl = ptl;
   323			}
   324			goto this_pte;
   325		} while (pvmw->address < end);
   326	
   327		return false;
   328	}
   329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
