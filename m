Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB23DB33D;
	Mon,  1 Jun 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327814; cv=none; b=YBMNC/R6bhYnZuS8hBLbTCNL3Go0pL2xbJ10N9w4X08OMtgu+peXceuJqUiX3GBe5V/WLxJ73GmovtZLQDOVHLUDCCm8gJlNYRNiNt92o6HwtA+3/zljB4bA3cwKS0aVKptgK9AJ99mmgq4OtfKG+VFD2T8X5pnLU132wlFoCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327814; c=relaxed/simple;
	bh=q/4VAZUDR9wKIqDbkUpA49JakPieFRHX1ZGX+F9Tlk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLzAjQMBsGWiTko4ahMtB2CQWv8c8gfYNiYuQGiEJjBqEhKHWZnyupk0zacppMv6i4KG0wGBAU7Lubjev+OJKRDFNKw9+4hYujDGgJCSS6XxCkrximt36JYDTK6eKCgDjDpUQyhte2w0U6RHsWpgj4Stf7oVKqcj8lP6+FBFoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AifDKMTf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AifDKMTf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651D3AMP096369;
	Mon, 1 Jun 2026 15:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q3ON+ZZRcqGRnrLY+
	eHwQpEqFpiLy7qpH+dy3PWXk0Y=; b=AifDKMTf1Zn+RyxITr38MFOunxmCR/ghU
	nMd5PTmteoEtcsgaCHtB29okeG0E21uj5YJ5sIptpEWZwWyYs9qlzbpLT9e+cmsj
	Szccn3PO2Z5bw+oGVp+Y3olLahU47ZD+hRBgd9WJzAqUdDnkZKBGxE75n1gCyjIv
	cB3y/3qJUAvb6m7LncRWJ5dxKB+Y9e5hM6tGVIl/f9dsgHSc25WM0QKdHpR2tee8
	4RLecXAgRyIUEExKu5wYRSvSslpX4/jABYtqeY4uW5qg8RwjI+uQVcgoqPM0JwEJ
	R0p/2LLik7T0VAbK0R4veLqiDC/CQwetXYHHXT1agvKERU82zkeOA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq1fdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FOCnG027078;
	Mon, 1 Jun 2026 15:29:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh6p3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTqxw30015762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C85BE2004E;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F75D2004D;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 4/8] KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
Date: Mon,  1 Jun 2026 17:29:47 +0200
Message-ID: <20260601152951.196859-5-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _0jLKG4U4pnVAhN9NKzGeqqBnBu54tD0
X-Proofpoint-GUID: _0jLKG4U4pnVAhN9NKzGeqqBnBu54tD0
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1da577 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfXx/oRPQxpWadO
 CifJefbzaadNXoSMu6MmP+LvqsW+s6fTBXdJXYlViY+KqcAGJxd9ZjFWQOqy2w8/Kl/H3VsppCr
 wo6RkgD+0+C85Trlz+rc8WkvyLNcaUj1CLof3toa5+7uhcvJNp5JyUDUndlVBHIpRsAewAM96pJ
 JB5c8Two/kvzglEjAMDVJ9Uyg34EvtQ86aFe4wMNxbxK0CF+cZMN8HMDKpF19ySqK4cwL0/jIyG
 BGdELdYLQYAxWRjks1cs4NHd83D6H9z9ieS8ZeA4OcM7+G9/PxahMcKncS9NPJxAWVQWlDSfCof
 whQAC3fo+x8IJ+ar1MSTWiXZkYHYoaiT1eDXgmwvASVWksRZpLFlkv8yfyMdPDT7O5lhXMCEfiR
 GcnpnsJPA0ybUrKatwK5UOHFP/6JAhSyacgJ+G7KQkgn01Qw3EjCbjmMy1zgPkR0waw7pyZgdwc
 +ghtIJkaFabypQQRtzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

Until now, gmap_helper_zap_one_page() was being called with the guest
absolute address, but it expects a userspace virtual address.

This meant that in the best case the requested pages were not being
discarded, and in the worst case that the wrong pages were being
discarded.

Fix this by converting the guest absolute address to host virtual
before passing it to gmap_helper_zap_one_page().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cc0553da14cb..447ec7ed423d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1188,6 +1188,7 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
+	hva_t hva;
 	int i;
 
 	lockdep_assert_held(&vcpu->kvm->mmu_lock);
@@ -1199,8 +1200,11 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 		if (!ptep || ptep->s.pr)
 			continue;
 		pgste = pgste_get_lock(ptep);
-		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero)
-			gmap_helper_zap_one_page(vcpu->kvm->mm, cbrl[i]);
+		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero) {
+			hva = gpa_to_hva(vcpu->kvm, cbrl[i]);
+			if (!kvm_is_error_hva(hva))
+				gmap_helper_zap_one_page(vcpu->kvm->mm, hva);
+		}
 		pgste_set_unlock(ptep, pgste);
 	}
 }
-- 
2.54.0

