Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgFQVYK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 17:24:10 -0400
Date: Wed, 17 Jun 2020 16:29:30 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] s390: appldata: Use struct_size() helper
Message-ID: <20200617212930.GA11728@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/s390/appldata/appldata_os.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 5503217366ec..a363d30ce739 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -129,8 +129,7 @@ static void appldata_get_os_data(void *data)
 
 	os_data->nr_cpus = j;
 
-	new_size = sizeof(struct appldata_os_data) +
-		   (os_data->nr_cpus * sizeof(struct appldata_os_per_cpu));
+	new_size = struct_size(os_data, os_cpu, os_data->nr_cpus);
 	if (ops.size != new_size) {
 		if (ops.active) {
 			rc = appldata_diag(APPLDATA_RECORD_OS_ID,
@@ -165,8 +164,7 @@ static int __init appldata_os_init(void)
 {
 	int rc, max_size;
 
-	max_size = sizeof(struct appldata_os_data) +
-		   (num_possible_cpus() * sizeof(struct appldata_os_per_cpu));
+	max_size = struct_size(appldata_os_data, os_cpu, num_possible_cpus());
 	if (max_size > APPLDATA_MAX_REC_SIZE) {
 		pr_err("Maximum OS record size %i exceeds the maximum "
 		       "record size %i\n", max_size, APPLDATA_MAX_REC_SIZE);
-- 
2.27.0
