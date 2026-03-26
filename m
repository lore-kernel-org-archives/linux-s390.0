Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DA34B1BE;
	Thu, 26 Mar 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531066; cv=none; b=NPjNDKBKd7ONX8pZIdP4Jj6X+/RQkLBnVProlbIaMYTof0trFJXKFn620uSmkSRqWuvBoJNDMNiMxAN/kjOuHNR6UEy3+5VyOch5pLWRjwFMv+By2lEj8pdpvAikg8/GRtuSDaBnnQ/BX5H5dMKBZA6T7xyGHTVEJR0uDRr4eP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531066; c=relaxed/simple;
	bh=pvHe9Q1FBZmyVCJ9CREb4VNvkPI+HWhs0fRgRLKfKpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATmIG51+dyCJL5MOiIIgvzvinFaMpA/x898pyB15Gi4CGeHNFZSgrrRsb+FRPBbC9QLACr/bKS0cPAH4sB20xtUGArjOyq8Gr720wgZczT0K8LxDmJgX/yBeMFqTWwlX802l1WzgnYSVxzzpThJKWp9qdqUfa7t7vNEGbvieOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YNSl6Bu2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YNSl6Bu2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q28LxA511489;
	Thu, 26 Mar 2026 13:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YMToFAhlOgBsbN3dC
	2Q3sJrD+DL+uvwWiFy3/CLg958=; b=YNSl6Bu2/yW1cxH8A+jdcuChembI4T1ng
	WwFfqp/wvG81ngNsaefqzQM2U5yKMpo19pjavzmru3EYXV/YvG/0lq80MhoUDbfT
	neS7uBsWXCnOdB0RADRhVXkBstj1OP0pK3Rv72Ga07EQdsNCQuMYKg5osORG4UaB
	aQyR16gXicyysr8HrGLJaGh4zTyM64psnwqUZO9G+ogGnEQdQeobFQ1EDOmJwxd1
	mFS24t9/lMBQKi4EC1VTcMJ+BeREUXDgCMserpUHuSaZmu0G7+cMae0jqCcqjuj8
	Lmi5w2DkYN1byqCbP2YUD0q6wHCE28yDQFVpvtCT9DBp8kTyCC5nQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa5be6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAuMNC031631;
	Thu, 26 Mar 2026 13:17:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt36tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHSrg51970528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 149F92004E;
	Thu, 26 Mar 2026 13:17:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE8132004B;
	Thu, 26 Mar 2026 13:17:26 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 05/10] KVM: s390: Correctly handle guest mappings without struct page
Date: Thu, 26 Mar 2026 14:17:14 +0100
Message-ID: <20260326131719.98229-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HPMrG9SaFHMVdwRNjpPhNzXn1RaWFojn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX2A52MU1zMh+d
 fkoxKyVHI7r2/YDRR5VjW679umm0U0mMBLkxkDtgCZPnd1xAV20le+cEkAB8y6xhHfofQru83U/
 DbGtxua4jSbSl5BrNlaiSboC4PWQv/yyWzH8pNv7vRjmHurKx/jBUVsygLlqEqA8lAV7Yf8HLM7
 2+bhS9kIkg8WuOPia7YbjThWYq7Ny+2U5Ws9AeT0Sw0S+I8PSPCnZGNuVj+BUKD90MoansrtXs+
 Vy7w4LeW25+wZ0H+dwYxI7msqtOnJxmlE20SSZw1XdNMf94IQRBI4kk3naIni2TAwNTP3d6/rtK
 y8LVSFzAb6xrXr3W0fsQ1lmgQ/0fuZfY0YvGZt1kAMQMlkUfZIfiN5YExW+L51zVLHGKPmRA+vF
 IIaYdL7ZGpZTQV5VSkoah8eVLTTP9sROJitJ6ctAGkKSdOCoU73tsbHtzXlpF5o+krc62ZFtNX2
 qKf/ND0n5xEzqJeGPjw==
X-Proofpoint-GUID: HPMrG9SaFHMVdwRNjpPhNzXn1RaWFojn
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c531ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ue6YGX6Dnm8zniBr13YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260093

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
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.h  | 12 ++++++------
 arch/s390/kvm/gmap.c | 11 ++++-------
 arch/s390/kvm/gmap.h |  4 ++++
 3 files changed, 14 insertions(+), 13 deletions(-)

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
index 03e15b5e0b9a..c8b79ad04ac9 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -519,7 +519,7 @@ void gmap_sync_dirty_log(struct gmap *gmap, gfn_t start, gfn_t end)
 	_dat_walk_gfn_range(start, end, gmap->asce, &walk_ops, 0, gmap);
 }
 
-static int gmap_handle_minor_crste_fault(union asce asce, struct guest_fault *f)
+static int gmap_handle_minor_crste_fault(struct gmap *gmap, struct guest_fault *f)
 {
 	union crste newcrste, oldcrste = READ_ONCE(*f->crstep);
 
@@ -544,10 +544,8 @@ static int gmap_handle_minor_crste_fault(union asce asce, struct guest_fault *f)
 			newcrste.s.fc1.d = 1;
 			newcrste.s.fc1.sd = 1;
 		}
-		if (!oldcrste.s.fc1.d && newcrste.s.fc1.d)
-			SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
 		/* In case of races, let the slow path deal with it. */
-		return !dat_crstep_xchg_atomic(f->crstep, oldcrste, newcrste, f->gfn, asce);
+		return !gmap_crstep_xchg_atomic(gmap, f->crstep, oldcrste, newcrste, f->gfn);
 	}
 	/* Trying to write on a read-only page, let the slow path deal with it. */
 	return 1;
@@ -576,8 +574,6 @@ static int _gmap_handle_minor_pte_fault(struct gmap *gmap, union pgste *pgste,
 		newpte.s.d = 1;
 		newpte.s.sd = 1;
 	}
-	if (!oldpte.s.d && newpte.s.d)
-		SetPageDirty(pfn_to_page(newpte.h.pfra));
 	*pgste = gmap_ptep_xchg(gmap, f->ptep, newpte, *pgste, f->gfn);
 
 	return 0;
@@ -614,7 +610,7 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault)
 			fault->callback(fault);
 		pgste_set_unlock(fault->ptep, pgste);
 	} else {
-		rc = gmap_handle_minor_crste_fault(gmap->asce, fault);
+		rc = gmap_handle_minor_crste_fault(gmap, fault);
 		if (!rc && fault->callback)
 			fault->callback(fault);
 	}
@@ -669,6 +665,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 			oldval = READ_ONCE(*f->crstep);
 			newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
 					    f->write_attempt | oldval.s.fc1.d);
+			newval.s.fc1.s = !f->page;
 			newval.s.fc1.sd = oldval.s.fc1.sd;
 			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
 			    crste_origin_large(oldval) != crste_origin_large(newval))
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 150e91e15ee0..579399ef5480 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -185,6 +185,8 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
 	}
+	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
+		SetPageDirty(pfn_to_page(newpte.h.pfra));
 	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
 }
 
@@ -220,6 +222,8 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
 	}
+	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
+		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
 	return dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
 }
 
-- 
2.53.0

