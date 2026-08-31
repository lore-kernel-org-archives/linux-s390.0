Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB53AFAF1;
	Mon, 31 Aug 2026 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155025; cv=none; b=usMqGECZhJARPLPjxoxCuBI6oDv4jtNjZTShHYDQBXSIxGF63Z3CVb0FaFUlzi+26v2/yqRDuoSV161PQaiAQ9iO9O8PVv5CP3NkmCOVGZWAYKHkG/IcInmZfEeyJD9bIbW8lY6BhxtF3KBdDD71veK3yog6SSOKLeC/o8U/ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155025; c=relaxed/simple;
	bh=QXu4QCgmr2H1ZCNmIiMG/ZtqTETXJXvgk4Bv9ZBGY20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBw+7Mp0J8kX2GvHeoIyAKKfZ+l69GFwxBi9BjMqcixnJSfwzvN7CUWXW7G/7BXCZCooTH5U+Y0Kv3sDBrQznww3hwnjn+Q6ccLSO0In8dOpJF1tBQ1zBOkWq9/NxlJaJSfcZg9eTZMUlfvSDHoEyEugnd9WGUxtVKwL1lo8Keg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bOYCZ7KY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bOYCZ7KY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81995176C;
	Sun, 30 Aug 2026 22:43:38 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D1D3F85F;
	Sun, 30 Aug 2026 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155022; bh=QXu4QCgmr2H1ZCNmIiMG/ZtqTETXJXvgk4Bv9ZBGY20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOYCZ7KYkGWJMwi9hv08o8CPIK1B1PpAWsT/CWN6Rgcfw95970wz0SYilqsTPRRdM
	 jy771f4RrMqp3RlkJj0jL31egGOxLsKMhmyO6mjoCsqu3qGWanVlVBYExkolRR0f08
	 s6ecC7ZYicemVZWC8wmn+aaVAZnWZ7DbjWG2cN+I=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm: Stop using pxd_ERROR()
Date: Mon, 31 Aug 2026 11:13:24 +0530
Message-ID: <20260831054331.625505-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxd_ERROR() has been used in generic mm just to print the page table entry
in pxd_clear_bad() before clearing those out with pxd_clear() later. These
pxd_ERROR() macros have been provided by all platforms which basically did
the same thing.

Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
page table entries thus completely dropping dependency on platform provided
pxd_ERROR() macros which can then be dropped off later on.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V1:

- Dropped including mm_type.h

 mm/pgtable-generic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..224c444cf45d 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -26,14 +26,20 @@
 
 void pgd_clear_bad(pgd_t *pgd)
 {
-	pgd_ERROR(*pgd);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pgd_val(*pgd));
+	pr_err("bad pgd %s.\n", str);
 	pgd_clear(pgd);
 }
 
 #ifndef __PAGETABLE_P4D_FOLDED
 void p4d_clear_bad(p4d_t *p4d)
 {
-	p4d_ERROR(*p4d);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, p4d_val(*p4d));
+	pr_err("bad p4d %s.\n", str);
 	p4d_clear(p4d);
 }
 #endif
@@ -41,7 +47,10 @@ void p4d_clear_bad(p4d_t *p4d)
 #ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *pud)
 {
-	pud_ERROR(*pud);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pud_val(*pud));
+	pr_err("bad pud %s.\n", str);
 	pud_clear(pud);
 }
 #endif
@@ -53,7 +62,10 @@ void pud_clear_bad(pud_t *pud)
  */
 void pmd_clear_bad(pmd_t *pmd)
 {
-	pmd_ERROR(*pmd);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pmd_val(*pmd));
+	pr_err("bad pmd %s.\n", str);
 	pmd_clear(pmd);
 }
 
-- 
2.43.0

