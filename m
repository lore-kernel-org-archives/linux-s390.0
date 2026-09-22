Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037625B0BE
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059391; cv=none; b=IoX3H1fneo83qUcu2is0z71C0r5AIc0TttWsdVfs0T0Wz3HczAO1ftD5zzd5Ss+txU0S6h7vIpFL5iQZ/rLCSZkDyDnlWgpYz+uI3juHzF93Y06inNi3XPyy2DVBqRBcj5Am/ICsztYfatvrKpJLk6Q0Vj5zH3Vfy/t+Ixc2I/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059391; c=relaxed/simple;
	bh=aU8HjF/L4BhRhMqKgP0FwpOfQt2RHimsEH2uoTnXkCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEdKpuHshZRYFwRN42+B3snv8ap/1xLxY1GvmDVX9CpeCK3Q6/tTuqPM6Oe7CRl6xuorJXzQpvhFeOaUadjgwCVpO8uRTJ/vZkuyZGhLpfPWGsc3QlpSK45YgTEpwqTwnwW0j1Vcx/wQzqCc9rjvq+MdvYGJBT+rzGGDqlfk8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G+OWHFiE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G+OWHFiE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05WGE2980329
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W4I5U8UGgmfVHuDND
	2qrQr/M6qB88qGCkOlm80vioN4=; b=G+OWHFiE6tJoWgiG9huPA6MoQd2QX6Yoj
	8GT2r1xjvmkZCBdPgzQ+hbFksyCw3wfKvi+wlNcaHTmhJpQBDDc8HRrogFvqL/L5
	+Wcgj1a1vGSGgqOTUfASTQe7+Wdkd85llkKhEpelTZJMNhQrGY14R1+WMAaaC0FT
	O91FyTAGPeapMI6XhAGaVrSJBLJEQOaAj/V84NLBdK+SN2Lw/PWeqt1WoP407upa
	tYM+3PLTwtINQZ42l5LC8JEzuDYdP9tS9yBAgTSYzzbNxFc/heoUd8x+HrHoKBl2
	sFzxXc6Gu/AvEHKn9qjGbsRiLaWCNGsXXDLglwCY70i2Gc/+0F7iA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv43fe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5MVZi2085677
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq8t8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M6h3vG49217794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 06:43:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4A3D2004B;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78DC2004F;
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
Subject: [PATCH v6 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
Date: Tue, 22 Sep 2026 08:43:00 +0200
Message-ID: <20260922064303.524293-3-egorenar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: THChkDee9RPNNuJtLgDf5SfIYrbUt0nq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfXws3oX8zmJdZd
 gUzHQ+7skXVfK+8+KxNMdqQ6uJIef3RHYmJRwCw1o0jKJlHc/sOC05PbFhn0ek+IJNFXFVDVtRI
 H/4n6tITsJqZOjrshdjavKTEtj/vQhU=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2237d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=6L2ITpmw0Ys5tFHv31kA:9
X-Proofpoint-GUID: THChkDee9RPNNuJtLgDf5SfIYrbUt0nq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfXxL72bVY6vJPP
 fFzZ3f1GXqIa3NS5nr1xxEEatFqY6925BAz1HMZl9aW0V/Xp3cQMDSZBgC9taNlJQPgHKXKGikn
 EFZYjsZANvfy5/WgZa15VBAZJrfGqci+3RzGMpC1V+JhaC21geCvxxB0tPWdaNvaKVucl4Jp6w2
 Mljdd41i8u6/D9x1O4DGj6eogBdo3/5IzDHBXAtw29yAIt/RlBEWYn6NdXMpq8/YB8yrnEQS9NO
 q5gRAhPMuSFtkhgcJoydo+tBsI2H9K1jsitOuEUkFn3XqAMkYslSlZTYDFcYUgUjDePxrJFlpZp
 uwPrh7hC+CvmNWXDsi5P/kcSodHQMHbWt1ZJD8qMGu0RlTzf+JTDPVAB+F7v0G0+BEFiaCK8GLs
 wWIHm4AmT3TBtLvR1MGDOGL49HQhK8Rj45DlNqYDwdCccBmRc5LOXG/BaSTqOU8e7q/Xt6tb8Xc
 adO93oBz3WCAySWc4WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220093

sclp_find_gds_{sub}vector() does not deal well with malformed event buffers
consisting of GDS {sub}vectors. This can result in an infinite loop or
an out-of-bounds memory read. Therefore, abort with NULL if
* the next GDS header would exceed the given end boundary
* the length in a GDS header contains an invalid value.
  A valid length value in a GDS header should be at least as large
  as the size of the corresponding GDS header (2 or 4 bytes)
  but also not lead to exceeding the given end boundary.

Use the new macro in sclp_find_gds_{sub}vector() to iterate over entries
of a GDS {sub}vector in a safe manner bailing out on the first invalid
entry.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
---
 drivers/s390/char/sclp.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index b31a680e0871..a006d7abfdf3 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -360,25 +360,33 @@ sclp_ascebc_str(char *str, int nr)
 	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
 }
 
-static inline struct gds_vector *
-sclp_find_gds_vector(void *start, void *end, u16 id)
+/* Loop over all GDS {sub}vectors in a safe manner. */
+#define sclp_gds_for_each(v, n, start, end)	\
+	for ((n) = (void*)(end) - (void*)(start), (v) = (typeof(v))(start);	\
+	     (n) >= sizeof(*(v)) && (v)->length >= sizeof(*(v)) && (v)->length <= (n);	\
+	     (n) -= (v)->length, (v) = (void*)(v) + (v)->length)
+
+static inline struct gds_vector *sclp_find_gds_vector(void *start,
+						      void *end, u16 id)
 {
 	struct gds_vector *v;
-
-	for (v = start; (void *) v < end; v = (void *) v + v->length)
+	int n;
+	sclp_gds_for_each(v, n, start, end) {
 		if (v->gds_id == id)
 			return v;
+	}
 	return NULL;
 }
 
-static inline struct gds_subvector *
-sclp_find_gds_subvector(void *start, void *end, u8 key)
+static inline struct gds_subvector *sclp_find_gds_subvector(void *start,
+							    void *end, u8 key)
 {
 	struct gds_subvector *sv;
-
-	for (sv = start; (void *) sv < end; sv = (void *) sv + sv->length)
+	int n;
+	sclp_gds_for_each(sv, n, start, end) {
 		if (sv->key == key)
 			return sv;
+	}
 	return NULL;
 }
 
-- 
2.53.0

