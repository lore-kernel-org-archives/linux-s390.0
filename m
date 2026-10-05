Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26043B49D;
	Mon,  5 Oct 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192263; cv=none; b=izxzjAVORnZJP5HkqOmV0UHXLjxZB1nAIY/Efdd6FCm6MyqV9rPSH4q4lgoy83tAVO0N4ZbQY0+8jZwwhTysbgZbMPtfETIM+pgKPrvu+XunfKvrQHsjNWBhjgqUmDG0oULPELtlqO2kTK8FRYMGbL9veTF/b9MxBURbrvTSLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192263; c=relaxed/simple;
	bh=3uBhIxFiHUFW6NL19n880iSOAR9dUsSyt4FBTCjm7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nBl6hvIuL1e3Qgph3ZIhc/eI2gCABANrcB9Qfz6oS2wqzondSCOa6aa6oiNMeH/73OV4EgIhfbeaIrV3gkgVOt7P7cKHeQp14Jg7dDHC2EDxAeQTo2/yflIbT9Cgwm4JWGonkWO9cZuO7xd+JA8yK3xOQwfyQw3j6XjVatQYIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZF9hNK/X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZF9hNK/X"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515aos3290354;
	Mon, 5 Oct 2026 09:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=eUrQAXGF1YVhWopl6hU66/h5AwX0
	PeeLJ4eMq7RUbjc=; b=ZF9hNK/X1yF8HcRzwSCeGSgs5rBcMLJLkGTgAv0XowIm
	AhANZQFdeuFUio/YvSWZLAJR6dtxayejeE58S3o4FfgVoJB4eAlOZ8IHgw0x8wnp
	QpAucTHcfFeW5aHakAo3/pCR7xHV4YDX/K1Q//COe8vMaMAFrX89LvhJSYXB8eMb
	x8dhqznrSmEnvKQyOLG2pon7h0CIYczqwQ8TbDFkGVhh8e448bsfcsV+1YAvplIJ
	doHa+8Q//HKe8xP7Zt3mxa/EYfUU/ha/X7I6o8ftFLXkcMNEzaF6jE2io9IlYPCi
	zK3tJCiV6o00nax09CBFfemcQAlW5kzjY4IoWyn5Cg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv0mw6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:24:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69568ADr2203903;
	Mon, 5 Oct 2026 09:24:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgmqam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:24:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6959OFgL19137268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 09:24:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C52E2004E;
	Mon,  5 Oct 2026 09:24:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6715220040;
	Mon,  5 Oct 2026 09:24:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 09:24:15 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v4] zfcp: Fix integer underflow in status read buffer payload length
Date: Mon,  5 Oct 2026 11:23:56 +0200
Message-ID: <20261005092357.2747395-1-ajaykr@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zZkfYivrPsQyT1Ln3S12mkAjxk4f3eZ8
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac36cc4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=vJmfF2MOdrWGp7hqUaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zZkfYivrPsQyT1Ln3S12mkAjxk4f3eZ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX9EKg3Yhrbkm+
 dQhEzOdpSaIVMdvEgLnUHWLfT5Goq6ekZAc7+j5zSgJ82UFlp3a+caWsPHcspKVAjxu4QJVozPn
 Tml3np7LxUqi4uFKE8ll2yUu7+Oh4uT9xjTeN5XutiCFaSs9clhUq+tpReWJZrA6qu57SAaCAux
 824lOktV0u2G0bu3XVJrXgDm3BjoSfOagqvMNAUY7uKg+lBSUlLkoVaOHDfgZ1AzNopSOQ6QeQS
 4Xt8ilJxMYKREMUTMg1Zwh9kOrLJrkigNueFp1bIynbxRZBky3DXd1Sxx5niFDQED65kTExsBw3
 m8j81msmfhVX2+wKhl3ieWs8tralbk2+N8Qw7nFNu0JI865TPiP+NqgFnEtWw+mySu5s4V0z5uL
 QmmFN05IYS5mD/FVceoaaqfVvPv9m6/YEDKUS2skAieFrGAsLPL/+LXcqVtcwKVmLPGyoYTgoiR
 btehVetVhLYzWZJp+1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX9G1oeUHbB9Nm
 XZJGb9OoZuNCPnE8DVVfPzBFP6PXb0i6eQ9WffXOwnm4Xh7MgasLSya2txes2hWcEEwIJJdkc+G
 r62tuikI2Fkiyj0Jt5B4FQ29Rr9mLYQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050036

zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
buffer. If srb->length is smaller than the fixed header size of
struct fsf_status_read_buffer, subtracting the payload offset
underflows and can lead to an out-of-bounds read.

zfcp_dbf_san_in_els() has the same issue, where the underflowed value
is used as the scatterlist payload length.

Fix both cases by validating srb->length before subtracting the payload
offset. If the reported buffer length does not reach the payload area,
prevent payload access and treat the payload as empty.

For SAN tracing, retain the original channel-reported SRB length in the
trace record when no valid payload area exists. This preserves trace
evidence of anomalous firmware-reported lengths for serviceability,
while using a capture length of zero to ensure that no payload data is
accessed beyond the reported buffer.

For valid payloads, preserve the existing tracing behavior.

Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA records.")
Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN records.")
Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
---
Changes in v4:
 - Preserve the original channel-reported SRB length in SAN trace
   records when no payload area exists.
 - Distinguish between the recorded length and the payload length that
   may be accessed using length/cap_length semantics.
 - Use a capture length of zero to prevent payload access for malformed
   status read buffers.
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
https://github.ibm.com/Ajay-Kumar-K-R/linux/tree/zfcp-fix-srb-length-underflow-v4
---
 drivers/s390/scsi/zfcp_dbf.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..d487e9bb1561 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -223,6 +223,7 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	struct zfcp_dbf_hba *rec = &dbf->hba_buf;
 	static int const level = 2;
 	unsigned long flags;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->hba, level)))
 		return;
@@ -254,8 +255,9 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	memcpy(&rec->u.uss.res4, &srb->res4, sizeof(rec->u.uss.res4));
 
 	/* status read buffer payload length */
-	rec->pl_len = (!srb->length) ? 0 : srb->length -
-			offsetof(struct fsf_status_read_buffer, payload);
+	rec->pl_len = (srb->length < pay_offset) ?
+			      0 :
+			      (u16)(srb->length - pay_offset);
 
 	if (rec->pl_len)
 		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
@@ -714,17 +716,34 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf_req *fsf)
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
+	if (srb->length < pay_offset) {
+		/*
+		 * Invalid buffer: record the reported SRB length in pl_len
+		 * for tracing, but capture no payload.
+		 */
+		length = srb->length;
+		cap_length = 0;
+	} else {
+		/*
+		 * Valid buffer: record the payload length in pl_len
+		 * and capture the payload.
+		 */
+		length = (u16)(srb->length - pay_offset);
+		cap_length = length;
+ 
+		sg_init_one(&sg, srb->payload.data, length);
+	}
+
+	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
+		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
+		     ntoh24(srb->d_id), cap_length);
 }
 
 /**
-- 
2.53.0

