Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgAPRMr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:47 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 586/671] s390/qeth: Fix error handling during VNICC initialization
Date: Thu, 16 Jan 2020 12:03:44 -0500
Message-Id: <20200116170509.12787-323-sashal@kernel.org>
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit b528965bcc827dad32a8d21745feaacfc76c9703 ]

Smatch discovered the use of uninitialized variable sup_cmds
in error paths.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 95669d47c389..cf3b15ebcf75 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2331,10 +2331,10 @@ static bool qeth_l2_vnicc_recover_char(struct qeth_card *card, u32 vnicc,
 static void qeth_l2_vnicc_init(struct qeth_card *card)
 {
 	u32 *timeout = &card->options.vnicc.learning_timeout;
+	bool enable, error = false;
 	unsigned int chars_len, i;
 	unsigned long chars_tmp;
 	u32 sup_cmds, vnicc;
-	bool enable, error;
 
 	QETH_CARD_TEXT(card, 2, "vniccini");
 	/* reset rx_bcast */
@@ -2355,7 +2355,10 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 	chars_len = sizeof(card->options.vnicc.sup_chars) * BITS_PER_BYTE;
 	for_each_set_bit(i, &chars_tmp, chars_len) {
 		vnicc = BIT(i);
-		qeth_l2_vnicc_query_cmds(card, vnicc, &sup_cmds);
+		if (qeth_l2_vnicc_query_cmds(card, vnicc, &sup_cmds)) {
+			sup_cmds = 0;
+			error = true;
+		}
 		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
 		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
@@ -2364,8 +2367,8 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-	error = qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
-					      timeout);
+	error |= qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
+					       timeout);
 	chars_tmp = card->options.vnicc.wanted_chars ^ QETH_VNICC_DEFAULT;
 	chars_tmp |= QETH_VNICC_BRIDGE_INVISIBLE;
 	chars_len = sizeof(card->options.vnicc.wanted_chars) * BITS_PER_BYTE;
-- 
2.20.1
