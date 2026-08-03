Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A240B0FB;
	Mon,  3 Aug 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760857; cv=none; b=V26LoakUcc264T9Vwim+FjyyFvmxVzOC2sp07zgHWT/V7qN2DsgjMPDw/ukUFlN+i7NHF8/VqfFdXXdzYH6N1m6NARGISf9jyPfl+eR2DekSaFi3bpL3518kmUP5qpeVi0DfoTNVvSXfphWj/gVC8qHR5jFX5lK8cT99OyFc4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760857; c=relaxed/simple;
	bh=HOanDrvD+bLZnZeY7pEyreY/JBB5XIzF0GbLYIxmYn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO43yyPguBfpV29HTPRN/KYwLPi/dQA54VF8T3o4YbEa7Q5XxASHdMRq+Her8FzdDqETJHwA3J6iBmOwzSsP0VBwHArcoZEBAZ1z4t9a4E9bRGuyI24F5hiPQyRie2P5GxKqpVsg/pOzV7XoL33MssrCN0/fWkmeAqPgusKnWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=szJHMVfz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="szJHMVfz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHtv01943569;
	Mon, 3 Aug 2026 12:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rwemp1JR72yGC96fZ
	c2lb5FsV7ftYuKoDvMVFB/ovOA=; b=szJHMVfz/jkqIjDaBQNKp4FDjwV2G58+1
	yTr3bxWgPc5BvkbJcyZbrQju0dOOdQ7GQ49fbVluMM0lzLigl07DKcmnLKRVtycP
	VUSZ3NdWRc7JI6lynou9zboBr/47LWlSk3zs30g0MTsX0bv4XL7NxXfSSldblxuS
	xFXV6JMtNGE/+3/8rvr9N3PFxhrIuxp/U/NiM0vKpXXpjmySIQStNfZNT/6qh463
	2dSOIITSrONCF+OQNbqnC4P7YK+OEqQiuqdFTkLGIL/nCRQolnUVLUkAOjG251Jw
	91l5aZ7DaBILyPmIctjMcQ6Q/jSqZJmRjgL8bBnYkyPetEcvhOEzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0k6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQKhd026114;
	Mon, 3 Aug 2026 12:40:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyd3j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Cej9g30015836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC49620040;
	Mon,  3 Aug 2026 12:40:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28FAC2004B;
	Mon,  3 Aug 2026 12:40:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 09/13] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Mon,  3 Aug 2026 14:40:36 +0200
Message-ID: <20260803124040.126471-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX6QCwpzF7eeMh
 49GUAeGwi/swmxDeo+LHmCgWZT2ZuahCqVA+g9MNdZwNfQRUyqEss78AdaItIbdNAD1cDO9yvnY
 S8W/9o2TEM720GNYeZyuJIj+hHs+X5f2Qr4Vpp+RKFvxEFlT6ML2px+h8eer1Qrw4Iin2Q1hK0E
 Y8KxxscW3fHwJhz0TD6pAYhblJmwp1DxMDTcU3eRMXgsUhWANVJpE+8DsX37Hjs+Ly61VLilP+j
 D4iKkC9V60ZQ17u/oGuyE9SeyFqdIaqVx3svHtFRbbl6anm406dQ9NUFKcF9ITkCJBfENEWUpxC
 vf+zS/CnMpKlay8lpeWs3OzkNTafLFnyd18CrLPZQl9fEmITVyUK4lYeS2O1xu8JSLIcvwSk7c/
 PtcZcexB74r8f2XHEVJ1UXQ10fZ6vxBUvkv5jswt3Z8eCZBe2xNyFCpRe2C2eFSaeu6RgdBE05i
 m8Yk5ZGIy0KlgRUub4Q==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a708c54 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-GUID: TmcPc_ONycnH_uTvkokGgNmgmsh4hVzH
X-Proofpoint-ORIG-GUID: TmcPc_ONycnH_uTvkokGgNmgmsh4hVzH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXzQyokIytL4uS
 hC06j8UfGhEakmSCJ42Bha4ymZZdmMugaS1EFaot1QKEdp3e/hKCh99pnIU/oQuSoA0coNVuBhc
 7LW2oybMyAZ5SO2XSbV+qH11xq0ar3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

Fix by adding the missing lock.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ba811f0673d1..2741ca323ede 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3875,7 +3875,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 out_ucontrol_uninit:
 	if (kvm_is_ucontrol(vcpu->kvm)) {
+		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
 		gmap_remove_child(vcpu->arch.gmap);
+		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
 		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
 	}
 out_free_sie_block:
-- 
2.55.0

