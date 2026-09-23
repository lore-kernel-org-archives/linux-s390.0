Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9555218AF;
	Wed, 23 Sep 2026 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169742; cv=none; b=C0daXz1oSL+uvTjAyByBPkolzx+ffd5m/XvJh+kYGQ1kSBUjaAssIraH2YnIUFvqwK6/vn0JxRdX4JFMkyqWLZ6UX2P4Ix6TFefLVRXLDMvTYcCOUvnj7+waIaDkSXRlj6r7sK76aW0f/eqb4IiwyXwsFbFj0xjVQJT6osN2uuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169742; c=relaxed/simple;
	bh=fv/PJsh8Z0zTlCVSKOt2XBkxllgDkngoF7NIde+KnzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLnyTCfTW2fCjwtPCCZGE0e0lga6SVU2/KPkrRRkN1PcUTfc/gq0ui0RX0aR/reNMTLGTYuMSlS9CIL4xhqonQv3e8MThwiNGO9/ogXOJDExyE7L0nmZVlmuy4qvkoqciuLyh3IPEqCVicwtiVp5cAzC85i5XTdO13CasViwZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQwWOQky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQwWOQky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B955C1F000FF;
	Wed, 23 Sep 2026 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169741;
	bh=fv/PJsh8Z0zTlCVSKOt2XBkxllgDkngoF7NIde+KnzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oQwWOQkywYDf1JkmRsDbC/o6DR3oPInrHh+/leVHpzXY/fgKnBPlAbat4yOirXksi
	 EWALa8XUeMd2tsIqTrSCJ0hISS3LcHe3D0i0Tgz4u8GN0a6ybM3BZinVZZLhG3Kwem
	 I7b4mFWjjtLPtBFFyxKMPPiC1fv/6tqbKR6ms7bWmlQ8jqkRp5houN8+Tl0nlHq8Ok
	 pNWxEWvRV+ENJCiZHISEOFERm2DQsybnZiI9c7WeH02xnMWwF75/9ODvNlEXLXkUxS
	 1sCqPrGh63gyzzgORCeokaPT4Set6v00jX6f1b6hgWldcMbm+rJMuLtgU0iQ1Yzy3g
	 sAGIwJhyz9HZg==
Date: Wed, 23 Sep 2026 14:21:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Message-ID: <arPSa1dVX3AOHAvM@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
 <20260923131634.47896-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923131634.47896-1-lance.yang@linux.dev>

On Wed, Sep 23, 2026 at 09:16:34PM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:40PM +0100, Lorenzo Stoakes (ARM) wrote:
> >sun3 and coldfire are already supported, however motorola requires a little
> >more care.
> >
> >Here, custom table removal logic is required, so
> >CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
> >
> >Firstly as part of this change, the page table level must be communicated
> >to the underlying __tlb_remove_table() implementation.
> >
> >Take advantage of the fact that page tables are aligned by more than enough
> >to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
> >and store this there.
> >
> >Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
> >then have __tlb_remove_table() decode this and pass it to
> >free_pointer_table().
> >
> >The page table freeing is performed via call_rcu(), so free_pointer_table()
> >now will be invoked from softirq context, and as such may be re-entrant.
> >
> >Introduce an irq save/restore spinlock to handle this, and hold it over the
> >time a given ptable entry is being referenced in both get_pointer_table()
> >and free_pointer_table().
> >
> >In order to make things a little easier in this respect, separate out the
> >logic for adding a new ptable entry into add_pointer_table() and only hold
> >the lock during ptable entry insertion in this case.
> >
> >Note that original list_add_tail(new, dp) added new prior to dp, which is
> >ptable_list[type].next, i.e. after ptable_list[type].
> >
> >The equivalent therefore is list_add(new, &ptable_list[type]), which adds
> >new after ptable_list[type], only without needing to make reference to dp.
> >
> >Note that, as m68k-motorola specifies CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE, it
> >does not enable CONFIG_PT_RECLAIM. This isn't meaningfully impactful.
> >
> >With this applied, all of m68k implements CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> >
> >This forms part of an overall effort to switch every architecture to this
> >mode.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
>
> I wondered about slot reuse during the RCU wait, but that can't happen :)
>
> The slot stays marked busy until free_pointer_table() runs after RCU, and
> the last free unlinks the page under ptable_lock.
>
> Also ran page-table teardown stress and fork/exec churn on
> qemu-system-m68k (virt, m68040, CONFIG_MMU_MOTOROLA=y). All 40 rounds ran
> cleanly :D
>
> Acked-by: Lance Yang <lance.yang@linux.dev>
>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Great, thanks! Really appreciate the testing :)

--
Cheers, Lorenzo
