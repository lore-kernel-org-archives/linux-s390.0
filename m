Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81467329E57;
	Thu, 19 Mar 2026 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918234; cv=none; b=odVjJ0pNYZlouvuKeI7O9p2f6jdY0m0D2yQlbHoJ3gQ+3TaU8WbBTcM42tAPbJOejOp6oE5H5RuAtfKdHeAa7l0wiD/pCfgWwMgTlVpmCqnultsx0ZipETfTz2K93yk8sxqAPVd7xHUQQbya9qsC8SOh+fM0spgDQdps+e/tT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918234; c=relaxed/simple;
	bh=AdANwHypkaoyFgnPBWGs0+AL4kby1VfMSciqBhxaL7g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HidQSUZdt7nhm+Jy3mXzetDZ0NSI+CoDTlX3KeHATKAYFeYPML0OpozfwTfsk+LkK9vwxJsYcWetSUZmr7ixn+Mim39D56TGyKslV53BC91TyCoOubDeu/KjuRnDdYn7OJag5AEuGf+AGuFIpVxLp7DTEIWf/S1tqwNAIxF4008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc2py5dyzzJ46Dn;
	Thu, 19 Mar 2026 19:02:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A71A40086;
	Thu, 19 Mar 2026 19:03:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 11:03:48 +0000
Date: Thu, 19 Mar 2026 11:03:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, "Thomas Gleixner" <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
	<ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan
	<ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
Message-ID: <20260319110346.000034a5@huawei.com>
In-Reply-To: <20260319-config_migration-v1-0-42270124966f@kernel.org>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Mar 2026 09:19:39 +0100
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> While working on memory hotplug code cleanups, I realized that
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.
> 
> Changing that revealed some rather nasty looking CONFIG_MIGRATION
> handling.
> 
> Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
> option and reducing the dependencies that CONFIG_MIGRATION has.
> 
> Heavily cross compiled. I assume these changes are fine, but messing
> with kconfig sometimes feels like playing with fire :)
Seems fine to me, but I agree it always feels a bit like playing with fire.
So more eyes good!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (2):
>       mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
>       mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION
> 
>  arch/arm64/Kconfig           |  1 -
>  arch/loongarch/Kconfig       |  1 -
>  arch/powerpc/Kconfig         |  1 -
>  arch/riscv/Kconfig           |  1 -
>  arch/s390/Kconfig            |  1 -
>  arch/x86/Kconfig             |  1 -
>  include/linux/memory-tiers.h |  2 +-
>  init/Kconfig                 |  2 +-
>  mm/Kconfig                   | 33 +++++++++++++++------------------
>  mm/memory-tiers.c            | 12 ++++++------
>  mm/mempolicy.c               |  2 +-
>  mm/migrate.c                 |  5 ++---
>  12 files changed, 26 insertions(+), 36 deletions(-)
> ---
> base-commit: fbf55982f31ae6aa11f890c36bccc130ce70a312
> change-id: 20260317-config_migration-463e20400499
> 
> Best regards,

