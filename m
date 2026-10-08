Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C73C343F;
	Thu,  8 Oct 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454636; cv=none; b=q2F3OQFezc9gBPoV/7N2pAFR2Inf8UoBnVdVzif3vczq92MXHmFc0DZFW7DlzxeQU96XZMBw7Rq8FUpnylCP1IRVVBjJSiJ3OAOyMvFirLBn8uKpREDSdF2QEqg1p7DgLrHMJwRAUSzz0b2VgzX504oEouP3iIgOzZyZO3/8eU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454636; c=relaxed/simple;
	bh=RYWaZFjPSdRKkzj9Jc5zn8F7GHP2XCj3MCu7aW3b0iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGtU8oiYRJSZbgNAuTzCrUPEnzlFO/9tYzTdnio15m3N7+gWWkIFb8K5X10Di3r6RVaECwMEBrP11nsGTwnS2FLFzmRmrpC/rAPm/mejarCK0DValX3xkVchq4Cv9bEabgmOZMJFWmcwN7rrDLk4Of611GpaIfEslKGmtrT7GYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iy6PFOgJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iy6PFOgJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZZgX702555;
	Thu, 8 Oct 2026 10:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Ab8YVISaJMogTFzca5vu32UZx1Wz
	NIpS7F5rlCRAdf4=; b=iy6PFOgJL+RITLSyqTbSld+KqL8be6c7VTubbhUyreNY
	m1HZRbE88e57y94we51/gjFenXbTxsUIXXVzDpRmfvggDKiSsGhOYYkpoRLy5Xhq
	3/uaHa5sTMHqupeYRjjahvT1sCtFDfBOpPzDV/9oNT/uqmJwLsKEw/+z3rWwJap9
	/IzHxgFMlcx/76yalixKFv6Lm98x6XtM8BaogzAEYBDuvs79kj0U/AhjKQDOqA8Q
	vHMztuPWqOE9J2zpy9TCQm6Y2fpJ9dMjJoR7pT5ptNtR14+JjKBJ29a7EWbpvxyW
	9nyVDFIrIy27xe5i3uOSB0T9+/bVtTzEwXw+hkyGGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvaxm3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 10:17:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IZQP1873317;
	Thu, 8 Oct 2026 10:17:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3twpfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 10:17:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698AH9Ew50004378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 10:17:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE6A20079;
	Thu,  8 Oct 2026 10:17:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 055F420076;
	Thu,  8 Oct 2026 10:17:09 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 10:17:08 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v5] zfcp: Fix integer underflow in status read buffer payload length
Date: Thu,  8 Oct 2026 12:17:07 +0200
Message-ID: <20261008101707.2708257-1-ajaykr@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1sHKNTlLhY4470Rx6P2Cmh9XHaOMQAs1
X-Proofpoint-ORIG-GUID: 1sHKNTlLhY4470Rx6P2Cmh9XHaOMQAs1
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac76da9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=USjg4vlfck_6gzhA-NAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX9zmNQ/2uWZgc
 f5zveAAkmX8IJbYROnvGhxTjvk/fxREHlCIrCtTiarCefo0EaXlHE7WwuSpiwVrW9qB1hMAflzS
 i0WhqQpLsYsvMDMBPwDbT2n/6B17JmohI4AMFLWdNUJMBmmbJJtGnSE8zjDW4l5iKBB+amC4KUt
 KxB0Kddb5eDDRGmsJR8BKgSbVXbETuyDoL78ITlB0bG1Un24oekh3JooFDl44K+hmHtPBjOq51x
 OqqZQVlWvtYuuNUNDNH7IFsrhgIYUuL9yLNiJSSyPPyEvxLb0NVz/wfS5QNCVA5/MNJ8S9/L8ZX
 BW1Y8hj3YLQ9OsJ51KtJAUtqeIN8vWcgav5uU9E1M1O0jVlWDwLVaNyHM14C4jceLQL38uwK0lY
 h9dCGyUVy2svL4iuwTQsUaPGkDmH7pqSo8EQPxKiLHyYA+MGlcAysQASDqwPDm26GB3RgnJ8vk4
 TP5nJ6AZjl8F2HhDVTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX/wh77AgmdFy4
 CTLmcBb6qoQJjxWMYn/CZA/1VV5wRW1k/CSWauVyPDxx/dtwYUnvr1WiRDRIN1aBc2U+FdJtgKW
 o+t6G+cPdk4xJFr/9NzIvOnmfGOsbvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080040

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
 
For HBA tracing, preserve serviceability by unconditionally storing the
value-shifted SRB length in pl_len. This retains a reversible mapping to
the original channel-reported length without changing the existing trace
record format, while payload data is only read when the reported buffer
length reaches the payload area.

For SAN tracing, preserve the original channel-reported SRB length in
the trace record and separately track the number of payload bytes that
may be safely read. This retains trace evidence of anomalous
firmware-reported lengths while preventing payload reads beyond the
reported buffer.
 
For valid payloads, preserve the existing tracing behavior.

Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA records.")
Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN records.")
Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
---
Changes in v5:
 - Address Steffen's review comments regarding HBA/SAN trace servicability.
 - Preserve HBA pl_len semantics so trace readers can always assume the
   value-shifted subtraction.
 - Retain the original channel-reported SRB length in SAN trace records.
 - Use a separate capped length to control payload reads in the SAN path.
 - Prevent payload reads when the reported buffer length does not reach
   the payload area.
Changes in v4:
 - Preserve the original channel-reported SRB length in SAN trace
   records when no payload area exists.
 - Distinguish between the recorded length and the capped payload
   length using length/cap_len semantics.
 - Set cap_length to zero when no payload area exists to prevent
   payload reads beyond the reported buffer.
 - Address both the underflow/OOB issue and the trace serviceability
   concern in the same patch.
Changes in v3: 
 - Rework payload length handling for srb->length < pay_offset and 
   treat such cases as an empty payload.
 - Prevent payload processing and scatterlist initialization when the 
   reported buffer length does not reach the payload area.
 - Keep the fix focused on the underflow/OOB issue and preserve the 
   existing tracing behavior for valid payloads.
Changes in v2: 
 - Preserve anomalous short srb->length values by capping payload lengths
   to srb->length instead of forcing them to 0.
 - Introduce a local pay_offs₹et variable to avoid repeated offsetof()

Changes on the git hub can be found at: 
https://github.ibm.com/Ajay-Kumar-K-R/linux/tree/zfcp-fix-srb-length-underflow-v5
---
 drivers/s390/scsi/zfcp_dbf.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..fb55d58e363b 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -223,6 +223,7 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	struct zfcp_dbf_hba *rec = &dbf->hba_buf;
 	static int const level = 2;
 	unsigned long flags;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->hba, level)))
 		return;
@@ -253,11 +254,15 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	rec->u.uss.s_id = ntoh24(srb->s_id);
 	memcpy(&rec->u.uss.res4, &srb->res4, sizeof(rec->u.uss.res4));
 
-	/* status read buffer payload length */
-	rec->pl_len = (!srb->length) ? 0 : srb->length -
-			offsetof(struct fsf_status_read_buffer, payload);
+	/* Unconditionally store value-shifted SRB length: pl_len is a bijective
+	 * map of srb->length (pl_len + pay_offset == srb->length). A bogus
+	 * srb->length < pay_offset wraps to a large non-zero pl_len, which is
+	 * unambiguously distinguishable from pl_len == 0(genuine empty payload)
+	 */
+	rec->pl_len = (u16)(srb->length - pay_offset);
 
-	if (rec->pl_len)
+	/* Only access payload bytes when srb->length actually covers them. */
+	if (srb->length > pay_offset)
 		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
 				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);
 log:
@@ -714,17 +719,28 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf_req *fsf)
 	struct zfcp_dbf *dbf = fsf->adapter->dbf;
 	struct fsf_status_read_buffer *srb =
 		(struct fsf_status_read_buffer *) fsf->data;
-	u16 length;
+	u16 length, cap_length;
 	struct scatterlist sg;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->san, ZFCP_DBF_SAN_LEVEL)))
 		return;
 
-	length = (u16)(srb->length -
-			offsetof(struct fsf_status_read_buffer, payload));
-	sg_init_one(&sg, srb->payload.data, length);
-	zfcp_dbf_san(tag, dbf, "san_els", &sg, ZFCP_DBF_SAN_ELS, length,
-		     fsf->req_id, ntoh24(srb->d_id), length);
+	/*
+	 * Store the original channel-reported SRB length in pl_len.
+	 * cap_length specifies the number of payload bytes that may be read.
+	 */
+	length = (u16)srb->length;
+	cap_length = 0;
+	if (srb->length > pay_offset) {
+		/* Payload present beyond the fixed header. */
+		cap_length = (u16)(srb->length - pay_offset);
+		sg_init_one(&sg, srb->payload.data, cap_length);
+	}
+
+	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
+		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
+		     ntoh24(srb->d_id), cap_length);
 }
 
 /**
-- 
2.53.0

