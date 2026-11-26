Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691685;
	b=e+5LI8i6Pgr0vr2/lWCr6xij3ZAxK6UKCQR32Vo2LYA9LZyDP25HHbOxC/SMeKOHaURe
	 Yajb5npt4K/whBbHW4+7hK5kEmtwQ8XAuOKQE/gOUYim0wmNe8KbLlRUT8n4a15WrrR+T
	 WxQ1iPcydUETcr2PfMghGFUzDeF/w4jhKvJsn+6lWGSvr5ysFCUV39QK3Qvs//KZiqbtE
	 aT6qziDyHOBoNBVShgCC6blTMG5FK8iFCUtl6r4UA3X69yw7AH5AhoURMC/hfCoGgr7b/
	 H7nlAOOwaFinpINAYK62Ve0FKT12+yELnhi4i3sEe/bbG8ecEmR7VAA3D4VMNAqKsGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691685;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+zAN299vizOOPECPls5C9ly2hX7A6i/wCUYEhdWTrYE=;
	b=urTwIXMliPMSQPAISif+jZBbPer4BaknLq6ECAyv1wrJDwA43UYZe8o4BUQlaCEzfQIa
	 Cc6nVX7npbfus7xYxsukvNyGJ14YR72Es0Q2uwd4lscl31IsSTI9vKHsUjxMV8IGbEb14
	 PgsxwmEL2D79IWZGtiEjhdhHLIy5wuDyP/tsmxfr5j9KBW4dJfnWVgZuZB/S3Zjee4/Li
	 CSX44HmZuZ65jNseYS3JdyW/i4Uj1wXZkFs4DvZX1Z9WqsLtjOWJSUOpie2O7PlKnGug1
	 1KZp1cag9y2vMs4fJZy4PlPAgu5YoNtyHYDH6ldZG8ujpz+TN0cwVmW4153DaMDsvFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJyTKMIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC18606A31C;
	Thu, 26 Nov 2026 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJyTKMIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488AA1F000C4;
	Thu, 26 Nov 2026 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691684;
	bh=+zAN299vizOOPECPls5C9ly2hX7A6i/wCUYEhdWTrYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kJyTKMIef9KUJ7TrzxTw1NFRlFaRrs8sShSVVpag23heJBC0+PbBRsR1oW1Wkkfe3
	 /BEDq5VE3iJDg9scZN+INRUCab6B1pQg4aSTRrJ64C0kKSQyJj5olaROHEH5iUjs+j
	 8wKpdu+jFo2YDtHGgaZw4V+6poffdw5Oag7Yqa5qdXG3V3GPOwPnZgPhV6dXf9v76W
	 Sb0W8VbJ3BmR3nLdG+OyaPztr9yMUdYv/loapVRW0yE+e+WYmM44YbzJciMR6VYcE8
	 wGiDHGR3bmNJb9AN7Zbx5mEvbwquRTkTxaAYZtEGd9VyUgt5DRG8mbCQoHnOAjKSOb
	 +bMedTT8QILgA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:14 +0200
Subject: [PATCH RFC v2 01/54] riscv: do not use P4D entries for the linear
 mapping
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-1-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

The linear map uses P4D sized leaves with Sv57 since commit 3335068f8721
("riscv: Use PUD/P4D/PGD pages for the linear mapping"), but riscv has no
p4d_leaf() and the generic stub returns false.

As a result, kernel page table walks treat P4D leaves as tables and wrongly
descend to lower levels. This affects the split in set_memory_*(),
kernel_page_present(), ptdump and the hibernation page table copy.

Stop creating P4D leaves rather than teaching every walker about them, as
commit 629db01c64ff ("riscv: Don't use PGD entries for the linear mapping")
did for PGD leaves.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/mm/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 070ee69eabb3..e1bcc3a16129 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -717,10 +717,6 @@ static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, phys_addr
 	if (debug_pagealloc_enabled())
 		return PAGE_SIZE;
 
-	if (pgtable_l5_enabled() &&
-	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
-		return P4D_SIZE;
-
 	if (pgtable_l4_enabled() &&
 	    !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;

-- 
2.53.0

