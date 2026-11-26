Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691694;
	b=rtBxqLGkZRsR9Hw7cnD/esth6swnhWmy67yzeH7VFLBhj8apELP/UTOQWQM5ctFWOyhM
	 ff2xnM04HahZV3fesnGL5IA4yYwt2NUgFx8JHXB3hBP+r+KuW/+1F+kyNvQP4IY3A89Ci
	 516bg3ny+VQesTPoH3hb0/808U924JjFR1oVR47QdU/1gky9UgHQMhcU0XLYV1Ig08WCR
	 MnAEa4mmXzXNA5DWM1GAXxzm2JR1++Ol5tNy5u2xa1CugzA7fAjfOCt6NzEjURJeYbtXQ
	 L1ltHmhgfDtN0O2IxMu6SfF8N2dAfn4bexcCAHrbpj8DesHMkMMk9NOH2vj4pemnwpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691694;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=pOe0fNlH4H+/AQprp4nKXyU+tisJl0prDAgrQlBRIqs=;
	b=gwOa7a4mzmqxbHTB36w+KT6jpKDrRnlTr8INKffs2j0IWnsDf8/Ar6ZeQ/xzrTqoA/+u
	 5lRiHHe+wQXrqjZTiYLqA55FUsNese47gmIRoBFmRuy06+IBsa9pZk6/PiBzIjaotuI7O
	 J1HQzypDgVBNij/g2UbGia/BoCAgKDcSNMYZNszqxbYs+qESOsbzmN54ScDdthaiKnnIJ
	 p6AA1N4jh7Xlx0g4QStec6M1gCNfO8Hg/22Fu3ymk9bzXnrGRuXwvwOnIlB0ma9cRMm5p
	 murjpj/b+fOwEDPZKANSaJxCbu9d/1KUHagD5Fo8uiq6CxV6IWQs9C99/WqxQ6R2Uww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXrhltc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A54606A31C;
	Thu, 26 Nov 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXrhltc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714501F000D4;
	Thu, 26 Nov 2026 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691693;
	bh=pOe0fNlH4H+/AQprp4nKXyU+tisJl0prDAgrQlBRIqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EzXrhltcMrtKqO6MUWfWRH8/mg8UPhf8i9k4imGHKf4DwbyhoWKKGEnGwRRQgDHwr
	 GmANWhG79gGu7kXW0nekO6FiH4J7RNjWmJoACGQuDBbF6TFy0hUTXDeJ0AR58NQZc6
	 buOPNoDUiaYbPsAZILufugpB4I0oq+kC27B2yxiGnZBMhs/TYqArOIvN/BjSWka2Ll
	 CnvSHYHGIaFGI/ZvB/lVrv8z1dzNmQ6KLqJFB4zTv51MOrM0Ketp2V7nlbX1PnrjAl
	 v0eW8OfCD1pYNH03IstDX7+gNwHnJQcool9WeGFi33CrMoUwm4fiA2rhPhJlQOskbm
	 xnEyOahRKWe7A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:15 +0200
Subject: [PATCH RFC v2 02/54] riscv: test for Svnapot in pte_napot()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-2-723f1e33c3d8@kernel.org>
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

pte_napot() tests only bit 63 and relies on its callers to check that the
CPU supports Svnapot.

On T-Head CPUs bit 63 is not the NAPOT bit: it is set in the non-cached I/O
mappings (_PAGE_IO_THEAD).

pte_pfn() checks has_svnapot() before pte_napot(), but pte_leaf_size() does
not. With CONFIG_RISCV_ISA_SVNAPOT=y on T-Head, a page of an I/O mapping
looks like a NAPOT block and pte_leaf_size() derives its size from the
alignment of its PFN. perf then reports a bogus page size for addresses in
I/O mappings.

Check has_svnapot() in pte_napot() so that its callers don't have to, and
drop the check that became redundant in pte_pfn().

Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2ebd5fa5adc5..1c1ba48315ed 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -288,9 +288,9 @@ static __always_inline bool has_svnapot(void)
 	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
 }
 
-static inline unsigned long pte_napot(pte_t pte)
+static inline bool pte_napot(pte_t pte)
 {
-	return pte_val(pte) & _PAGE_NAPOT;
+	return has_svnapot() && (pte_val(pte) & _PAGE_NAPOT);
 }
 
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
@@ -306,9 +306,9 @@ static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 
 static __always_inline bool has_svnapot(void) { return false; }
 
-static inline unsigned long pte_napot(pte_t pte)
+static inline bool pte_napot(pte_t pte)
 {
-	return 0;
+	return false;
 }
 
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
@@ -318,7 +318,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 {
 	unsigned long res  = __page_val_to_pfn(pte_val(pte));
 
-	if (has_svnapot() && pte_napot(pte))
+	if (pte_napot(pte))
 		res = res & (res - 1UL);
 
 	return res;

-- 
2.53.0

