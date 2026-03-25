Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70FC40244C;
	Wed, 25 Mar 2026 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458810; cv=none; b=mhHtX60c3dS4fVan9sJhWivG1n7r9DwNAotXrayQNfC9oPbj3jpkjIBs+2pnV7dOTPxjbXbPf2CE23ANwFPf+ikc37XLK8s5je/N3Wl7VFwUiETWwHn1vTwg2AiSe4CHCPbYutrlULWRfA4A2oqt5QZdxgH5iofWiH//1oCHR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458810; c=relaxed/simple;
	bh=VDusSxgoDYGAh2GCyL/uoPtDzMLdO29kDce9PMY4OJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpzAWwHG9K2MC30FfmZC3s1X/5OL1nkgrIJRRqM/yV7RlgmT0cIfLXdZ+XoXXsojbp+GnjvrTmlXx6l6Efhw1EwJ+TAO2oldeBu+BHqcfYHWFyR+CMdgcbdM8Cnt7gR/lfp8N0OQDfwj5//GoAAJimihmHj8VAZy71ZADvMrfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Spt7LF4b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Spt7LF4b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PCe3D41172616;
	Wed, 25 Mar 2026 17:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IPRwo6QncZgKHtfSq
	5N2hHB9Ez2BfBUWIR4hvBTz68k=; b=Spt7LF4bCSdsBofWodJHmfbFsEsaY+6tk
	oXdq/VTcut6qEEZFR5lARiN16etRUUSkilXq5DB3hcMouXd3Hd32RlpAu4SAover
	NF4kS2ymXC1TVz+YX7QypvP1svNQdHBDyxxdgXvIy6gjVarTH7qyKFG3pDVSC6sw
	LIjXcyfmQsg064U6at5+0uV4rN3dt/sdW6K5BOZKk4vIy11nERZ7quAJ1a2+StW8
	dmRH0FigR20KxDJ3e6bcOZWEriDXnQocbQvgjLWPOC6xpLrUMyo05moS9WHQ2x6A
	bXl8xQz3e0JERWs4yFvIQfyqVj0DohLpMmK15uBSSHH2QKPNePsng==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumrs7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PF1lti005964;
	Wed, 25 Mar 2026 17:13:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yqjwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDDde44040586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC5E20040;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 336ED2004B;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 05/10] KVM: s390: Correctly handle guest mappings without struct page
Date: Wed, 25 Mar 2026 18:13:06 +0100
Message-ID: <20260325171311.182210-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n1Yv5DFcZ_ChFMSf5u9YuUPwqvADQHyc
X-Proofpoint-ORIG-GUID: n1Yv5DFcZ_ChFMSf5u9YuUPwqvADQHyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX7BqS9aT8pAd8
 IQTE5d7b77gfSFNwGC6KmdiWWGVjrexhWESBNdtu8+H2PbDbNh8rcULRPg3ScYOPjqFPIcFlCi0
 9aOp8LkPA04L4B+ISneGstS5altUX7oPbtokBq1Upe4Xs4n6zsEepbfVXiTd2F/kTRu7Ngcgu/p
 7hTTJVTzei8YKmLYz+ia66/+SqQUUTVUQdHZl9f3fSQ6w5LHjm4OiWQOaCy5RLF170Ihd7OGjMD
 fe+cOFZqeSgMyPZb9Ao2z4Q0P2MJJ+gRRNB7KIiBLeD3ImUgeFWcSZOi23HTbhHsXDiNIUer1fV
 NiwwG9AThdBsXIUmfzSKljKJOQzsn7K98iZmn+VK0rkCnpaHjhdaQD1aWdC4A12w6fZzG98pG+t
 z4bOiquZKjDo2eRcL1ehk4CnBmZUUEGmL5WimuOFnvYMHssnWKxYc9XGsmIAxCNNrMIL09gZ/mR
 x3bWMlbBbIxgS5qD8dQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c417ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=x4-NZlbSC-zwRaKax1cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

Introduce a new special softbit for large pages, like already presend
for normal pages, and use it to mark guest mappings that do not have
struct pages.

Whenever a leaf DAT entry becomes dirty, check the special softbit and
only call SetPageDirty() if there is an actual struct page.

Move the logic to mark pages dirty inside _gmap_ptep_xchg() and
_gmap_crstep_xchg_atomic(), to avoid needlessly duplicating the code.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/dat.h  | 12 ++++++------
 arch/s390/kvm/gmap.c |  5 +----
 arch/s390/kvm/gmap.h |  4 ++++
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index efedcf96110c..874cc962e196 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -160,14 +160,14 @@ union pmd {
 			unsigned long              :44; /* HW */
 			unsigned long              : 3; /* Unused */
 			unsigned long              : 1; /* HW */
+			unsigned long s            : 1; /* Special */
 			unsigned long w            : 1; /* Writable soft-bit */
 			unsigned long r            : 1; /* Readable soft-bit */
 			unsigned long d            : 1; /* Dirty */
 			unsigned long y            : 1; /* Young */
-			unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 			unsigned long              : 3; /* HW */
+			unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 			unsigned long vsie_notif   : 1; /* Referenced in a shadow table */
-			unsigned long              : 1; /* Unused */
 			unsigned long              : 4; /* HW */
 			unsigned long sd           : 1; /* Soft-Dirty */
 			unsigned long pr           : 1; /* Present */
@@ -183,14 +183,14 @@ union pud {
 			unsigned long              :33; /* HW */
 			unsigned long              :14; /* Unused */
 			unsigned long              : 1; /* HW */
+			unsigned long s            : 1; /* Special */
 			unsigned long w            : 1; /* Writable soft-bit */
 			unsigned long r            : 1; /* Readable soft-bit */
 			unsigned long d            : 1; /* Dirty */
 			unsigned long y            : 1; /* Young */
-			unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 			unsigned long              : 3; /* HW */
+			unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 			unsigned long vsie_notif   : 1; /* Referenced in a shadow table */
-			unsigned long              : 1; /* Unused */
 			unsigned long              : 4; /* HW */
 			unsigned long sd           : 1; /* Soft-Dirty */
 			unsigned long pr           : 1; /* Present */
@@ -254,14 +254,14 @@ union crste {
 		struct {
 			unsigned long              :47;
 			unsigned long              : 1; /* HW (should be 0) */
+			unsigned long s            : 1; /* Special */
 			unsigned long w            : 1; /* Writable */
 			unsigned long r            : 1; /* Readable */
 			unsigned long d            : 1; /* Dirty */
 			unsigned long y            : 1; /* Young */
-			unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 			unsigned long              : 3; /* HW */
+			unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 			unsigned long vsie_notif   : 1; /* Referenced in a shadow table */
-			unsigned long              : 1;
 			unsigned long              : 4; /* HW */
 			unsigned long sd           : 1; /* Soft-Dirty */
 			unsigned long pr           : 1; /* Present */
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 03e15b5e0b9a..e9fc471a5141 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -544,8 +544,6 @@ static int gmap_handle_minor_crste_fault(union asce asce, struct guest_fault *f)
 			newcrste.s.fc1.d = 1;
 			newcrste.s.fc1.sd = 1;
 		}
-		if (!oldcrste.s.fc1.d && newcrste.s.fc1.d)
-			SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
 		/* In case of races, let the slow path deal with it. */
 		return !dat_crstep_xchg_atomic(f->crstep, oldcrste, newcrste, f->gfn, asce);
 	}
@@ -576,8 +574,6 @@ static int _gmap_handle_minor_pte_fault(struct gmap *gmap, union pgste *pgste,
 		newpte.s.d = 1;
 		newpte.s.sd = 1;
 	}
-	if (!oldpte.s.d && newpte.s.d)
-		SetPageDirty(pfn_to_page(newpte.h.pfra));
 	*pgste = gmap_ptep_xchg(gmap, f->ptep, newpte, *pgste, f->gfn);
 
 	return 0;
@@ -669,6 +665,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 			oldval = READ_ONCE(*f->crstep);
 			newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
 					    f->write_attempt | oldval.s.fc1.d);
+			newval.s.fc1.s = !f->page;
 			newval.s.fc1.sd = oldval.s.fc1.sd;
 			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
 			    crste_origin_large(oldval) != crste_origin_large(newval))
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 150e91e15ee0..1b900819bab2 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -185,6 +185,8 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
 	}
+	if (!ptep->s.d && newpte.s.d && !ptep->s.s)
+		SetPageDirty(pfn_to_page(newpte.h.pfra));
 	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
 }
 
@@ -220,6 +222,8 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
 	}
+	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !oldcrste.s.fc1.s)
+		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
 	return dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
 }
 
-- 
2.53.0

