Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8D3E92BF;
	Thu, 19 Mar 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937122; cv=none; b=jk3OVnBhwgAXeQ2/QbQy+G7XvomTD7+mNLl3XVxurBkeydAoUDpEa1vU977ZrUF4LS/Ps/2d030e/t50fRRgJ1RKySzkN+Meb005qF6b1Wtk2+xYP43i88sveIo05uMPkD1Cu5ifJ212TDHQSBXiSiRRdcteZ53UKxIzzFY0EnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937122; c=relaxed/simple;
	bh=+rJxXvh9jbY/cYu63rGxCHb0s8bdU5IuTtrr+qf/8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L//53MzZwIws7mJFByd1GiZ2KQthHwntPOgW9OJD4adBtUN4ntwMKwtYDxRyPbH5aqBPw3UzzXNiiwxRmT3uTag/LRkg0sS75KnLEOkKBEej4IJ3ISvixM6uhgObtxPoKYEU1GldVChrRhbjB/ff+e8vASdkrpgYGm+MJh5T+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAhj5GuC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAhj5GuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5EDC19424;
	Thu, 19 Mar 2026 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937121;
	bh=+rJxXvh9jbY/cYu63rGxCHb0s8bdU5IuTtrr+qf/8ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAhj5GuC0PfaoylzOpmZEg5wivkofnQ+GtRsdaeJOUJ4uAmHeX9yWUjJtJAn3it/L
	 DtIYhs/uZLj/VchTSC0AmON6+W7EzTrZwPGqVuCyAhjCjaHPnhkABYQUeqprmOj1i/
	 R/FWq7IVvWU1IGMy9FTlbHxdCNuIq9kR2X6GzLnLDJQbozNo/mkx2YeXRGXNiMY0o7
	 vQpts1+55w++E8C9ighzin4xwksBwu0yd2u4NfBf4vlh8psPZ69uaMIHcyWDj4a0OE
	 UwiaTPNnXiiVy+7V9ISLDkx2gH43hmidRMy6gz3GsbPkAVEku6PbjeRjw4rot/k9lf
	 Rn92JSY6yNwyg==
Date: Thu, 19 Mar 2026 18:18:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <abwhzkhM9Bk9xPIf@kernel.org>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>

On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> 
> For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> CONFIG_CMA and CONFIG_COMPACTION already do).
> 
> We'll clean up CONFIG_MIGRATION next.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm64/Kconfig     | 1 -
>  arch/loongarch/Kconfig | 1 -
>  arch/powerpc/Kconfig   | 1 -
>  arch/riscv/Kconfig     | 1 -
>  arch/s390/Kconfig      | 1 -
>  arch/x86/Kconfig       | 1 -
>  mm/Kconfig             | 9 +++------
>  7 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index edc927d9e85a..d01800962d84 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -85,7 +85,6 @@ config S390
>  	select ARCH_32BIT_USTAT_F_TINODE
>  	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM

Not really related, but s390 does not have anything but SPARSEMEM_VMEMMAP.

> -	select ARCH_ENABLE_MEMORY_HOTREMOVE
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>  	select ARCH_HAS_CC_CAN_LINK

-- 
Sincerely yours,
Mike.
