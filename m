Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/8] s390: device: constify attribute_group structures.
Date: Wed, 19 Jul 2017 12:39:13 +0530
Message-Id: <1500448157-24668-5-git-send-email-arvind.yadav.cs@gmail.com>
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

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/s390/cio/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 7be01a5..489b583 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -612,7 +612,7 @@ static ssize_t vpm_show(struct device *dev, struct device_attribute *attr,
 	NULL,
 };
 
-static struct attribute_group io_subchannel_attr_group = {
+static const struct attribute_group io_subchannel_attr_group = {
 	.attrs = io_subchannel_attrs,
 };
 
@@ -626,7 +626,7 @@ static ssize_t vpm_show(struct device *dev, struct device_attribute *attr,
 	NULL,
 };
 
-static struct attribute_group ccwdev_attr_group = {
+static const struct attribute_group ccwdev_attr_group = {
 	.attrs = ccwdev_attrs,
 };
 
-- 
1.9.1
