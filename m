Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] char: add WARN_ON() in misc_deregister()
Date: Sat, 29 May 2010 13:28:50 +0900
Message-Id: <1275107331-5045-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux390@de.ibm.com, linux-s390@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

misc_deregister() returns an error only when it attempts to unregister
the device that is not registered. This is the driver's bug.

Most of the drivers don't check the return value of misc_deregister().
(It is not bad thing because most of kernel *_unregister() API always
succeed and do not return value)

So it is better to indicate the error by WARN_ON() in misc_deregister().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/char/misc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cd650ca..abdafd4 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -242,7 +242,7 @@ int misc_deregister(struct miscdevice *misc)
 {
 	int i = DYNAMIC_MINORS - misc->minor - 1;
 
-	if (list_empty(&misc->list))
+	if (WARN_ON(list_empty(&misc->list)))
 		return -EINVAL;
 
 	mutex_lock(&misc_mtx);
-- 
1.6.0.6
