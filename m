Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/8] s390/qeth: clean up stale buffer state documentation
Date: Thu, 25 Apr 2019 18:25:56 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We don't keep track of Input Buffer states, so remove the comments that
make it sound like the qeth_qdio_buffer_states enum applies to
Input Buffers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 962e958c24f9..16c8049672b7 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -374,34 +374,6 @@ enum qeth_header_ids {
 #define QETH_HDR_EXT_CSUM_TRANSP_REQ  0x20
 #define QETH_HDR_EXT_UDP	      0x40 /*bit off for TCP*/
 
-enum qeth_qdio_buffer_states {
-	/*
-	 * inbound: read out by driver; owned by hardware in order to be filled
-	 * outbound: owned by driver in order to be filled
-	 */
-	QETH_QDIO_BUF_EMPTY,
-	/*
-	 * inbound: filled by hardware; owned by driver in order to be read out
-	 * outbound: filled by driver; owned by hardware in order to be sent
-	 */
-	QETH_QDIO_BUF_PRIMED,
-	/*
-	 * inbound: not applicable
-	 * outbound: identified to be pending in TPQ
-	 */
-	QETH_QDIO_BUF_PENDING,
-	/*
-	 * inbound: not applicable
-	 * outbound: found in completion queue
-	 */
-	QETH_QDIO_BUF_IN_CQ,
-	/*
-	 * inbound: not applicable
-	 * outbound: handled via transfer pending / completion queue
-	 */
-	QETH_QDIO_BUF_HANDLED_DELAYED,
-};
-
 enum qeth_qdio_info_states {
 	QETH_QDIO_UNINITIALIZED,
 	QETH_QDIO_ALLOCATED,
@@ -433,6 +405,19 @@ struct qeth_qdio_q {
 	int next_buf_to_init;
 };
 
+enum qeth_qdio_out_buffer_state {
+	/* Owned by driver, in order to be filled. */
+	QETH_QDIO_BUF_EMPTY,
+	/* Filled by driver; owned by hardware in order to be sent. */
+	QETH_QDIO_BUF_PRIMED,
+	/* Identified to be pending in TPQ. */
+	QETH_QDIO_BUF_PENDING,
+	/* Found in completion queue. */
+	QETH_QDIO_BUF_IN_CQ,
+	/* Handled via transfer pending / completion queue. */
+	QETH_QDIO_BUF_HANDLED_DELAYED,
+};
+
 struct qeth_qdio_out_buffer {
 	struct qdio_buffer *buffer;
 	atomic_t state;
-- 
2.16.4
