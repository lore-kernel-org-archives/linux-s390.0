Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925424078D3
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153015; cv=none; b=TnKDmPzUXIf4Q6WFBoq/Z2R5Wi5t8Hnpfe4TLytjtX/hfPUIkZiDLYnPDhvqJioTunhtN3SdIlCcPpiPa+VsI8OAbae5f7U2WkFCmNRDx/dRv+5Ye0fRwOjgmu7rDG2MtgNwUO85sS5nJEsE0o9F0WsYDIS2H/Gv4wGSzmgKwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153015; c=relaxed/simple;
	bh=99+UKhu23KDHlR6Muc20Ly3uTrswjM+UPnqZD8Rdr68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgPLBbSobQ7ruBl0C0tSpE006dqK5/cnaJT9xB91JFXzEoFEuizx+SzsKK2yRHDlvDH7MAG0WSS+Z1UA+MUriBS7fGP37093ynVqqA59fNFhYc5nbDGgFFqatfa49CKrTBVN9Pp6Gaz61an2L/lSXzjV8J6jhSQKfSEoWEA6cJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MXSkb2Dp; arc=none smtp.client-ip=95.215.58.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MXSkb2Dp"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=99+UKhu23KDHlR6Muc20Ly3uTrswjM+UPnqZD8Rdr68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790153004; v=1; x=1790757804;
 b=MXSkb2DpclhOBsFPPNOlk7p7Q+fP/OJU25EHZdH6R7uu1CUXGTPOe7gA2aSznMPd5exGUhkg
 DdrO3WZAhRx0tnIfOfHn6zlnAr5LcJOcca74Ol5KsNdsny7aRsBHhg2Jvq/wzzd7baAJ61BnWQ5
 GM2W5Uf1FiRwZd5z2cDu0Qr0=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c8a1201785675537;
	Wed, 23 Sep 2026 08:43:18 +0000
X-Mizu-Trace-ID: c8a1201785675537
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
Subject: Re: [PATCH v4 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc, microblaze, xtensa
Date: Wed, 23 Sep 2026 16:43:11 +0800
Message-ID: <20260923084311.15570-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:36PM +0100, Lorenzo Stoakes (ARM) wrote:
>Each of these architectures directly free page tables without routing these
>changes through tlb_remove_ptdesc().
>
>The use of tlb_remove_ptdesc() is required for
>CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
>so simply update these architectures to use these functions.
>
>Since none of the architectures share page tables or do anything unusual,
>nothing complicated is required here.
>
>Therefore this is simply a mechanical change - convert __pud_free_tlb(),
>__pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
>required.
>
>At the point this is in place, all mmu_gather page table freeing is
>performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
>each architecture.
>
>Note that CONFIG_MMU_GATHER_RCU_TABLE_FREE is dependent on CONFIG_MMU for
>xtensa to reflect the fact that nommu does not implement page table
>gathering.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Right, the old frees already end up in pagetable_dtor_free(). With
tlb_remove_ptdesc(), the same cleanup happens after an RCU grace period.

Makes sense to me, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>
