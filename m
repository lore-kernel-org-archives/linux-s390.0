Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 1/2] s390: vmlogrdr: Use ARRAY_SIZE instead of reimplementing its function
Date: Sat, 8 Sep 2018 18:26:27 +0800
Message-ID: <1536402388-23872-2-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jwi@linux.ibm.com, ubraun@linux.ibm.com, jdelvare@suse.de
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ARRAY_SIZE has implemented its function. we prefer to use the function
rather than the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/char/vmlogrdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 069b9ef..58333cb 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -153,7 +153,7 @@ static void vmlogrdr_iucv_message_pending(struct iucv_path *,
 	}
 };
 
-#define MAXMINOR  (sizeof(sys_ser)/sizeof(struct vmlogrdr_priv_t))
+#define MAXMINOR  ARRAY_SIZE(sys_ser)
 
 static char FENCE[] = {"EOR"};
 static int vmlogrdr_major = 0;
-- 
1.7.12.4
