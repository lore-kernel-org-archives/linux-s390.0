Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936683E557F;
	Mon, 15 Jun 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527375; cv=none; b=r10bGkjlzlL5hZ1lOH9h/fdgkW2NMXCZNDuZUHRYo4Lbg4DwP24IJTjY9eY3jjhz3OfCbWomHGNN+9oEzVXz/8a2eqSChRRNTD5MXWksD+xe7lvqnKhjJjyUPu0RNTjSjdh1oGuEtEBs8y+AbJb2obkOQWzT7wSs0AdoaDqMY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527375; c=relaxed/simple;
	bh=PsYqllWnfberHB/5SW5F+vVd7sKL5TcWTl+LDfdlCrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4UhZSh/n37G3NDjVMQuTin1/Kk//zbKKSrY1gxjv3egCS/+hQj0AghggZl7WrFvB7eRrhYIJSPsailW7G68le8BF5fiYFiIR88K3Ubs3JNlHhWW1s1MsjE7u3Uv9+r5tlob+QFoA2njFPJ6ra0+16aasi1bLHXQqz4SYP2a5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAPS73AM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAPS73AM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo0M52208714;
	Mon, 15 Jun 2026 12:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=usOe955sna4HfzTga
	6g5XrsjQW9LZ4agDuivEpbntkI=; b=sAPS73AM9YJ0WfVzgMcd6saMPlBfv13WZ
	OZ6XPQSCu9lTPELfli1qNpxdyGYcsTkEs0pqPk4KkOMBXDmjPG1fpQlLb0DxEQsh
	PbSABY4+XX62UMhuFb+vWg8HyyBMsw8fBfvo5XbDVbgYE+vbbiEABPiw56wTZ41e
	WAY87siKX6TG0QtA+MlZ6Lp35LMz9Q/O9EqVLj3qzxP4W/2/kBmSYWahOzNYNTFo
	bwuLVSGSq/NVSa/VlTmPameIOxkrjbZyt6+2QyKSg2Boa/yLclheLV0Tde0ssYHg
	Y+aXa+H3RKK83GPVtdvpreEUkOtGt9BZQGvvAyboFc0c1D95hCFWw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0g77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYmvq017189;
	Mon, 15 Jun 2026 12:42:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg6cpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgi9c58720716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 675E420040;
	Mon, 15 Jun 2026 12:42:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F31B820067;
	Mon, 15 Jun 2026 12:42:43 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 01/17] KVM: s390: Track page size in struct guest_fault
Date: Mon, 15 Jun 2026 14:42:27 +0200
Message-ID: <20260615124243.187614-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX2ZGPrSG+sZo7
 T/oR9aXYYhsgP0M6VROB8PPV2MDftikXN4usugKTr/TgoB7fmUx8RAh8q5vh+dddA47glorvciX
 +8cGUGJkcImfXbOFLb31vGFY4aatOKI=
X-Proofpoint-GUID: EOdsVSsSpBYrIiXGm0OYyQ6VlNHzr6Pc
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ff34b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=HydwJh4hHmF5zmZ3e14A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX/S9Iz5VoDVbZ
 JJpbXLNHuIomPGsye9NPKRsW44TMd7RJ9fSAc6/rfsZqVVRjcCDHq0H4Fr8dauybxI8xLd1ORy3
 SiEmrS/zpvX3gbVfiHuXriwNLTKonxH5TDi0m4IY1KF4TXdEV138Rv+yhVxPU9IjzFOv6Nh710d
 SS22FQczFEwZrjEwtL4MmZrawT7514Ra8Qwe9tVgl++vr0VwUj11oQzLBCjPN5lw2y7JcgOomCb
 puXjpiQ86gKDlVB4RiJIlCEhLIYn8lWzOBwCaAkYMU2pgdlkKJJ00buGb2BOEsx94eBWVnkjae4
 Svb7pRbvImQS4YI4qy+j2DL6ICYPvr/yjbrwC6dBAxX3WQGpnWdcEqa3seEEte5DvsleCiOHsKq
 emH6Aw8S6uiDFz4Y1v9+CXep56EIEqk9Sb3Ay8uyHzSLWtFj5KcGbpv4qMLpdsHBKtl7Konuufa
 JpEuRmHiCL+BKTdtANw==
X-Proofpoint-ORIG-GUID: EOdsVSsSpBYrIiXGm0OYyQ6VlNHzr6Pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

Until now, the members of struct guest_fault are always accessed while
holding the required locks, and thus the ptep and crstep pointers can
be dereferenced safely.

There will be some new cases where callers of kvm_s390_faultin_gfn()
need to know the size of the page used to solve the fault, at which
point no locks are held anymore, and dereferencing the crstep field
is not possible.

Introduce a new crste_region3 flag for struct guest_fault to indicate
whether the crstep used to solve the fault was a region 3 entry with FC=1
(large pud).

This allows to disambiguate all three possible scenarios:
* If ptep is not NULL, the fault was solved with a pte.
* If ptep is NULL and crste_region3 is 0, a segment entry with FC=1
  (large pmd) was used.
* If ptep is NULL and crste_region3 is 1, a region 3 entry with FC=1
  (large pud) was used.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260527144358.186359-2-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.h  | 1 +
 arch/s390/kvm/gmap.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 8f8278c44879..5d848e74e382 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -500,6 +500,7 @@ struct guest_fault {
 	bool write_attempt;	/* Write access attempted */
 	bool attempt_pfault;	/* Attempt a pfault first */
 	bool valid;		/* This entry contains valid data */
+	bool crste_region3;     /* Whether crstep refers to a region3 entry */
 	void (*callback)(struct guest_fault *f);
 	void *priv;
 };
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3c26e35af0ef..fe138d17caaf 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -531,6 +531,7 @@ static int gmap_handle_minor_crste_fault(struct gmap *gmap, struct guest_fault *
 	f->pfn = PHYS_PFN(large_crste_to_phys(oldcrste, f->gfn));
 	f->writable = oldcrste.s.fc1.w;
 
+	f->crste_region3 = is_pud(oldcrste);
 	/* Appropriate permissions already (race with another handler), nothing to do. */
 	if (!oldcrste.h.i && !(f->write_attempt && oldcrste.h.p))
 		return 0;
@@ -690,6 +691,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
 			    crste_origin_large(oldval) != crste_origin_large(newval))
 				return -EAGAIN;
+			f->crste_region3 = is_pud(newval);
 		} while (!gmap_crstep_xchg_atomic(gmap, f->crstep, oldval, newval, f->gfn));
 		if (f->callback)
 			f->callback(f);
-- 
2.54.0

