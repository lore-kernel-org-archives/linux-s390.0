Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213679;
	b=qY1nEUvTKrIXliLbzLMF+IKeWnUk7pNGogEIh6pdtF28qIGpd8JBKS6oMAf4o2z1vyKU
	 o+DvYAIM8bCTuf3F/SYOSXXu2KaRp424S4C7UCcPTgwoM9MPy4qG/dMN9IULlE/gFw4uc
	 ZrCtvsFZPyIZC4vABRsKFb3l493jz3qyYJa6M1VSiW8LUeAMSDLndeZzooWZ0aX0Y+21t
	 0qHOkU1pofZcbbpltQYy7al8S453M+nS6CtlERNYouXj3k0v+je/JgHSdnava3euDkab7
	 Hi20w91n+7a2B2e9k1pPD5quOqzemR7GZcGsDxBc6iK6bbFLwBWIiPYdpB2HWZDhIGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213679;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9YVBTzCoBmFYTK0l2/O6XJkdzc+P4h0u7drIqQo/0r0=;
	b=YhEyK5EPAzJ+cjLx6x2m5xTfuYaqMTDuc2t0BBIxdZrj7Dq3ZIsSI9taY3HALL2o5+Qm
	 0d7Cbh2nSv7zDe7x44d/L8AXNXsS0b4A99Z0oiY3gM2/c+i7n+omlUWwuBnQdo/dOQTrv
	 7XhWq5/FifpLDfA/qzDrEt65qCenCSNBUh/Q8KUWj7k7XOmJrBBlEvIcO81Pzp83Rd9UR
	 WNUrauFi229gX9VENW0ZhBMOSLmjqhgpxf0ISEzx+H78kuLfxOziEQp2MBXsuxA3s/+tS
	 a9t5vrS80bzXD6ajT4iOGuDR0tdJRB/g8HK/AHDO8sena3jkWxwGaJx68i2CdipUmCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eql0p0wC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC64606A32F;
	Wed, 28 Oct 2026 18:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC64606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eql0p0wC
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIiJMZ2234481;
	Wed, 28 Oct 2026 18:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9YVBTzCoBmFYTK0l2
	/O6XJkdzc+P4h0u7drIqQo/0r0=; b=eql0p0wCvLZNus7mzFQzOef80DukGxK1A
	E8ctslYUnG4v5mbX6iB2vTwgUKOav9lR/zj+QelajAurZiMQGfdrF+fgOeabOTj9
	jlagbFnNOxVyRkSVGARN67+xn7xuyGl9rOv0Flj0NU95ctjlIxrAodQplW8i7a4B
	7E5r8hfpnFxF4UAXJHs66Dsz+SAk+wvHedbbRs05ZCpFJPeswHRwcf8QdhGSoZoI
	D/bt/z5G2Q3dh+weU3TEI3qDTqvuXSkuy/rz+Or0OaRsv2lSEbqJ6AvaSaSf5z2F
	H+MUmg7mjqR1sombh8whlpuS/EVYznCP4I90sHYJzO+0srFMpEn2Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm646h6p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYvOC2008293;
	Wed, 28 Oct 2026 18:54:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh8pwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SIsMwh51708188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 18:54:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD98F2004B;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DA7B20043;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v4 2/7] KVM: s390: Move some skey functions to headers
Date: Wed, 28 Oct 2026 19:54:17 +0100
Message-ID: <20261028185422.272146-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028185422.272146-1-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX873H+PBei649
 dnXI4WupB6vXbDQ7GTbT8ttaDMu4G8WA7TWno8gGi+m/WxKCJWEsMqCZJs9G89uyIM8h6gGDYop
 3YA7ynpmxlAe7Sau0tBXcJJwayfNcPs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfXxoFipQU0szTC
 bAghqYXQYX/nGmuJDEv+ZrpZQ55zpxdvtV2ZAhEyqHq8NBen/jFWHirpxPhiMz+WM66b1/mTfy+
 s3KoHgJXrg5FQPPAWg+xf8QscvvgIS0xsIqtdgiRCVsPmckjJDZhOiLgfWOZN5h2M6UB2MZRHoW
 72adfPkapNZPzfFsBk1rJ9leJWsx1pXLLJoIgBGzNqbaQ/X5NG0GtBC3/bwc7/mjDohFeuFoE8G
 zww5Shyi6QfOiO27BBoTPVMn5Pvl6FYtF3TbZLqo0XmrzX57RmXBkZbG4fHqsaGOGB+p4Xe/Nm/
 FypGwQYUun0hpjGboqnyAv81BUpuMMppWVyRtJhp2/2QafgZpnPlYey7fNbE2sKru/LHVe6jsdm
 QxxbZPp0zrJt6HaZos8uNEVQNiHWjBaxfXFex+FXZJi/xT2KB0YnTmP+Gf5OpGiJxxoNJXH0Vvj
 fQDzo2o0IzzWW1OR5Qw==
X-Proofpoint-ORIG-GUID: hZJrnw6ES7efjpuxk1MSp05IlISAqwXm
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae244e5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-GUID: hZJrnw6ES7efjpuxk1MSp05IlISAqwXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280074

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
---
 arch/s390/kvm/gmap/dat.c | 26 --------------------------
 arch/s390/kvm/gmap/dat.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ff80d02c9f56..b9507daaf327 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -159,32 +159,6 @@ bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, u
 	return cspg_crste(crstep, old, new);
 }
 
-static void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
-{
-	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
-
-	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
-}
-
-static void dat_move_storage_key(union pte old, union pte new)
-{
-	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
-}
-
-static union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
-{
-	union skey skey;
-
-	skey.skey = page_get_storage_key(pte_origin(pte));
-
-	pgste.acc = skey.acc;
-	pgste.fp = skey.fp;
-	pgste.gr |= skey.r;
-	pgste.gc |= skey.c;
-
-	return pgste;
-}
-
 union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, gfn_t gfn,
 			    union asce asce, bool uses_skeys)
 {
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 4665c1112bb9..687e1fa904d6 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -1002,4 +1002,30 @@ static inline bool crste_is_ucas(union crste crste)
 	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
 }
 
+static inline void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
+{
+	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
+
+	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
+}
+
+static inline void dat_move_storage_key(union pte old, union pte new)
+{
+	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
+}
+
+static inline union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
+{
+	union skey skey;
+
+	skey.skey = page_get_storage_key(pte_origin(pte));
+
+	pgste.acc = skey.acc;
+	pgste.fp = skey.fp;
+	pgste.gr |= skey.r;
+	pgste.gc |= skey.c;
+
+	return pgste;
+}
+
 #endif /* ARCH_KVM_GMAP_DAT_H */
-- 
2.56.0

