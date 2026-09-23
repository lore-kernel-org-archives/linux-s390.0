Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728845561F
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149216; cv=none; b=caaxcO0Yn1b6yYka3/RelESxlrzUQXzOr7Hw6VdWSGLyCcjKq9g+xW9NekBL+FaPvCkNbVfH0vR64eahh+yIF3m1NEvDL9/+8ZiAM7syvhb4odywIh8eu7NNh9YMzOlOyVwhW6wjrFugvIGftswIYJxYKtTCNh7YaW1PX7c3oCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149216; c=relaxed/simple;
	bh=aU8HjF/L4BhRhMqKgP0FwpOfQt2RHimsEH2uoTnXkCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY2v/JvI2Rmw+VdRhNRrawu58m+Lqt5kIsmC2yzbU6TT+RRJq1B/rofNnZrAH6QwIms1/ffU5gEqNK/doVVhVR5vgZy5Gz3vvy7LmfehhZetGS+NBIiM0R8mw11x5Zinf7Sd4LKL031UXYh8hZh/1qZ/OeV2REP+WH96/NMwM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CRjYWyvy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CRjYWyvy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N78rjH2567411
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W4I5U8UGgmfVHuDND
	2qrQr/M6qB88qGCkOlm80vioN4=; b=CRjYWyvywOxRRD5va28JfJbWWVrxyy7rM
	tH+Y3+mWa3ytEuO6TSQOnLx/kBM/PxZFPrk98W+M6ePgRFjrVPwhhSbV7CIfrMwK
	CgqGkxvtEU+Nbr/TDr+Js3F4ZhNnZ/entdARs64Ufkd0ttNjBV3CIyGwn6ScNMEb
	ZwS82qKGPn5Fok1oDg+4r9KCWxU93tbayn2iUrAyMruMHKCELWUHiBZP0+gJYmNG
	Nwh1GgJF0dVXq/AQGz2V+h5HfrP564u2lXYXMuSbzPk4ESDeRvzZiiun/lWpULlJ
	BHMdM2SeiwQhLodVA8+aNMYuEZd2YOpPNred6wQmpemhf2k43lDWA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hgcm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N7HYVS4052747
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjw9xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N7e7xN52887866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30EFA20040;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB122004F;
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
Subject: [PATCH v7 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
Date: Wed, 23 Sep 2026 09:40:03 +0200
Message-ID: <20260923074006.3962077-3-egorenar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 133TNmJMIn797TyGOFI_jz55Q6gKolSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX2fFPT+y+LWTf
 QDQNvyn/l3Y/gWxWcF4TZAdrlntyMfsrF4f25LAN6SHAp7fILKBA/3GcZjEudro77rD+0geeEMz
 AdIOR0seGS6GojOs8JwAcsoKggmFJLalHmYV0C7tkBXz0wOedRFkC6ZlJl0yA8nx/OeQX/ShXtU
 W4+Y0Um3zMHNt4IloDCx7AuKoif7c4NjEic0hmErtCfqbzLwGt4xFziwC7JyvuTNfELmAAE+840
 ziG+DT951b0y51h4jR0Obv0Vsp7XGcZP+LHu3ZQv39u7bOITcvM2ZiVpJcQ0W318U6oXxuGSSUz
 IDfjWTsAhuVWhLbAyFg+QHXfcTxqQVzKgPcUXnRmhekMDJs1X9u08l8Gl0DyqVeNodVc1CcPmDA
 2AX1w9anhdsj8mnoi6iG4MWlOBUQInyWXbbhtdzlVTfq/DuZ0ogPLBk1P6R83k3DUtkh6tRvRV6
 7n5kSD/0yZGFQOv0TFw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3825d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6L2ITpmw0Ys5tFHv31kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfXyMJSkODofSz0
 3Cz+r2Fr9LZAJcP6r52yCKAvDUw4ic8KD3aSm0hHwLJ+kuDPeuTZi7Nx2DR4ksKwZdE+TGU3jyN
 e3bOyTvV0jfoRU9XYdB+/UGTZbvxCQA=
X-Proofpoint-GUID: 133TNmJMIn797TyGOFI_jz55Q6gKolSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230030

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

