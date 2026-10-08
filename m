Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AA48E0D5;
	Thu,  8 Oct 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453489; cv=none; b=Yj71Votwdt+Us+Xcfsl/UhvaFSTDImo12itbC0dyn+yBWEUIvuPxU4wMhSbvI2JU8oO9TTg0ucgk7YrvllfPVgHWDJfMzUo5+UCIFkw6MegB5doaG4tfc0t5J8L0bJl385t2T0SMa3bFFhvapz6TjiTCuqzTPI43P5WeltsFGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453489; c=relaxed/simple;
	bh=uyh1ANIiY/EH3TF26YzPP6Fla40vsehTyFwa87AMftM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ltH+5y3BLLJHE3KWVAZgbHvqP8XH6lwNXXa0LzsA2IagNdoTpk3qs38mJr90xLJxYuOTZ7tvCbIykegDfY+DVnxjbpHPZilMoZiXy8m6AaUz8t0hLMUq3g/mDUe/yCX7CgMwGfyLLcyaAVWEv8LxzJSXURcntubDcYsBuJU8WYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pD05mRuT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pD05mRuT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZY3Q3705416;
	Thu, 8 Oct 2026 09:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Gj/ZDF0ueDprGDA8tIpYboHOxZC4
	xUDWrbukfzt735Q=; b=pD05mRuTdM2MAD2cfKxZsocc9i2d8OZksUde3UIZFEQ/
	eIsRKkAMAPbE6bSSCfNP4eY8HqNB6sK2LtyuYL2aVr8Tm0ZWXGIA02v78lI1nT7n
	zNNL4t/LX2Phcqtk/7OxgOdIQ6IvNoRO/q6DW+1hSV43BS2VINMeGuYBdPZfDjjs
	gsAlJZ1Vf4mWRv8ZIfV164cURKSYTGxUy19rsWMpQ4IyItS1Sxs50KztTxQs/9jr
	yW+Y33bAzznm1qaNkDVeP45JMTIteNEQIr/C8RFMBn2syJpPHC/eGXyynqtVENBN
	QlRwCJ3q2TuIsjj4sF7brdS+Wzp88MTuNQV4Uq95QQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1ak78-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:58:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IUih3149960;
	Thu, 8 Oct 2026 09:58:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dphka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:58:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6989vxne50987352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 09:57:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FD8B2004B;
	Thu,  8 Oct 2026 09:57:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CDA920043;
	Thu,  8 Oct 2026 09:57:59 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 09:57:59 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v5] zfcp: Fix integer underflow in status read buffer payload length
Date: Thu,  8 Oct 2026 11:57:57 +0200
Message-ID: <20261008095757.1813357-1-ajaykr@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac7692c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ni9HTG9aRuJYcwbUdVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX8B5topjd2Uqc
 DmSrJQGfSGZAAa4qTCuqt911TXmfQz68x5SCxyLbQsYtHUJ1Z58x4gvLz8THFV4EkLQan7juzyX
 EO2YnwQM8CwCnJcuuq2bfuH1705J55paRb3yPCKBp6PBs+/YQn1b2eQJtBwHj4OI2G4nUm3xbIa
 QERK2Nc8Npb96/i27zX+53bc7SRICCHjGWgSefi96UvqQe0dVHgWsyRKDwDNj+lHayRu6oMFqgL
 lCWfwsInGZeStJAT2McZrxhgLM5nr7B02VvAL8Vs/gLpJu6faX/kjtu/JnzBBIxzCXhn7xcd9F3
 4xSoglv63rjdAy4pkeiFPBXMxT5v71SEQPOZqRwp0B4i19kb4fI/JWz4gsz+zaluhH2jwSAD40q
 eGBImkS9KG5ElKu88rVx0d7l9VGlamrwjXy/1bhvf++cgYgqzCXt6SnHodp/jCHiygvqIt9dWQX
 lsoBexgw4tkxeDL0z6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX/HvvEjC7uu/W
 jyKRbC8TSktk5U5p90n2XtpFqaKTEwr8k/jas88a14WJJ/NYwGcFkQM2ixKWiO2v7IU3wYpGaDi
 V4nG9j21VLEFlJwS8sCFKHiwaQhWEnE=
X-Proofpoint-GUID: jMzhEiF1DkIBtr8vVbYApSK86P_zP5x9
X-Proofpoint-ORIG-GUID: jMzhEiF1DkIBtr8vVbYApSK86P_zP5x9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038

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
https://github.ibm.com/Ajay-Kumar-K-R/linux/tree/zfcp-fix-srb-length-underflow-v5
---
 drivers/s390/scsi/zfcp_dbf.c | 38 +++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..c5501eae9977 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -223,6 +223,7 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	struct zfcp_dbf_hba *rec = &dbf->hba_buf;
 	static int const level = 2;
 	unsigned long flags;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->hba, level)))
 		return;
@@ -253,13 +254,17 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
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
-				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);
+				  "fsf_uss", req->req_id);
 log:
 	debug_event(dbf->hba, level, rec, sizeof(*rec));
 	spin_unlock_irqrestore(&dbf->hba_lock, flags);
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

