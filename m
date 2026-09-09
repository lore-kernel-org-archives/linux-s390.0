Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027143D5C2C;
	Wed,  9 Sep 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945889; cv=none; b=KE/3Gp0DpOoD9v6TGVTt9sRs+4jOKyxnsCB9wAXWDYS18N2RudX/NY+5P62gS8gZZnJ87/jO1Z0EMEoJUvMg9GV3At9tlJ/HouZ7mndcX+Z2LW+UFf1bk7BZqSfac7elUHGTh1ZouieTe9CwzqC60IYac5CzhHMPd6SPWniCtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945889; c=relaxed/simple;
	bh=9+bm5oEDo0srrI28L4tLmxJZ+mPiWBRVfLLAJe1RaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iozJ8hS9HQ6ml2yJhG4wX9xUx7DJxqJsofxf6C4qI7ysScTkgAYrgKzMBOA6ycab/UQGPJRY0OKAgo4BfVBjD+R/xDWC8VF5m9pu29bzVuD5ZChYzhbq+UY0N+t0gmWHOzNmJfi+4R4UGncI/Lylqrurx/avHznvfAz57uzVELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPCpNNRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPCpNNRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBEA1F00A3E;
	Wed,  9 Sep 2026 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945886;
	bh=nfrCF2g2kP9K2twlNtCkjBDUEX8FE2jfXjcc77olkz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPCpNNRdqmAOzJKeAhJyM/qgdzFD5BDME+mzm/D0LYvQ35AZoE4IRpxt25A1WsWHU
	 sdtDrJ2SzE2rLe+38qA+kIZiPHpWx7DG5zabqjD8m1sFFCGh28tbh/24A8lpUJIFJA
	 90PNWxQUDtx1JhX6wZlw2KH++f/ocL2mGqqXk69QhjvNpTik/9nRjZtzYlg1RJ/Zvl
	 2+czxp/V1dBm2oQ0APDu3O2qm08FKwHORszxVq5qWcLy82Dh04OpvMPiPUpaNhJR8+
	 k+H4+6SF+XD0j+iaWt0h1ot8PSJlBtASdm2va8Gh1AI1D+S801KAs3R2kItf6C9Obz
	 Kas5gMq8eNKdQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 068B4198003A;
	Wed,  9 Sep 2026 05:24:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 05:24:39 -0400
X-ME-Sender: <xms:yCWhagjYqM8NelhkAwJe6-ToA6Pzkvu6YtUuREipYL8qYrOUVJyZgA>
    <xme:yCWhahcYpVlF2jXB-c-ousju5AbfDlLNpcEkn0zv2-Bjj7RPxt0_wkhT2Cf8-Pnij
    cSAWf2i6zi5CzYjAj4myvtoY3SVxZH49D0dZWTUPSHvSeZS42olVEH5>
X-ME-Received: <xmr:yCWhangpq_Xwfwy2xpDLszI3Y5M-fiq-dcyxthWV1UYxPh0xCcAL_3OGJTU>
X-ME-Proxy-Cause: dmFkZTFezydZ8FO8du2voecZC8AJNWBjGdsMbkEpRuZb1pJQCW8oQ/07jIMET6eEJr7fJk
    jK9b6/RVqplj/hwhlVFzNnuocUhGgqg++Dch+Fm39jov+euRCynPx3rDxn0l47uIcRTbRe
    l+xEzXbGBcRtTkTfbYEXOMv4wH/lwQzt9buwKydCbN0FMAoNRBVHjKw/0cNgJBZE1BhGh1
    JIXdKXcVftccaMtpxVBgo74J6jWGt3VGDg3iw3wOFkhLBvYixt8JDYpFgoMYQzIsuuDFfO
    TmxjKB4+9FqzGw50TIvRfIkKnb0q9Uf+9J1G9dVByYDZGVfHLSHUlaveJL4gG3BOiwlNKu
    W94uMmoQw8nCimvgXUVlZxRFenvsExaDrMIxjkEpClNVWT8tTK0cUg3hfPedKUKzNTSxyw
    PQo3wSULgn+sr5Li/cuB2N6JbBdIRHieJsLH5DmSrr71RvsAofAw1M8uaPgyS5jmndiHxA
    zgS7f4oYsB34Klb9A5GIOP450BEQMbKt+S+wq27jxTPVFVkAOI0leIfTeRPDSAMJ/S5Cvj
    F+Dp6/7hHUv6nzA8YtErGhpxUI3elZWjTSI/dwCeUc77iE929sk0qwionLasDve2qpQnkr
    zdh7bJtqaOjuGUMpQqo0lzAFv6JNtn6CdttnT8jAZQyBSC+9JMBThNfmCvrw
X-ME-Proxy: <xmx:yCWhalvo38zscZUuzJiw__SF5Cd_YDtR8z07XGTBNrbfYO5Cja9FfQ>
    <xmx:yCWhaiC0jOQX0tYTam7Zn1UWsfu1g3GdKzOlHCzy4BasscJ1cL77Fg>
    <xmx:yCWhauPWpiwQW3Rbs1815_1XTbFTmY2R-MnEDNPuvSylJB8Tsj4RsQ>
    <xmx:yCWhagXzxSKsQG2dZ9P7Q4ciV-MKMH6LZvuOOY606G4QQG_ATA2T-w>
    <xmx:yCWhagVlhDnkLY1TVIAZHeCxMfQiuASa1ZoQzqTmswaPwqncjPDP919B>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:24:22 -0400 (EDT)
Date: Wed, 9 Sep 2026 10:24:21 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 	Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, 	Usama Arif <usama.arif@linux.dev>,
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
 	Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 	Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 	Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, 	Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 	Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, 	Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, 	Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 	Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 	Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 	Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, 	John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, 	linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <aqEkfKww9XDq15ZF@thinkstation>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-12-1f60b64e878e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-12-1f60b64e878e@kernel.org>

On Tue, Sep 08, 2026 at 01:32:21PM +0100, Lorenzo Stoakes (ARM) wrote:
> Now that page tables are freed after an RCU grace period, it is safe for
> read-only page table walkers to walk page table ranges that are being
> concurrently torn down, provided the mm is kept alive via mmgrab().
> 
> It is however unsafe for writers to do so, as they must obtain an
> appropriate lock to do so safely.
> 
> Update the pte_offset_map_lock()'s comment block to reflect this.
> 
> Similarly update the process addresses documentation.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  Documentation/mm/process_addrs.rst |  6 ++++++
>  mm/pgtable-generic.c               | 15 +++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> index a7296f251799..1e65b139f355 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -537,6 +537,12 @@ We establish basic locking rules when interacting with page tables:
>  * When changing a page table entry the page table lock for that page table
>    **must** be held, except if you can safely assume nobody can access the page
>    tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
> +* Page tables may be *walked* under RCU alone, as page tables are freed only
> +  after an RCU grace period has elapsed. However, any entry found must be
> +  revalidated after the page table lock is taken (such as the
> +  :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
> +  before it is acted upon. Changing an entry always requires the page table
> +  lock.

This says the PTL plus a recheck is enough to act on the entry. It is
not: free_pte_range() clears the PMD without the PTL, so pmd_same() can
pass and the table is torn down right after. That is the case we settled
on for the pte_offset_map_lock() comment, and the two now disagree.

Something like "Changing an entry requires the page table lock and one
of the locks that excludes teardown (mmap or VMA lock)" would match the
comment.

>  * Reads from and writes to page table entries must be *appropriately*
>    atomic. See the section on atomicity below for details.
>  * Populating previously empty entries requires that the mmap or VMA locks are
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index b91b1a98029c..a127e3e8f9b9 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -385,10 +385,17 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>   * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
>   * be read-only/read-write protected.
>   *
> - * Note that free_pgtables(), used after unmapping detached vmas, or when
> - * exiting the whole mm, does not take page table lock before freeing a page
> - * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
> - * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
> + * Note that free_pgtables(), used after unmapping detached vmas or when exiting
> + * the whole mm, does not take a page table lock before freeing a page table.
> + *
> + * As page table freeing itself is RCU-safe, page table readers can safely run
> + * concurrently with page table teardown.
> + *
> + * However, writers CANNOT as, without a lock being held, nothing prevents
> + * concurrent teardown.
> + *
> + * Also note that the PGD itself is freed at mmdrop() time, not under RCU - so
> + * the walker must keep the mm alive either by pinning the mm or the VMA.
>   */
>  pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>  			   unsigned long addr, spinlock_t **ptlp)
> 
> -- 
> 2.55.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
