Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F43DB322;
	Mon,  1 Jun 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327817; cv=none; b=rEVhzhCoovKlLgLKq/lgBD+NXF35yLF4n/2sIkuTi2ifiRQAA9fYh+YUYasedxl2lbacpOyYCqGGA+cXuInrPr8motrdErySmoLLgFa6jh8wRIsS5O1WAN4DxmFGm1n6MHrD5ItBtvlXldn9IMOu0XSZEb82/Omgj3mxo04QRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327817; c=relaxed/simple;
	bh=rxEq+p7FKrkLf08DNMOVsPgtR8katGipcUDE50aUb6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBt4LlgZw8ZtvkIkjDL5br4LsRw+o9H2XpAmai6AvrM8MM8XvIDcAkpgJ2oRIFdVCPQGirUesEHb/TtcBTt5cqT/n2PgvF2UOonQ6QDqFOPdRHd4hNqMbOZIaoZKG4UiigyamPOz8FogSPEGrOP3rSO1g0jxKpVVFgiLtcVImJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O3bJCtF0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3bJCtF0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FAHAi2665699;
	Mon, 1 Jun 2026 15:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f/WU64V7khT8NQeX/
	zbiYQ9Mor4o7IeReycbOeZvsm0=; b=O3bJCtF0EKupOP4LAMbZpr9M0jK03I19D
	7w+n3ZbINfDfXBkEa90QuaMZPnGHZ6FNVt88OHDrlsMqp8sKNXlIbz9zd6VredSO
	M2VHrksOMVy5YE4Zk4A5RrW05CQDYfWg34J4q3dOmRjAZ11i+3KnrkzwzLdMmt7l
	t4Ps/agPranPEvoHSnRqBwt8FctUxP2Xg31iNWM+HQkI5AUwX8ekzfdjSJZ/7gk8
	tYrBccK/+1mV97DKuaYb79hf0mW9J8JOXz5EoOUano8Lp3NOygbrvSgBRVqBXqWD
	/1VQoZceRdYl6+7da3xa60nISgfF+Ds8O0gagsszrd3ePIinz09yA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht12yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FOAb3022904;
	Mon, 1 Jun 2026 15:29:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jxs6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTrU351511672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0358820040;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8BF2004F;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 5/8] KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
Date: Mon,  1 Jun 2026 17:29:48 +0200
Message-ID: <20260601152951.196859-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601152951.196859-1-imbrenda@linux.ibm.com>
References: <20260601152951.196859-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wn4psKQsEhtDDOZFslUo-5QDdbVgJyY_
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1da577 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=sChW5zZnIGAfqb-v-YwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfX7J+zis+A/ZYJ
 S09rgoByHzShqTL5eZqyIc9oO+PKGx659Zq/o+vy757lQpfGKfgI1/wfQf0w6JrYu7cO207aR6m
 EEPGcR6SqGhyl4ckeypVEoWapzDrWFeoL/esQElF9JDgesF8lZXzsDCi2ndoufuamJApMpDP1Qf
 qShTeNkvklYBFLvoUWjP6XSx89Ar0+vloFa4EhyMfekKCcPFDlQoQlQGv1iYQJmS8bmd04COygO
 CuukZ++sBfUHRBGMR5QY5H5AJ0KsABghHd+Ur/vyg39mjR2w8QgxTbVRild+obBKYPzy7yLUjMa
 O2Zcr+VVubyuMv73iJUVJmMY5SXukRqd6gmyeRyGYOu0BG0O5kZ1Ha0bpK+WO9FcUy17LPPyc1l
 tzD9ZdoB4GBXNPr2bc4ruCRpBGxHSJIpcvj21V5rzgl2Mxc2nrwNz0/ffzsL52hI7hxTdUxA/lq
 Cu1VQshMlX7rPV1iQ0A==
X-Proofpoint-ORIG-GUID: wn4psKQsEhtDDOZFslUo-5QDdbVgJyY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

Fix _do_shadow_crste() to also apply a mask on the reverse address, to
prevent spurious entries from being created, like already done in
gmap_protect_rmap().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4f8d5592c9a9..20e28b183c1a 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1466,15 +1466,17 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 			    struct guest_fault *f, bool p)
 {
 	union crste newcrste, oldcrste;
-	gfn_t gfn;
+	unsigned long mask;
+	gfn_t r_gfn;
 	int rc;
 
 	lockdep_assert_held(&sg->kvm->mmu_lock);
 	lockdep_assert_held(&sg->parent->children_lock);
 
-	gfn = f->gfn & (is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK);
+	mask = is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK;
+	r_gfn = gpa_to_gfn(raddr) & mask;
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
-		rc = gmap_insert_rmap(sg, gfn, gpa_to_gfn(raddr), host->h.tt);
+		rc = gmap_insert_rmap(sg, f->gfn & mask, r_gfn, host->h.tt);
 	if (rc)
 		return rc;
 
@@ -1497,8 +1499,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		return -EAGAIN;
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-	gfn = gpa_to_gfn(raddr);
-	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn, sg->asce))
+	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, r_gfn, sg->asce))
 		;
 	return 0;
 }
-- 
2.54.0

