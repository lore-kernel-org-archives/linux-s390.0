Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A749E13D
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169409; cv=none; b=mQLpQGrB7x4hSxwEwVcKqXH/oXtR7kx+A0oJcs3y75LZJJN0lUzZSsgpmRNzrvoQAnu+qi+Ryoi4AdlsN9xjvnWlYBQ4PwdiyACi8CvQPyTkOYL7sUAgGn+XJxxREb5mQJorypYgDwK+zYwB6gtbjDX0E2PuHg8SzgT1546SkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169409; c=relaxed/simple;
	bh=Oo904kmsf5S8wAGGf7/FG6FAeaEtExRT7Jk7mDgjtow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOcdI6HGCLNaJHEt+5orcZSgejrcVWAGr0d0nm0ve0SaWPdzHRo3ydNQwBOXylhV2vfbX/JB4FivD6QgP/lg/3AyXqhmwcCjRMx0URW3bwXYEC2a71eyk6s3fsjKNS6nKfpHh83E5MFxjRGC0t5rQo/XJsixrh6DQCyLmTe1JFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xCzssSsp; arc=none smtp.client-ip=91.218.175.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xCzssSsp"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Oo904kmsf5S8wAGGf7/FG6FAeaEtExRT7Jk7mDgjtow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790169403; v=1; x=1790774203;
 b=xCzssSspaBGhFiXSrVms0nnKI8bL98Kz40GqFav+hw8EIGJMCNagy0TZf6kOokebvah9UFDl
 qyg9XbD0oLRtfKVJqxPdr51QiR0NG7WWNSyy4w0KsJ4w6SrHZYvLtoTjdX0EEdBn6zVwOU1UcwY
 CJg7lOfPMG8u2DTCRLUGFamc=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id acd8da373ac6bf50;
	Wed, 23 Sep 2026 13:16:40 +0000
X-Mizu-Trace-ID: acd8da373ac6bf50
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
Subject: Re: [PATCH v4 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-motorola
Date: Wed, 23 Sep 2026 21:16:34 +0800
Message-ID: <20260923131634.47896-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:40PM +0100, Lorenzo Stoakes (ARM) wrote:
>sun3 and coldfire are already supported, however motorola requires a little
>more care.
>
>Here, custom table removal logic is required, so
>CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
>
>Firstly as part of this change, the page table level must be communicated
>to the underlying __tlb_remove_table() implementation.
>
>Take advantage of the fact that page tables are aligned by more than enough
>to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
>and store this there.
>
>Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
>then have __tlb_remove_table() decode this and pass it to
>free_pointer_table().
>
>The page table freeing is performed via call_rcu(), so free_pointer_table()
>now will be invoked from softirq context, and as such may be re-entrant.
>
>Introduce an irq save/restore spinlock to handle this, and hold it over the
>time a given ptable entry is being referenced in both get_pointer_table()
>and free_pointer_table().
>
>In order to make things a little easier in this respect, separate out the
>logic for adding a new ptable entry into add_pointer_table() and only hold
>the lock during ptable entry insertion in this case.
>
>Note that original list_add_tail(new, dp) added new prior to dp, which is
>ptable_list[type].next, i.e. after ptable_list[type].
>
>The equivalent therefore is list_add(new, &ptable_list[type]), which adds
>new after ptable_list[type], only without needing to make reference to dp.
>
>Note that, as m68k-motorola specifies CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE, it
>does not enable CONFIG_PT_RECLAIM. This isn't meaningfully impactful.
>
>With this applied, all of m68k implements CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

I wondered about slot reuse during the RCU wait, but that can't happen :)

The slot stays marked busy until free_pointer_table() runs after RCU, and
the last free unlinks the page under ptable_lock.

Also ran page-table teardown stress and fork/exec churn on
qemu-system-m68k (virt, m68040, CONFIG_MMU_MOTOROLA=y). All 40 rounds ran
cleanly :D

Acked-by: Lance Yang <lance.yang@linux.dev>

Tested-by: Lance Yang <lance.yang@linux.dev>
