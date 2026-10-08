Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44F3BA22C
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446914; cv=none; b=NEsRduj0VAq7+O/6uvAyIAQrDNgmypd6dWt2GtPpURGJPAsAPbEdq8vS0UxDercuOhii+1Znb4j6orsZ4dSBdwF1ep5JAgyqLn3bcGyC78hu2H0etAW1lmnMV+6ClNZ+LCs8XFdCMTky8V1xJZT4RCVdVNfN5YhD+NyiYqNQ30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446914; c=relaxed/simple;
	bh=gOllxtPIx20L2QNnP0ecQtVuEvJQarMovDi7pZvRKFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUmDHJMa9a7V2RDqvAuNst7FROcXDvCzZ4waxUA6czlMQ+8OzL4eXgP7oIzdrMQqY88z+YZ3tBYVolxMR5S889z1VlLO+xvOJ51bae9bon8TxA718ddtLegSSRrudhJhgTWIEdiuopzU3QPzdTb/cv8CNs+LP7kMUEAjdYwygkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UtxE87pN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UtxE87pN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZW1d3705377
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=THcNlm
	+UpSDMMlpO3Cy+KS7zBzJuoaHEVBpAM75Uu8M=; b=UtxE87pNGJlVRLiQj2ALSz
	oyK/4RLrbhActfVXwkodMYIHTCyRz+BI3TAt9YaChwW81pXxinmwKit3T+kY0BS2
	PM0rfE/zccx2pDtt4tq9CNuJGVKc2oKKtH2Nd4B2+auDOlAM5eHusD8LA8YSSIwv
	0wIm8C/svfU0/caNBezeWl0G8atb6jHp4/eni1/h4cN3G2tymkDxx0wGlpCj/DWz
	ih91gnsJrFs54MVG0Szv6kVXUsEfL/+CRZ24b6bNzJcHUsSf2HhxmRN1fenfL5U9
	SP2fI04t0qw0Hm9xpG3QC208HGd5L+Kn+/1LU10W90205LMdIhWOP0rwh/3Y2hyA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1a3k5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IUin1873262
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tw997-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69888MxT34669000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:08:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D105320043;
	Thu,  8 Oct 2026 08:08:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64FD92004D;
	Thu,  8 Oct 2026 08:08:22 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:08:22 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:08:03 +0200
Subject: [PATCH 1/4] dibs: introduce ring-buffer send/receive API
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac74f7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Fouuoq3SSqER9ciVO9QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfXwC/9I2IZzUFf
 2AVFhmqmnEVYatlOxR2Xz9Cd27acsjwWIA4nzpvZVeiZShiy0KhDQzaCu73MYTtVEgF6LUVO83D
 hnrx6APDizlr5wg3gyFqNm4Yc9jVdBf2frXJdIld+KbLxkr1T0Jc555xheN6rPkIw6+FeE6lDez
 lsMnzIVoxGw/8ublIERs0p4mWDB3KIF4c1/dPSFPUv46a8ArCP/q05zHB5ft5866uZMXZMxd3wz
 TW1CeY4rkhfwGFKTxmBe7wFpz0yHLHZQvPKAHxpDf46FFk37UV7DG6zZLDQKR+4VWSXNdoUVORm
 fl4U/Nk3MofPUkf9Hul/BgpoMbVTb5RbvfTQMW11/N6W5kr/AWU9chEQtVoN0P/ZzICs/637+nC
 lhBgbIcg+zfbkbzwTn2VM8Pabcu/5Zqxgtq3ujA9XVvzPg2Jeabc0QeLcBvX4BLZQEm/iux6QFg
 lCqn8+g1B2ZuF4RjfYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX57rcwoigUjmw
 69aHJKoZPFcIvfHOcXvOyYYLdWf6BJPz7CVH3pxPWLFKEldFcYuSAYlQ59XHWKFuErmSg93XtIw
 QALmSgXIhnCyyX6jANqyJ+FwZmOeizQ=
X-Proofpoint-GUID: GKbe59PCqa1U_UdyL49KY3zbrerfYlI_
X-Proofpoint-ORIG-GUID: GKbe59PCqa1U_UdyL49KY3zbrerfYlI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

From: Tobias Schumacher <ts@linux.ibm.com>

Introduce a centralized API for sending and receiving data between dibs
peers via ring buffers. With this API, drivers no longer need to
interact directly with DMBs and manage read/write pointers.

A driver must first register its ring buffer using
dibs_register_ring_buffer() and set the rdmb_tok via
dibs_ring_set_rdmb_tok(). After that, data can be sent using
dibs_ring_send().

Receiving messages is split into two steps: dibs_ring_recv() returns a
pointer to the next DIBS message if one is available. After the message
is processed, dibs_ring_ack() must be called to free up the message
buffers and to advance the read pointer. If no message is available,
dibs_ring_recv() returns NULL.

Co-developed-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 493 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/dibs.h     |  99 ++++++++++
 2 files changed, 590 insertions(+), 2 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 20c50997a7cf..e3a33bc42fe8 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -13,6 +13,9 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/dibs.h>
+#include <linux/circ_buf.h>
+#include <linux/log2.h>
+#include <asm/barrier.h>
 
 #include "dibs_loopback.h"
 
@@ -20,7 +23,7 @@ MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
 MODULE_LICENSE("GPL");
 
 static const struct class dibs_class = {
-	.name		= "dibs",
+	.name = "dibs",
 };
 
 /* use an array rather a list for fast mapping: */
@@ -93,7 +96,8 @@ int dibs_unregister_client(struct dibs_client *client)
 		max_dmbs = dibs->ops->max_dmbs();
 		for (int i = 0; i < max_dmbs; ++i) {
 			if (dibs->dmb_clientid_arr[i] == client->id) {
-				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
+				WARN(1,
+				     "%s: attempt to unregister '%s' with registered dmb(s)\n",
 				     __func__, client->name);
 				rc = -EBUSY;
 				goto err_reg_dmb;
@@ -245,6 +249,491 @@ void dibs_dev_del(struct dibs_dev *dibs)
 }
 EXPORT_SYMBOL_GPL(dibs_dev_del);
 
+/**
+ * dibs_ring_peer_meta() - take a snapshot of the peer's ring metadata
+ * @rb: pointer to the ring buffer
+ * @peer: snapshot to fill in
+ *
+ * The peer writes its metadata dmb at any time, so read each field once and
+ * copy to the snapshot.
+ */
+static void dibs_ring_peer_meta(struct dibs_ring_buffer *rb,
+				struct dibs_ring_meta *peer)
+{
+	peer->meta_dmb_tok = READ_ONCE(rb->rd_ring_meta->meta_dmb_tok);
+	peer->buff_dmb_tok = READ_ONCE(rb->rd_ring_meta->buff_dmb_tok);
+	peer->size = READ_ONCE(rb->rd_ring_meta->size);
+	peer->head = READ_ONCE(rb->rd_ring_meta->head);
+	peer->tail = READ_ONCE(rb->rd_ring_meta->tail);
+	peer->reserved = 0;
+}
+
+static int dibs_ring_send_hdr(struct dibs_ring_buffer *rb, u64 meta_dmb_tok)
+{
+	int res;
+
+	if (!meta_dmb_tok)
+		return 0;
+
+	res = rb->dibs->ops->move_data(rb->dibs, meta_dmb_tok, 0, true, 0,
+				       &rb->wr_ring_meta,
+				       sizeof(struct dibs_ring_meta));
+
+	if (!res)
+		rb->hdr_sent = true;
+
+	return res;
+}
+
+/**
+ * dibs_ring_register() - register a DIBS ring buffer
+ * @name: name of the ring buffer. This will be used in debug output to
+ *        support identifying the ring buffer.
+ * @rb: pointer to the ring buffer struct. The fields in the struct don't have
+ *      to be initialized.
+ * @client: pointer to the DIBS client
+ * @dibs: pointer to the DIBS device
+ * @rgid: the remote GID that will be allowed to write into this ring buffer
+ * @size: size of the ring buffer in bytes
+ *
+ * Register and initialize a DIBS ring buffer. Allocates the metadata DMB and
+ * the payload DMB, initializes the fields in dibs_ring_buffer.
+ *
+ * Return: 0 in case of success, an error code in case of failure
+ */
+int dibs_ring_register(char *name, struct dibs_ring_buffer *rb,
+		       struct dibs_client *client, struct dibs_dev *dibs,
+		       uuid_t rgid, u32 size)
+{
+	int ret;
+
+	if (!size || !is_power_of_2(size))
+		return -EINVAL;
+
+	strscpy(rb->name, name, sizeof(rb->name));
+	rb->dibs = dibs;
+	rb->dmb.rgid = rgid;
+
+	rb->rd_meta_dmb.dmb_len = ALIGN(sizeof(struct dibs_ring_meta), 4096);
+	rb->rd_meta_dmb.rgid = rgid;
+	ret = dibs->ops->register_dmb(dibs, &rb->rd_meta_dmb, client);
+	if (ret)
+		return ret;
+
+	rb->dmb.dmb_len = ALIGN(size, 4096);
+	ret = dibs->ops->register_dmb(dibs, &rb->dmb, client);
+	if (ret) {
+		dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);
+		return ret;
+	}
+
+	rb->dmb_registered = 1;
+
+	rb->wr_ring_meta.meta_dmb_tok = rb->rd_meta_dmb.dmb_tok;
+	rb->wr_ring_meta.buff_dmb_tok = rb->dmb.dmb_tok;
+	rb->wr_ring_meta.size = size;
+	rb->wr_ring_meta.head = 0;
+	rb->wr_ring_meta.tail = 0;
+	rb->wr_ring_meta.reserved = 0;
+
+	rb->rd_ring_meta = rb->rd_meta_dmb.cpu_addr;
+	rb->peer_buff_dmb_tok = 0;
+	rb->msg_size = 0;
+	rb->hdr_sent = false;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dibs_ring_register);
+
+/**
+ * dibs_ring_unregister() - unregister a DIBS ring buffer
+ * @rb: pointer to the ring buffer to unregister
+ *
+ * Free the resources allocated by dibs_ring_register().
+ *
+ * Return: 0 in case of success, an error code in case of failure
+ */
+int dibs_ring_unregister(struct dibs_ring_buffer *rb)
+{
+	struct dibs_ring_meta peer;
+	int ret;
+
+	rb->wr_ring_meta.meta_dmb_tok = 0;
+	rb->wr_ring_meta.buff_dmb_tok = 0;
+	rb->wr_ring_meta.size = 0;
+	rb->wr_ring_meta.head = 0;
+	rb->wr_ring_meta.tail = 0;
+
+	dibs_ring_peer_meta(rb, &peer);
+	if (peer.meta_dmb_tok) {
+		ret = dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
+		if (ret)
+			pr_warn("%s: failed to send header update: %d\n",
+				__func__, ret);
+	}
+
+	ret = rb->dibs->ops->unregister_dmb(rb->dibs, &rb->dmb);
+	if (ret)
+		pr_warn("%s: failed to unregister payload dmb: %d\n", __func__,
+			ret);
+
+	ret = rb->dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);
+	if (ret)
+		pr_warn("%s: failed to unregister metadata dmb: %d\n", __func__,
+			ret);
+
+	rb->dmb_registered = 0;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dibs_ring_unregister);
+
+/**
+ * dibs_ring_peer_replaced() - check if the peer has replaced its ring buffer
+ * @rb: pointer to the ring buffer
+ * @peer: snapshot of the peer's metadata
+ *
+ * The fabric hands out a new dmb token for every registration, so a buffer
+ * token that differs from the one this side is synchronized to means the peer
+ * ring this side writes into is a different one.
+ *
+ * Return: true if the peer ring has been replaced, false otherwise
+ */
+static bool dibs_ring_peer_replaced(struct dibs_ring_buffer *rb,
+				    const struct dibs_ring_meta *peer)
+{
+	return peer->buff_dmb_tok != rb->peer_buff_dmb_tok;
+}
+
+/**
+ * dibs_ring_sync_peer() - synchronize with a replaced peer ring buffer
+ * @rb: pointer to the ring buffer
+ * @peer: snapshot of the peer's metadata
+ *
+ * Restart both pointers: head is this side's write position in the peer's
+ * buffer, which is a new and empty one, and tail is this side's read position
+ * in its own buffer, which the peer has started to write at offset 0 again.
+ * Sends the updated metadata header to the peer and only then remembers the
+ * new token, so that a failed send is retried on the next call.
+ *
+ * A peer that has torn its ring down is not synchronized to, it is only
+ * forgotten - this side cannot send anything until the peer registers again.
+ */
+static void dibs_ring_sync_peer(struct dibs_ring_buffer *rb,
+				const struct dibs_ring_meta *peer)
+{
+	if (!peer->buff_dmb_tok) {
+		rb->wr_ring_meta.tail = 0;
+		rb->peer_buff_dmb_tok = 0;
+		rb->hdr_sent = false;
+		return;
+	}
+
+	rb->wr_ring_meta.head = 0;
+	rb->wr_ring_meta.tail = 0;
+
+	if (dibs_ring_send_hdr(rb, peer->meta_dmb_tok)) {
+		pr_warn("%s(%s): failed to send header after peer restart\n",
+			__func__, rb->name);
+		return;
+	}
+
+	rb->peer_buff_dmb_tok = peer->buff_dmb_tok;
+}
+
+/**
+ * dibs_ring_peer_ready() - check if the peer ring can be written to
+ * @peer: snapshot of the peer's metadata
+ *
+ * All of the peer's metadata is remote controlled. Its size is used as a mask
+ * for the head pointer and by the CIRC_* helpers, both of which require a
+ * power of two, so validate it before anything is derived from it.
+ *
+ * Return: true if the peer ring can be used, false otherwise
+ */
+static bool dibs_ring_peer_ready(const struct dibs_ring_meta *peer)
+{
+	if (!peer->meta_dmb_tok || !peer->buff_dmb_tok)
+		return false;
+
+	return is_power_of_2(peer->size);
+}
+
+static size_t __dibs_ring_space(struct dibs_ring_buffer *rb,
+				const struct dibs_ring_meta *peer)
+{
+	if (!dibs_ring_peer_ready(peer))
+		return 0;
+
+	return CIRC_SPACE(rb->wr_ring_meta.head, peer->tail, peer->size);
+}
+
+static size_t __dibs_ring_space_to_end(struct dibs_ring_buffer *rb,
+				       const struct dibs_ring_meta *peer)
+{
+	if (!dibs_ring_peer_ready(peer))
+		return 0;
+
+	return CIRC_SPACE_TO_END(rb->wr_ring_meta.head, peer->tail, peer->size);
+}
+
+static u32 __dibs_ring_cnt(struct dibs_ring_buffer *rb,
+			   const struct dibs_ring_meta *peer)
+{
+	return CIRC_CNT(peer->head, rb->wr_ring_meta.tail,
+			rb->wr_ring_meta.size);
+}
+
+static u32 __dibs_ring_cnt_to_end(struct dibs_ring_buffer *rb,
+				  const struct dibs_ring_meta *peer)
+{
+	return CIRC_CNT_TO_END(peer->head, rb->wr_ring_meta.tail,
+			       rb->wr_ring_meta.size);
+}
+
+/**
+ * dibs_ring_space() - query the ring buffer's free space for sending
+ * @rb: pointer to the ring buffer
+ *
+ * Get the free space in the ring buffer that can be used for sending data.
+ * Automatically resynchronizes if the peer has replaced its ring.
+ *
+ * Return: the free space in the ring buffer
+ */
+size_t dibs_ring_space(struct dibs_ring_buffer *rb)
+{
+	struct dibs_ring_meta peer;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	if (dibs_ring_peer_replaced(rb, &peer))
+		dibs_ring_sync_peer(rb, &peer);
+
+	return __dibs_ring_space(rb, &peer);
+}
+
+/**
+ * dibs_ring_space_to_end() - query the rb's space until the end of the DMB
+ * @rb: pointer to the ring buffer
+ *
+ * Get the free space in the ring buffer until the end of the underlying DMB.
+ * This is the amount of data that can be written without wrapping to the
+ * beginning of the DMB.
+ *
+ * Return: the free space in the ring buffer until the end of the DMB.
+ */
+size_t dibs_ring_space_to_end(struct dibs_ring_buffer *rb)
+{
+	struct dibs_ring_meta peer;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	return __dibs_ring_space_to_end(rb, &peer);
+}
+
+/**
+ * dibs_ring_cnt() - query the ring buffer's fill state
+ * @rb: pointer to the ring buffer
+ *
+ * Get the number of bytes available in the ring buffer for reading.
+ * Automatically resynchronizes if the peer has replaced its ring.
+ *
+ * Return: fill state of the ring buffer
+ */
+u32 dibs_ring_cnt(struct dibs_ring_buffer *rb)
+{
+	struct dibs_ring_meta peer;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	if (dibs_ring_peer_replaced(rb, &peer))
+		dibs_ring_sync_peer(rb, &peer);
+
+	return __dibs_ring_cnt(rb, &peer);
+}
+
+/**
+ * dibs_ring_cnt_to_end() - query the number of bytes in rb before wrap
+ * @rb: pointer to the ring buffer
+ *
+ * Get the number of bytes that can be read from the ring buffer without
+ * wrapping the tail pointer.
+ *
+ * Return: number of consecutive readable bytes
+ */
+u32 dibs_ring_cnt_to_end(struct dibs_ring_buffer *rb)
+{
+	struct dibs_ring_meta peer;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	return __dibs_ring_cnt_to_end(rb, &peer);
+}
+
+/**
+ * dibs_ring_set_rdmb_tok() - complete ring buffer token exchange
+ * @rb: pointer to the ring buffer
+ * @rdmb_tok: remote peer's metadata DMB token
+ *
+ * Completes the ring buffer setup by storing the remote peer's metadata DMB
+ * token and sending our local metadata to the peer. Normally, DMB tokens are
+ * read from rd_meta_dmb, but this creates a circular dependency during initial
+ * setup (need the token to read the metadata that contains the token). To break
+ * this, one peer must receive the remote token through an alternative channel
+ * and call this function to send its own header as the initial handshake step.
+ * After this, both peers can read each other's metadata.
+ */
+void dibs_ring_set_rdmb_tok(struct dibs_ring_buffer *rb, u64 rdmb_tok)
+{
+	WRITE_ONCE(rb->rd_ring_meta->meta_dmb_tok, rdmb_tok);
+	dibs_ring_send_hdr(rb, rdmb_tok);
+}
+EXPORT_SYMBOL_GPL(dibs_ring_set_rdmb_tok);
+
+/**
+ * dibs_ring_send() - Send DIBS message to peer
+ * @rb: Ring buffer to send message to
+ * @msg: Message to send
+ * @size: size of the message to be sent
+ * @notify: if true, update the remote's ring header and generate an IRQ after
+ *          sending.
+ *
+ * Send a DIBS message to the peer device using the specified ring buffer.
+ *
+ * Return: zero in case of success, an error code in case of failure
+ */
+int dibs_ring_send(struct dibs_ring_buffer *rb, void *msg, u16 size,
+		   bool notify)
+{
+	struct dibs_ring_meta peer;
+	u32 old_head;
+	int ret;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	if (!dibs_ring_peer_ready(&peer))
+		return -EAGAIN;
+
+	if (__dibs_ring_space_to_end(rb, &peer) < size)
+		return -ENOSPC;
+
+	ret = rb->dibs->ops->move_data(rb->dibs, peer.buff_dmb_tok, 0, false,
+				       rb->wr_ring_meta.head, msg, size);
+	if (ret)
+		return ret;
+
+	old_head = rb->wr_ring_meta.head;
+	rb->wr_ring_meta.head = (old_head + size) & (peer.size - 1);
+
+	if (notify) {
+		ret = dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
+		if (ret) {
+			rb->wr_ring_meta.head = old_head;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dibs_ring_send);
+
+/**
+ * dibs_ring_send_padding() - send padding data to ring buffer
+ * @rb: pointer to the ring buffer
+ * @size: number of bytes to send
+ *
+ * Advance the ring buffer's head pointer by size byte without actually
+ * writing any data into the data buffer. This can be used by higher level
+ * APIs to send padding data which shall be ignored by the receiving peer.
+ *
+ * Return: zero in case of success, an error code in case of failure
+ */
+int dibs_ring_send_padding(struct dibs_ring_buffer *rb, u16 size)
+{
+	struct dibs_ring_meta peer;
+	u32 old_head;
+	int ret;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	if (!dibs_ring_peer_ready(&peer))
+		return -EAGAIN;
+
+	if (__dibs_ring_space(rb, &peer) < size)
+		return -ENOSPC;
+
+	old_head = rb->wr_ring_meta.head;
+	rb->wr_ring_meta.head = (old_head + size) & (peer.size - 1);
+
+	ret = dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
+	if (ret) {
+		rb->wr_ring_meta.head = old_head;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dibs_ring_send_padding);
+
+/**
+ * dibs_ring_recv() - Receive message from DIBS ring buffer
+ * @rb: Ring buffer to get message from
+ *
+ * Get the next message from the ring buffer. After processing, the caller must
+ * call dibs_ring_ack() to update the ring buffer.
+ *
+ * Return: pointer to the DIBS message or NULL if the ring buffer is empty
+ */
+void *dibs_ring_recv(struct dibs_ring_buffer *rb)
+{
+	struct dibs_ring_meta peer;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	if (unlikely(!rb->hdr_sent))
+		dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
+
+	if (dibs_ring_peer_replaced(rb, &peer))
+		dibs_ring_sync_peer(rb, &peer);
+
+	if (!__dibs_ring_cnt(rb, &peer))
+		return NULL;
+
+	/* pairs with the peer filling the payload before publishing head */
+	dma_rmb();
+
+	return rb->dmb.cpu_addr + rb->wr_ring_meta.tail;
+}
+EXPORT_SYMBOL_GPL(dibs_ring_recv);
+
+/**
+ * dibs_ring_ack() - Acknowledge received message
+ * @rb: Ring buffer to operate on
+ *
+ * Acknowledges the message received by dibs_ring_recv(). This means, the read
+ * pointer in the ring buffer header is incremented and the updated header is
+ * sent to the remote side. After calling dibs_ring_ack(), the message structure
+ * returned by dibs_ring_recv() may be reused, so the driver must not use it
+ * anymore.
+ */
+int dibs_ring_ack(struct dibs_ring_buffer *rb, size_t size)
+{
+	struct dibs_ring_meta peer;
+
+	dibs_ring_peer_meta(rb, &peer);
+
+	if (size > __dibs_ring_cnt(rb, &peer)) {
+		pr_warn("%s(%s, %lx): error: tail would overtake head\n",
+			__func__, rb->name, size);
+		return -EINVAL;
+	}
+
+	rb->wr_ring_meta.tail = (rb->wr_ring_meta.tail + size) &
+				(rb->wr_ring_meta.size - 1);
+
+	return dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
+}
+EXPORT_SYMBOL_GPL(dibs_ring_ack);
+
 static int __init dibs_init(void)
 {
 	int rc;
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 0c10c224bcca..30ae03484b58 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -67,6 +67,83 @@ struct dibs_dmb {
 	dma_addr_t dma_addr;
 };
 
+/* Ring Buffer Communication
+ * -------------------------
+ * Based on the DMBs, DIBS provides a ring buffer mechanism for bi-directional
+ * communication between two peers. For each ring-buffer connection, two DMBs
+ * are allocated per peer:
+ * - one DMB holding metadata about the ring and
+ * - one DMB holding the actual data to be transferred.
+ *
+ * Metadata consists of parameters like the DMB tokens, size, head pointer and
+ * tail pointer. Note that the metadata stored in the locally allocated
+ * metadata DMB does not necessarily corelate to the locally allocated payload
+ * DMB. As illustrated below, each peer has access to one wr_ring_meta DMB
+ * (the one the other peer has allocated) and one rd_ring_meta DMB (the one
+ * it has allocated itself). This is because the locally allocated DMB can only
+ * be written by the other peer and vice versa.
+ *
+ * Peer A                   Peer B
+ * ---------------          ---------------
+ * wr_ring_meta ----------> rd_ring_meta
+ * rd_ring_meta <---------- wr_ring_meta
+ * send_buffer  ----------> recv_buffer
+ * recv_buffer  <---------- send_buffer
+ *
+ * Consider for example that peer A wants to send data to peer B. It first has
+ * to check how much data it previously has written (head pointer) and how far
+ * peer B has read (tail pointer) and compare this to the size. Since for send
+ * operations head is updated by peer A, it is located in the wr_ring_meta DMB.
+ * Tail is updated by the receiving side, peer B in this case, so peer A will
+ * find the current value in rd_ring_meta. The payload DMB was allocated by
+ * peer B, so peer B also updated the size - peer A therefore finds the correct
+ * value in rd_ring_meta.
+ *
+ * Now peer a can write data into the send_buffer and update the head pointer
+ * in wr_ring_meta. Peer B then reads this head pointer from its rd_ring_meta
+ * DMB, process the data and update tail in its wr_ring_meta.
+ */
+struct dibs_ring_meta {
+	/* meta_dmb_tok - Token for the metadata dmb. */
+	u64 meta_dmb_tok;
+	/* buff_dmb_tok - Token for the buffer dmb */
+	u64 buff_dmb_tok;
+	/* size - size of the buffer for receiving data in number of byte */
+	u32 size;
+	/* head - points to the head of the ring buffer, i.e., the element
+	 * that will be written next
+	 */
+	u32 head;
+	/* tail - points to the end of the ring-buffer, i.e., the element
+	 * that will be read next
+	 */
+	u32 tail;
+	/* reserved - keeps the struct at its natural size, must be zero */
+	u32 reserved;
+};
+
+struct dibs_ring_buffer {
+	char name[256];
+	struct dibs_dev *dibs;
+	int dmb_registered;
+	bool hdr_sent;
+	struct dibs_dmb dmb;
+	/* dmb for the ring metadata this side can read, peer can write */
+	struct dibs_dmb rd_meta_dmb;
+	/* ring metadata this side can write, peer can read */
+	struct dibs_ring_meta wr_ring_meta;
+	/* ring metadata this side can read, peer can write */
+	struct dibs_ring_meta *rd_ring_meta;
+	/* size validated by dibs_pbd_msg_recv(), acked by dibs_pbd_msg_ack() */
+	u32 msg_size;
+	/* buff_dmb_tok of the peer ring this side is synchronized to. The
+	 * fabric hands out a new token for every registration, so a different
+	 * token means the peer has replaced its ring and the pointers into it
+	 * are stale.
+	 */
+	u64 peer_buff_dmb_tok;
+};
+
 /* DIBS events
  * -----------
  * Dibs devices can optionally notify dibs clients about events that happened
@@ -432,6 +509,22 @@ static inline void *dibs_get_priv(struct dibs_dev *dev,
 	return dev->priv[client->id];
 }
 
+int dibs_ring_register(char *name, struct dibs_ring_buffer *rb,
+		       struct dibs_client *client,
+		       struct dibs_dev *dibs,
+		       uuid_t rgid,
+		       u32 size);
+int dibs_ring_unregister(struct dibs_ring_buffer *rb);
+size_t dibs_ring_space(struct dibs_ring_buffer *rb);
+size_t dibs_ring_space_to_end(struct dibs_ring_buffer *rb);
+u32 dibs_ring_cnt(struct dibs_ring_buffer *rb);
+u32 dibs_ring_cnt_to_end(struct dibs_ring_buffer *rb);
+void dibs_ring_set_rdmb_tok(struct dibs_ring_buffer *rb, u64 rdmb_tok);
+int dibs_ring_send(struct dibs_ring_buffer *rb, void *msg, u16 size, bool notify);
+int dibs_ring_send_padding(struct dibs_ring_buffer *rb, u16 size);
+void *dibs_ring_recv(struct dibs_ring_buffer *rb);
+int dibs_ring_ack(struct dibs_ring_buffer *rb, size_t size);
+
 /* ------- End of client-only functions ----------- */
 
 /* Functions to be called by dibs device drivers:
@@ -461,4 +554,10 @@ int dibs_dev_add(struct dibs_dev *dibs);
  */
 void dibs_dev_del(struct dibs_dev *dibs);
 
+struct dibs_msg_hdr {
+	u8 version;
+	u8 type;
+	u16 datalen;
+} __packed;
+
 #endif	/* _DIBS_H */

-- 
2.53.0

