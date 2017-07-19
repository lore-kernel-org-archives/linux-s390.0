Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 7/8] s390: tape_core: constify attribute_group structures.
Date: Wed, 19 Jul 2017 12:39:16 +0530
Message-Id: <1500448157-24668-8-git-send-email-arvind.yadav.cs@gmail.com>
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
  11511	    656	     16	  12183	   2f97	drivers/s390/char/tape_core.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  11575	    592	     16	  12183	   2f97	drivers/s390/char/tape_core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/s390/char/tape_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 3c379da..9dd4534 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -175,7 +175,7 @@ static int devid_to_int(struct ccw_dev_id *dev_id)
 	NULL
 };
 
-static struct attribute_group tape_attr_group = {
+static const struct attribute_group tape_attr_group = {
 	.attrs = tape_attrs,
 };
 
-- 
1.9.1
