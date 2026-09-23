Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051D455603
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149216; cv=none; b=sX1TIsXGPZh/CogW4uTFs5La8ATLuhfTR/g2mRnfio1Fof8jqmsH/N4jCpVC4QnbNiO+OsvEVbf/G8JAttWUXzZteURI2p8IOPh9rguw23ug6cyegkSnWv7V0TRfFMLwYhXeOHvNyRD2haUKdvyp+nGckuNfz1aH9MPBCoQ3M1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149216; c=relaxed/simple;
	bh=sVAfLfsywL1cQQ1m4Esm+XL2AEgotHqfaYDTj9F+jx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXa/IzodEkCfqJL+KnOvm5Etx6So/xduJJSN7lKPjkIeLfx48SorZo2PIJ4+3E1wXGsLLuciN406JFlCh3NjHMTMVY/2OJSmIJAncGD+lNDUNeXiYPOmrJRbFqgq+5RRzUNY94TImlffZvkYwL0sNiHrhlZ/EyL7glVGyaPF4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CML8k+Ub; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CML8k+Ub"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N78FWK2566484
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pDRWEoko6kBZq5XiF
	IEh9oKpkcnW1/SN+1p3Ok3UL2I=; b=CML8k+UbVrhbf3R52R1xNcMsZtjbqpu5x
	v54+fPMRsasU6YEejHFbdSFlrFfPAFvKqaiK/6bwc/MRw3ZmyINe88woqc4BHJED
	QW3aQW1c8tYzBhZcToKqEZL7cBVNqGvyRexfeHHK5DaW9yhhe/Y9mmIwAPX0VrrP
	ViRmhGFc+pipiVtostfTvHPg0+mM2YIVL0AOIEc1OIKkUq94yepQgAnRpZDSv3uR
	V8At1eRFtpHVoIlXJaTqOvJjNSml5Pl783Z/nLNRv3BWFjTRCbhrq2+X/c0Lz5SI
	qOzB7g6ZBeG2YyqRdZaSgE96MwxgCHtH1w0F8WoqGwUR0/hDAZsrw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hgck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N7HU1o839894
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyd24u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N7e7U552429234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56FFD2004D;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35A5E2004B;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v7 3/5] s390/sclp_tty: Make use of sclp_gds_for_each()
Date: Wed, 23 Sep 2026 09:40:04 +0200
Message-ID: <20260923074006.3962077-4-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074006.3962077-1-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Kq3tAFZB_q3ug0Wn2s-y0VSKUby6EbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX9hS3I3AhC9KV
 VBufYKetLB2yNh/+hIxbQ3FOMi5IfPTFU08THofW2QvCioERcXazAj9nO+jUJD2mx/oT1wU9j4n
 Nzwx0lvfyHQsOlYk0K7j79W9JbeazRQeNLSvTkOUhlJCrIHtIVYX5QQmzmoAn5RCWF44BgwVlG9
 eDGT/vnsMltb1f71u5Ew2j1YviQHa/xyF2ANDSZVlOg12u0Ou/GANDLsVkAqFSm/leYq2LsfYH+
 NMl2FCAmJ40uTrkM4GlWYmXWIReSSkAV9wFZ+Nih2NmNuONQaO02ZvQjf5qr8t4r40xqSxTXLqQ
 XG7lkiTEwpf5Msx9RBMfZFz5Q+2y5HbnVzVdjIFPvmR8QUnrJJ+/kuKeASJXJHRqxS7R4Jeq6wK
 JlLldPqOHJHatWkjCYpNB62UcOY430qh3QngLBT5MYY1pUjWlUCyzPzhiozBsz+WemTcamduBOc
 k3O6auIjRQFub9iHHqA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3825c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Rw-E5omhhRtl92cmDEAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX71qOnpFd42/p
 ZXKJT6tXx4LNPYqDcaPmKts9nHcHw7lehGpleVReHT3yFOGiVuNXE88t4B/tR/4Vbjcub4QlJmO
 MVV14FV9ciaC/JfqsZRV1GHgUd4ZhNc=
X-Proofpoint-GUID: 6Kq3tAFZB_q3ug0Wn2s-y0VSKUby6EbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230030

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

