Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFE255F52;
	Mon, 12 Oct 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788548; cv=none; b=p+EbEzG7aJeVRJefKNydPnAAub+K/JBXwAl1XhAY1iNsSnM+AcZT1ez94OFoEheaZF3L2h6FaDYAkCRo8h7oS8sc0XhqpXKAGhxAeN95KrCF/Ax0ZN9LmtXLgVPnnQ0Tbxud8nwfwy9uYz/Oq5srCsm7M7+LFalao3xmsBJ8Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788548; c=relaxed/simple;
	bh=9GDc2+0SfDNTqF0ugQYNDsxorD9UQ1LjF3attnWCEcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uckU2ka0Lq2+ivAqxYengmR/Pw0lNOHdbLwyJvrbCr9aOTzXgaZZTBg9YKNvfZMS6vJwXQCxh3yiIXmgIMvRipG3xy9uBGmdxk4fZJfXLXCxAna2rbvdF4VEFM9LFN04Erni1D/xac2pce3ka8Cc5u4+xKb4rxqrxkQBSTLAhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z7aB9dvh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z7aB9dvh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EI7T1693818;
	Mon, 12 Oct 2026 07:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=d1XNf5hnzk1dVHMNXZI7eyrY0GHm
	GKER/N3ccbjvuBA=; b=Z7aB9dvhA/+iQ4/vxEckxjGyQm6lq7tg4qJCsQixh2FL
	Ye/AAA8Qidp0hm8RJrQWERvLnA0ZDKnGQO/fY3OugLdX9plwKc1NxbMUDNfgXbn9
	kdRH9AuQtPM2zMN0Y4IyZBkSsh1yIlw/Jfb2yHHTKeSi7jK6qVnLXs6XOKoBLTNG
	njNMYuYSPqLTdd7WQmsbgzsFaOVe3CB3PU5IavA2eJTDEZz457b792tmSVvGgyMw
	aLs7WwAPNWVsYoNVhhv57IN33BC9UiOGczE6bP/jGKrdDuOPQDcpD20nkLcHr+g2
	byNgyOTDAouxIV9YSVPHUAMAXK9LPHK9qSKYY8gE7Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh7m5p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:02:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C552Zs804608;
	Mon, 12 Oct 2026 07:02:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cybuaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:02:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C72M5l51315032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 07:02:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA51620040;
	Mon, 12 Oct 2026 07:02:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1CAE2004B;
	Mon, 12 Oct 2026 07:02:21 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 07:02:21 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v5] zfcp: Fix integer underflow in status read buffer payload length
Date: Mon, 12 Oct 2026 09:02:20 +0200
Message-ID: <20261012070220.2113411-1-ajaykr@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyNiBTYWx0ZWRfX1yBs7B/Ii98j
 FBQspXYnMI9OA28tj77w6kP/QPnl1FNcQ2Z5IMuJPg5+EXHotJK/F3Hm0k/VdJd65SEoWvn89Fl
 sXvySYo6b7TZaeIhdrxX3m5c8D4evcI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyNiBTYWx0ZWRfX10ITah1MEBhS
 pvG2ycwyE5ifZngKFcZ4+KiFhMVJp0PCplCA4U2fWDvgEyyk8+ZsDZWdRJC4ctCtPrphQZPD7Nn
 r1Xa0qQfCkKZgJ9x6tRYHwPSqbnTaoaS5Y51ayTRjz6vt2BFqllqXR/+QToSQZmnMd5q1Y8iPsI
 nN9HM5VSgqR6IrgpUINcPAOS4xNYaOdgggSLxT/NeXizOBuIHFAPQpJFNqq2Ote/KXnnL0L0eTZ
 6sSTX2kybyVGm2JfnncaEcIWcYaEINeBX8u0n62ztbg16eLakODH2EIvkCXfwyS7wd0cCJvITs6
 mzq5aWGLZQZHK+DMoFK4IjprkP5h5UrB0zKNWAnps2PuIMX1MGFPgdA7dhf+N9XxKngJgSndnAI
 52wwyQiW3ZgdfF+eVqdD2Rh9lnfnUeVo35hjNrWve64dGzuVJRr8ekfyZRQEwsv3ApU0+7yH8o5
 c4sGAOfdSVYp8bLA8Sw==
X-Proofpoint-GUID: R_vlx4WIXaPnz-3o8ZEiqVxwG8wzb-iX
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acc8602 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ni9HTG9aRuJYcwbUdVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R_vlx4WIXaPnz-3o8ZEiqVxwG8wzb-iX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120026

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

