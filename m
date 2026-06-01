Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2123DA7ED;
	Mon,  1 Jun 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327815; cv=none; b=sEqiBr7uBmh3oRCfawO8U/mGxp/2ToNhOwfyV3Lrh5IoLqo0vrIi07/2DgHD3UVUM2oAlYP/o1pIl24KCymEr+tgGaIxE2DVbOY/41I44pnY8B3Sf+aln4Epmv42M7BgS6f/io7+ZkmiMrKJGi97X0wYfrzEtHqEkYAHl4U3Usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327815; c=relaxed/simple;
	bh=PFeMKJR8nR7wr+MoY/+dZNvE3wZJ8jFHROaaMChHhQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owlBg58wuaAj1puk7/BaFUtgDGv9aKxMbShMREUIdyJEiD5ngu68cgVchurhBNQIcOFQ+z6Jsgp/WDMY0IEv61tPiUIOFQrwOiWAdNqgyFs+tiLmWpACUCRRy21q2+n1cmfRIEMKlKcmXpyA1hbO9niZe9Vidfe13zlxb/4SDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o+Me9nhI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o+Me9nhI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651F7VeL1065217;
	Mon, 1 Jun 2026 15:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lmk3DeMg100OdUmml
	UuLjTKMHcFnlbhpGWHXgUhCo4U=; b=o+Me9nhI6VNtnoOVc5SvWHRLLOKrY5cKS
	lNBfP9Ged6CozfkZtgg29IpN3CgL3vEd6b/yD4ckI4TJRQRc8P7bwhMoBDPCqSaK
	3ukU+ASTolsDPbh+11KU0sX18k20gWnZYj/KafnoLYHXQMpxzNCky0L0CohM+fti
	8Y5vstppeZckooGuXdlQC1et+zX4jTtE6ZGpzNUTWq0gvVsdkpTzRtzv0bfOXUcQ
	50lBdovWvYQIO2HhlSnu7z05/k0gd0cVYrKKLcSdJPDkCTjkGa3iSAVBD3HkhmvZ
	LjRwYAO15dp9daYJiOIoy46s5vDcY5S6jrJ8AuY3TkYyBTIl09d6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht12ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FO9bY022901;
	Mon, 1 Jun 2026 15:29:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jxs6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTqje30015758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD9A2004B;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 418B72004D;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 2/8] KVM: s390: Fix _gmap_crstep_xchg_atomic()
Date: Mon,  1 Jun 2026 17:29:45 +0200
Message-ID: <20260601152951.196859-3-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: bWKJrV7Wf4pl2BhTxhAoVR_ouD9DTprF
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1da576 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SMUcQ3FjFaoWpPRfvsEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfX+lHE2yo+67+r
 J1uLBCokbqs7FeCU4cSbbqvwqJNXG9SkDSWkz95nV+7M3lEZWjW/cTRR9HC6xotEVPdW4zgRrCM
 GMoZ0NKn2qF4b+juZiOiKmBV8vw+LPu7hPC1vBmTrQRvJBoee6TqBxim++GkXPVYmMxQvs3g0s1
 hM4oFNx0KYVkt86SaGLuSSX0bVHxEP5KrK2mWtJDiM7X3fxRxoKH7Lhq7C6PFtui4Ls3vx7TfiD
 NLOV9Bhd4n0TF4bcEVsOEDE5kerHsKlTCOV8BxrWB/nyINb9WOKyeHpfvlI/fEm69EAmI4TGn5A
 bbV0LbuX5DZDIsklh3o8gJzSFKM/+QBfXHiZ9oOmZZV9sjE9z5POZE6X8ZT5FgItSYULcvVbBpT
 i54pUncJoole1K6VpV37ATfVHZdfjV3WQe8zMu8KOMGFVaRAQo4ulMWdqPKnLh8tzGdQPAR1Zws
 rTyWTlPTNxFZH+ABLvQ==
X-Proofpoint-ORIG-GUID: bWKJrV7Wf4pl2BhTxhAoVR_ouD9DTprF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

The previous incorrect behaviour cleared the vsie_notif bit without
returning false, which allowed shadow crstes to be installed without
the vsie_notif bit.

Return false and do not perform the operation if an unshadow event has
been triggered, but still attempt to clear the vsie_notif bit from the
existing crste.

This will prevent the installation of shadow crstes without vsie_notif
bit and will also prevent the caller from looping forever if it was
not checking for the sg->invalidated flag.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: b827ef02f409 ("KVM: s390: Remove non-atomic dat_crstep_xchg()")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 742e42a31744..5374f21aaf8d 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -273,11 +273,14 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
 	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
+		newcrste = oldcrste;
 		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
+		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
 		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
-- 
2.54.0

