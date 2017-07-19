Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/8] s390: qeth: constify attribute_group structures.
Date: Wed, 19 Jul 2017 12:39:14 +0530
Message-Id: <1500448157-24668-6-git-send-email-arvind.yadav.cs@gmail.com>
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
   6763	   1216	      0	   7979	   1f2b	drivers/s390/net/qeth_l3_sys.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   7019	    960	      0	   7971	   1f2b	drivers/s390/net/qeth_l3_sys.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/s390/net/qeth_l3_sys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index f2f94f5..1a80ce4 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -350,7 +350,7 @@ static DEVICE_ATTR(hsuid, 0644, qeth_l3_dev_hsuid_show,
 	NULL,
 };
 
-static struct attribute_group qeth_l3_device_attr_group = {
+static const struct attribute_group qeth_l3_device_attr_group = {
 	.attrs = qeth_l3_device_attrs,
 };
 
@@ -680,7 +680,7 @@ static QETH_DEVICE_ATTR(ipato_del6, del6, 0200, NULL,
 	NULL,
 };
 
-static struct attribute_group qeth_device_ipato_group = {
+static const struct attribute_group qeth_device_ipato_group = {
 	.name = "ipa_takeover",
 	.attrs = qeth_ipato_device_attrs,
 };
@@ -843,7 +843,7 @@ static QETH_DEVICE_ATTR(vipa_del6, del6, 0200, NULL,
 	NULL,
 };
 
-static struct attribute_group qeth_device_vipa_group = {
+static const struct attribute_group qeth_device_vipa_group = {
 	.name = "vipa",
 	.attrs = qeth_vipa_device_attrs,
 };
@@ -1006,7 +1006,7 @@ static QETH_DEVICE_ATTR(rxip_del6, del6, 0200, NULL,
 	NULL,
 };
 
-static struct attribute_group qeth_device_rxip_group = {
+static const struct attribute_group qeth_device_rxip_group = {
 	.name = "rxip",
 	.attrs = qeth_rxip_device_attrs,
 };
-- 
1.9.1
