Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/8] s390: raw3270: constify attribute_group structures.
Date: Wed, 19 Jul 2017 12:39:15 +0530
Message-Id: <1500448157-24668-7-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1500448157-24668-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500448157-24668-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, freude@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, wi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, jwi@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   8069	    816	     16	   8901	   22c5	drivers/s390/char/raw3270.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   8133	    752	     16	   8901	   22c5	drivers/s390/char/raw3270.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/s390/char/raw3270.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 710f229..5d4f053 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1082,7 +1082,7 @@ struct raw3270_view *
 	NULL,
 };
 
-static struct attribute_group raw3270_attr_group = {
+static const struct attribute_group raw3270_attr_group = {
 	.attrs = raw3270_attrs,
 };
 
-- 
1.9.1
