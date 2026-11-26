Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691741;
	b=BdP9HjvC8LbjsVMIfJcEgWMPjYTYC5VKA/5DvMi9Stp4zQC2PGv8rpCWRmI0kmTlmR0S
	 dDSsQIaG9FMcBg/rRFByASwEbBaw6g02bZL7mWtP0sRjk+1eBMF1yoTLODxZzeVhNvmzd
	 7BQpDk8l6urEIl9qAvLrY4IzYXWVtEcA2Us1tj3NDkhQzNW/MGC4k7ijbT0iWICDe8akI
	 8xNEGFDPiY/yy3QTVa6kzE2y8qYAdtl8jAV1+17QBzN+QWYLUBgqMUnlgC1fpMqzSKqd4
	 DtbPKX0N/3Wy1RL+huvmTDrFKopWgLb/OLRIVsnRpzUpwrkJVizOHjth7Miih4/ZYKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691741;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nf8Dg1I8n4rgs3e9w7cnbg/z5iiBQqzebLGhMMMtmX4=;
	b=gZOsPSItp03ipq416xwTn7ICROkQrk6sN8qI9329DclDS2+eZ6zls5imd44EwLDh7BjV
	 UxiiAIZzddjl2Ho0f80iGuSjQ8kUK8HF7IEjrH78Nb37qniwMrSKp+MfqMt60qGop3F1w
	 4LLZEQej9yRijUJnsK5cSjCfI/G8HXD6CXxkzHk8oFxUIdGsuFVp+aMiJQoT8nS+xS9hW
	 xp9ysOuI1u1ypY8NHhNnmHawHVGSocmNfLxYXyBMt5plu1MOUXfRM0OVY8qd0ThazOx2j
	 PzrEz+WTgil+MNNdC4NTYJfPZkBP19FUVMObE63U+zWkUNPqxkVsbHL1WGLs37/a11Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgm6ni1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2E606A321;
	Thu, 26 Nov 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgm6ni1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AD91F000CA;
	Thu, 26 Nov 2026 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691740;
	bh=nf8Dg1I8n4rgs3e9w7cnbg/z5iiBQqzebLGhMMMtmX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dgm6ni1b4ATvsu8fOCDBBMC4Gh77ed8M4GQRbcomJQs08awcbabF4eaq9qmXy0gqg
	 JJvtmZ6YrX89lCG0g6pPuy/2dFSN9kOM6Gz56GcV7TnzjNyrWyS3PFur8FPZpE2ffJ
	 2PgnJyOJTT0Z8ORoOShyglFN4IjkQlALevS2VfUB8S9Zi/qhrGyEus3D7slbTIChIB
	 T2YrCvr7+p4qI96CGgok8isNnhQgrbn9k9y9zWEv2CeyRtTpAMgS4KW/4gxjfHZ5iO
	 2mcAZCh8kqAsGsfpbwo1eszlrG4UjdQZeusc0Ba1auKtD460X+FDVjWIcghsrzOaJg
	 GkQEntGvSaGjg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:20 +0200
Subject: [PATCH RFC v2 07/54] x86/mm/pat: drop KERN_WARNING from the WARN()
 in __cpa_process_fault()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-7-723f1e33c3d8@kernel.org>
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

WARN() prints its message at the warning level, so the KERN_WARNING in the
format string is redundant.

Drop it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 42f27d60adf3..db41f94f2355 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1835,7 +1835,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 		/* Faults in the highmap are OK, so do not warn: */
 		return -EFAULT;
 	} else {
-		WARN(1, KERN_WARNING "CPA: called for zero pte. "
+		WARN(1, "CPA: called for zero pte. "
 			"vaddr = %lx cpa->addr = %lx\n", vaddr,
 			cpa->addr);
 

-- 
2.53.0

