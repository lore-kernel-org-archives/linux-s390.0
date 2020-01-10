Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgAJWGD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 17:06:03 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 06/11] s390/qeth: Fix vnicc_is_in_use if rx_bcast not set
Date: Fri, 10 Jan 2020 17:05:50 -0500
Message-Id: <20200110220556.28505-5-sashal@kernel.org>
In-Reply-To: <20200110220556.28505-1-sashal@kernel.org>
References: <20200110220556.28505-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit e8a66d800471e2df7f0b484e2e46898b21d1fa82 ]

Symptom: After vnicc/rx_bcast has been manually set to 0,
	bridge_* sysfs parameters can still be set or written.
Only occurs on HiperSockets, as OSA doesn't support changing rx_bcast.

Vnic characteristics and bridgeport settings are mutually exclusive.
rx_bcast defaults to 1, so manually setting it to 0 should disable
bridge_* parameters.

Instead it makes sense here to check the supported mask. If the card
does not support vnicc at all, bridge commands are always allowed.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 66bc6f1ffd34..c238b190b3c9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2285,8 +2285,7 @@ int qeth_l2_vnicc_get_timeout(struct qeth_card *card, u32 *timeout)
 /* check if VNICC is currently enabled */
 bool qeth_l2_vnicc_is_in_use(struct qeth_card *card)
 {
-	/* if everything is turned off, VNICC is not active */
-	if (!card->options.vnicc.cur_chars)
+	if (!card->options.vnicc.sup_chars)
 		return false;
 	/* default values are only OK if rx_bcast was not enabled by user
 	 * or the card is offline.
-- 
2.20.1
