Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF73DEFFE;
	Sun, 16 Aug 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878008; cv=none; b=AlTzbYEQARcsMqBTnQnHnPnSpr20AKnwRYMdDubVnsaxaW6mycjHYlDIjtjBzZ5Ef7OHsFmNzRcDK8z4fL4A7uACTrhGczOwhqKZB9DPHGZUZK5a6vDYajYoCjb/3niDSh5862dH8IR5iuJf5hNwyk225DKmJORdXsL1Y+OG3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878008; c=relaxed/simple;
	bh=ozgrsiTGOYisD+hDwa3qYD5pKcpI6G3ZsYnz9nV8AtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecMSgSiJW/MKkoNwahbT0qFwRIFlsCn4S0mG91W7XkC/V7WvxKSViLgJG7ZKNNuSRMx6Z/8GljVFvbUGPWjbj2MHhf29CVZb8kAnZ22JY+iOvEUzfw2WaN4ZRVXcNdADH4GX3Zom5yzurYeumfI8Vd9Ei4G4aqhs0F1cCYyX+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhcayokE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhcayokE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DB71F00A3A;
	Sun, 16 Aug 2026 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878007;
	bh=gy2s2udgAuUOuqiiG581Z7vL2dnOoGEiogGjehxnVAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lhcayokEj43ho0cwYwXSsPkKuYBPIh9x6hGmG7ih3uLsYURAu3S/D5HPbKqADyg3G
	 Pn/qo1s8e+YdNqNPYFYKLnk3uW+Qxcn4pjWu+rILw26T1RvSQ9uzDkgh8ZGk5iaXjp
	 23V5pkiCv2OtGtQldL3UnMXwFTy1HAwZq3MNoDc0AVt84RmjXctY3LEIz5jZ/Nyfz7
	 CisMqAS9gASEjwdc+fUzDeXAsec3VmceqO25xO+htrehQM6I7hJXZYjTU5GAos6kla
	 Bpmwk7AT9oICEYNjyjibk/sz26kXrKCZIv0ddB9GkmW6oMBTDXpZ32LXrEpJqOT6bW
	 vt3YeZwG5M/tg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 16 Aug 2026 13:59:26 +0300
Subject: [PATCH 3/6] mm/vmalloc: constify vm parameter of
 get_vm_area_page_order()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-execmem-set-vm-perms-v0-2-v1-3-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 Will Deacon <will@kernel.org>, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 loongarch@lists.linux.dev
X-Mailer: b4 0.17-dev

get_vm_area_page_order() and vm_area_page_order() do not need to modify
struct vm_struct passed to them.

Constify the parameter.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/vmalloc.c | 4 ++--
 mm/vmalloc.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6822f0fe9583..fc7993db4152 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3124,7 +3124,7 @@ EXPORT_SYMBOL(vm_map_ram);
 
 static struct vm_struct *vmlist __initdata;
 
-static inline unsigned int vm_area_page_order(struct vm_struct *vm)
+static inline unsigned int vm_area_page_order(const struct vm_struct *vm)
 {
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
 	return vm->page_order;
@@ -3133,7 +3133,7 @@ static inline unsigned int vm_area_page_order(struct vm_struct *vm)
 #endif
 }
 
-unsigned int get_vm_area_page_order(struct vm_struct *vm)
+unsigned int get_vm_area_page_order(const struct vm_struct *vm)
 {
 	return vm_area_page_order(vm);
 }
diff --git a/mm/vmalloc.h b/mm/vmalloc.h
index 8866ddcff668..211869f36509 100644
--- a/mm/vmalloc.h
+++ b/mm/vmalloc.h
@@ -12,7 +12,7 @@ void __init vmalloc_init(void);
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages,
 		unsigned int page_shift, gfp_t gfp_mask);
-unsigned int get_vm_area_page_order(struct vm_struct *vm);
+unsigned int get_vm_area_page_order(const struct vm_struct *vm);
 #else
 static inline void vmalloc_init(void) {}
 

-- 
2.53.0

