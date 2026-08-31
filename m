Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5A4570C3;
	Mon, 31 Aug 2026 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188215; cv=none; b=DlGZA6Ol6AL5Tm2OCku0+RuNWREbc5WrFbAD9NX/iDcwMWjQGhmsIncv56IWxju1//5PWryVlknU/XvhMiDE0XcbHBZx5u9Mqql/eznfqqNjg/I6Lrx4isAJAAPdJOJFpsYchEJZVCuSwDTicDQZyVircH26nxSzrMSKfxHE7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188215; c=relaxed/simple;
	bh=0KyYcmzkgzZTTu21wghjyQyMjjUJgUgujf/cC2tsaXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlCdkLcIqbzzBZ18gwOajnB2x9BikkX/fYtuA+ApSVlyvYuNLHYmCkhCpT4kDYR9dlz239Lg+oFIah0+HjT7a0jq/Z1GzRBW+LRS2fR2nwfRW/K13PiacYLfFlaES+rGyxm8tN1gCURAfbr3RXIsKWR+UQa1pAn8wMb9sGDGWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aZOW/Z6d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aZOW/Z6d"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEvl2414993;
	Mon, 31 Aug 2026 14:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AgOdmKk0HGp2w6txJ
	NQpE2tFc4GPDNhhNoLF19m8si8=; b=aZOW/Z6dT9eqkuf8zgxy8EdUlI8knzwYY
	uW2ypbNaBCyVikctgWrOrKvIJUWO8sIRoXghKclGA8HbTt1wd/qGIZ+bSO06vljy
	EvNwXvRTmtL94WQNemm5YrZGa0R9pZ2DchH1hAjzwQmyVZbe+D8yXWsC5hNv9Z5W
	fg+bICXJbqhU24jbwsk8zcsjlvwOSN7M1Aruvkz1hUIm8q3IUiZ2FDvzu//X1enU
	GivG7ZFwZ7niZ31Fp/ADIqOHsLG1L/JQQFG5xzT1qGIXNYFALRT4ybVimv29TbZD
	zO87+NRVGb+nsYb0tuXquHvrqLdzSwhJMfzTK+GyusmlctmOGTvsw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj66b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfbmC029519;
	Mon, 31 Aug 2026 14:55:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx8v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtjWA31981880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E9E20040;
	Mon, 31 Aug 2026 14:55:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9694120043;
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 15/20] KVM: s390: arm64: Use QAAF init save area
Date: Mon, 31 Aug 2026 16:55:30 +0200
Message-ID: <20260831145536.913567-16-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NBzZ3vNIKerg2wA0OsIPkgrhomuar2rM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX9nekivU1Lxuu
 BbHWp/4tdO+b8ZawBA6/xXovRBsZWLlI493Lp4n41Pt/cUAy1uhctoA7LuQXD/3fpj40xmkj5YM
 ZOEAbGfhMr7siDEwIO6JeSlZ2noOLLADGGtpLuBZAFaGpuu+io2BknrQEOkwMBkXS1BVuK+Y9Rv
 /SexI8pLtKpPaJm6OXV69lrAk0iT0pjeph8B1h71SYqzRruU7tD6pbyj1tZQenuEBeDNjFpYKQ7
 KVavIP62XWxiACsQRb9WZTSSAu1IqtCwo9rjKmoRGZ15l5g3gNQpyXv3hXdOUzhd9USHq3x+iYD
 J/rVltz1cV3u1xzxtlKA+yhMc1KC77l4+od5JSBIWPoYU049eeMNVtuZOAbNFhqZ/AaLvJeE+7t
 ZJ4hT+EDO64fFE2LwvmmcG1hgoaRhHatuNuuvKg24+4rVh6Zu8hNFCJs5wrk7cvdvtk6Fbn5wMY
 wtczudlMVVpbqmOesIA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9595f9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=4v_MITeQBDqVJkbHs2kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX6500rR5VYJKJ
 iVcLUSoRYPoiu4PxA+WRrYJzq9/KOnvJ84VfSq3+/i5THd+EZbE+Bq0+1jjjNNf/3la8n6RGfVx
 p9qRg7Yfjyl55JaS/WP/oMVRQz/UVGI=
X-Proofpoint-ORIG-GUID: PRi0ymHEIIdEKaZWe21iewkiw92C0-he
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Use the (cached) result of QAAF fc2 (Generate Initial
System-Registers-Save Area) to initialize the Save Area.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 1 -
 arch/s390/kvm/arm64/reset.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 3a0bba6e0a06..ab6e7d135435 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -360,7 +360,6 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	int ret;
 
 	sae_block->save_area = virt_to_phys(save_area);
-	save_area->sdo = virt_to_phys(sae_block);
 
 	ret = kvm_vcpu_set_target(vcpu, init);
 	if (ret)
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index 74622ba6f081..bc7bcee75779 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -10,6 +10,8 @@
 
 #include <clocksource/arm_arch_timer.h>
 
+#include "qaaf.h"
+
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 {
 	return true;
@@ -79,6 +81,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	if (loaded)
 		vcpu_put(vcpu);
 
+	kvm_vcpu_init_save_area(&vcpu->arch.save_area);
+	vcpu->arch.save_area.sdo = virt_to_phys(&vcpu->arch.sae_block);
+
 	kvm_reset_vcpu_core(vcpu);
 	kvm_reset_sys_regs(vcpu);
 
-- 
2.53.0

