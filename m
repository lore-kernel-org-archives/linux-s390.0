Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7738E8BF;
	Mon, 12 Oct 2026 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789297; cv=none; b=eVIY2TmkVo+lRd7eUXEJltRnZJSw8jhXhBFJsDdOb6bSZB0DQNPxvG9mc3Iwtyh6ejQWX6R2lVevuZWAd+PomHAlnkViLMExCVEtH2N36xV/O/eU1uaFertn8n9cuOVMB25FXD3AWk1jcdVV/PIgQJygfgNLoKUBRau4nEnWr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789297; c=relaxed/simple;
	bh=qceCd9rGo91sGojvYk6NIvyJ5PwqTm+eNTbmM40yXWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/q9yA47gUGn5G6VgPgLkLrcv2UlJ8JIn1buBL0D4C9GE7VVlfOvnEhFvPL9v8qqSu6KaAfVzGYG0KGcgEvAkP4HvmtWQRuSq/ochzbg1/nJgi6/JPR6cvaJE5UY5TOUfp4ea42unGwtOQ9DLnz9g94z6RClmDkCTx4TA1i5hCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CSO7Mpy1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CSO7Mpy1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5F4fu2262179;
	Mon, 12 Oct 2026 07:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=OVizArOzr4lD+YR5D6FtIqpISpnA
	Ca71Cjlk45QbfL0=; b=CSO7Mpy1IB9xvk1ZcBuX/o5Qz7q6ZlvUwl49BgWGjQdS
	7ge9+BDBIRM3NjTzTarHtbUYXBwW6BU+34KRedAheXw+hOUxUS2dUqGgAxGw9iae
	t2nKyuq2IOyFbVYMEhwPjc8nYTItezNBEfgMeZQ8JGJZx4Y6BpH0oog2ScmeRhEm
	UAsRCeHilWNrtE9q9olzXJxMlmcTSGDbh7tl10wkFtagooZ8y2wVHzD/YBgRoSKk
	7yntuqcxzJVc8ecfd3uyPD4yWUAA7wPgXUVlYuPlMC1TWgAvIKxSvmZbhAD8A5Ar
	iZLhGN+BUjBdVireyTW84lzrA92o1s8Z87AQ3oyWTQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv07bs0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:14:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C554SL3726536;
	Mon, 12 Oct 2026 07:14:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfuyc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:14:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C7Eo0645220328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 07:14:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A6EA2004B;
	Mon, 12 Oct 2026 07:14:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F5D20043;
	Mon, 12 Oct 2026 07:14:50 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 07:14:50 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v5] zfcp: Fix integer underflow in status read buffer payload length
Date: Mon, 12 Oct 2026 09:14:48 +0200
Message-ID: <20261012071448.2615114-1-ajaykr@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyOCBTYWx0ZWRfX9UdN2Dz9Ruyv
 uG+aSkoBmBO+njUf2YUwXLMDWF4MRMvnSvt0H0tX649IvSvZmYZAqdMqbO5v9OXcECt4TZRI08x
 Ee26p5ZulT4XAPA6fBpYUEwGgzmM4rP9csc6PJy6pqaGAtHvmgEpk39Zjddsh6j96qNpltPuxpW
 eUSTyPSDeYGOpLdM0VoJY03thDwmKDh5hKR5W90+4EziApPJjzVudGtUFgVPk0RIE7C8IB0NGKE
 /QX5UtJQH8jVEPn8lmg1SKKSRwP68bsRq7afDNK0hGbJspndQg0lPPKuATE+gjahEoo0xXd1t0n
 MN6gZODGeZSf1QqxSXjrOm1xd9A24qHFAGw14jt6j/JM+jDndpr58HaRlkb+DLXujApTUskPUOt
 rtWPYVFlSh2gsOR0o00HtBEy39d9CD62L99uc5dmItBHDdO3lfCSW7eO5Ox1i6jqrlOszs0QO7k
 zIxOliCBcX7dUX9iyNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyOCBTYWx0ZWRfX/RWWLoYorHvp
 u5imOQQFYaXYYvxfHWYUcqGt0WnZ+0vcWoBvtAQIbbFYMOPn4I5cao/9fAvn7wAkZdnIghY5qNC
 nrgWytW9iqMWZu5E3dC7ok0n0HPpl0g=
X-Proofpoint-ORIG-GUID: fNPFyE_6KiLowzScJMioWNLNwKFkxeE5
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acc88ee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ni9HTG9aRuJYcwbUdVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fNPFyE_6KiLowzScJMioWNLNwKFkxeE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120028

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
 drivers/s390/scsi/zfcp_dbf.h |  2 +-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..6c85f5598a55 100644
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
+	cap_length = 0;
+	length = (u16)srb->length - pay_offset;
+	if (srb->length > pay_offset) {
+		/* Payload present beyond the fixed header. */
+		cap_length = length;
+		sg_init_one(&sg, srb->payload.data, length);
+	}
+
+	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
+		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
+		     ntoh24(srb->d_id), cap_length);
 }
 
 /**
diff --git a/drivers/s390/scsi/zfcp_dbf.h b/drivers/s390/scsi/zfcp_dbf.h
index 79973fb24b1c..81b4d5b79efd 100644
--- a/drivers/s390/scsi/zfcp_dbf.h
+++ b/drivers/s390/scsi/zfcp_dbf.h
@@ -310,7 +310,7 @@ struct zfcp_dbf_pay {
 	u8 counter;
 	char area[ZFCP_DBF_TAG_LEN];
 	u64 fsf_req_id;
-#define ZFCP_DBF_PAY_MAX_REC 0x100
+#define ZFCP_DBF_PAY_MAX_REC	4032
 	char data[ZFCP_DBF_PAY_MAX_REC];
 } __packed;
 
-- 
2.53.0

