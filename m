Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH 11/12] s390/net/qeth_l2_main: check given MAC address, if invalid return -EADDRNOTAVAIL
Date: Fri, 24 Feb 2012 17:01:21 +0100
Message-Id: <1330099282-4588-12-git-send-email-danny.kukawka@bisect.de>
In-Reply-To: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
References: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ursula.braun@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Danny Kukawka <dkukawka@suse.de>, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Check if given address is valid in .ndo_set_mac_address/
qeth_l2_set_mac_address(), if invalid return -EADDRNOTAVAIL as
eth_mac_addr() already does if is_valid_ether_addr() fails.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/s390/net/qeth_l2_main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index e5c9cf1..d10b3a4 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -661,6 +661,9 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 	struct qeth_card *card = dev->ml_priv;
 	int rc = 0;
 
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
 	QETH_CARD_TEXT(card, 3, "setmac");
 
 	if (qeth_l2_verify_dev(dev) != QETH_REAL_CARD) {
-- 
1.7.8.3
