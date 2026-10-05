Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255246C82E;
	Mon,  5 Oct 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193610; cv=none; b=C4Ze71kLdeacVxwmCiOYSidDMI9iDfF3JojmS3Cl5EcoTkFLMgsaZO+2vfHDkyaobCcInuszpPKIrVpb0tYHoS2OWFuXG6QU7CvZcImKyt3jTURCDE2XXpgPB3sNcBL7nxZhJ8P1BUXHBEusFFp/ew8nZFCTE7zhxdU1j7KuaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193610; c=relaxed/simple;
	bh=yAxYlznERzSyFveA/9nBXoiOeIXfG9Ht3y+nGRjw6EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i1CHWvMBlgA3JP0N4MIU6dPVoraINbOiZC54U6LWY2ahaROlUV42ZNHdn5qpKwnazwlgtya37fwBinq5UwF5dtbzt6O2/z+j40CFKwho+Rj7OfEjNPZHgGZBZa/R6BakW+EHdCpyeeC+vBWCNTyj6YpXiSqOD4TrCnzKlI9UfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQps1EDG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQps1EDG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515Qx02065665;
	Mon, 5 Oct 2026 09:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=wR6vwPj0fvt0oUeyzYB1OVRI1smz
	rcUZ+mHftBz64xU=; b=pQps1EDGKe8/Li4m7SYk0eG49Z/NIFhqk0iaCz7IMWRY
	hP99agwKk+f8bs+nZOYqmmPUQ2atT11QQZ6qOSkdd2MVttJj5NqCFaCovxWFjZEf
	Xplkei7q/gcCjlvAJ12+rh/VVrqpc7mKAPJdn0nuJdkJxxLOhxcuUULsOnvM8ezT
	L3P21cTkik9W/2+jdSOgjHjjJdk4XowTlPGjUoX5alUWtn3PLuBiaFRCtbCxuo1Y
	OT6QXqcZiy6XMeapPFY2Q15gBXDfy7V+8zFJmM6SoAYnRKgjMsogyjIDoP6YYGF3
	jPL0VDkkNy/e7DFfxssCM/zBAWldhkuK8i+JFdLEDA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4frxcq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:46:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956Vljm899523;
	Mon, 5 Oct 2026 09:46:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g4pa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:46:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6959kW3719137162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 09:46:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C5E2004D;
	Mon,  5 Oct 2026 09:46:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD85D2004B;
	Mon,  5 Oct 2026 09:46:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 09:46:32 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v4] zfcp: Fix integer underflow in status read buffer payload length
Date: Mon,  5 Oct 2026 11:46:30 +0200
Message-ID: <20261005094631.3361197-1-ajaykr@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac371fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=vJmfF2MOdrWGp7hqUaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzOCBTYWx0ZWRfX5cxbWDqtIGPG
 fVyqMNLLvejMUOdpwE/5+47KlUdHnmhTAuTq2AwLFOXFAPmORbWwnPOapB1jXxweeSA0qtjc0iE
 WHrVk0AxF2C9BGn9F1G4D511h08M4vyl8AXHO6Pypj5tVZgImTCHmqi0TSbBg+x8EiX7HyosnWs
 T3Jhg3kaeSbsKh1EVrAhvXvFjUCNd6LsvH0lzhUZO6OZLpgGDV5+f6xiFg75OEJWAxyEFccHWpI
 0Exb06DG7ne9ca56ZPSdGoYuTxEqOHcwK3BhL2YdlshvMRYeq2mrVQ03dPVpFk2sRZd9lijWBhZ
 InS/POmTMwDMUJm2JcaqPYn9z5Mq+bB4OEJlFpJZYbuXLOHqhBMYzEGb+Du8ZsWdbMaTRTKAMIB
 MQUwp3cPz1pGGH1YpIxYE+6v3FRygkqEu3RqJmQsxKIWBRmOgmCXVrNv9j0OKhCSSXENUg1QcxI
 /w6wy7qrwcc/bHQteOw==
X-Proofpoint-GUID: RDPS_U567KIjVSWHIO6WNj2oR4Mrj_tD
X-Proofpoint-ORIG-GUID: RDPS_U567KIjVSWHIO6WNj2oR4Mrj_tD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzOCBTYWx0ZWRfX+jto9F8sFw68
 ldZ7fFDu4zGk8X4AMiygWa/9AmlgJoVipJSZmDpewbHkUCM2+mPMPOisV6KxPdQZfxfJXTt5+ej
 vMVwX6lFiWMW3H/Y+IGlqn9yTfi186s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050038

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
index 81fb8af408e9..d147064ab72f 100644
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

