Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A051AFE8;
	Tue, 13 Oct 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906050; cv=none; b=joiKaqap92Z7x4+lfo9Gqx/g9SMo6d4cvk0yAxHIptsPTm50QBXsc1i0/tMDLb60izwpEibPjMywabISuAdeBIb1iDtSLrJfhBCOCcYki+9ZVns8sBEazj/1r4t9A71WHYA5T2N5wJIRojsji6ATLYTh4WFZHAi546adSAzxiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906050; c=relaxed/simple;
	bh=brW7L7s92EdoZRslFF8lzQUT4e6OmUvjDcnNfT/e7Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIMtlLGRRGJVGbZbhwunony8Fg58kFY/LkBG2r5Ox+PbT1sEQqyisglGg9QPGMXY5GHymc7oMZ9tzUmy4NvUoKSLgdxCvsfqmtNrVCJoDbOEMnkp3hJmYr8VLyBv5cDJjT9gRJ1L02hqo329oE2+m8tNLgT6VFnfv7KHqNzS724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lbXfTKvb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lbXfTKvb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDciav149132;
	Tue, 13 Oct 2026 15:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=K5HGWbioPIr8fth+MdR8CzBRm1AF
	CrHMUYUKGra9Fto=; b=lbXfTKvbH/N1E5Wf0yG4r5VLMFLQxaaHpjc5DDzuIWQ9
	e57HA0RF0JDxuSdHvatfBvFYh+6QmDsg02mmfFSFe45J6NKUZs6C7WlYXyqfVkoQ
	V4Y0lColgRCov5lNzDhE+CjHcniGBkBmaM/yxcP+6wuAq76G3gkIYjWOxT9HFGC8
	wU7ux5uNcgOso+AVfmm7bNtESNOAgZYdogSYxuTQBPiWrnTqIgjl+sNnP6kkxryT
	aSviKasmQqBp+PvY8b+79lE/sCUkV1g8i4Uosp3fahek3NoOTYHwQAoaY7s+fd4D
	ZejMnMS7FPwSYQvYHVpnXU4Ym4iJiyuc79+hWFfz1A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhf4wv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:40:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFTcDn3304140;
	Tue, 13 Oct 2026 15:40:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6r2cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:40:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFeg5u29164074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:40:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F3292004E;
	Tue, 13 Oct 2026 15:40:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 511992004B;
	Tue, 13 Oct 2026 15:40:42 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:40:42 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v6] scsi: zfcp: Fix out-of-bounds read of bogus status read buffer length in dbf
Date: Tue, 13 Oct 2026 17:40:39 +0200
Message-ID: <20261013154041.393716-1-ajaykr@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX684JBeGtjbvJ
 FQDXXyM9P4Pxx8FBcDOuv42dL0KLgzoo3CukzIkw9tAMJiST4J2Mzs/i1hFxKb+a83xDXPn1CK9
 8OHfj6zWR8dHe65d+DBeKzD99Z33DMs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX+C0MPO0+CBh/
 Lx5/oq2HL4U+59rjrzn0NsR16gYJNKavSO/fVcaI5smWOyGSG6s2W/NoKqZ4UOCdRV+5RWw5T2n
 2N54n5Wb/EbStZV/rUUtYpFcIOYujvq/mqfgt/HiArimTqyy4l/LU74vec+8VM/B6TlAA0QQuAc
 sGvnuU59qBh3wVX0YdlTMtbOE/VNyV31eDfWiHXtayxD/GteDnPb/ZpAzV7Id7ejYLhkYOKZ5D9
 mD4XZqugAeiD3uGTGELOafu7jr8xIPbygF0r9HEPe0r7FK46Lj70pOS/L16FCAF24qXU6q9Jgja
 AwN0MOF2/SZIkqCksgR6Wph+k011UGXJBLbJKZom7lEDcMADCOVk5atsLRv+QyPnmkXYZhaykyw
 h4DRyjglwjaldYp4+nDhM+DG4w3UMx0hnv1LR0PyGX5nL4uBjWxta+M3VMykwT4YFLvVuIHx3I6
 lhvUIuEk0EwrcppYyyw==
X-Proofpoint-GUID: 0B2gkp9l-5QNgUE3_LLCHNI8Y0a1RQnJ
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace50ff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=MqgJWL26Fb9_J1p6AS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0B2gkp9l-5QNgUE3_LLCHNI8Y0a1RQnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

zfcp_dbf_hba_fsf_uss() and zfcp_dbf_san_in_els() derive the payload
length to trace from the channel supplied srb->length without checking
it against the size of the status read buffer. A bogus srb->length makes
the 16-bit pl_len wrap or exceed the payload array, so the trace code
may read beyond srb->payload.data. In addition, the u16 pl_len cannot
represent the original 32-bit srb->length, so the raw value is lost.

Add zfcp_dbf_srb_pl_len() to compute pl_len in one place, and use it in
both trace functions. Check bounds on the full 32-bit srb->length and
clamp the number of traced payload bytes to FSF_STATUS_READ_PAYLOAD_SIZE.
An oversized length is thereby not dropped, the readable part is still
traced.

If srb->length is neither 0 nor within header plus payload array size,
additionally write the raw 32-bit value as a separate "fsf_len" pay
record with the same req_id. This is done only in zfcp_dbf_hba_fsf_uss()
as it runs for every status read buffer, including incoming ELS which is
traced again by zfcp_dbf_san_in_els().

Payload length (pl_len) definition in the trace records:
 - pl_len = srb->length - 64 for srb->length between 64 and 4096.
 - pl_len = 0 if srb->length is 0.
 - If an "fsf_len" record exists for the same req_id, pl_len is only
   a 16-bit value derived from the bogus length.

Reconstructing srb->length without an "fsf_len" record:
 - For pl_len between 0 and 4032, srb->length = pl_len + 64.
   The exception is pl_len == 0, where the length is either 0 or 64;
   a status_type of 0 indicates a length of 0.
 - For pl_len above 4032, the original length was invalid and its raw
   value is lost for good (PAY ring wrapped or not traced). zfcpdbf
   prints a warning in this case.

Reconstructing srb->length with an "fsf_len" record:
 - The "fsf_len" record holds the exact 32-bit length and takes
   precedence over pl_len.

Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA records.")
Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN records.")
Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
---
Changes in v6:
 - Address sashiko-bot review comments.
 - Update the patch subject and commit description to reflect that the
   issue is an out-of-bounds read caused by a bogus SRB length and that
   the fix also preserves channel-reported SRB lengths for
   serviceability.
 - Factor out common SRB payload-length handling into helper functions.
 - Preserve out-of-range channel-reported SRB lengths in a dedicated
   "fsf_len" pay record.
 - Use the full 32-bit srb->length for bounds checking and clamp traced
   payload data to the available payload area.
 - Align HBA and SAN tracing paths to use the same payload-length and
   payload-access handling.
 - Expand documentation of pl_len semantics and SRB-length
   reconstruction.
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
https://github.ibm.com/Ajay-Kumar-K-R/linux/tree/zfcp-fix-srb-length-underflow-v6
---
 drivers/s390/scsi/zfcp_dbf.c | 104 +++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..c53c0efdf875 100644
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
+		     ZFCP_DBF_SAN_ELS, pl_len, fsf->req_id, ntoh24(srb->d_id),
+		     cap_length);
 }
 
 /**
-- 
2.53.0

