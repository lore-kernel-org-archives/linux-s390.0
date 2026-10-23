Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770944;
	b=pMJ46DTXQkSUKxeJmGLVwqiceFXcbrODZLNo7Kj2nWzmjKKyqPuktnCcThkG19oV9miR
	 +leFubhbq1ca0AH7y47+4WGBlWV1mGFgeEqnpyzsB6oSCfh2Pgl2Xt8RMeOBhsA00tzwM
	 AZB9n8oR6QOZwY/LA/0BT8e9RIEesGX76+cQsJXVXePebuskbTts5mlylbfqX7h9LAyRe
	 pNAkLmR38dqUF4TxgoHHR80EICU6wc8z6UfUE04Qt8dgRUwISISFq3hHwEsk5hHeW83ls
	 FDLLvA3+lAop09Rk+Q1twLTiVy1zJfFZ+jfiJ18o0hRD7s4vPjXWRaNxstNu9/2yIjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=//LC2jAST24DAoY98PcaHDYdfcioSyCkECevwBxnKXY=;
	b=B4S/vKmlwPeXNd84/7JtYJkQRXTuQ2btEW5LOKx7gMG1NCDiCOZbTdhIyjqKB7E6DNQW
	 goUREtB8CcWlWVq4sAh5hgRC9Vyh5PJZXTv4r6kKeFhvNuVjxIezUFB7gZUy6t78jWed4
	 fU8B3/Wj3LP9h0QcSH6/pAHojH3hGfgz1ow5P9QWUbfGokJLR1EjdDcn8HAjm0zFnkcDE
	 DmLPkNedzJpOv9xJWEQ6xsoNn4Y/kdDEthHV6ZwQJPOumWNJAo0kGHZANOP9S399KIFIR
	 sx6thk965swtonIDLMZgjO+t4uegN/z5QrqmVCcqiHeweKmJvv0pQq09O1Rrnjg1Tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m7E9Ujjv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1E60A2609;
	Fri, 23 Oct 2026 15:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F1E60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m7E9Ujjv
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEE1Xa3182526;
	Fri, 23 Oct 2026 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=//LC2jAST24DAoY98
	PcaHDYdfcioSyCkECevwBxnKXY=; b=m7E9UjjvLeBZAvGbKQBSS3fglqyMOILaP
	0z+uw/7EDrfEo3UaSZF7EhQkpFF3ROhE4ftUP3SgyohTvuHwP/j8SQzLQBvXLsF8
	CeNdhTe27jdiqigTwQY+SaGsbau+PM5mGSCC9JKSLE7QLXNkXafdHx5qI3TjiFvO
	RLMgfsAs56u4XkfOqRQoHOySVMxnOu0Dh6i1i0gnhUU5Zqxk/OrnxVN/OmtwhjGe
	IHDyzpZ61WywSQs19OuOhCXR35eRAgXl1rnfNlcU8WGBA/BkjPPkeycr+5Lm18P1
	Hyk5V22xYi255+EMOmAZRuQbqA/Pf2USVJOU+4azRnMAB/wKk1NKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5ap3hc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE65Bc2260517;
	Fri, 23 Oct 2026 15:55:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn585v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtXSA48955822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E81E42004B;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7C0320043;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 06/10] KVM: s390: Rework some helper functions
Date: Fri, 23 Oct 2026 17:55:27 +0200
Message-ID: <20261023155531.206113-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023155531.206113-1-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX0T9+JJPKpYk1
 YBdJ5QyoMTe0988SJnpvyDXZJgUcW8mWLeZgJUxTdaTcmpr1a4NZ64RmzX+6sgjzaaPN42kKdpB
 rqoFXncYs72eCxhgt6naThOsw6y3zTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX6a4esIIRv9Wu
 lm+LaBm3Xzmr4eZltoh5P1DGnM2kLrT5C9fHXdwxZ8lvyzD61ygW+LbWEwq5fEfnDinQcgg3IHx
 Z7q+b5xIbTARBdcCx03GJjKB+TDtFEMxcQebASDIv+QP2yTodKF56t+9g3SyJcGxnWVt0Mta49E
 Necf4yZXi94voR8PCjAwp52fVIFAmivJnG7jVlWEP/GpjKVCzd+EYlSRfTbGTNw4dxOasgzdUcG
 8TDXaJfccOkPvbofOdJqAvKk0ueEWDaq4H+EWG9y/+DCyXdvRHBZxUr9HzVFgw83A8vhH4jmRrf
 jqY0UIvDedQmo575NU8DHoUXQIKk2K3OMl+hhNzLwSVXfo/adcdSqGnDhacPnoudtdiigjJrv67
 DLNYDlET9KaKhKJH9USKlQnKXhxrdLYlyg0WWeqKNZFTaxp99UytBqcavLcDOnXPOTvYgmSLnRm
 DAn4JCyTKo+17OXcRDA==
X-Proofpoint-GUID: d0vl0nf8ykNqjI6tSKUU1srJGtJKxXFg
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb837c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZG6AEE5d4vmO0EujH08A:9
X-Proofpoint-ORIG-GUID: d0vl0nf8ykNqjI6tSKUU1srJGtJKxXFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230061

Introduce export_on_unmap() to make the code more readable

Move the #ifdef inside is_ucontrol(), make kvm_is_ucontrol() into a
wrapper around is_ucontrol(). This way the compiler can remove more
code when CONFIG_KVM_S390_UCONTROL is disabled.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 2 +-
 arch/s390/kvm/gmap/gmap.h | 9 +++++++++
 arch/s390/kvm/s390/s390.h | 6 +-----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index cb8f247cff60..c23da6fad92a 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -414,7 +414,7 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 	if (!old.h.fc)
 		return 0;
 
-	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
+	if (old.s.fc1.pr && export_on_unmap(priv->gmap))
 		folio = phys_to_folio(crste_origin_large(old));
 	/*
 	 * No races should happen because kvm->mmu_lock is held in write mode,
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index c40a49b30618..6824507706ed 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -123,7 +123,16 @@ static inline bool pfault_enabled(struct gmap *gmap)
 
 static inline bool is_ucontrol(struct gmap *gmap)
 {
+#ifdef CONFIG_KVM_S390_UCONTROL
 	return test_bit(GMAP_FLAG_IS_UCONTROL, &gmap->flags);
+#else
+	return 0;
+#endif
+}
+
+static inline bool export_on_unmap(struct gmap *gmap)
+{
+	return test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &gmap->flags);
 }
 
 static inline bool is_shadow(struct gmap *gmap)
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index aa0d1d062f8d..daf3b0d004a4 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -115,11 +115,7 @@ static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
 
 static inline int kvm_is_ucontrol(struct kvm *kvm)
 {
-#ifdef CONFIG_KVM_S390_UCONTROL
-	return test_bit(GMAP_FLAG_IS_UCONTROL, &kvm->arch.gmap->flags);
-#else
-	return 0;
-#endif
+	return is_ucontrol(kvm->arch.gmap);
 }
 
 #define GUEST_PREFIX_SHIFT 12
-- 
2.56.0

