Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Levente Kurusa <levex@linux.com>
Subject: [PATCH 13/38] arm: s390: add missing put_device call
Date: Thu, 19 Dec 2013 16:03:24 +0100
Message-Id: <1387465429-3568-14-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/s390/kernel/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 064c308..16c717f 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -1351,8 +1351,10 @@ static int __init etr_register_port(struct device *dev)
 	int rc;
 
 	rc = device_register(dev);
-	if (rc)
+	if (rc) {
+		put_device(dev);
 		goto out;
+	}
 	for (attr = etr_port_attributes; *attr; attr++) {
 		rc = device_create_file(dev, *attr);
 		if (rc)
-- 
1.8.3.1
