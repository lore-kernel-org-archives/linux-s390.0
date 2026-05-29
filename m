Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26E3F39F3;
	Fri, 29 May 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070187; cv=none; b=uLorFzJsAIS2W9ANJzxIWMIaWnf/yJAt2kiruiBDsT1dYODRdTNyPOKsJx3FDq2q/UPnCeB/YP5SdHFAh+6aSPqWwxrVNZQxeCMFbRHizbuPk14UCpBt1v7f+0gtjmYJ8vZUaP//qRVIY3Ix9yxRlaOh43VwsRDHaOMfIpZnFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070187; c=relaxed/simple;
	bh=V9dDmcTZrFbO1AFx9bd9anPVnixWvwu/8ZEoTVMf4M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APydJZ07DiJzDAHKT0MpW5Z9Zfe07uTGcB75qkiSusfW64Fcqbm3muwArtfyrTu/M996yRkPsC8nXwEfpeFWBG201H2znZ9dVpGnU37lRc2ve2/jM6jFapDQ1fX6yHV8zhG3cKiu3W9g4L+aRtWhW9s4LSqPMx5/Yj4UM2PWacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHWP+mAI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHWP+mAI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFGVBL2418177;
	Fri, 29 May 2026 15:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r8qv0I8vvxpjvrNnb
	+Rd4VaSRAFc/2VGBv0YYFUfb6Q=; b=FHWP+mAI+48JECvH3V5WAE/KTCF+w87d/
	rRoWG7cFfMz5S9kdy/cECpUjzZefBDlnJzLwmSMiy4wuIsdzuOjes3fAhMLI4SP7
	ledii2FrEBj0HNmiIY9r5tYbBYq8RFs6qP8jCl9bCrIrNR3o9WZMDmtbZRumtoZN
	EyG+Cv0LMcz4wc4ky5hMtVmmNCropBKK3Y5oNeLQ+AWdNfyEq10tkJHiJF4RCuus
	SdKi6/pCYKPXtzodw8uFg9DEv9l98AA/ZcyNsIZUUUsoxzrGYFRMu8JGwFHiObL3
	tPWGC/x2s+xjMJvjMkTsfS85yJpSg5LSB5Kt1qyD4Zjye6nR6rR6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884ve37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd76Y024390;
	Fri, 29 May 2026 15:51:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgfsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFov3g48431392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72FC82004F;
	Fri, 29 May 2026 15:50:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AC442004B;
	Fri, 29 May 2026 15:50:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:57 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v3 18/27] KVM: s390: Prepare kvm-s390 for a second kvm module
Date: Fri, 29 May 2026 17:50:32 +0200
Message-ID: <20260529155050.2902245-19-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b5e9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=D2QCReHFeZxoMWIWDosA:9
X-Proofpoint-ORIG-GUID: LXkxrC-Rn5pJk1pTcJtkgP9RCroIABMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX3iV7Ki2qo8es
 8WxpfGchgtRgVSK20MRwvoVkbH3MJ/fdha+N8ezkfrbj6ezkPMpovuVFC1V/3f7jd26eBk3X+sZ
 K6yFu/wf4zxic6zC9m1zwsfFy4EYXjt35wOQH0nzWTsMtce5HgFQgTpWEU1QHuYzsuzUHIGGO4y
 DY4UbC20W+AF0a34S86h0ZWYkWo/pmYQsN6GGmvXM6gnGrrANjy7fDOQzdAWds90cDnFmCCI0k2
 DvcBbq+ScLCvC8WawDxY490yCzzyrqR33fGQGbld7yD8WThI7W0Oxxm7NP/P2MdFHgOqNLhhcXD
 yySVxafk4hVuFWwVdppfqu2HUplaUxWs8Jz+yc/w0b4xlOtw3swYNY7q6r8xx15VjG4CGaFh8Na
 7hAgWrl4E2LHo8GVmeW9kC/0qxvyE+nZKOASfG+npiWUdkDQXM5Fh77A80M5VMkNCTSo+qnqLOs
 gMHOVNru/hyXNt7lESw==
X-Proofpoint-GUID: LXkxrC-Rn5pJk1pTcJtkgP9RCroIABMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

The second KVM module will have a different Kconfig set.
When both modules are compiled the Kconfig sets get merged and
the native s390 KVM needs to implement functionality required by
the respective config options. Ensure that s390-KVM will still compile.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index c9dff21f823e..e9352864a492 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5683,6 +5683,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, range->end);
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
+/* Make s390 compile if arm64-on-s390 is selected */
+int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+#endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
+
 static inline unsigned long nonhyp_mask(int i)
 {
 	unsigned int nonhyp_fai = (sclp.hmfai << i * 2) >> 30;
-- 
2.53.0

