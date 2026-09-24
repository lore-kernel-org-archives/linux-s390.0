Received: from mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79210175A97
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218570; cv=none; b=jmY6e/vt1Bck+e5wf1hUYj859aiYz8jW95J85F73Q5ERXusK/1KaOPEY2TUIjZX64bT2+2K7c3pjLxL5WiGA79nZ+qnxqb3g3ojrV+rium5raoqaP5fiMo/MLNcIaiwmNVBE/uoBLGR8SirzUH4VFmHs046nJZ4hakdcytvXc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218570; c=relaxed/simple;
	bh=i3rUJrOssAsIlzaIbpG4p7ewG7Kkt+KPljgikjsMoRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jK2fCYxUbhQbWYR53H0aNIVcyyf+3M4OS8lsFUHpXEt8H9eEDwTcAykajgpCx14urxrDyJSxlT7TzVK8m9+XqslObllKa7fsBceLXE6mHBelYclK33rmz7XiqqYyjOvA3wkN+Rq5pjX9xzmCcDUky3pCchtc4EDp0U85oq9ujDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EDjaiT41; arc=none smtp.client-ip=95.215.58.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EDjaiT41"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i3rUJrOssAsIlzaIbpG4p7ewG7Kkt+KPljgikjsMoRc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790218566; v=1; x=1790823366;
 b=EDjaiT41ZgFQHOmmd3U14v63DGKeAKzSd07ipSi9OhtEqdfBiFMIT+/650+y/YlNfXr7cQmC
 luOgAqI5FwgNygaHo9a3noVvQINaaE41+N9SnQIcGEOEuI6xpGqpnvp/3zgB+Dic0lpyXF9EcMm
 Wg+pd1JsB3Jn3xCsBHHaRIAc=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9cade30b803883cf;
	Thu, 24 Sep 2026 02:56:02 +0000
X-Mizu-Trace-ID: 9cade30b803883cf
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
Subject: Re: [PATCH v4 11/12] mm: make userland page table freeing RCU-safe
Date: Thu, 24 Sep 2026 10:55:56 +0800
Message-ID: <20260924025556.18719-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:42PM +0100, Lorenzo Stoakes (ARM) wrote:
>Now every architecture has been converted to support
>CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer makes
>any sense to keep around.
>
>Therefore remove it, and remove all the dead code that existed for
>!CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.
>
>Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
>architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
>__tlb_remove_table() is required, so remove this too.
>
>A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
>CONFIG_MMU was set, however the mmu_gather logic only actually does
>something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled in
>this case, for instance).
>
>As a result, there's no need to gate any of this logic on CONFIG_MMU
>explicitly.
>
>CONFIG_PT_RECLAIM however does have a strict dependency on CONFIG_MMU, so
>make this dependency explicit.
>
>Additionally, correct comments to remove references to non-RCU page table
>gathering and make it clear that this is not 'semi-RCU', nor has it been
>since commit 1fb3d8c20bfa ("mm/mmu_gather: replace IPI with
>synchronize_rcu() when batch allocation fails").
>
>With this change in place the kernel policy is now that userspace page
>tables are freed after an RCU grace period, and thus it is now safe to
>unconditionally perform page table walks under RCU, safe in the knowledge
>that page tables will not be freed underneath the walker.
>
>This is all that is guaranteed, however, so naturally it is still incumbent
>upon page table walkers to ensure that the page table entries are as
>expected.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

with David's feedback folded in, LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
