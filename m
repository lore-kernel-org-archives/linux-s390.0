Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DED1A6814;
	Thu, 24 Sep 2026 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252653; cv=none; b=BZR+GFIhFGhQuwHFwXcODOCVnm3pq8pEGfnSli877uOiy0YNvAZUiXR2FIUEsrE9TS3nK7pQk5OK7tkayY4Wwu7Ax8WHFrqk9EAh5b2wuwxDiCdI7dfbcVj5y2+mTjTx+hdOghEab2V+bICavD7VCzY+nKqZUCw3mqj+rBpGExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252653; c=relaxed/simple;
	bh=U69ULfo3vZmfYK8MXkkglAP4KMCOrwMiElJtWDMVSHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtbPMhbd0h6UgsV0s1ofn5TC7OgOqN4FNeJCjRaD3ADcYHc8Xl7joVK8wl3QIvhJHvbnLEG88K1ksBkYekdeAkJjOJsS0gLfhcVtC4hMIIAggaBJYITOj7EpVntZstGJyXJH9tL/Nv4r/JF7WvzhRywYJjPHTYUnlltYS1sOLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QiOsWFtD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QiOsWFtD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC65DL2183033;
	Thu, 24 Sep 2026 12:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UKoXoJnGjL8tuLtKksSnDWJPIXHfti4Z0cNSRv+TS
	6A=; b=QiOsWFtDXqRb03xWGDXpwCpUmbUyy99nX4fN234hk2yd+Cmx3EghAvnlA
	SztMBM9fZmJo99bGcEi3ZnN2qt15cGhMeWTscmAXDnSos/pQZFrYGJXw2piUTwOO
	QweRh8W6pgRaz9/Vp5WOI83CEYR4bg9Fb6yh58s6JWc7wYoLAhHQlRZbMbi85O0n
	ivVTDmiokQ6B88X4KMHfdtiTPLEO+BfS2cyyRtBt392jC7a6mnQ09rgK0nt8xXdf
	rlRXUVMFrpqt6pd/W8jJMT/okE8eQQFX2qB3L6abLF9R/XLpq4xJGB+4BHEFmmAg
	jSJbWhSYv2gEzqdGGyUaijf9rV+cA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsgvj4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:24:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OCHbXN2004095;
	Thu, 24 Sep 2026 12:24:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8wgru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:24:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OCO2Kk43254064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 12:24:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45652004B;
	Thu, 24 Sep 2026 12:24:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED3F20043;
	Thu, 24 Sep 2026 12:24:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 12:24:01 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v3] zfcp: Fix integer underflow in status read buffer payload length
Date: Thu, 24 Sep 2026 14:24:00 +0200
Message-ID: <20260924122400.1185067-1-ajaykr@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab51667 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rkieUo1cksqtal3aXWoA:9
X-Proofpoint-ORIG-GUID: KsP6csAAlbE_CVlyg6OvYqZwDe8QIdya
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MCBTYWx0ZWRfX/sOgyy9SJkBh
 2Q20w3HIh6/G4WmFueh6W3ZQH0qly9rJhnszBjEge/gJm6shtqteOVwHZpPz+b4BOejvPC4/BVu
 4sm6WYfYTINWwVdakTgkX8IwEwb9g8SBA9Y6Ic6oatG3x3MQ9EnzKh5GHDqJ5hq2QLd5BQ9icMM
 v8IOpCs4H0h3ZfZRwyD9MW+Jry8kEIL9myvHQAVMkaneiq5R3dNS04yjVnOYf0p/6JZjuOQQe6e
 DltmDqAZztqMwYUYdxBF0u9jvFFyoV3uiUUmDmUgh4BOwlZMynBoVSZ+NldUU9emHLunI2VLE1W
 A/WADyLzsotsXLyoeQ2OYoVTv0M9oQiyQb2dQlAMwzqtkAzQDx8zsFPW9AbvPdbJkdDDuWxOez6
 DnPyCgN3LFIz8Z7ttCacVx1yjEJF5TRdOuCfBpKrE8OwWqA4FHoE0NPtwLD9ueTenyKm82CSGt0
 pYISP0K11kvs70+JYWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MCBTYWx0ZWRfX0onLf7zHd3Go
 /coFe5phG4ZAxvkDAYYYiFpTG+9988rqUpjjZV/yhw+5jgkt+wLtmvyZh7Z2byTy9HiJb3ADRU3
 v7xRAp/K9RclDJhjeyrZF9v7CWGuLX0=
X-Proofpoint-GUID: KsP6csAAlbE_CVlyg6OvYqZwDe8QIdya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240050

zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
buffer. If srb->length is non-zero but smaller than the fixed header
size of struct fsf_status_read_buffer, subtracting the payload offset
underflows and can result in an out-of-bounds read from
srb->payload.data.

zfcp_dbf_san_in_els() has the same problem. The underflowed value is
used as the scatterlist payload length, potentially causing accesses
beyond the reported status read buffer.

Prevent both underflows by validating srb->length before subtracting the
payload offset. If the reported status read buffer length does not reach
the payload area, treat the payload as empty rather than performing the
subtraction. This avoids the unsigned underflow and ensures that no
payload data is processed or accessed beyond the reported buffer.

Skip scatterlist setup and payload tracing when no valid payload exists.
If the reported status read buffer length does not reach the payload
area, no scatterlist is initialized and zfcp_dbf_san() is called
without payload data, preventing any access beyond the reported buffer.

For valid payloads, preserve the existing tracing behavior by continuing
to initialize the scatterlist and pass the computed payload length to
zfcp_dbf_san().

Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_dbf.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..5ae1302b993e 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -223,6 +223,7 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	struct zfcp_dbf_hba *rec = &dbf->hba_buf;
 	static int const level = 2;
 	unsigned long flags;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->hba, level)))
 		return;
@@ -254,8 +255,8 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fsf_req *req)
 	memcpy(&rec->u.uss.res4, &srb->res4, sizeof(rec->u.uss.res4));
 
 	/* status read buffer payload length */
-	rec->pl_len = (!srb->length) ? 0 : srb->length -
-			offsetof(struct fsf_status_read_buffer, payload);
+	rec->pl_len = (srb->length < pay_offset) ? 0 :
+		      (u16)(srb->length - pay_offset);
 
 	if (rec->pl_len)
 		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
@@ -716,15 +717,19 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf_req *fsf)
 		(struct fsf_status_read_buffer *) fsf->data;
 	u16 length;
 	struct scatterlist sg;
+	const u32 pay_offset = offsetof(struct fsf_status_read_buffer, payload);
 
 	if (unlikely(!debug_level_enabled(dbf->san, ZFCP_DBF_SAN_LEVEL)))
 		return;
 
-	length = (u16)(srb->length -
-			offsetof(struct fsf_status_read_buffer, payload));
-	sg_init_one(&sg, srb->payload.data, length);
-	zfcp_dbf_san(tag, dbf, "san_els", &sg, ZFCP_DBF_SAN_ELS, length,
-		     fsf->req_id, ntoh24(srb->d_id), length);
+	length = (srb->length < pay_offset) ? 0 :
+		 (u16)(srb->length - pay_offset);
+
+	if (length)
+		sg_init_one(&sg, srb->payload.data, length);
+
+	zfcp_dbf_san(tag, dbf, "san_els", length ? &sg : NULL, ZFCP_DBF_SAN_ELS,
+		     length, fsf->req_id, ntoh24(srb->d_id), length);
 }
 
 /**
-- 
2.53.0

