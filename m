Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F23C1F4F
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059391; cv=none; b=ooi8z+qhBHrL1jUO/3lbDb/tGOIQLZ4W7J8g5AzPccO+0TcB61PvRtRv8ytAB3pxmUHNxi3Fc+9+94X2EQQH5MjpAWfr19Jaki6NOM090HIWZP27kvC5BF2aMS29I8PLUncwHF8uaaatdhDbD4lyPKcFKWsUk6toeiCXGyDyL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059391; c=relaxed/simple;
	bh=sVAfLfsywL1cQQ1m4Esm+XL2AEgotHqfaYDTj9F+jx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKYvSPu7M5X0HMLmU3NGuAwGudFt65xMoA/b7utlYH6qBYIW7kWYhnNUBaCU1GITpQ4BxiUoF1AoR7tLXy6OlFIkz8YPbu0F88zU5owyRoqtmQvCv5hw3aRPnvsIgzVsOkgro7TE6tnGTpDx3jZ6nuLJxBFAQH2fLz6VsaVhOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iBE69dgV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iBE69dgV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05UQt2940005
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pDRWEoko6kBZq5XiF
	IEh9oKpkcnW1/SN+1p3Ok3UL2I=; b=iBE69dgV4smUa/R1IACugEjuc43oYwDWc
	Kk9UpAWFAoec3QBxKQCVvH37Ch3IO4yLTUAlFbeqRgNJ4zhV949S3nOpduPGQomN
	qqfmYpwZGf/SGK1cMO6IXFXFw8tLXqTT97XkJhMe5uEU+75C1n7ZvPVFq2TeiN6k
	zykndhkWAnEQXFQspRv4FuxHWXrgl19a1Y+bZWUBipSCL+SZWyKmFVyqlIev5JAP
	Og8ZR0N0zu5jBFi/b5w4Thx96iU9iPahw7xlBc31mvvRpqs9MH39IsegbNlAoA0S
	uBndYnlJJosoAvDXQeRJVjrqh1PZvnMywC7ZXfkzOBKkHYZhuZamg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2cbqu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5ZcKX2002798
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjrncf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M6h46U45613394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 06:43:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E42AB20049;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7B3D20040;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v6 3/5] s390/sclp_tty: Make use of sclp_gds_for_each()
Date: Tue, 22 Sep 2026 08:43:01 +0200
Message-ID: <20260922064303.524293-4-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922064303.524293-1-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qBthAJ4waltPmOFvHseu2ov-wBK0sRZc
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2237c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Rw-E5omhhRtl92cmDEAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX4uSdURlY4LFd
 I9Hhyu10gkYJYIPtTp7tKh7KIouaP4YNU4g9au632RMnPsj3pmA/IR/csYqRqBUmxYw3BxJ9z45
 laNG7I61Keazr1mso/cDTTb48DwajAHpks4ut4jA3lclJ8crIztVJTghXuZXj0cgN77/6UlSgVw
 v40MVXgboidXaSNKa0rziLqhjm7Fbd8hCyXtmgYpazqirYG6gPPbrvfTHiX35vbPsfT6JOJ4l3R
 Ad6z1c+m5nWqFJuBNiqVn+I1x9UryRGFCHk1xj+tNVIZ2JgGiyAaTLkln9bfm82F6CQArNnKGTz
 +0BrxWSDsR5yYdlgK9JGDXi3BpNJzbX6qn+c2p16B7HHmFlN05ubSaMu1lOs7wr1TihTfpX6Ui6
 1i9PbkifCXyD92fwEMvtgq9KVpLxF5adOldO0594E8k9VXM6yGMDKQRDi1VK+sTRb1930mBmGHn
 onIDSsee9VYMp5SbOAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX7x/feff+l3hE
 WIfGEGXOA7OWE+xenqo0dZdpwr2EuuCG5WmDDu7kscIZXADaApWy84o/2E2BRXRuzOxRjpIdsjM
 sCwnHX7Yyi+R4zuA8j/AKH6yir0n444=
X-Proofpoint-GUID: qBthAJ4waltPmOFvHseu2ov-wBK0sRZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220093

Replace manual and error-prone iteration over entries of a GDS {sub}vector
with sclp_gds_for_each() which deals with erroneous entries in GDS
{sub}vectors more safely.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
---
 drivers/s390/char/sclp_tty.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 0a92d08830e7..95ab3b090081 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -418,38 +418,32 @@ static void sclp_get_input(struct gds_subvector *sv)
 
 static inline void sclp_eval_selfdeftextmsg(struct gds_subvector *sv)
 {
-	void *end;
-
-	end = (void *) sv + sv->length;
-	for (sv = sv + 1; (void *) sv < end; sv = (void *) sv + sv->length)
+	int n;
+	sclp_gds_for_each(sv, n, sv + 1, (void *)sv + sv->length) {
 		if (sv->key == 0x30)
 			sclp_get_input(sv);
+	}
 }
 
 static inline void sclp_eval_textcmd(struct gds_vector *v)
 {
 	struct gds_subvector *sv;
-	void *end;
-
-	end = (void *) v + v->length;
-	for (sv = (struct gds_subvector *) (v + 1);
-	     (void *) sv < end; sv = (void *) sv + sv->length)
+	int n;
+	sclp_gds_for_each(sv, n, v + 1, (void *)v + v->length) {
 		if (sv->key == GDS_KEY_SELFDEFTEXTMSG)
 			sclp_eval_selfdeftextmsg(sv);
-
+	}
 }
 
 static inline void sclp_eval_cpmsu(struct gds_vector *v)
 {
-	void *end;
-
-	end = (void *) v + v->length;
-	for (v = v + 1; (void *) v < end; v = (void *) v + v->length)
+	int n;
+	sclp_gds_for_each(v, n, v + 1, (void *)v + v->length) {
 		if (v->gds_id == GDS_ID_TEXTCMD)
 			sclp_eval_textcmd(v);
+	}
 }
 
-
 static inline void sclp_eval_mdsmu(struct gds_vector *v)
 {
 	v = sclp_find_gds_vector(v + 1, (void *) v + v->length, GDS_ID_CPMSU);
-- 
2.53.0

