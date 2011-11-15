From: frank.blaschka@de.ibm.com
Subject: [patch 1/5] [PATCH] qeth: return with -EPERM if sniffing is not enabled
Date: Tue, 15 Nov 2011 13:31:12 +0100
Message-ID: <20111115123152.253948315@de.ibm.com>
References: <20111115123111.128739986@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=619-qeth-eperm-hs.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Without appropriate configuration at the SE, a HiperSockets device
cannot be used for sniffing. Setting the sniffer attribute is rejected
with -EPERM.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

 drivers/s390/net/qeth_l3_sys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/qeth_l3_sys.c linux-2.6-patched/drivers/s390/net/qeth_l3_sys.c
--- linux-2.6/drivers/s390/net/qeth_l3_sys.c	2011-11-14 18:26:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_l3_sys.c	2011-11-14 18:27:16.000000000 +0100
@@ -335,10 +335,10 @@ static ssize_t qeth_l3_dev_sniffer_store
 					QETH_IN_BUF_COUNT_MAX)
 				qeth_realloc_buffer_pool(card,
 					QETH_IN_BUF_COUNT_MAX);
-			break;
 		} else
 			rc = -EPERM;
-	default:   /* fall through */
+		break;
+	default:
 		rc = -EINVAL;
 	}
 out:
