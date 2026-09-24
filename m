Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CE3D5C23
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217696; cv=none; b=NnvogeIp1m++30bVMq63CM6lpG1PZQGWyGKxngixIGyvLIpiITFF/LOmaOw1Yeji/GKEDaIUoXIdYwJOhhX2sjlo0trae9jGeOR7HMMSckc0THobqixC0ncL8JXNw2L/8Xh7KgTtgFVqcg/8Oc8g8cVBZ3yqoHzS2G3whaFLKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217696; c=relaxed/simple;
	bh=4JyEcF/oNMZQFBpW+pWfHZaiat0WqM84Tbff9DsrqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdJ9sWIQGX/s5g1sdS6bol1C/Wi7RJ1jPB/50OEzGvD7V8e8dB1hAI7qO6656cemHxQx3eH8N1t/FyUfVhxT7Y0j/CXf6aNIDzQzwcRdPz0Us0sTguBWRjqGa8+UtZ5BIzxlXHlT/SKC1p7rNNJ831H0QBcrvIR7n84MGUkDM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VPiRC6gZ; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VPiRC6gZ"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4JyEcF/oNMZQFBpW+pWfHZaiat0WqM84Tbff9DsrqFA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790217691; v=1; x=1790822491;
 b=VPiRC6gZba8yFYNQpqTSni09Egij5edXFDUUnAj7i3M5zkd80EAj4aqT/N7XfWc5F2OixOop
 0Q8er/e7zgITLXB2+juST/5TNsyW+iFj5/5dlwLxHT1bp2FoRxxnk5B5dayr/3EMAq3bR/sEbdT
 lo3p2/Fk0ljGasHRnRbYD/Zo=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1489725b085043fe;
	Thu, 24 Sep 2026 02:41:26 +0000
X-Mizu-Trace-ID: 1489725b085043fe
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc32
Date: Thu, 24 Sep 2026 10:41:20 +0800
Message-ID: <20260924024120.14225-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-10-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-10-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:41PM +0100, Lorenzo Stoakes (ARM) wrote:
>Careful handling is required for sparc32 which implements page tables as
>part of a shared backing page.
>
>To support this, a custom __tlb_remove_table() function is required, as
>specified by CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE.
>
>This allows __pte_free_tlb() and __pmd_free_tlb() to specify which page
>table level is being freed, which is transmitted to __tlb_remove_table()
>through setting the lowest bit of the page table to 1 for a PMD and 0 for a
>PTE (the page tables are 256-byte aligned so this is safe to do).
>
>Next, since the page table freeing is done via RCU callback, and thus might
>be executed in softirq context, update the spin locks to IRQ save/restore.
>
>Then, in __tlb_remove_table(), figure out whether to free a PMD page table
>via free_pmd_fast() or a PTE via the newly introduced __pte_free()
>function, using the lower bit encoded in __pte_free_tlb() or
>__pmd_free_tlb() to determine which to call.
>
>As part of this change use this spin lock rather than mm->page_table_lock
>for all shared page table exclusion, as RCU freeing means that page tables
>can be freed from soft IRQ context so both don't have an mm and also
>mm->page_table_lock is not IRQ-safe.
>
>Note that the specification of CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE disables
>CONFIG_PT_RECLAIM for sparc32, which mirrors sparc64.
>
>This forms part of an overall effort to switch every architecture to this
>mode, and with it complete, means every architecture now supports
>CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Also ran page-table teardown stress on qemu-system-sparc (SS-20, sun4m,
CONFIG_SPARC32=y). All 24 rounds ran cleanly :)

Feel free to add:

Tested-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Lance Yang <lance.yang@linux.dev>
