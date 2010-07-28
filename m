Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 02/10] s390: sysinfo: check return value of create_proc_read_entry()
Date: Wed, 28 Jul 2010 20:39:07 +0400
Message-Id: <1280335147-23185-1-git-send-email-segooon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kernel-janitors@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Tejun Heo <tj@kernel.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

create_proc_read_entry() may fail, if so return -ENOMEM.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 arch/s390/kernel/sysinfo.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index a0ffc77..db358e6 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -231,9 +231,8 @@ static int proc_read_sysinfo(char *page, char **start,
 
 static __init int create_proc_sysinfo(void)
 {
-	create_proc_read_entry("sysinfo", 0444, NULL,
-			       proc_read_sysinfo, NULL);
-	return 0;
+	return create_proc_read_entry("sysinfo", 0444, NULL,
+			       proc_read_sysinfo, NULL) ? 0 : -ENOMEM;
 }
 device_initcall(create_proc_sysinfo);
 
-- 
1.7.0.4
