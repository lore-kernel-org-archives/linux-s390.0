Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/8] s390: zcrypt_card: constify attribute_group structures.
Date: Wed, 19 Jul 2017 12:39:11 +0530
Message-Id: <1500448157-24668-3-git-send-email-arvind.yadav.cs@gmail.com>
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
   1019	    160	      0	   1179	    49b	drivers/s390/crypto/zcrypt_card.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1083	     96	      0	   1179	    49b	drivers/s390/crypto/zcrypt_card.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/s390/crypto/zcrypt_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index 53436ea..f85dacf 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -98,7 +98,7 @@ static DEVICE_ATTR(online, 0644, zcrypt_card_online_show,
 	NULL,
 };
 
-static struct attribute_group zcrypt_card_attr_group = {
+static const struct attribute_group zcrypt_card_attr_group = {
 	.attrs = zcrypt_card_attrs,
 };
 
-- 
1.9.1
