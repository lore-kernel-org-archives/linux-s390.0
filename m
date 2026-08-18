Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637E53D567E;
	Tue, 18 Aug 2026 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025651; cv=none; b=j/bCGt2gCYSSbZVC1QFaUdeyzZiTcnRBXPM1LStjFxke0zUfWpSjb8Ida24dXu3oxpLPyh8HOiMMDKrXBKtKoXPjJsx5QUZRmLj1khyzvIfisfZjvLmNtL5l6/0Y4PsDw3QDdDE/fIh3fQ5f0CcMREsFpifcBCTyL4d//bbJrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025651; c=relaxed/simple;
	bh=ttb24YxqPfvdlZDv4/6sPaZz7dp5RDI+R8A7FcbdkQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ4VME5Lonq2r0UFY/+hUGF4Zuc6u7VFSDQ3qrw15r1lemYjB9pMqDLMfTRZ11nMMltKII+wULYTt/sAHJChmgtCW3en950D0XlPnw3qZAKsaGfEDV9GvOZpwJ7GgIk65eHP38CFihfDssHVO35qbbxtcLT6VXjk6RXsauNvTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Nm9wKCIr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Nm9wKCIr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6A7D1713;
	Mon, 17 Aug 2026 21:00:44 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A313F66F;
	Mon, 17 Aug 2026 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025648; bh=ttb24YxqPfvdlZDv4/6sPaZz7dp5RDI+R8A7FcbdkQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nm9wKCIrKirdGI7EsjFmNpzvktBxen3s+Y8bQddcn8JS5ntzJoAry+6wo+3u4vhyn
	 M7CRYhYAvk1FZnrpGWYeR2L9tvn1Sn/4mF9BXA7BiP3Pw3dmPL/RpL6VcCsRFudXyN
	 14LSMlFlRUiV28bQxOW5lFnD7s8QFTIgvbWS0vko=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Date: Tue, 18 Aug 2026 09:30:34 +0530
Message-ID: <20260818040041.1891769-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ptrval_to_str() inside a header thus making the helper more generally
available for new users which are being added later. While here, also move
another related string size macro PTVAL_STR_MAX inside the header as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm_types.h | 15 +++++++++++++++
 mm/memory.c              | 16 ++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..a5b514e55dd7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
 	return flags & MMF_INIT_LEGACY_MASK;
 }
 
+void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
+
+#define ptval_to_str(buf, val)								\
+	do {										\
+		auto __val = (val);							\
+											\
+		ptval_bytes_to_hex_str((buf), sizeof(buf), &__val, sizeof(__val));	\
+	} while (0)
+
+#if defined(__SIZEOF_INT128__)
+#define PTVAL_STR_MAX	(32 + 1) /* Max 128-bit value in hex + NUL */
+#else
+#define PTVAL_STR_MAX	(16 + 1) /* Max 64-bit value in hex + NUL */
+#endif
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/memory.c b/mm/memory.c
index 01893720b6d8..752fc04ef8ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -46,6 +46,7 @@
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
 #include <linux/hugetlb.h>
+#include <linux/mm_types.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/highmem.h>
@@ -519,7 +520,7 @@ static bool is_bad_page_map_ratelimited(void)
 	return false;
 }
 
-static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
+void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
 {
 	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
 		snprintf(buf, buf_size, "overflow");
@@ -546,19 +547,6 @@ static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry
 	}
 }
 
-#define ptval_to_str(buf, val)								\
-	do {										\
-		auto __val = (val);							\
-											\
-		ptval_bytes_to_hex_str((buf), sizeof(buf), &__val, sizeof(__val));	\
-	} while (0)
-
-#if defined(__SIZEOF_INT128__)
-#define PTVAL_STR_MAX	(32 + 1) /* Max 128-bit value in hex + NUL */
-#else
-#define PTVAL_STR_MAX	(16 + 1) /* Max 64-bit value in hex + NUL */
-#endif
-
 static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
 {
 	char pgd_str[PTVAL_STR_MAX];
-- 
2.43.0

