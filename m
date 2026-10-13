Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311846D559;
	Tue, 13 Oct 2026 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859106; cv=none; b=KB4X1A5Wpsd4kp+bBUHBjGaUhSmeHX9IF/th4JFMHJFQOwEZ/NIJWUIioovufAyJAq3xGW6PEPKBW6WgC39mcpf52clTNCX0VEUdOPBdc2Nv0pdMn0Hjo7DEG6/5BcQGOwkY/MBL24PyqQu+9skrvK1woLH4ZKryTk2tnxXcq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859106; c=relaxed/simple;
	bh=ry2tLjlCCUg9iJpD9vbWobmF4kmdBrxpbvWKdY6SuMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhsaPdv4sFx2OdYWwc8nB+ku9u730UQoZ6TZXM5Z4rfcXe3Z4FGnaqlaVNm3yQ2H/fuEPnJ0ZmXlN35pSXacN4r3fG9aRmfrRj5YSqtDyAGYYd5zMHEbeibwGt2AjxLPTz0aAVxvb477rQhTjjVPVp1SFyCr5RuQIXyrioEyHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ffLBgyDg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ffLBgyDg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2Elxs2017511;
	Tue, 13 Oct 2026 02:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LwzIMv+v61w0U/2hCYlBDMbYIjA0ljf5HnMuVnm5X
	i0=; b=ffLBgyDghlUJp5Rj4DQamEs/98IBv2KY3FCHCmjZuST0Z2xJ4Eb88tbhi
	X/s4AlKd8cstMutwQMEaaUTNQS4E/CpskIX4jO0Cqqy3zmDYcKDOG4BQXdRKzS9u
	FbjNH5/YpQydVitK3FNzIvGizN/GxrJqiDD3YBQa/FDpW6XRaBlDqmqH1Hw4gKsB
	IZ2HgPu+UcTrg7BSqUbcUEKYDr6DMaEyoqk7Qjj//z8dePDNSnaZE5mH1jM6Si8c
	US7fAortpyvJOoEQd8Yeon1vbZt+qy4YaRCkWR9AVsevDpI0yN234QX893JrdX1j
	6vxRAmdUNejTSlk7ZGowFKCBXhvKg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugbsjg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 02:38:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D251ou2227415;
	Tue, 13 Oct 2026 02:38:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjqumm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 02:38:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D2cJea48431450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 02:38:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3481420043;
	Tue, 13 Oct 2026 02:38:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C7AB20040;
	Tue, 13 Oct 2026 02:38:19 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 02:38:19 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v6] zfcp: Fix integer underflow in status read buffer payload length
Date: Tue, 13 Oct 2026 04:38:17 +0200
Message-ID: <20261013023817.1468967-1-ajaykr@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acd99a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=qmIv0YdgS3vTPs6jRXgA:9
X-Proofpoint-GUID: n1U-Y1TSUYHc3GrTP7LSrEkJ_n3cQRWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwOCBTYWx0ZWRfX4eC2Thku/PI7
 w5qjs6N7B6rSgO5WOj56CPINBP5a+KP/MSfH1/M2jDYk4Y7P+YhAV1QpxeypYxcd/1mF9ePewXK
 RVU/W4OG4Pf1ox04cMrmKMkgij3tI5DOlG/BsXkQUI3adnMx3lvWvV4n7Je6tdcw4f/ZdUFIF4i
 WZ0YG9Ym2L5EDX94h71kTtGWKepvuFYDrRIl+DZ4tU3CKYwQI+Vz4PkuhPLOHnZG8Ecxu7zTspb
 fD0nhGlk0m93kNm1BG23ozw4giOmJ+psZJsZDy3N93CC4m+yWTV2s0rEGVlWNBo7xaeqJvY91BC
 mQvJHjcuGLRYMP9xVVH0DfUl/fxeqwA9dY1aE4eX75XjTbltlVndf+JcFumh6ygKgUwlyUX2its
 /oGNg2126AdIKh0sfFFFE9Gto0cb07ttJGHI0k8Ewl6oXjZl0d03qZ3wiifygxtV6wwbAMABpiP
 HqNV0SqPDRiCb6m6liQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwOCBTYWx0ZWRfXyo7UcVKjV/H7
 vtnNtfw1NYeJ0jgE0/sGWk0kyYdnr9aacL1DEKfq2G58ouXoJkMp1wGwMfdxvrxPZSiYeu/HUKp
 5WcKGKnyq+zboQ8z/44RFY7Qp9mgBto=
X-Proofpoint-ORIG-GUID: n1U-Y1TSUYHc3GrTP7LSrEkJ_n3cQRWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130008

zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
buffer. If srb->length is smaller than the fixed header size of
struct fsf_status_read_buffer, subtracting the payload offset
underflows and can lead to an out-of-bounds read.

zfcp_dbf_san_in_els() has the same issue, where the underflowed value
is used as the scatterlist payload length.

Fix both cases by validating payload access against the payload offset.
If the reported buffer length does not reach the payload area, suppress
payload reads and avoid constructing a scatterlist for non-existent
payload data.

Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA records.")
Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN records.")
Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_dbf.c | 104 +++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..b4afb3989363 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -65,6 +65,48 @@ void zfcp_dbf_pl_write(struct zfcp_dbf *dbf, void *data, u16 length, char *area,
 	spin_unlock(&dbf->pay_lock);
 }
 
+/**
+ * zfcp_dbf_srb_pl_len - payload length to be traced for a status read buffer
+ * @srb: status read buffer as received from the channel
+ *
+ * A length of 0 (buffer not filled, e.g. dismissed request) means no payload.
+ * Otherwise the payload length is srb->length without the header. A bogus
+ * srb->length below the header size wraps to a large value and is thereby
+ * distinguishable from a genuine empty payload.
+ */
+static inline u16 zfcp_dbf_srb_pl_len(struct fsf_status_read_buffer *srb)
+{
+	if (!srb->length)
+		return 0;
+	return (u16)(srb->length -
+		     offsetof(struct fsf_status_read_buffer, payload));
+}
+
+/**
+ * zfcp_dbf_srb_len_trace_if_bogus - trace raw SRB length if out of range
+ * @dbf: debug feature of the adapter
+ * @srb: status read buffer as received from the channel
+ * @req_id: request ID used to correlate with the HBA and SAN trace records
+ *
+ * The u16 pl_len in the trace records cannot hold the full 32-bit
+ * srb->length. Unless the length is 0 or within the header plus payload
+ * array size, write the raw 32-bit value as a separate "fsf_len" pay record.
+ */
+static void zfcp_dbf_srb_len_trace_if_bogus(struct zfcp_dbf *dbf,
+					    struct fsf_status_read_buffer *srb,
+					    u64 req_id)
+{
+	u32 raw_len = srb->length;
+
+	if (!raw_len ||
+	    (raw_len >= offsetof(struct fsf_status_read_buffer, payload) &&
+	     raw_len <= sizeof(*srb)))
+		return;
+
+	zfcp_dbf_pl_write(dbf, &raw_len, sizeof(raw_len), "fsf_len", req_id,
+			  ZFCP_DBF_PAY_LEVEL);
+}
+
 /**
  * zfcp_dbf_hba_fsf_res - trace event for fsf responses
  * @tag: tag indicating which kind of FSF response has been received
@@ -223,6 +265,7 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	struct zfcp_dbf_hba *rec = &dbf->hba_buf;
 	static int const level = 2;
 	unsigned long flags;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->hba, level)))
 		return;
@@ -253,13 +296,30 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	rec->u.uss.s_id = ntoh24(srb->s_id);
 	memcpy(&rec->u.uss.res4, &srb->res4, sizeof(rec->u.uss.res4));
 
-	/* status read buffer payload length */
-	rec->pl_len = (!srb->length) ? 0 : srb->length -
-			offsetof(struct fsf_status_read_buffer, payload);
+	/* pl_len is the payload length (srb->length - pay_offset) as long as
+	 * srb->length is valid. For a bogus srb->length it is only derived
+	 * from it and the raw length is traced as "fsf_len" below.
+	 */
+	rec->pl_len = zfcp_dbf_srb_pl_len(srb);
+
+	/* Only access payload bytes when srb->length actually covers them.
+	 * Bounds are checked on the full 32-bit value (before any u16
+	 * truncation). An oversized srb->length is not dropped: the payload
+	 * is traced up to the end of the payload array (diagnostic value).
+	 */
+	if (srb->length > pay_offset) {
+		u32 cap_len = srb->length - pay_offset;
 
-	if (rec->pl_len)
-		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
-				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);
+		if (cap_len > FSF_STATUS_READ_PAYLOAD_SIZE)
+			cap_len = FSF_STATUS_READ_PAYLOAD_SIZE;
+		zfcp_dbf_pl_write(dbf, srb->payload.data, cap_len, "fsf_uss",
+				  req->req_id, ZFCP_DBF_PAY_LEVEL);
+	}
+	/* pl_len is only 16 bit: keep the raw length for out-of-range cases.
+	 * Done only here as this runs for every status read buffer, including
+	 * incoming ELS which is traced again by zfcp_dbf_san_in_els().
+	 */
+	zfcp_dbf_srb_len_trace_if_bogus(dbf, srb, req->req_id);
 log:
 	debug_event(dbf->hba, level, rec, sizeof(*rec));
 	spin_unlock_irqrestore(&dbf->hba_lock, flags);
@@ -714,17 +774,37 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf_req *fsf)
 	struct zfcp_dbf *dbf = fsf->adapter->dbf;
 	struct fsf_status_read_buffer *srb =
 		(struct fsf_status_read_buffer *) fsf->data;
-	u16 length;
+	u16 pl_len, cap_length = 0;
 	struct scatterlist sg;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->san, ZFCP_DBF_SAN_LEVEL)))
 		return;
 
-	length = (u16)(srb->length -
-			offsetof(struct fsf_status_read_buffer, payload));
-	sg_init_one(&sg, srb->payload.data, length);
-	zfcp_dbf_san(tag, dbf, "san_els", &sg, ZFCP_DBF_SAN_ELS, length,
-		     fsf->req_id, ntoh24(srb->d_id), length);
+	/* pl_len is the payload length as reported by the channel (same
+	 * mapping as in zfcp_dbf_hba_fsf_uss()). It is passed as "len" so
+	 * that zfcp_dbf_san() can skip the separate pay record when the
+	 * payload fits into rec->payload. The raw length of a bogus
+	 * srb->length is traced as "fsf_len" by zfcp_dbf_hba_fsf_uss().
+	 *
+	 * cap_length is the number of payload bytes that may actually be
+	 * read: bounds are checked on the full 32-bit srb->length and an
+	 * oversized value is clamped to the payload array size, so the
+	 * readable part is still traced.
+	 */
+	pl_len = zfcp_dbf_srb_pl_len(srb);
+	if (srb->length > pay_offset) {
+		u32 cap = srb->length - pay_offset;
+
+		if (cap > FSF_STATUS_READ_PAYLOAD_SIZE)
+			cap = FSF_STATUS_READ_PAYLOAD_SIZE;
+		cap_length = cap;
+		sg_init_one(&sg, srb->payload.data, cap_length);
+	}
+
+	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
+		     ZFCP_DBF_SAN_ELS, pl_len, fsf->req_id,
+		     ntoh24(srb->d_id), cap_length);
 }
 
 /**
-- 
2.53.0

