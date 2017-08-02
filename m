Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] s390/sclp: add const to bin_attribute structure
Date: Wed,  2 Aug 2017 21:37:22 +0530
Message-Id: <1501690043-7640-2-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
References: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: julia.lawall@lip6.fr, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Declare bin_attribute structure as const as it is only passed as an
argument to the function sysfs_create_bin_file. This argument is of
type const, so declare the structure as const.

Cross compiled for s390 architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/s390/char/sclp_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 1406fb6..7003d52 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -135,7 +135,7 @@ static ssize_t sysfs_ofb_data_write(struct file *filp, struct kobject *kobj,
 	return rc ?: count;
 }
 
-static struct bin_attribute ofb_bin_attr = {
+static const struct bin_attribute ofb_bin_attr = {
 	.attr = {
 		.name = "event_data",
 		.mode = S_IWUSR,
-- 
1.9.1
