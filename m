Return-Path: <SRS0=MWzg=R6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v8 0/4] Fix free/allocation of runtime gigantic pages 
Date: Wed, 27 Mar 2019 02:36:22 -0400
Message-Id: <20190327063626.18421-1-alex@ghiti.fr>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Cc: Alexandre Ghiti <alex@ghiti.fr>
List-ID: <linux-s390.vger.kernel.org>

This series fixes sh and sparc that did not advertise their gigantic page        
support and then were not able to allocate and free those pages at runtime.      
It renames MEMORY_ISOLATION && COMPACTION || CMA condition into the more         
accurate CONTIG_ALLOC, since it allows the definition of alloc_contig_range      
function.                                                                        
Finally, it then fixes the wrong definition of ARCH_HAS_GIGANTIC_PAGE config     
that, without MEMORY_ISOLATION && COMPACTION || CMA defined, did not allow       
architectures to free boottime allocated gigantic pages although unrelated.      
                                                                                 
Changes in v8:                                                                   
  This (hopefully last) version is rebased against v5.1-rc2 so that              
  it takes into account https://patchwork.ozlabs.org/patch/1047003/.             
  This version:                                                                  
  - factorizes gigantic_page_runtime_supported such as suggested                 
    by Christophe.                                                               
  - fix checkpath warning regarding the use of 'extern'                          
  - fix s390 build that does not include asm-generic/hugetlb.h                   
  And note that I did not add the reviewed-by and acked-by received in v6        
  since the patch differs a little.                                              
                                                                                 
Changes in v7:                                                                   
  I thought gigantic page support was settled at compile time, but Aneesh        
  and Michael have just come up with a patch proving me wrong for                
  powerpc: https://patchwork.ozlabs.org/patch/1047003/. So this version:         
  - reintroduces gigantic_page_supported renamed into                            
    gigantic_page_runtime_supported                                              
  - reintroduces gigantic page page support corresponding checks (not            
    everywhere though: set_max_huge_pages check was redundant with               
    __nr_hugepages_store_common)                                                 
  - introduces the possibility for arch to override this function                
    by using asm-generic/hugetlb.h current semantics although Aneesh             
    proposed something else.                                                     
                                                                                 
Changes in v6:                                                                   
- Remove unnecessary goto since the fallthrough path does the same and is        
  the 'normal' behaviour, as suggested by Dave Hensen                            
- Be more explicit in comment in set_max_huge_page: we return an error           
  if alloc_contig_range is not defined and the user tries to allocate a          
  gigantic page (we keep the same behaviour as before this patch), but we        
  now let her free boottime gigantic page, as suggested by Dave Hensen           
- Add Acked-by, thanks.                                                          
                                                                                 
Changes in v5:                                                                   
- Fix bug in previous version thanks to Mike Kravetz                             
- Fix block comments that did not respect coding style thanks to Dave Hensen     
- Define ARCH_HAS_GIGANTIC_PAGE only for sparc64 as advised by David Miller 
- Factorize "def_bool" and "depends on" thanks to Vlastimil Babka                
                                                                                 
Changes in v4 as suggested by Dave Hensen:                                       
- Split previous version into small patches                                      
- Do not compile alloc_gigantic** functions for architectures that do not        
  support those pages                                                            
- Define correct ARCH_HAS_GIGANTIC_PAGE in all arch that support them to avoid   
  useless runtime check                                                          
- Add comment in set_max_huge_pages to explain that freeing is possible even     
  without CONTIG_ALLOC defined                                                   
- Remove gigantic_page_supported function across all archs                       
                                                                                 
Changes in v3 as suggested by Vlastimil Babka and Dave Hansen:                   
- config definition was wrong and is now in mm/Kconfig                           
- COMPACTION_CORE was renamed in CONTIG_ALLOC                                    
                                                                                 
Changes in v2 as suggested by Vlastimil Babka:                                   
- Get rid of ARCH_HAS_GIGANTIC_PAGE                                              
- Get rid of architecture specific gigantic_page_supported                       
- Factorize CMA or (MEMORY_ISOLATION && COMPACTION) into COMPACTION_CORE 

Alexandre Ghiti (4):
  sh: Advertise gigantic page support
  sparc: Advertise gigantic page support
  mm: Simplify MEMORY_ISOLATION && COMPACTION || CMA into CONTIG_ALLOC
  hugetlb: allow to free gigantic pages regardless of the configuration

 arch/arm64/Kconfig                           |  2 +-
 arch/arm64/include/asm/hugetlb.h             |  4 --
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  5 +-
 arch/powerpc/platforms/Kconfig.cputype       |  2 +-
 arch/s390/Kconfig                            |  2 +-
 arch/s390/include/asm/hugetlb.h              |  8 +--
 arch/sh/Kconfig                              |  1 +
 arch/sparc/Kconfig                           |  1 +
 arch/x86/Kconfig                             |  2 +-
 arch/x86/include/asm/hugetlb.h               |  4 --
 arch/x86/mm/hugetlbpage.c                    |  2 +-
 include/asm-generic/hugetlb.h                |  7 +++
 include/linux/gfp.h                          |  4 +-
 mm/Kconfig                                   |  3 ++
 mm/hugetlb.c                                 | 54 ++++++++++++++------
 mm/page_alloc.c                              |  7 ++-
 16 files changed, 67 insertions(+), 41 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
