Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:39478 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgGCRKP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 3 Jul 2020 13:10:15 -0400
Date: Sat, 4 Jul 2020 01:09:04 +0800
From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 4/9] s390/vmemmap: cleanup when vmemmap_populate()
 fails
Message-ID: <202007040129.TlExXvvF%lkp@intel.com>
References: <20200703133917.39045-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200703133917.39045-5-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: kbuild-all@lists.01.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on s390/features]
[also build test ERROR on next-20200703]
[cannot apply to linux/master kvms390/next linus/master v5.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/s390-implement-and-optimize-vmemmap_free/20200703-214348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: s390-alldefconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arch/s390/mm/vmem.c: In function 'vmemmap_populate':
>> arch/s390/mm/vmem.c:368:3: error: implicit declaration of function 'vmemmap_free'; did you mean 'vmem_altmap_free'? [-Werror=implicit-function-declaration]
     368 |   vmemmap_free(start, end, altmap);
         |   ^~~~~~~~~~~~
         |   vmem_altmap_free
   arch/s390/mm/vmem.c: At top level:
   arch/s390/mm/vmem.c:372:6: warning: no previous prototype for 'vmemmap_free' [-Wmissing-prototypes]
     372 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~
>> arch/s390/mm/vmem.c:372:6: warning: conflicting types for 'vmemmap_free'
   arch/s390/mm/vmem.c:368:3: note: previous implicit declaration of 'vmemmap_free' was here
     368 |   vmemmap_free(start, end, altmap);
         |   ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +368 arch/s390/mm/vmem.c

   280	
   281	/*
   282	 * Add a backed mem_map array to the virtual mem_map array.
   283	 */
   284	int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
   285			struct vmem_altmap *altmap)
   286	{
   287		unsigned long pgt_prot, sgt_prot;
   288		unsigned long address = start;
   289		pgd_t *pg_dir;
   290		p4d_t *p4_dir;
   291		pud_t *pu_dir;
   292		pmd_t *pm_dir;
   293		pte_t *pt_dir;
   294		int ret = -ENOMEM;
   295	
   296		pgt_prot = pgprot_val(PAGE_KERNEL);
   297		sgt_prot = pgprot_val(SEGMENT_KERNEL);
   298		if (!MACHINE_HAS_NX) {
   299			pgt_prot &= ~_PAGE_NOEXEC;
   300			sgt_prot &= ~_SEGMENT_ENTRY_NOEXEC;
   301		}
   302		for (address = start; address < end;) {
   303			pg_dir = pgd_offset_k(address);
   304			if (pgd_none(*pg_dir)) {
   305				p4_dir = vmem_crst_alloc(_REGION2_ENTRY_EMPTY);
   306				if (!p4_dir)
   307					goto out;
   308				pgd_populate(&init_mm, pg_dir, p4_dir);
   309			}
   310	
   311			p4_dir = p4d_offset(pg_dir, address);
   312			if (p4d_none(*p4_dir)) {
   313				pu_dir = vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
   314				if (!pu_dir)
   315					goto out;
   316				p4d_populate(&init_mm, p4_dir, pu_dir);
   317			}
   318	
   319			pu_dir = pud_offset(p4_dir, address);
   320			if (pud_none(*pu_dir)) {
   321				pm_dir = vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
   322				if (!pm_dir)
   323					goto out;
   324				pud_populate(&init_mm, pu_dir, pm_dir);
   325			}
   326	
   327			pm_dir = pmd_offset(pu_dir, address);
   328			if (pmd_none(*pm_dir)) {
   329				/* Use 1MB frames for vmemmap if available. We always
   330				 * use large frames even if they are only partially
   331				 * used.
   332				 * Otherwise we would have also page tables since
   333				 * vmemmap_populate gets called for each section
   334				 * separately. */
   335				if (MACHINE_HAS_EDAT1) {
   336					void *new_page;
   337	
   338					new_page = vmemmap_alloc_block(PMD_SIZE, node);
   339					if (!new_page)
   340						goto out;
   341					pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
   342					address = (address + PMD_SIZE) & PMD_MASK;
   343					continue;
   344				}
   345				pt_dir = vmem_pte_alloc();
   346				if (!pt_dir)
   347					goto out;
   348				pmd_populate(&init_mm, pm_dir, pt_dir);
   349			} else if (pmd_large(*pm_dir)) {
   350				address = (address + PMD_SIZE) & PMD_MASK;
   351				continue;
   352			}
   353	
   354			pt_dir = pte_offset_kernel(pm_dir, address);
   355			if (pte_none(*pt_dir)) {
   356				void *new_page;
   357	
   358				new_page = vmemmap_alloc_block(PAGE_SIZE, node);
   359				if (!new_page)
   360					goto out;
   361				pte_val(*pt_dir) = __pa(new_page) | pgt_prot;
   362			}
   363			address += PAGE_SIZE;
   364		}
   365		ret = 0;
   366	out:
   367		if (ret)
 > 368			vmemmap_free(start, end, altmap);
   369		return ret;
   370	}
   371	
 > 372	void vmemmap_free(unsigned long start, unsigned long end,
   373			struct vmem_altmap *altmap)
   374	{
   375		remove_pagetable(start, end, false);
   376	}
   377	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--mYCpIKhGyMATD0i+--
