Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691968;
	b=PLsvn7PXUK+KflaStWT8be20Mhh5lpvu2gnHuAkfsPFV/8LhJ1KJm1ogmVXFSppTrmjn
	 Duqn3d7cBaeE3AFNuE5+km42C4OWOPu+CHHAKbwyiFGBQ9FyyMJFGhdw+lD85TY1znNi+
	 8POBNDSCjybUEVDpktdIVy4LgUjNfGRqhS/KjBYJKSnGEsEpTYgX/YrYCsF66cbVCGvom
	 G5g5C02ikrtsO52Z5pmeAbwl3khn4y2JsNmIMwGIYeeNVi3HOpii3DUNqRmlZ7Tc87Ji/
	 3MdFIigOv9XaVYSkSn8AEGpliVM8/70vF68VCeusyrZYlagAdi5txsZdauVq+dYp6YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691968;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=9cPWUjHIPI7LtCSNqYYvsVdQiH3MUbUDgs7gRvdWWiI=;
	b=DpPq6ikJ0KqcriuI3Re6tfOge5k7Qq+UIDwbXVSRdgCCoLTm/UVmnc7bIX221YUTQcbX
	 rMrwZ1h5RQdaVphwWo0PacVa52dEKFXj8S/txwfaiouqyfENcKzEnIwvKc8h6tAF+q3PF
	 U8TtEEF2LEmGn2kStq8C//J6wrySrChHuis6lddvvrp3PARL0RUtlRjs7h/2UvzneW8Vr
	 nCtGLIEV1IzN25B+ExDKGUKo/1DE1yG9657Sr5iG8TZg51tGyjKHFq6QhyxSZv7n09JVm
	 tmO3pBRddTwYx5XaXCbGcUVTrj8tiXBg0WVs81HQdghkEYGD8jFZIopRYrXhSyFMqMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N6q86/Uu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B3606A32A;
	Thu, 26 Nov 2026 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6q86/Uu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38AB1F000C6;
	Thu, 26 Nov 2026 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691968;
	bh=9cPWUjHIPI7LtCSNqYYvsVdQiH3MUbUDgs7gRvdWWiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N6q86/UuKdbMrBdtERhjhVFw0CbAJ4clSdTmUchWL6RgFVkEFE3mEFyjySuZ/PEVC
	 rUCd6Kq2go9A79rGKv9HgKqGK83C2clZ6aUkNYsA29a1Wo0vuxFjA1XROwrOgbp8xw
	 aOL75eZCeV1YUWJizVWuqhiRYrNriruvGv6qFzQV16MzEVZyn/pOqMpQzhn0BETYu1
	 Pw/fxf1OEmACLN0sONM/NixOOFWiGvIiGavxH1woaBbI73/XNSn75AXasiZb0IIKd0
	 HqmQAy3YxyZej2Z4YIxY5NMru1NNVtgYbxwMHf1zAj+lpMo3vwasqVbinhwzpc4VDC
	 dZfOgF0XejigQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:44 +0200
Subject: [PATCH RFC v2 31/54] mm/pageattr: introduce
 cpa_flush_tlb_kernel_range()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-31-723f1e33c3d8@kernel.org>
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

Many architectures that implement set_memory_*() APIs flush the TLB after a
page table update with flush_tlb_kernel_range() for the range of the
request.

Add cpa_flush_tlb_kernel_range() helper for their arch_cpa_flush() hooks.

When to flush and whether to flush more than the request stays up to the
architecture.

LoongArch, ARM, powerpc, riscv and arm64 will use it when they switch to
the CPA core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/pageattr.h | 1 +
 mm/pageattr.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/pageattr.h b/include/linux/pageattr.h
index 25f04e61ee85..091408ad328f 100644
--- a/include/linux/pageattr.h
+++ b/include/linux/pageattr.h
@@ -65,6 +65,7 @@ static inline unsigned long cpa_addr(struct cpa_data *cpa, unsigned long idx)
 
 int cpa_process_fault(struct cpa_data *cpa);
 int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias);
+void cpa_flush_tlb_kernel_range(struct cpa_data *cpa);
 
 int change_page_attr(struct cpa_data *cpa);
 
diff --git a/mm/pageattr.c b/mm/pageattr.c
index dcece32ebad2..852e0989dac9 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -14,6 +14,8 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 
+#include <asm/tlbflush.h>
+
 /*
  * Serialize CPA using cpa_lock so that:
  * - concurrent requests don't split or change the same large mapping at the
@@ -482,6 +484,12 @@ int change_page_attr_noflush(struct cpa_data *cpa)
 	return ret;
 }
 
+void cpa_flush_tlb_kernel_range(struct cpa_data *cpa)
+{
+	flush_tlb_kernel_range(cpa->addr,
+			       cpa->addr + cpa->numpages * PAGE_SIZE);
+}
+
 int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias)
 {
 	int ret;

-- 
2.53.0

