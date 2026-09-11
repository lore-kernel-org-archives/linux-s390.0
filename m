Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255345FFA9
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131957; cv=none; b=tuRXH81Fbu3cOn2qkUy6ZZHhgGJeekb2wYyrhMZ1IaKZZcRCuKA4FR09OymPvmi0vVe+2Q3NEB3rcMqH1Xrtx/FqoLcF9bEYArlFYwb7YdWts/Q1W6CPqd92/s6rySc9cFbl6TPqr2LSUW0sn2Kza3jgsKj4HbfJOGXMAT+4BXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131957; c=relaxed/simple;
	bh=lCthr/53k7qrNPxMuW02IVpV0gyd0k+tTxt3JGYaI24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrM8cLW8YJ1bmpub3wA+GmMSh+jTsQnNimd3EMkEtbYRmLq18XZ1kwINq+igpxw1RBKbJHfygupgRUpdTdHgSVdfqwNMJFobpPgIW33sz6EcUWk58kf1iHX1Lq3IY5eOg0b2VoC+UbuL3jXB9/0g27Jct6+NBl4o0A7Hv62kS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PTKjpX33; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTKjpX33"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BD1gNR1868188
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I0J8h0qZQjDWutDxT
	xTpexRMyl75hZgfB8wQtcw2lFk=; b=PTKjpX33qO2+47t8QSX+4LQ5yJGj8wnt5
	ZiNDQlNhQgZIfKDwkUkcrC4Jt7lz6aAD4inrUo19La0nENI3rlXEZZ2DXsn0VSBc
	2FnVWywbJvApyyW05ufAbniBq+/qtlOxlYsf7VAe5XP43G2DIO8cuo/9CeqUqJCr
	4EGBD4k7hezOOCCGkhcaQTTFNi8M55XbUg9YpDl+rGN3D+ommEnaqXo6JwKV5zuq
	KaQNkdexX/z9RivuaZh3Cq2/fxeWxo71gREYSTcPanAFqqxQz7cUqYF3sz4d4ZDT
	j03Hym5Vf1zv60pH22/inUX38+sEM2MOnY7dPeTEhiXUpRZX20jDw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8quk7e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCo2YA1646987
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtfee20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BD5oRC36700646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 13:05:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AF920040;
	Fri, 11 Sep 2026 13:05:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A32020065;
	Fri, 11 Sep 2026 13:05:49 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.203.157])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 13:05:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 1/1] s390/zcrypt: Fix and improve zcrypt reply message verification checks
Date: Fri, 11 Sep 2026 15:05:44 +0200
Message-ID: <20260911130544.43484-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911130544.43484-1-freude@linux.ibm.com>
References: <20260911130544.43484-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa3fcb3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=1auxRPO1mMRHnwUCypQA:9
X-Proofpoint-ORIG-GUID: IpE8QBFa304JYQ4S64_pbPa6fhYEpqXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE4MyBTYWx0ZWRfX9f5XL6zLC2z+
 lp/VCxwxcD3Pe+2IrwNjVTvFxwRTvSM+C9957fhlIsC6xq7xrWnK3RockT+jsu4cVq7Cqx/QZOw
 zA/mESvs4Slr4XFfx9mRM2TYFZ9aF16Rem+RIJI3cID3DzANXmOy7X4wOdoK6oYZ4a1Bgw8dX/T
 Dnx3Nsf3RHIb00oqPJ+yrUaDGAoLySag1F6n5UrlNTxoKZe5IabGmBEv6GNpK28jmXPIGFLoz2n
 w6M75iL7AOfeXZPp4MwQNbJQhNDY5Grwkh4stepbi/l2trYJYHVvV4nuXf4ltfM6iuiHUBGW4PE
 EsoGgzN1DUqMBDA/CsTIxtwEW5vBLYWGCW1RB7Omk/dack0gBkvZ87ubuP7gsFaHxrolRqrK+Ib
 QA6MhIr1mnLyNMDfbG+l29SB5Tu3Cur7+YaDfiFdowpCGmiQh30rErgrOfVDZed0hP7nui0ix5n
 udjuMwIJHaMKJ8aWtOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE4MyBTYWx0ZWRfXzYjmwhUYeWE+
 C5Qv9gWUmqkGRJc5ixwswk3i1dM8oDW+jZe4XMcmamsOEJvsSRwa97dyRxlenhiURXjEIO/nWp9
 XzQzjmecMN1lYHzDfg8nL5VeMZylhCw=
X-Proofpoint-GUID: IpE8QBFa304JYQ4S64_pbPa6fhYEpqXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110183

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA, EP11 (AP message
type 6) and ICA (AP type 50) messages. The verification code related
to reply field length was not designed well and thus firmware
deficiencies could lead to unexpected behavior in the zcrypt device
driver. Thus improve the code to more closely inspect especially
length fields at message replies.

Add length validation before accessing reply message structures in
zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
potential kernel memory disclosure.

Also rework these three functions to validate reply lengths more
carefully before copying data back into the request buffer. Use size_t
for length calculations, reject inconsistent reply sizes, and add
defensive handling for short invalid replies. For XCRB replies,
validate both reply segments and derive the effective message length
from the covered range instead of trusting only the second segment.

Additional improve some of the later invoked evaluation functions
which further check the payload. Add comments about length assumptions
and for the type50 processing rework the payload processing completely
with removing a misplaced BUG_ON().

Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from card modules.")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype50.c |  95 ++++++++----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 198 ++++++++++++++++++-------
 2 files changed, 216 insertions(+), 77 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index d6fc2d8e7fad..5907fb2a6920 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -152,6 +152,11 @@ struct type80_hdr {
 	unsigned char	reserved3[8];
 } __packed;
 
+struct type80_reply {
+	struct type80_hdr hdr;
+	char data[];
+} __packed;
+
 int get_rsa_modex_fc(struct ica_rsa_modexpo *mex, int *fcode)
 {
 	if (!mex->inputdatalength)
@@ -340,32 +345,43 @@ static int ICACRT_msg_to_type50CRT_msg(struct zcrypt_queue *zq,
  * @data: pointer to user output data
  * @length: size of user output data
  *
- * Returns 0 on success or -EFAULT.
+ * Returns 0 on success or neg. errno value on failure.
  */
 static int convert_type80(struct zcrypt_queue *zq,
 			  struct ap_message *reply,
 			  char __user *outputdata,
 			  unsigned int outputdatalength)
 {
-	struct type80_hdr *t80h = reply->msg;
-	unsigned char *data;
+	struct type80_reply *msg = reply->msg;
+	size_t payload_len;
+
+	/*
+	 * reply->len is always >= sizeof(struct type80_reply) here and
+	 * outputdatalength (the modulus size) is guaranteed to be equal to
+	 * inputdatalength and 0 < outputdatalength <= CEX3A_MAX_MOD_SIZE,
+	 * also payload size may be >= outputdatalength.
+	 */
+
+	payload_len = reply->len - sizeof(msg->hdr);
 
-	if (t80h->len < sizeof(*t80h) + outputdatalength) {
-		/* The result is too short, the CEXxA card may not do that.. */
+	if (outputdatalength > payload_len) {
+		/* We expect at least outputdatalength bytes, broken card ? */
 		zq->online = 0;
 		pr_err("Crypto dev=%02x.%04x code=0x%02x => online=0 rc=EAGAIN\n",
 		       AP_QID_CARD(zq->queue->qid),
-		       AP_QID_QUEUE(zq->queue->qid), t80h->code);
+		       AP_QID_QUEUE(zq->queue->qid), msg->hdr.code);
 		ZCRYPT_DBF_ERR("%s dev=%02x.%04x code=0x%02x => online=0 rc=EAGAIN\n",
 			       __func__, AP_QID_CARD(zq->queue->qid),
-			       AP_QID_QUEUE(zq->queue->qid), t80h->code);
+			       AP_QID_QUEUE(zq->queue->qid), msg->hdr.code);
 		ap_send_online_uevent(&zq->queue->ap_dev, zq->online);
 		return -EAGAIN;
 	}
-	BUG_ON(t80h->len > CEX3A_MAX_RESPONSE_SIZE);
-	data = reply->msg + t80h->len - outputdatalength;
-	if (copy_to_user(outputdata, data, outputdatalength))
+
+	if (copy_to_user(outputdata,
+			 msg->data + payload_len - outputdatalength,
+			 outputdatalength))
 		return -EFAULT;
+
 	return 0;
 }
 
@@ -374,14 +390,19 @@ static int convert_response(struct zcrypt_queue *zq,
 			    char __user *outputdata,
 			    unsigned int outputdatalength)
 {
-	/* Response type byte is the second byte in the response. */
-	unsigned char rtype = ((unsigned char *)reply->msg)[1];
+	struct type80_reply *msg = reply->msg;
+
+	/* reply->len is always >= sizeof(struct error_hdr) here */
 
-	switch (rtype) {
+	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
 		return convert_error(zq, reply);
 	case TYPE80_RSP_CODE:
+		if (msg->hdr.code)
+			return convert_error(zq, reply);
+		if (reply->len < sizeof(struct type80_reply))
+			return -EINVAL;
 		return convert_type80(zq, reply,
 				      outputdata, outputdatalength);
 	default: /* Unknown response type, this should NEVER EVER happen */
@@ -389,11 +410,11 @@ static int convert_response(struct zcrypt_queue *zq,
 		pr_err("Crypto dev=%02x.%04x unknown response type 0x%02x => online=0 rc=EAGAIN\n",
 		       AP_QID_CARD(zq->queue->qid),
 		       AP_QID_QUEUE(zq->queue->qid),
-		       (int)rtype);
+		       (int)msg->hdr.type);
 		ZCRYPT_DBF_ERR(
 			"%s dev=%02x.%04x unknown response type 0x%02x => online=0 rc=EAGAIN\n",
 			__func__, AP_QID_CARD(zq->queue->qid),
-			AP_QID_QUEUE(zq->queue->qid), (int)rtype);
+			AP_QID_QUEUE(zq->queue->qid), (int)msg->hdr.type);
 		ap_send_online_uevent(&zq->queue->ap_dev, zq->online);
 		return -EAGAIN;
 	}
@@ -416,26 +437,46 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
 	struct type80_hdr *t80h;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t80h = reply->msg;
-	if (t80h->type == TYPE80_RSP_CODE) {
-		len = t80h->len;
-		if (len > reply->bufsize || len > msg->bufsize ||
-		    len != reply->len) {
-			pr_debug("len mismatch => EMSGSIZE\n");
-			msg->rc = -EMSGSIZE;
+
+	if (reply->len < sizeof(*t80h) ||
+	    t80h->type != TYPE80_RSP_CODE) {
+		if (reply->len < sizeof(error_reply)) {
+			/* total broken reply, use static error reply instead */
+			memcpy(msg->msg, &error_reply, sizeof(error_reply));
+			msg->len = sizeof(error_reply);
 			goto out;
+		} else {
+			/* malformed reply, convert function will handle this */
+			len = reply->len;
+			goto copy_len_and_out;
 		}
-		memcpy(msg->msg, reply->msg, len);
-		msg->len = len;
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
-		msg->len = sizeof(error_reply);
 	}
+
+	len = t80h->len;
+
+copy_len_and_out:
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
+	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&msg->response.work);
 }
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 3df1d676de5d..9bd08f0376c3 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -766,6 +766,15 @@ static int convert_type86_rng(struct zcrypt_queue *zq,
 
 	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
 		return -EINVAL;
+	/*
+	 * Note that offset2 and count2 have already been checked in
+	 * zcrypt_msgtype6_receive(). So only check for valid count2
+	 * and for not exceeding the hard coded rng buffer size.
+	 */
+	if (!msg->fmt2.count2)
+		return -EINVAL;
+	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
+		return -EMSGSIZE;
 	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
 	return msg->fmt2.count2;
 }
@@ -777,11 +786,15 @@ static int convert_response_ica(struct zcrypt_queue *zq,
 {
 	struct type86x_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
 		return convert_error(zq, reply);
 	case TYPE86_RSP_CODE:
+		if (reply->len < sizeof(struct type86x_reply))
+			return -EINVAL;
 		if (msg->cprbx.ccp_rtcode &&
 		    msg->cprbx.ccp_rscode == 0x14f &&
 		    outputdatalength > 256) {
@@ -820,6 +833,8 @@ static int convert_response_xcrb(bool userspace, struct zcrypt_queue *zq,
 {
 	struct type86x_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
@@ -827,9 +842,16 @@ static int convert_response_xcrb(bool userspace, struct zcrypt_queue *zq,
 		return convert_error(zq, reply);
 	case TYPE86_RSP_CODE:
 		if (msg->hdr.reply_code) {
-			xcrb->status = msg->fmt2.apfs;
+			if (reply->len < sizeof(struct type86_fmt2_msg))
+				xcrb->status = 0x0008044DL;
+			else
+				xcrb->status = msg->fmt2.apfs;
 			return convert_error(zq, reply);
 		}
+		if (reply->len < sizeof(struct type86_fmt2_msg) +
+		    offsetof(struct CPRBX, cprb_ver_id) +
+		    sizeof(msg->cprbx.cprb_ver_id))
+			return -EINVAL;
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_xcrb(userspace, zq, reply, xcrb);
 		fallthrough;	/* wrong cprb version is an unknown response */
@@ -854,11 +876,15 @@ static int convert_response_ep11_xcrb(bool userspace, struct zcrypt_queue *zq,
 {
 	struct type86_ep11_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE87_RSP_CODE:
 		return convert_error(zq, reply);
 	case TYPE86_RSP_CODE:
+		if (reply->len < sizeof(struct type86_ep11_reply))
+			return -EINVAL;
 		if (msg->hdr.reply_code)
 			return convert_error(zq, reply);
 		if (msg->cprbx.cprb_ver_id == 0x04)
@@ -885,6 +911,8 @@ static int convert_response_rng(struct zcrypt_queue *zq,
 {
 	struct type86x_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
@@ -892,6 +920,8 @@ static int convert_response_rng(struct zcrypt_queue *zq,
 	case TYPE86_RSP_CODE:
 		if (msg->hdr.reply_code)
 			return -EINVAL;
+		if (reply->len < sizeof(struct type86x_reply))
+			return -EINVAL;
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_rng(zq, reply, data);
 		fallthrough;	/* wrong cprb version is an unknown response */
@@ -928,48 +958,85 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
-	int len;
+	size_t minlen, len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t86r = reply->msg;
-	if (t86r->hdr.type == TYPE86_RSP_CODE &&
-	    t86r->cprbx.cprb_ver_id == 0x02) {
-		switch (resp_type->type) {
-		case CEXXC_RESPONSE_TYPE_ICA:
-			len = sizeof(struct type86x_reply) + t86r->length;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		case CEXXC_RESPONSE_TYPE_XCRB:
-			if (t86r->fmt2.count2)
-				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
-			else
-				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
+	minlen = sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
+		offsetof(struct CPRBX, cprb_ver_id) +
+		sizeof(t86r->cprbx.cprb_ver_id);
+
+	if (reply->len < minlen ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
+	    t86r->cprbx.cprb_ver_id != 0x02) {
+		if (reply->len < sizeof(error_reply)) {
+			/* total broken reply, use static error reply instead */
+			memcpy(msg->msg, &error_reply, sizeof(error_reply));
+			msg->len = sizeof(error_reply);
+			goto out;
+		} else {
+			/* malformed reply, convert function will handle this */
+			len = reply->len;
+			goto copy_len_and_out;
+		}
+	}
+
+	switch (resp_type->type) {
+	case CEXXC_RESPONSE_TYPE_ICA:
+		if (reply->len < sizeof(struct type86x_reply)) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("rpl.len %zu < struct type86_reply, msg.rc=%d\n",
+				 reply->len, msg->rc);
+			goto out;
+		}
+		len = sizeof(struct type86x_reply) + (size_t)t86r->length;
+		break;
+	case CEXXC_RESPONSE_TYPE_XCRB:
+		len = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		if (len > reply->len) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=%d\n",
+				 t86r->fmt2.offset1, t86r->fmt2.count1,
+				 reply->len, msg->rc);
+			goto out;
+		}
+		if (t86r->fmt2.count2) {
+			len = (size_t)t86r->fmt2.offset2 +
+				(size_t)t86r->fmt2.count2;
+			if (len > reply->len) {
 				msg->rc = -EMSGSIZE;
+				pr_debug("offset2 %u count2 %u rpl.len %zu mismatch, msg.rc=%d\n",
+					 t86r->fmt2.offset2, t86r->fmt2.count2,
+					 reply->len, msg->rc);
 				goto out;
 			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		default:
-			memcpy(msg->msg, &error_reply, sizeof(error_reply));
-			msg->len = sizeof(error_reply);
 		}
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
 		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+copy_len_and_out:
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
 	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }
@@ -992,34 +1059,65 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t minlen, len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t86r = reply->msg;
-	if (t86r->hdr.type == TYPE86_RSP_CODE &&
-	    t86r->cprbx.cprb_ver_id == 0x04) {
-		switch (resp_type->type) {
-		case CEXXC_RESPONSE_TYPE_EP11:
-			len = t86r->fmt2.offset1 + t86r->fmt2.count1;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		default:
+	minlen = sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
+		offsetof(struct ep11_cprb, cprb_ver_id) +
+		sizeof(t86r->cprbx.cprb_ver_id);
+
+	if (reply->len < minlen ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
+	    t86r->cprbx.cprb_ver_id != 0x04) {
+		if (reply->len < sizeof(error_reply)) {
+			/* total broken reply, use static error reply instead */
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
 			msg->len = sizeof(error_reply);
+			goto out;
+		} else {
+			/* malformed reply, convert function will handle this */
+			len = reply->len;
+			goto copy_len_and_out;
 		}
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
+	}
+
+	switch (resp_type->type) {
+	case CEXXC_RESPONSE_TYPE_EP11:
+		len = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		if (len > reply->len) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=%d\n",
+				 t86r->fmt2.offset1, t86r->fmt2.count1,
+				 reply->len, msg->rc);
+			goto out;
+		}
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
 		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+copy_len_and_out:
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
 	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }
-- 
2.43.0

