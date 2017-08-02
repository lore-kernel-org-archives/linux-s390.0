Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] s390/cio: add const to bin_attribute structures
Date: Wed,  2 Aug 2017 21:37:23 +0530
Message-Id: <1501690043-7640-3-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
References: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: julia.lawall@lip6.fr, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Add const to bin_attribute structures as they are only passed to the
functions device_{remove/create}_bin_file. The corresponding arguments
are of type const, so declare the structures to be const.

Cross compiled for s390 architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/s390/cio/chp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 432fc40..f4166f8 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -143,7 +143,7 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
 				       sizeof(chp->cmg_chars));
 }
 
-static struct bin_attribute chp_measurement_chars_attr = {
+static const struct bin_attribute chp_measurement_chars_attr = {
 	.attr = {
 		.name = "measurement_chars",
 		.mode = S_IRUSR,
@@ -197,7 +197,7 @@ static ssize_t chp_measurement_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute chp_measurement_attr = {
+static const struct bin_attribute chp_measurement_attr = {
 	.attr = {
 		.name = "measurement",
 		.mode = S_IRUSR,
-- 
1.9.1
