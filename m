Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:43782 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZKHK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jun 2019 06:07:10 -0400
Date: Wed, 26 Jun 2019 13:06:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] s390/dasd: Fix a precision vs width bug in
 dasd_feature_list()
Message-ID: <20190626100658.GB3242@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org

The "len" variable is the length of the option up to the next option or
to the end of the string which ever first.  We want to print the invalid
option so we want precision "%.*s" but the format is width "%*s" so it
prints up to the end of the string.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

 drivers/s390/block/dasd_devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index fab35c6170cc..245f33c2f71e 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -203,7 +203,7 @@ static int __init dasd_feature_list(char *str)
 		else if (len == 8 && !strncmp(str, "failfast", 8))
 			features |= DASD_FEATURE_FAILFAST;
 		else {
-			pr_warn("%*s is not a supported device option\n",
+			pr_warn("%.*s is not a supported device option\n",
 				len, str);
 			rc = -EINVAL;
 		}
-- 
2.20.1
