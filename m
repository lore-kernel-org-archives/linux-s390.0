Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgLWCSn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Dec 2020 21:18:43 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 055/217] s390: make sure vmemmap is top region table entry aligned
Date: Tue, 22 Dec 2020 21:13:44 -0500
Message-Id: <20201223021626.2790791-55-sashal@kernel.org>
In-Reply-To: <20201223021626.2790791-1-sashal@kernel.org>
References: <20201223021626.2790791-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 97b142b7400bdce93aa674df044a4bc58e88f08c ]

Since commit 29d37e5b82f3 ("s390/protvirt: add ultravisor initialization")
vmax is adjusted to the ultravisor secure storage limit. This limit is
currently applied when 4-level paging is used. Later vmax is also used
to align vmemmap address to the top region table entry border. When vmax
is set to the ultravisor secure storage limit this is no longer the case.

Instead of changing vmax, make only MODULES_END be affected by the
secure storage limit, so that vmax stays intact for further vmemmap
address alignment.

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/setup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 4d843e64496f4..f8e31dde5ac07 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -567,13 +567,14 @@ static void __init setup_memory_end(void)
 		vmax = _REGION2_SIZE; /* 3-level kernel page table */
 	else
 		vmax = _REGION1_SIZE; /* 4-level kernel page table */
+	/* module area is at the end of the kernel address space. */
+	MODULES_END = vmax;
 	if (is_prot_virt_host())
-		adjust_to_uv_max(&vmax);
+		adjust_to_uv_max(&MODULES_END);
 #ifdef CONFIG_KASAN
-	vmax = kasan_vmax;
+	vmax = _REGION1_SIZE;
+	MODULES_END = kasan_vmax;
 #endif
-	/* module area is at the end of the kernel address space. */
-	MODULES_END = vmax;
 	MODULES_VADDR = MODULES_END - MODULES_LEN;
 	VMALLOC_END = MODULES_VADDR;
 	VMALLOC_START = VMALLOC_END - vmalloc_size;
-- 
2.27.0
