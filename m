Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684542;
	b=NdHe8QTHXylY2poVswkz5nJ6weeVpAAY7O6HUZfGd+8jWm9a1FlDpBtQIv9tvSYQ9PQc
	 q7E7OuEvgnD/XDd/m9mZWkxGhzrCxDRjMZnr81sOXn8hf9sLhcZ+OiRduQUekp6zRW8s0
	 VWmSpt4NjXH0kZLNDZZEhcVfqOF1hDNPhWb8WUY/v/GpK4dJQZ/3xy0u92vz1lOleCmyh
	 eF2ZFvDFQV/miWUZG1yvPAPUJWchU0icaJdPCY+MELDSWWJbslNCitKj6lKTssOrXMzEZ
	 reli2EBAuJ+1ovrtX1KGbUcuc0WYTaP/3XtoLIXhFwV8bfPCIMSvFTSucohdgKxP70w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=//LC2jAST24DAoY98PcaHDYdfcioSyCkECevwBxnKXY=;
	b=dxK2+QOC1yx+/JLMzXUmpwMHcNxzG12/uOS5yd3N21btmUoLKl2bfso7Xb9EJQQH7rgJ
	 yiUaLqtrPt9Ua+MmgRIxduI6qLckuseMU2V6X7U4oq3IQKI3MzrjOQuj8j/wx7YxOlhZ0
	 9c0L7VxOBp2vVEs7/R7okOkgwyk8upCsIkEeGufuNIZsl88MAYEcmV8kPX55MzS8PgH7s
	 2X1anmsIciyvs0PoREW0BYijcIaAfyQTrz+YfIUyQSfsbYPvxBiltgutEin+fZXV02c8A
	 r0vJzfoDzKTUeRZHmCZiK5qfgPyeXIa9Gj0HLsPWcFgNo1V63qPqJYxYzOAAEUss4AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NleRQHH5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D76606A31A;
	Thu, 22 Oct 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NleRQHH5
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEXxq243100;
	Thu, 22 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=//LC2jAST24DAoY98
	PcaHDYdfcioSyCkECevwBxnKXY=; b=NleRQHH5WoSfOrSqph9aJBmrF+xf2PpkV
	0v1cpzHd1oUda9U1A/PS7/F22MJ5I0V8jfJev8WbJEaxDoxmaeO3SkzzODVjXiFC
	+Ec+tsOQv0264AOCrt1JMcrzBsIJukjCeLG1YkaTW4OGzNd3NTmAC77sG14rvXWW
	XRqVTvxmAtM2vCmv3+1LYDQql8i2avPmEttH2LKZYMVN1tp/pu1i5EiPUHb8XbMI
	05c8rLgre5EyHgN195OnyVd2bhoKNK/CMnj1YOFmO2wrc5wfQO03YzRkFHmgHQxj
	xKucsfZZe0aHYdXKA9SiBfIEd3yDBEszDR69ptPFovdV3VxtvboyA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5901kh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJrvv619351;
	Thu, 22 Oct 2026 15:55:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x0ubs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtWWG35651996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9C72004D;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8BE2004B;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 06/10] KVM: s390: Rework some helper functions
Date: Thu, 22 Oct 2026 17:55:27 +0200
Message-ID: <20261022155531.204593-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: F9irNmK2kXD7PojDD3D9FioTnQaBWWvC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX7LgLXJ7iN0em
 cX4WhIZHX50i/DnhZ0WI7ltQCVma7B3OFqzS0kP/u6U/Yja9E7oazOPePqveigPten1pMCZgHBx
 dsvj7uEcKEJ0j8ELsNIni8xkJdlsJos=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX34j416Xo7NHT
 degeTQDNtnFbNYltraqzW/fK8hbGA8Hb/5JvhGUHmr9K2+H4H+V5cTUCNWvMKanPBkAWZkBJLv1
 nkwkzMMlPedFxkwjG5CC5hT0RY9ign0NLym1u6n+3NHlJTe+NHLdAS1jVyicm26UzzJF3oXLWLv
 ZqizEXFhaa+2J88y6dykizXspGslCDY3l4KcrQqkrdR+ysuYdFEr5EfoqzCTfy4JO9lTTMLHbmF
 EgywyexJOpuzL/HjltQ5WmKesm8KgML7rYp31xHZNNOP+9FW9VmjRrIpVF+yClHlS7KK0EcdPyz
 OBT2+CqGgiWoCVmaGpw2GzI6rDnbnOpxbcf58qABppqz2TQCXI+pVim+ergC5xkY2u2DS8ahlXh
 x9+8nZHvBnVrA/olOm5QtZXzBfdRtOKV8fwFaO/dlUvutBu9pJcUC3q+bfWWpdlM/deOvTpRto+
 OXYvyXkvAVVRKTHgCzg==
X-Proofpoint-ORIG-GUID: F9irNmK2kXD7PojDD3D9FioTnQaBWWvC
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ada31fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZG6AEE5d4vmO0EujH08A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220062

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

