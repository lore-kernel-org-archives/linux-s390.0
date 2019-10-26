Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfJZNR1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Oct 2019 09:17:27 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 45/99] s390/qeth: Fix initialization of vnicc cmd masks during set online
Date: Sat, 26 Oct 2019 09:15:06 -0400
Message-Id: <20191026131600.2507-45-sashal@kernel.org>
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit be40a86c319706f90caca144343c64743c32b953 ]

Without this patch, a command bit in the supported commands mask is only
ever set to unsupported during set online. If a command is ever marked as
unsupported (e.g. because of error during qeth_l2_vnicc_query_cmds),
subsequent successful initialization (offline/online) would not bring it
back.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f011e2c43f00d..d5d0b2408a6b2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2063,11 +2063,15 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			sup_cmds = 0;
 			error = true;
 		}
-		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
-		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
+		if ((sup_cmds & IPA_VNICC_SET_TIMEOUT) &&
+		    (sup_cmds & IPA_VNICC_GET_TIMEOUT))
+			card->options.vnicc.getset_timeout_sup |= vnicc;
+		else
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
-		if (!(sup_cmds & IPA_VNICC_ENABLE) ||
-		    !(sup_cmds & IPA_VNICC_DISABLE))
+		if ((sup_cmds & IPA_VNICC_ENABLE) &&
+		    (sup_cmds & IPA_VNICC_DISABLE))
+			card->options.vnicc.set_char_sup |= vnicc;
+		else
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-- 
2.20.1
