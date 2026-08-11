Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122C2E5B21;
	Tue, 11 Aug 2026 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422105; cv=none; b=q39kIlAWBum4XT36QsEOyWazT/JLOHtS8hZfaRGM+bxUOepIEOBeptJj1OYoIwW0jCNSXR8SyPCv5U2F1JpOv3CpvejVB9F7XbbejOuq2LKtQmDRz7Oxf2z/CvJoiUoIQgv0BsL6d4yU7MnFzX23p43q3da/mqem+FIgUO4kt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422105; c=relaxed/simple;
	bh=OKKk+J7eMHIWw8QjhuEJW1LEtsSDjKpxvNzpv83/ug8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvjw8xxzDkSW2OYZHWZkVzRoIltZpMc1kGy4t0VAjvaUrbybClRPUxVC07+tp8s70rPFaXhoWjHy+6sLOIwAEMbOCiFQ5otG6qHOS9pzqbzmksiZ6J0/ds991srCSkoqttM/8ZrD7bklBNDBAPbAVYgwcgUahcfI0TWG3O+hhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NDnTBVj2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NDnTBVj2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977B6168F;
	Mon, 10 Aug 2026 21:21:35 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6F33F673;
	Mon, 10 Aug 2026 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422099; bh=OKKk+J7eMHIWw8QjhuEJW1LEtsSDjKpxvNzpv83/ug8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDnTBVj22FStQ+XK0HLwvJKJro3KeX1TWQm5rzPJ0S7csuqOhawi++Hc637b87GPD
	 Hvinpr7iTMbSodkYtTOTqdZ/yXYwlvbKLRTdNZffXQArm0ptKBDdXtxSDLXybURVE7
	 0SmAxajLRK1u+03/uA3LFe6J/WvE1OGUYKFOsK0Q=
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
	linux-kernel@vger.kernel.org
Subject: [RFC V2 4/6] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Date: Tue, 11 Aug 2026 09:51:17 +0530
Message-ID: <20260811042119.3652929-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
are known to be NULL and hence could not really be accessed.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/mm/init.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b3c7fd84ceb4..0bb8555568a4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -58,22 +58,16 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	}
 
 	p4d = p4d_alloc(NULL, pgd, addr);
-	if (unlikely(!p4d)) {
-		p4d_ERROR(*p4d);
+	if (unlikely(!p4d))
 		return NULL;
-	}
 
 	pud = pud_alloc(NULL, p4d, addr);
-	if (unlikely(!pud)) {
-		pud_ERROR(*pud);
+	if (unlikely(!pud))
 		return NULL;
-	}
 
 	pmd = pmd_alloc(NULL, pud, addr);
-	if (unlikely(!pmd)) {
-		pmd_ERROR(*pmd);
+	if (unlikely(!pmd))
 		return NULL;
-	}
 
 	return pte_offset_kernel(pmd, addr);
 }
-- 
2.43.0

