Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] s390: numa: Export __node_distance
Date: Sun,  4 Nov 2018 13:28:06 -0800
Message-Id: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

__node_distance is used by nvme, resulting in:

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!

when trying to build nvme as module.

Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I thought I had seen that patch already, but I don't find it anywhere.
Maybe that was for another architecture. My apologies for the noise if it
is already queued.

 arch/s390/numa/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index ae0d9e889534..d31bde0870d8 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -53,6 +53,7 @@ int __node_distance(int a, int b)
 {
 	return mode->distance ? mode->distance(a, b) : 0;
 }
+EXPORT_SYMBOL(__node_distance);
 
 int numa_debug_enabled;
 
-- 
2.7.4
