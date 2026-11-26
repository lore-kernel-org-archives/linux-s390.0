Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692130;
	b=lpWPXI0yBudQC1TXGhAYqO/irpHSgpZCHXGzp2pYg6qFUHkNTIVSPJ4JqZ6QQ2nJtgHc
	 EIjIebGPFzPO04+rqQKURTd2X0Y8GetSnSZ7smW52N4dJklUJ+SIPnhFaKM0UAWpLZMHE
	 pZc0iPnrG/b/rV9ZQOmay995nl0kHrzWXbEoML92w7OIQebZs2Pw2Fhwt08sA2mMgPQma
	 E5pmDRTFDZ+lZ/lLWb7OFz38XiG/D96X6kWBe8T6ldV7HI5/0S04hNCjRzue4kFQEjPTN
	 DW1xJAV0lOifZDkMbIIzLAonohdptXtTTRX9SZTnTdyojf87lWlA1LdNnx+FyM2OT0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692130;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=tUxcS45TVWAOQ3yj2MwWjXfOGvQz0MBdACY4dT2j47w=;
	b=ziCr9efDd9RJC2nRhEXlQaDAhhmXmCuCCyRtCJHdF370DCbviCvlSI51VbwmPvzS/eM4
	 /wvqL5nDdMif96fSGQCkaJqEP4I7opYLOXoS1jKC2zmaUIDaPRwkLOpXhWjv1UxCv+Y+1
	 RXwskQT78sIXT2oYL2x4cC48Wuy7sNkrQovXgvpUmfoCvy7RLIDhjiFUAItLnmKKH+rtC
	 a3Z1FqS3TmMATDTrQVMwvkk2OQmOZH+Ca0rGD82MYWGg2DSEuxgpfrQ0kVwUjxOvQQLaL
	 rozH1R9zwY0I5PrRjeysbhXBqXfqriMJuLNAeWU5FTYRfuOTQ188B4l/a3QTu/Oio2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diFmkQfo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F6606A32D;
	Thu, 26 Nov 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diFmkQfo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A771F000C4;
	Thu, 26 Nov 2026 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692130;
	bh=tUxcS45TVWAOQ3yj2MwWjXfOGvQz0MBdACY4dT2j47w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=diFmkQfoDg5QaKnzRhtb3dPuIfKNl0W3v2/HyhJ+bw2yp93GAHaSlIeWYzBHb/40m
	 i+ZtghuGSVyt695isWPEeoMaLeOsXG64CGjkz77ZObAMLql1JWy71PfnFBv6cXcAHP
	 fcz/yI6LnN1dX94cmS3ldnZicBUliyZTcZsAD/Zok4kH/2m9VTprVyh7kqa6YI5Cln
	 PPMegtrQjn23MEnKUCRDUCYTkntmVWGv1yGe7pI3s4ZvZXXqyimuS2nSji10j7XMoU
	 +EWnVm/T+sx6/6USLVlth9OiWz8f51m5+sw91RrDH7rROK0utXDuRj+7vNwFmAY6Bz
	 E9E2soRiU6+9A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:01 +0200
Subject: [PATCH RFC v2 48/54] mm/pageattr: let an architecture bracket the
 set_memory() entry points
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-48-723f1e33c3d8@kernel.org>
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

arm64 changes its kernel page tables in lazy MMU mode, so that a request
pays for one set of barriers for a range rather than one for every entry it
writes.

The core cannot enter lazy MMU mode by itself. On powerpc with the hash MMU
that disables preemption, and a CPA request may sleep.

Call arch_cpa_enter() and arch_cpa_leave() around the request of the
generic set_memory_*() and set_direct_map_*_noflush(). They do nothing by
default.

arm64 will use them to enable lazy MMU mode when it switches to the core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/pageattr.h | 12 ++++++++++++
 mm/pageattr.c            | 12 ++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageattr.h b/include/linux/pageattr.h
index 1a4e7c5dca98..a2a7235a633e 100644
--- a/include/linux/pageattr.h
+++ b/include/linux/pageattr.h
@@ -171,4 +171,16 @@ static inline void cpa_init_op(struct cpa_data *cpa,
 
 int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op);
 
+#ifndef arch_cpa_enter
+static inline void arch_cpa_enter(void)
+{
+}
+#endif
+
+#ifndef arch_cpa_leave
+static inline void arch_cpa_leave(void)
+{
+}
+#endif
+
 #endif /* _LINUX_PAGEATTR_H */
diff --git a/mm/pageattr.c b/mm/pageattr.c
index 555e55e7ecea..d8ca8fb9bdd1 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -615,7 +615,11 @@ static int set_memory_op(unsigned long addr, int numpages, enum cpa_op op)
 	    !(cpa.flags & CPA_REQ_SPLIT))
 		return 0;
 
-	return change_page_attr(&cpa);
+	arch_cpa_enter();
+	ret = change_page_attr(&cpa);
+	arch_cpa_leave();
+
+	return ret;
 }
 
 int set_memory_x(unsigned long addr, int numpages)
@@ -661,7 +665,11 @@ static int set_direct_map(struct page *page, unsigned int nr, enum cpa_op op)
 	 * set_direct_map_*_noflush() change only the direct map, not its
 	 * aliases.
 	 */
-	return change_page_attr_noflush(&cpa);
+	arch_cpa_enter();
+	ret = change_page_attr_noflush(&cpa);
+	arch_cpa_leave();
+
+	return ret;
 }
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)

-- 
2.53.0

