Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692102;
	b=Y4TX+Lb+mXZlX4971Zph9G57kdCL/+9c5t+qTGsVj9hsfhrfTlTW2/jGpGu/8qdE2zB+
	 A5sTETvoShsHP/YpZd6tQEIFDNFGxcwA1cKUa3YODCFfvampzWeEecFqV+SFO9HSrYoZ2
	 9ekQ3LbmJVs+vMznTtH23UA/DhBfcEsZ8kipFOZ+s3mmAnXk8yo20XzellUCSk4yt3DoT
	 jxVSVKyCLNEcVwo4ZhJpQoukdRmwxo2rHpxjgsnWJxzDOPoXWbpx93anaStWk2UoMeyi4
	 B4MqXu4XUajZu/HzGGuXT0+RtruvfUS7NhIDoac/Y1hKmNk2dhHP95x766MVO5gV00g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692102;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=AWz1FsKs9LGo5NyRovT968VOcnA5bINSvJfjoSeKHiM=;
	b=kHn0fKV5aV16HSPDBl77TtuZeil7/LpjguQHKY2VopHekxWrAi2Av1/e5JsrK1V8y1VX
	 Go8Y/tqECq3K4YDuzMIPIEOLgtu/BpRizKv98ejw63QPPm0EbNJysXNN4t/tBd6okJwqn
	 pqUSY8jdZ6vbBoSrP6BjA7NsCWMU6/tsz2xeWC5HItxv1UdfgOfuS+vcgNCj09nd5ZZuQ
	 QuQQdBduyueUeOUEXkbYEII7VYL9TUpyRr+cp+Kq38ZTH4v4kjeuog+CNDXgTDDmAnKok
	 ueYjP58HgZGiP7eVaKpsCP33HYAWFZ5ogTVLHxiB+QV4Exnpl8LMuTKr/hzO4ra2ojw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ824Twb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9AD606A326;
	Thu, 26 Nov 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ824Twb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22E1F00A01;
	Thu, 26 Nov 2026 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692102;
	bh=AWz1FsKs9LGo5NyRovT968VOcnA5bINSvJfjoSeKHiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AQ824Twb4ALIqbjov3o+wIN2U+2/6b51/CWeKM+zoQx5APB58zI/yLVE7AgN02BLY
	 90rmSuGQUtENr/nE4mNk+jvdK++v4rBBpkaAD/3lGFydSk94agQAQvnGNBIrUt7pqJ
	 qeG0tLyEXHORMngIoNNGSeIOYL0uTbbz0Wd9xJhVugOxmWuCAufAq2YqzjGtP1LCA/
	 o3L4T1istYHsA0MbvoYUVeiWmyGjXxpLn3lmCyFfZvQheV46g+ImAlMUwMcVpcOlZ6
	 dYQ8sYKoKt8MvfmQsAdZfRioSw6scLwAFDjaPy6WIhwYm+gm398pxo1SOKIvCx2SKz
	 lLqrMgtJFIy6Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:58 +0200
Subject: [PATCH RFC v2 45/54] s390/boot: map the identity map with 4K pages
 for debug_pagealloc
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-45-723f1e33c3d8@kernel.org>
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

debug_pagealloc maps and unmaps single pages of the identity map, so it
needs the identity map to use 4K pages.

The decompressor maps it with large pages regardless, and vmem_map_init()
then splits it with __set_memory_4k().

The s390 implementation of change_page_attr() skips the PTE level for that
request, so the split costs little more than filling the new page tables.

The generic CPA core, which s390 is going to use, has no such shortcut:
after the split it would visit each page of the identity map, taking
cpa_lock and walking the page table for every one of them.

Parse debug_pagealloc in the decompressor and map the identity map with 4K
pages when it is enabled, like x86 and arm64 do for their direct and linear
maps. Drop the split from vmem_map_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/boot.h     | 1 +
 arch/s390/boot/ipl_parm.c | 9 +++++++++
 arch/s390/boot/vmem.c     | 3 ++-
 arch/s390/mm/vmem.c       | 2 --
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/boot.h b/arch/s390/boot/boot.h
index 61a205b489fb..07ca806ff8ff 100644
--- a/arch/s390/boot/boot.h
+++ b/arch/s390/boot/boot.h
@@ -110,6 +110,7 @@ extern const char kernel_version[];
 extern unsigned long memory_limit;
 extern unsigned long vmalloc_size;
 extern int vmalloc_size_set;
+extern bool debug_pagealloc;
 extern char __boot_data_start[], __boot_data_end[];
 extern char __boot_data_preserved_start[], __boot_data_preserved_end[];
 extern char __vmlinux_relocs_64_start[], __vmlinux_relocs_64_end[];
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index ac4cf1ced71d..cf6c6679c5a5 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -34,6 +34,7 @@ int __bootdata_preserved(cmma_flag) = 1;
 unsigned long vmalloc_size = VMALLOC_DEFAULT_SIZE;
 unsigned long memory_limit;
 int vmalloc_size_set;
+bool debug_pagealloc = IS_ENABLED(CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT);
 
 static inline int __diag308(unsigned long subcode, void *addr)
 {
@@ -332,6 +333,14 @@ void parse_boot_command_line(void)
 			stack_protector_debug = 1;
 #endif
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+		if (parameq(param, "debug_pagealloc")) {
+			rc = kstrtobool(val, &enabled);
+			if (!rc)
+				debug_pagealloc = enabled;
+		}
+#endif
+
 #if IS_ENABLED(CONFIG_KVM)
 		if (parameq(param, "prot_virt")) {
 			rc = kstrtobool(val, &enabled);
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index ff6d58a476ba..3a6cd62c31ae 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -286,8 +286,9 @@ static unsigned long resolve_pa_may_alloc(unsigned long addr, unsigned long size
 static bool large_page_mapping_allowed(enum populate_mode mode)
 {
 	switch (mode) {
-	case POPULATE_DIRECT:
 	case POPULATE_IDENTITY:
+		return !debug_pagealloc;
+	case POPULATE_DIRECT:
 	case POPULATE_KERNEL:
 #ifdef CONFIG_KASAN
 	case POPULATE_KASAN_MAP_SHADOW:
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index d2879ce860a1..191326ee7ec8 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -681,8 +681,6 @@ void __init vmem_map_init(void)
 	 */
 	if (!cpu_has_bear())
 		set_memory_x(0, 1);
-	if (debug_pagealloc_enabled())
-		__set_memory_4k(__va(0), absolute_pointer(__va(0)) + ident_map_size);
 	pr_info("Write protected kernel read-only data: %luk\n",
 		(unsigned long)(__end_rodata - _stext) >> 10);
 }

-- 
2.53.0

