Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC53CF02B;
	Thu, 28 May 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968859; cv=none; b=WzscG3+J/bYxDqcAH1c3w9VLiil+WXaYWK7WW0nq7bdgLToPLXgVJnsZ+Ovx4UerEnAHoHbzQ7ytOXR04Ft+ZIA5T6EYhXPkmkIQZl/ukyKSf8C/FVWhkGWCSCMP0dhkXWyrjy9EE/aKbd5u44b9SNhKcTaaQsQmgviIuZBW1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968859; c=relaxed/simple;
	bh=rxEq+p7FKrkLf08DNMOVsPgtR8katGipcUDE50aUb6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDbbg5TYq+SkB+LdEsmH69XRePZSgV+WECT7iUDc/0xD86eN3SU28FR/LoMkHRiAwJC3MBjRL6XkQq/lFF8c/ZC4TdbM3YNHWs8PJRrff6khAe9DGP46NBj0Zzi0aW+360tY+AuSwZtV4QbEEugQO6gN27CsYHL1vCVo+pnnb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buyem44E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buyem44E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL6Wcs2692459;
	Thu, 28 May 2026 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f/WU64V7khT8NQeX/
	zbiYQ9Mor4o7IeReycbOeZvsm0=; b=buyem44EnJ/nhOAzlKmFOqPrercNCVVus
	AsPUFkQL+DrVDXQ7NHjO9GJ26QgngqlfSs9HLSTd1jJAou0PBSSnBa4TBgxWwwdO
	jMZE0OLVeVsVTLusQJFlIRt/q+80cu/NYdc1+KDCn4e8goC/6Q5MC++CQwhM1KAG
	impJQdDjfqlYdPSevguWISXzAiuxVQNiAUwgDLDHU6CtZSgccbtMtMb1xHm8lulv
	DfbHmz4cnYWBXDcsAnZG0Jt0Hj0QezRliBzJ+wIYxwa9LwYQ2fJk20pdzeYPolIO
	4Z1DpV0cf4P8UydpXV8ZoHsDb7cSuk29YsbdOqajI+f6UnSi3L9mw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884asvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBdGeb004692;
	Thu, 28 May 2026 11:47:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbyv69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlT3i51118568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D3820040;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D48362004B;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 3/7] KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
Date: Thu, 28 May 2026 13:47:23 +0200
Message-ID: <20260528114727.142178-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a182b58 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sChW5zZnIGAfqb-v-YwA:9
X-Proofpoint-ORIG-GUID: yTRE5Hz6yYSb9-LuRjefkmDBKWiIusyM
X-Proofpoint-GUID: yTRE5Hz6yYSb9-LuRjefkmDBKWiIusyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfXx2/qG0SVRPaN
 JEf/zTeHQceFIk19vIeVYyZcmeqEK2nMNxDubOU2C7ZLkhi8ACF9/Fz3dDXDbNBynv4bWROKU2i
 BGyolW+Jlq3brvAsRBNkHtsoW2qQyExiAcLbt2yDWxIXBv7CFJhKCEzzhdlttcd0rnXJvF5lXjq
 xepMh43PMNnSxxvcc3zm/ILHDB1VpcWY3/rUig2wNUvdmQrYUwgsrv2x2COFDb1ENsS05XBo4zJ
 wzRwxlM7L4qhxXA3FoDN4qGVeoV1z9OcybkuQQoKwI77xIsWbTrgR4SVPnSHzNSk7rLCrPKB3JQ
 gUdrgmO4+35qOIircsxSA7GxIhdl1Rb1LO74UvP0JDc64h8jpZzY1Yzoa8fnM7BorPkVAxbxoPD
 wCPehh3fR9Dw9r0xOW+lTtl3k7Pi3LjAG4XyRzvxhLbWSRrcRcYW13c9laI7IebNpMiyTkig8Hk
 ocWANyq4EybelhJnHDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280117

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

