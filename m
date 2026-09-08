Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F452ED31;
	Tue,  8 Sep 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866975; cv=none; b=tc+gz0jtlg6Qf6UeBN33QDGLsKOORffOLv8vNQWvu9D0vqM+pUzGkisiS0bJAc+UTFXjwS3g11oqjDa6G4AvsvZ5mnIssgz2RWArdkf25LIMqlVCO2zJXrO2aG8irWJsK8iSOxVkJqs2tVTuz/D5n4o3LyzEaR117y3ITNj8VVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866975; c=relaxed/simple;
	bh=DJJ3y4HWUdHg21fDTQuBvRfNxO5F30ksapo9ZwKGzO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgJ+qervmYWrMYxg0LJ+0/PFUi71RJiEwt0q8tua4P4MChlTsrSHfvA4h6j0iz/GjQqw5dgZKNYkrVU7DhbcMbMxMi+OdTC2uRT4ZvUfXMKCE9DxzGT6goJ4AxGfEdxlqAs/ciyHmuK5Xw9twTHqCdoLVzDIOHwn+2Y5nDfiLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaGEuylv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaGEuylv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8561F00A3A;
	Tue,  8 Sep 2026 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866953;
	bh=wrZchMHbuIO6XXck0lzWb4MFVBIJqfPNOjZp2CkiLAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UaGEuylvnKTadsfjaS7bvwU33xN2v3VvG9wjjwlcHZzqg4jRyqMpEEdO03+MvqeIM
	 0cduj0er10VqGiGsJx7yjqifKpSllSZ3vK2y8omgzwmD0GHCZufWGZlTXVUWUiJ1V9
	 ryqufjLkVU0NIOGHntM/W5uaFdDur34HOl0mDF/iX8gW88SDJFV9ZGxssqTmrANwpQ
	 ynMdPQCgyGQbU6JnCqU5u6mlf0Svv7YVwvZzUogSUfvbxLoYO7+FDhTi6mBmpO9DWp
	 jokGL7RYOK/KgBIS1bsW+dwWJav2y/DtDFT7YQL4WN6vyefxcqOuYZ/U9v7ZU8r1QK
	 2OBX8O/r781rA==
Date: Tue, 8 Sep 2026 12:28:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Message-ID: <ap_xXoS5XDqJ0mgU@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-5-5456a81c8212@kernel.org>
 <CAJuCfpESe_BXihJh-8FhjQVKzsSpnS4zdMgg3e59byJTc8QViA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpESe_BXihJh-8FhjQVKzsSpnS4zdMgg3e59byJTc8QViA@mail.gmail.com>

On Mon, Sep 07, 2026 at 02:07:37PM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 1, 2026 at 4:06 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > Each of these architectures directly free page tables without routing these
> > changes through tlb_remove_ptdesc().
> >
> > The use of tlb_remove_ptdesc() is required for
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
> > so simply update these architectures to use these functions.
> >
> > Since none of the architectures share page tables or do anything unusual,
> > nothing complicated is required here.
> >
> > Therefore this is simply a mechanical change - convert __pud_free_tlb(),
> > __pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
> > required.
> >
> > At the point this is in place, all mmu_gather page table freeing is
> > performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
> > each architecture.
> >
> > This forms part of an overall effort to switch every architecture to this
> > mode.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/arc/Kconfig                      | 1 +
> >  arch/arc/include/asm/pgalloc.h        | 6 +++---
> >  arch/microblaze/Kconfig               | 1 +
> >  arch/microblaze/include/asm/pgalloc.h | 2 +-
> >  arch/xtensa/Kconfig                   | 1 +
> >  arch/xtensa/include/asm/tlb.h         | 2 +-
> >  6 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> > index 2ed7186c81c5..7a7542b61823 100644
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -47,6 +47,7 @@ config ARC
> >         select HAVE_SYSCALL_TRACEPOINTS
> >         select IRQ_DOMAIN
> >         select LOCK_MM_AND_FIND_VMA
> > +       select MMU_GATHER_RCU_TABLE_FREE
> >         select MODULES_USE_ELF_RELA
> >         select OF
> >         select OF_EARLY_FLATTREE
> > diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
> > index dfae070fe8d5..9b6c37f92e97 100644
> > --- a/arch/arc/include/asm/pgalloc.h
> > +++ b/arch/arc/include/asm/pgalloc.h
> > @@ -72,7 +72,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
> >         set_p4d(p4dp, __p4d((unsigned long)pudp));
> >  }
> >
> > -#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
> > +#define __pud_free_tlb(tlb, pmd, addr)  tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
> >
> >  #endif
> >
> > @@ -83,10 +83,10 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
> >         set_pud(pudp, __pud((unsigned long)pmdp));
> >  }
> >
> > -#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
> > +#define __pmd_free_tlb(tlb, pmd, addr)  tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
> >
> >  #endif
> >
> > -#define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
> > +#define __pte_free_tlb(tlb, pte, addr)  tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> >
> >  #endif /* _ASM_ARC_PGALLOC_H */
> > diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> > index 484ebb3baedf..af7e821e96c1 100644
> > --- a/arch/microblaze/Kconfig
> > +++ b/arch/microblaze/Kconfig
> > @@ -41,6 +41,7 @@ config MICROBLAZE
> >         select PCI_SYSCALL if PCI
> >         select CPU_NO_EFFICIENT_FFS
> >         select MMU_GATHER_NO_RANGE
> > +       select MMU_GATHER_RCU_TABLE_FREE
> >         select SPARSE_IRQ
> >         select ZONE_DMA
> >         select TRACE_IRQFLAGS_SUPPORT
> > diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> > index 084a8a0dc239..ffee6a009219 100644
> > --- a/arch/microblaze/include/asm/pgalloc.h
> > +++ b/arch/microblaze/include/asm/pgalloc.h
> > @@ -25,7 +25,7 @@ extern void __bad_pte(pmd_t *pmd);
> >
> >  extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
> >
> > -#define __pte_free_tlb(tlb, pte, addr) pte_free((tlb)->mm, (pte))
> > +#define __pte_free_tlb(tlb, pte, addr) tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> >
> >  #define pmd_populate(mm, pmd, pte) \
> >                         (pmd_val(*(pmd)) = (unsigned long)page_address(pte))
> > diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> > index f2f9cd9cde50..33c4caee30e2 100644
> > --- a/arch/xtensa/Kconfig
> > +++ b/arch/xtensa/Kconfig
> > @@ -55,6 +55,7 @@ config XTENSA
> >         select HAVE_VIRT_CPU_ACCOUNTING_GEN
> >         select IRQ_DOMAIN
> >         select LOCK_MM_AND_FIND_VMA
> > +       select MMU_GATHER_RCU_TABLE_FREE if MMU
>
> And MMU is required because NOMMU does not perform mmu_gather
> operations, same as in the previous patch? If so, maybe make a note of
> it in the changelog?

Right yup. Will update!

>
> >         select MODULES_USE_ELF_RELA
> >         select PERF_USE_VMALLOC
> >         select TRACE_IRQFLAGS_SUPPORT
> > diff --git a/arch/xtensa/include/asm/tlb.h b/arch/xtensa/include/asm/tlb.h
> > index 8c3ceb427018..6fb7b78154f6 100644
> > --- a/arch/xtensa/include/asm/tlb.h
> > +++ b/arch/xtensa/include/asm/tlb.h
> > @@ -16,7 +16,7 @@
> >
> >  #include <asm-generic/tlb.h>
> >
> > -#define __pte_free_tlb(tlb, pte, address)      pte_free((tlb)->mm, pte)
> > +#define __pte_free_tlb(tlb, pte, address)      tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> >
> >  void check_tlb_sanity(void);
> >
> >
> > --
> > 2.55.0
> >

--
Cheers, Lorenzo
