Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390: cleanup with list_first_entry_or_null()
Date: Tue, 13 Sep 2016 03:10:39 +0900
Message-Id: <1473703839-1185-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The combo of list_empty() check and return list_first_entry()
can be replaced with list_first_entry_or_null().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/kernel/crash_dump.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 29df848..621907d 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -71,9 +71,8 @@ struct save_area * __init save_area_alloc(bool is_boot_cpu)
  */
 struct save_area * __init save_area_boot_cpu(void)
 {
-	if (list_empty(&dump_save_areas))
-		return NULL;
-	return list_first_entry(&dump_save_areas, struct save_area, list);
+	return list_first_entry_or_null(&dump_save_areas, struct save_area,
+					list);
 }
 
 /*
-- 
1.9.1
