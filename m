Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgAJWFd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 17:05:33 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 15/26] s390/qeth: fix initialization on old HW
Date: Fri, 10 Jan 2020 17:05:08 -0500
Message-Id: <20200110220519.28250-10-sashal@kernel.org>
In-Reply-To: <20200110220519.28250-1-sashal@kernel.org>
References: <20200110220519.28250-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 0b698c838e84149b690c7e979f78cccb6f8aa4b9 ]

I stumbled over an old OSA model that claims to support DIAG_ASSIST,
but then rejects the cmd to query its DIAG capabilities.

In the old code this was ok, as the returned raw error code was > 0.
Now that we translate the raw codes to errnos, the "rc < 0" causes us
to fail the initialization of the device.

The fix is trivial: don't bail out when the DIAG query fails. Such an
error is not critical, we can still use the device (with a slightly
reduced set of features).

Fixes: 742d4d40831d ("s390/qeth: convert remaining legacy cmd callbacks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7320a187d66a..b60e6b3046ef 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4963,10 +4963,8 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	}
 	if (qeth_adp_supported(card, IPA_SETADP_SET_DIAG_ASSIST)) {
 		rc = qeth_query_setdiagass(card);
-		if (rc < 0) {
+		if (rc)
 			QETH_CARD_TEXT_(card, 2, "8err%d", rc);
-			goto out;
-		}
 	}
 	return 0;
 out:
-- 
2.20.1
