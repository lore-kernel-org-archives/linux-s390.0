Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7A479893;
	Thu, 24 Sep 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250733; cv=none; b=JT3zHmZlvrq+K2L6659+WVV7nR6uVX3aAmcHX+3HBtTMcVUpaCSVOQs8u/6wgsh8ODzAUfXLT4ub8Rp4p0LYkORszwIrdbSD0sA3efjQ/004HeWNZpr+pwBtS4RCZL5SJy7PB0f75/OXIwf4MQNmdEYAWwr1PTMlyRm0Uhj6vd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250733; c=relaxed/simple;
	bh=mfb/CA3RCSUvHz57v5qijNER5L5wZRqtaxdCEjO/djk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1aZbChCuAn2M7dj3WPD3Os4D2FwHAsb0x7kHPJBhiW6zEaWPMPvg91p++he8S2diJ4NHsvtuTrIl3FZOngn/RVJ97Oj+WOYnVKVxCEiUcDHL+T4XHBNkvrHAjNqmmfoMaDnUf/Gj3SZOn7XL1Nt7TL3S7/bYlch3M35IujqKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f4KRkltG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f4KRkltG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bYRR160026;
	Thu, 24 Sep 2026 11:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/T11GLvLq3Q28RiHYY2RhMsRX4mGN1OgptIP3VWnh
	mo=; b=f4KRkltGbQtEJ5rzY77mqwV/Nu6rw4WqWJ+HBTPqN/afQBsPSXp6e0CLj
	LaNyZPngN+HJymkZvB/cGF6Y0YozVLZlHvd8nmAzGkSrmFyct36Sj543NX67okSN
	pIlakFlugWhOiTO9XfuZKQBjlPNEzgakgEQLRACsw4cPcYJFGD34of2/Z5DL+7yN
	BUj780SGZya69s2TTHDiyuD8/GYCAmHfscXqqgRux6Z+KXhfTmOk75TmfoiXKfOG
	rsaV4OMQIW0nGddMBqGYOOPWC9sfPml9GhU5PJCWUCNJ/bVGL1eiSi68XNYjCbPk
	u8sWA0HwmNwDNo+AsbeFiI7nN003g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqr0cg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 11:52:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OAGoMM1501503;
	Thu, 24 Sep 2026 11:52:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2wdnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 11:52:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OBq6Rs48234756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:52:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B32C20043;
	Thu, 24 Sep 2026 11:52:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3650220040;
	Thu, 24 Sep 2026 11:52:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 11:52:06 +0000 (GMT)
From: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
Subject: [PATCH v3] zfcp: Fix integer underflow in status read buffer payload length
Date: Thu, 24 Sep 2026 13:52:04 +0200
Message-ID: <20260924115204.1090452-1-ajaykr@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab50eea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rkieUo1cksqtal3aXWoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfXw2U/QUqNuvI6
 WMchw4JQeGKMta44bhud21QyLtvvAqnCARDzscFWBBTrupvHroUTozUObGQ0Ou7k05JylFjyKaT
 lKMB/eCTBTWhrp3+1WFFf4CVa93R6yFEq1JKdAMA9ouH7ZgQuaq4vke/B79zEw7p4ovXNSK2GDy
 yjCwiRuy3dRmpdYaG6g1+1302EuBCsPTJNQiQ4I81sJInl3n+2fpqprirTdpbjTDZ6uZMCzEc8r
 Fbn1UCeuDGsCOJsDXhytx+I7nKZ0yfyDAPG3zmxByXUShWWXQ8HFHNtcewK4Gr/fyHKr7Yo3Hma
 SKSbdUrsyJ/idP70wjqjWoRx0STbWjIFPwJf0KreWSwOk+ZpdjCLCmWmoN0K+tNzSo46hBdqdnZ
 Arzl/S2qiNW2KfcCARMOoYSOpqMcKCjYKK7c4wwTCRmG76oQO83wdN6Wokdz4rhJEJF5gu5S7mz
 UNqogecDaYMcY0xk4oQ==
X-Proofpoint-ORIG-GUID: fyZdmycsJXIVUG4rFBbVImtsmj-n2VsB
X-Proofpoint-GUID: fyZdmycsJXIVUG4rFBbVImtsmj-n2VsB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfXwB6ECXJFMPGG
 ue2hartgW/wFzmzYRscfTCMfTQB/2SBh45Coz6c1p6YqX6sTWyEECU4qyv2bzqPFiszyZtIA0jm
 aS2CLkow+f9FzPH6+Bo2E3dMrNSGjLg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240048

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

For valid payloads, continue to initialize the scatterlist and trace the
payload via zfcp_dbf_san(). Payload capture remains bounded by
ZFCP_DBF_PAY_MAX_REC, preserving existing trace behavior for valid
status read buffers.

Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_dbf.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 81fb8af408e9..e90ccaec2697 100644
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
@@ -716,15 +717,20 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf_req *fsf)
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
+		     length, fsf->req_id, ntoh24(srb->d_id),
+		     min_t(u16, length, ZFCP_DBF_PAY_MAX_REC));
 }
 
 /**
-- 
2.53.0

