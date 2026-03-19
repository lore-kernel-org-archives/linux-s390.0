Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB221CC5A;
	Thu, 19 Mar 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908409; cv=none; b=DwJT3WF98T0s2CzyMON+wv62Qd5xnl0Df4LSDUkamhb+G19IzYAEbUWo/WNFcf8T2sifmyQ5Zd00J8mXNA2WOr5bxHw+LDfb+44+3uIKmRKAZW7Qq4eTFRM6QmjkGWwqBy8me3k2Lmx7nahXCbgax1dxdVjkpmkJ7EAMFTETkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908409; c=relaxed/simple;
	bh=GAQ9b9edKTgGxU+mpQzf5vrvp0GbZiNpB68nUzbzDyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MpmpAUHkiQqs2yw9+EfmiwUCHd1Q/+BwAEUkhKs2OItX/B9nGQuoFaMlvwLNOvMiRlVvPRerZzxIJp4iHPESnWoAUcd/c8woa2OKU+yGp8AxKuobStts6LXqYU6EslCxIuDqfBG5AUNil7WOmIgccJpgEzmB8z6SKHpecrg/p78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW9ab7On; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW9ab7On"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B1C19424;
	Thu, 19 Mar 2026 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773908409;
	bh=GAQ9b9edKTgGxU+mpQzf5vrvp0GbZiNpB68nUzbzDyY=;
	h=From:Subject:Date:To:Cc:From;
	b=nW9ab7OnkN7S00RxQQ6fV539CUU/HXaHfFwpCsfjk1vZa9nrCehAKXmvHkrdByEwi
	 UTuF8w219c0gp/9PlGkyTjPCXYgHMu+wuB+VcuJDOAEMR4YYArxHQyQe1bdwRE69iq
	 6KnzMuHTxJ83BywVs82C5DCGxHXYPZw/XiMZC3jCTCs7Ed7M20epXUlpSA58uZXblU
	 VhVWCftNRHTP6Wysxkep+z8UHXRrW+AIwQJO/Iq01wPPGebHyKnPiUVOyGVPTWywxV
	 gA0MkkSVRuNWrkUsu2BUt2gfc0ropCqtacyuIkXHK1ZCQaGyBOonZgNXG1/Y1ey4xt
	 IYgm8NZf2LthQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
Date: Thu, 19 Mar 2026 09:19:39 +0100
Message-Id: <20260319-config_migration-v1-0-42270124966f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuxu2kC/x2MQQqAIBAAvxJ7TlhNjPpKRISttocsNCIQ/550H
 JiZDIkiU4KxyRDp4cRnqCDbBuy+Bk+Ct8qgUBnsZC/sGRz75WAf17vKQpuOFGpEPQxQsyuS4/d
 fTnMpH8Y9x3JiAAAA
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-mm@kvack.org, 
 linux-rt-devel@lists.linux.dev, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

While working on memory hotplug code cleanups, I realized that
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.

Changing that revealed some rather nasty looking CONFIG_MIGRATION
handling.

Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
option and reducing the dependencies that CONFIG_MIGRATION has.

Heavily cross compiled. I assume these changes are fine, but messing
with kconfig sometimes feels like playing with fire :)

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
      mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION

 arch/arm64/Kconfig           |  1 -
 arch/loongarch/Kconfig       |  1 -
 arch/powerpc/Kconfig         |  1 -
 arch/riscv/Kconfig           |  1 -
 arch/s390/Kconfig            |  1 -
 arch/x86/Kconfig             |  1 -
 include/linux/memory-tiers.h |  2 +-
 init/Kconfig                 |  2 +-
 mm/Kconfig                   | 33 +++++++++++++++------------------
 mm/memory-tiers.c            | 12 ++++++------
 mm/mempolicy.c               |  2 +-
 mm/migrate.c                 |  5 ++---
 12 files changed, 26 insertions(+), 36 deletions(-)
---
base-commit: fbf55982f31ae6aa11f890c36bccc130ce70a312
change-id: 20260317-config_migration-463e20400499

Best regards,
-- 
David Hildenbrand (Arm) <david@kernel.org>

