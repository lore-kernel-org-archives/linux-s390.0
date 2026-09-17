Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21644236C
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628314; cv=none; b=BugnuiPk6iiprIvKQUfmNSoIEW0gIZLb4NOpI4CYp19Tbo84DD+4T4+YgBa/9OoTAaxbJ5fAvNQ4VBvOAjG2Y9bFd0/ZZp8PPyxHVFhlN/RCMGTh4JY8iFeyQ2OoqQPW8XzN82y5GeAVvvHDaPdkzBQ6V4x9JRamd3z3BvdT+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628314; c=relaxed/simple;
	bh=d3gS7EP3Iuc0PwsolSsi6tWPlkMRzyKZyd9wLjhjlnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjp2EaBVwtB9Ow45wwZZkBkh6btBJ5YDHDjqG4dle/Q6ATF6hM8X1QivUUzvQvpWpv+HupwriyxO+ctSqo+uwcf5ybiJ/+MKv9UEsH5Y/tOpJ8kcFLwVAjZ2nOeVCQNAKlsjXtzNFaleNIRJJuUBunXct4OuowA4j1pObbkuZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tudFNxw2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tudFNxw2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62N3E1743914
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+UbJ1y6A7Qe8uB7Gh
	kOzkvoJRd6wtqvbf6NDxlZpceI=; b=tudFNxw2945I43uOo96yjFxg23qkdRdK/
	AarQ3mOWk43xqxDW0l1sShHesvzyNzxUZiKiTTrHzvR1sVVNQdmJSUqRwibpjhiL
	MbxBcn0j3RMXxB/qCZktXEeJ8mUpx8j8/6wvl3r51+jotg0F2T6ZhQbW9Je7GAFs
	vcJLP9td4LvqUhfrxmtMLJY7DIhCSy39wa9Z51eecirhwumKKr2wKw7nm1xlGxyj
	jHzG8lsYEPMgxMSyBWPYM+VisIYFWUSIsIJm0IZggQ9err+FNlpDBxHiDgUkrC+F
	R8CUmhjTpMRO2FaaT1o3FuChr9rI2ENnGxuElHSg2JJ1poVEp1Y2w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv8ceq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H6539l3619000
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gegst3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H6wOZH30146948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 06:58:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D7620040;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA6E2004B;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 1/4] s390/sclp: Introduce macro sclp_gds_for_each()
Date: Thu, 17 Sep 2026 08:58:21 +0200
Message-ID: <20260917065824.2858737-2-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917065824.2858737-1-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfXz0GLcu/aQqvN
 QW9DLeZ/h2XFC5VSO5aKRZwp1SI0DH3Tk9s7WpxIydMNr97wBh0CIvMgBXkO3TFOz9AhGZE1bA4
 jlORHZWUDeSqywaWX3/OUIRsm7PFKLo=
X-Proofpoint-ORIG-GUID: upADFWoAZSkDGruChn-t_u7QqrToLAu9
X-Proofpoint-GUID: upADFWoAZSkDGruChn-t_u7QqrToLAu9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfX/Hz1sgPU9CSv
 UXw8r6amoBQ6oLEmWWU5Xb2zwT2Eo/pxmOSbbdnNuu3X0hcIo38pJI+1xTuFpNnp5duHAaJIewZ
 l2IHYT//RTvUaZK4zkPu9tPw+XRSrY8i7tGRdoSCDMhKx9jcIoGR3QcYgqDiiOr6av+UIO+pKMU
 g3eX/qH04+JG1Ej8+LutZASZ+ngwEjm11qs7WEpbhUM5Hw7X6oh6F5hBsl4bM9piVIjMNRS+6EW
 pq+Fn4pvL2f9EGWgC8++WM1qkx1STCf1mSwCjcfcd8APiEd88GIDoX1D2Un5Ed4W/osRwdyRFt7
 oTwMQWEF41SjVJ2krqXsoJovujcs58S7vF/ZJ7ibzkEUgEMKgNetwqfmDg1QDyvnIWkx7TVz6As
 BTkMzGidRIJIz2Qe3hY7GV1wqzApczIh/oZzRwDEV2ADCMouw1BaQzsY1OZjDLR0UayA2KJMxEF
 vqH+dIh6M6Y/PBfjcZw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab8f96 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=F2fggvlhTXQ8_NH1qZ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170086

sclp_find_gds_{sub}vector() does not deal well with malformed event buffers
consisting of GDS {sub}vectors. This can result in an infinite loop or
an out-of-bounds memory read. Therefore, abort with NULL if
* the next GDS header would exceed the given end boundary
* the length in a GDS header contains an invalid value.
  A valid length value in a GDS header should be at least as large
  as the size of the corresponding GDS header (2 or 4 bytes)
  but also not lead to exceeding the given end boundary.

Use the new macro in sclp_find_gds_{sub}vector() to iterates over entries
of a GDS {sub}vector in a safe manner bailing out on the first invalid
entry.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
---
 drivers/s390/char/sclp.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index b31a680e0871..d22003b769f1 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -360,25 +360,33 @@ sclp_ascebc_str(char *str, int nr)
 	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
 }
 
-static inline struct gds_vector *
-sclp_find_gds_vector(void *start, void *end, u16 id)
+/* Loop over all GDS {sub}vectors in a safe manner. */
+#define sclp_gds_for_each(v, n, start, end)	\
+	for ((n) = (end) - (start), (v) = (start);	\
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
+							   void *end, u8 key)
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

