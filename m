Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791879;
	b=XyuXasMp0N5XdswepvlfZBpJgmF+hCDtZjx5yW8xmmGQUFYv7mY5dA4Gz7995o+Q7XB6
	 Oyw8bCjE/lK9qozFn9gjSqcMJ8GF9iJDxJ/ebGyx0llMiau1H4tO5FA7onIywx3XgiBOy
	 0oV+NYlnQMXVXx8g6qaydSrhiJtKFBmCxRfOsQ8yxJF66p3AEu5Erojn0LabLIyARRqTX
	 TfyIxeiIm/pA8k8wIeuNJ5OUmn1tmm2+CMwtJj8XaVHgIzGPEQXMjdbNMzRZ/AlrpwMXy
	 z+MsAvYG0uDtagF5mdiHNe33PZfR4jk/k0L2J1bEA/jNTV3ED4TO0J09TuQew5y3KHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791879;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bd5GgLcukPt7JDj7GXXqwNiHkq05qBKYcD/JTMe5UZI=;
	b=yF+l8+5T9MGfZy7q4L8Za2YHMXBl/hdgvUH53relnPzY01ikx0XiTTvrH/MgPMtNjii1
	 8Nl5bME+fst3/LLshbYB8TMTvlDsjcKIj9DJSvgqeGfOiJcgfr5PVolxv7Km0WMCOLVFT
	 rkTUKumKZa7GSBCcBqb3mUKDmqDN+cZoaeQcHMZK7cjJ4p3/6DbhiU7oSxYzd6SOhI+sq
	 6QiSLWfqY4QceJGgcoUsFHPuRJPwjJ4LWzzq/B6MV/QU1br1xCISPdZQK+jgFiGDtnqWo
	 Wgly5KOEBfaUQlf3/c5DD293njIRNjoyMIzZijw+ElnTDXuc6W2Zobx6C/3/5ghkI+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A1wbXJYb;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D5606A32E;
	Fri, 27 Nov 2026 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C42D5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A1wbXJYb
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4kGS3266156;
	Fri, 27 Nov 2026 15:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bd5GgLcukPt7JDj7G
	XXqwNiHkq05qBKYcD/JTMe5UZI=; b=A1wbXJYbGNZjVdJDi2+CJ9uoFZRMckm/K
	JrULifSXzeanot7PxEuKgWX5aAhy1wz9rvzWfkrXF+P8KtpVb/r74vCVhv6h3hoA
	vooA69XrIFBjasSh3igy4u+/bFKaB0iSCP71bvz298zZk5LNYnXmBIdN5Jf+lXyj
	rYmrg5CNZMkldg6c19hgiCRYZOgdlTwaGmNdYDsnprASB2L4q3ANprkl2eKESS4I
	X8TGulRXXVUm/xkTmk7qlgh/dbJMFjisAdACwWQDvf5zJIUGne3pwzx7NPBmS6NB
	5vkoOFRonRXSP1gnBl9HZdCX3VqsJnFxUw7rAGf8QTwqPNkEDvhbQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkxbax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4HLj2819259;
	Fri, 27 Nov 2026 15:04:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaanmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4JL239518636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993392004B;
	Fri, 27 Nov 2026 15:04:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A61582005A;
	Fri, 27 Nov 2026 15:04:18 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:18 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 06/12] KVM: s390: Fix soft-dirty handling in _gmap_link()
Date: Fri, 27 Nov 2026 16:04:05 +0100
Message-ID: <20261127150411.221072-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3Lx9Euneltra
 fM1xEopMi6XK7tiyECqsjw1G4UZBYrkCaVAaPeLYDynuYOS1PDgIKebF3fm6EcF8ngqbGqzLu8U
 jy3XmI0VAINwchU4lBpwTWCi9AXsEW9+HJ9y+JpAVrKqjks2xqIy39rSRfAYGNjYa4S9Vk69X8W
 MWhFlKgKpilWDiCkhDtm0Ad1pnMRtxquISwZ/96TCiN4rDi5u7HclHq08GvdZGCJ2+WDyo5oGTR
 jTQMYKB5BPJ4+JFhKtUmZ2vlcS4S3l5+OZfMqT2+bPn2kcDpCToyhKT++vA82j/EgltWL3lT0sV
 rilwELsgTdNSjWafs8Zl19fr2pfPQXqXBX/wbWICDVIBSKOXnH5wRxKWxPXMTBRFnFxQZRu2B+F
 ykwcgHwK2JOWsl9wqJS3Vf1dJaCUL/zfd2abFt0n9bofi5oztDHRJqitXHcSNioKQlbX5bvrAv7
 RbsEw1QxjR4mpwETLvA==
X-Proofpoint-ORIG-GUID: tpJCJWTZYYoGkAlOFgpfqkOq4NnEC5Ab
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX+NlP9CqkT1gm
 uvpWgMUQM3aFbRk91UVKC0er7mubSprXEc519RnDmqItNiGHHkpEVimL77BYrmb04PYe48+pBAY
 pOyWlHHaWKUgL1hODcZnbnMTfMINUlo=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b099bf9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=o6lQO03veSDV3w01_vIA:9
X-Proofpoint-GUID: tpJCJWTZYYoGkAlOFgpfqkOq4NnEC5Ab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

When resolving a fault in the slow path, via _gmap_link(), the
soft-dirty bit of the old entry is used for the new entry, overwriting
whatever value it had.

If the new entry would have set the soft-dirty bit, it is overwritten
with the old value, potentially losing the soft-dirty status.

Fix by ORing the soft-dirty bit in the new entries with the old one. This
way a soft-dirty entry stays soft-dirty, but a previously clean page
can become soft-dirty.

Also fix improper check of the old crste. Use crste_none() instead of
the improper open coded comparison to _CRSTE_EMPTY(oldval.h.tt).

Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Fixes: 45921d0212d4 ("KVM: s390: Fix gmap_link()")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index c7af1ad9f7c1..31669a5c51cc 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -825,7 +825,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 		pgste = pgste_get_lock(f->ptep);
 		oldpte = *f->ptep;
 		newpte = _pte(f->pfn, f->writable, f->write_attempt | oldpte.s.d, !f->page);
-		newpte.s.sd = oldpte.s.sd;
+		newpte.s.sd |= oldpte.s.sd;
 		oldpte.s.sd = 0;
 		if (oldpte.val == _PTE_EMPTY.val || oldpte.h.pfra == f->pfn) {
 			pgste = gmap_ptep_xchg(gmap, f->ptep, newpte, pgste, f->gfn);
@@ -841,8 +841,8 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 			newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
 					    f->write_attempt | oldval.s.fc1.d);
 			newval.s.fc1.s = !f->page;
-			newval.s.fc1.sd = oldval.s.fc1.sd;
-			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
+			newval.s.fc1.sd |= oldval.s.fc1.sd;
+			if (!crste_none(oldval) &&
 			    crste_origin_large(oldval) != crste_origin_large(newval))
 				return -EAGAIN;
 			f->crste_region3 = is_pud(newval);
-- 
2.56.1

