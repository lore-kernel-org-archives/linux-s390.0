Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/11] s390/qeth: add phys_to_virt() translation for AOB
Date: Wed, 18 Mar 2020 13:54:53 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-10-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Data addresses in the AOB are absolute, and need to be translated before
being fed into kmem_cache_free(). Currently this phys_to_virt() is a no-op.
Also see commit 2db01da8d25f ("s390/qdio: fill SBALEs with absolute addresses").

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 33796fe80a63..3f0b13ff580e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -538,9 +538,10 @@ static void qeth_qdio_handle_aob(struct qeth_card *card,
 	for (i = 0;
 	     i < aob->sb_count && i < QETH_MAX_BUFFER_ELEMENTS(card);
 	     i++) {
-		if (aob->sba[i] && buffer->is_header[i])
-			kmem_cache_free(qeth_core_header_cache,
-					(void *) aob->sba[i]);
+		void *data = phys_to_virt(aob->sba[i]);
+
+		if (data && buffer->is_header[i])
+			kmem_cache_free(qeth_core_header_cache, data);
 	}
 	atomic_set(&buffer->state, QETH_QDIO_BUF_HANDLED_DELAYED);
 
-- 
2.17.1
