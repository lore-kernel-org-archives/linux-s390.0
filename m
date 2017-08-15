Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 01/13] s390: ccwdev: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:32 +0530
Message-Id: <1502793344-5368-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, maier@linux.vnet.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ccw_device_id are not supposed to change at runtime. AlL functions
working with ccw_device_id provided by <asm/ccwdev.h> work with
const ccw_device_id. So mark ccw_device_id as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/s390/include/asm/ccwdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index b80e456..d5c7af2 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -132,7 +132,7 @@ enum uc_todo {
  * @int_class: interruption class to use for accounting interrupts
  */
 struct ccw_driver {
-	struct ccw_device_id *ids;
+	const struct ccw_device_id *ids;
 	int (*probe) (struct ccw_device *);
 	void (*remove) (struct ccw_device *);
 	int (*set_online) (struct ccw_device *);
-- 
2.7.4
