From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 8/8] s390/lcs: Fix null-pointer access in msg
Date: Mon, 18 May 2015 14:27:59 +0200
Message-ID: <1431952079-6847-9-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1431952079-6847-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1431952079-6847-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com> 

An attempt to configure a CTC device as LCS results in the
following error message:

  (null): Detecting a network adapter for LCS devices failed
          with rc=-5 (0xfffffffb)

"(null)" results from access to &card->dev->dev in lcs_new_device()
which is only initialized later in the function. Fix this by using
&ccwgdev->dev instead which is initialized before lcs_new_device()
is called.

Signed-off-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/lcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 00b7d9c..2f5b518 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -2150,7 +2150,7 @@ lcs_new_device(struct ccwgroup_device *ccwgdev)
 	rc = lcs_detect(card);
 	if (rc) {
 		LCS_DBF_TEXT(2, setup, "dtctfail");
-		dev_err(&card->dev->dev,
+		dev_err(&ccwgdev->dev,
 			"Detecting a network adapter for LCS devices"
 			" failed with rc=%d (0x%x)\n", rc, rc);
 		lcs_stopcard(card);
-- 
2.3.7
