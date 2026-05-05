Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4687175A7D;
	Tue,  5 May 2026 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013931; cv=none; b=S983Ft8orrSD31/LBW7Bhvn7M4+Ux6O0TQCYKBrugHFqafxGgQWmh+9GP8Z0hMTr9J+JErS8g0MzviU96RZ6SSJDsu5iRqgy4mxgdDp8D4OhG6j/YI/5zB4u08NZAL1EQ1owoSbxDWmnraWAnWIyVHNFi+h0ggo7KVM/xW8O+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013931; c=relaxed/simple;
	bh=Nn04C1knZJirWEuYFoTKWZvlblyH82RCgi5tvI7g5cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckc/2Sr6inBp50N/QsGgwkCqZ4WFSP1iFFgyIU3kKFp5XMXidIGupPjHLVTvUiGdmqHE1tCTWvXjQeCVx9PDKwDIrapmb4ZYd4j+qAXSyj4RaNa6b1mo28NbMQNxstBp5SXUQf0/NZCMmRd+CF4yPUiQdSPY7ipnXE4ib7bbcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAGkipe6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAGkipe6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645DrJPK1421455;
	Tue, 5 May 2026 20:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oO6+PbfZP1uHPSGGS9+78RwOJ4UVqSw7sxxfIMwAA
	BI=; b=sAGkipe6cAFRU88mNgjKCs2BvOD28GXduFZ1Tws+B/TwrgWqEcKzSlpL4
	KCFnZdUtHOnRuRxobEWd6oLvIME8DHTJOUx0Bx5t1O9b9ZPb3IUwwmiIOZIepeLa
	WaWr9Lg/LjUVdXzTVh81KLrRFxcR2JAClmbitDbpV2gFV3KqBbe9hs1Tf78gN9HG
	VrArL0ZUErlTG1b5cRYhVeYrTRLIEMH4pOpwT8EzTn5DOEeOKk5ZxGAUntBSagTB
	eMkHmI1V6VnszeQQs4JFE3wb4LE3DsWo3ZN188JAxaY+WpkT28u5AyBjHAAWaBmk
	YqjEpwWyar3kJEvWhJBZiwpZLyX6w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4nnd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:45:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645Kdlnp026809;
	Tue, 5 May 2026 20:45:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h3b6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:45:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645KjNW643843978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 20:45:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4336620049;
	Tue,  5 May 2026 20:45:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2780F20040;
	Tue,  5 May 2026 20:45:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  5 May 2026 20:45:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 12A90E069B; Tue, 05 May 2026 22:45:23 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] KVM: s390: Toggle operation exception for userspace
Date: Tue,  5 May 2026 22:45:21 +0200
Message-ID: <20260505204521.1658704-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIwMCBTYWx0ZWRfX4m70vA6LmF/s
 J2hb1VsZXdLtOxjqw6n0Zy36f/IVlVpvCnKt+ygzTfLm1y7y/o8eZpkiC3sFTrnJq/X42dNdHbz
 PqFdqHPRgcVBTk5JZ6yKE2/Kw+I2rxIogO64MCub3NgQ2ynX4FiUf47Vm5/VdYHyGorvBwbuIRe
 EQ4MQUDuNbzzIkHh6d/JJhywDl/0HMUPTp4+OcUR2/5mSp62On0ZzpqC7i9IkcFWVtovqwOqJ9w
 WaOcDxUGNAb/wbY2tSrebz0UYB5rJtfREpNKc0p1e/02K2xnBaXxSOQsdUmb9Dh3CFxstODrFvJ
 hAc3yIYP37Nl8+cipwStAArHywSIdvar+bkYRkzCykOYAERMrSr6BTPLx/yGE3NdVY1PwYiWIcJ
 pS3S7uIU7vlABJuWh0MjaaFuz0pTxMJ7l43KUa8xJrUk8NcxvNottw5b4EiikcULD0k2EaBJVnF
 KoB+iogP8I6VbMzlzvA==
X-Proofpoint-ORIG-GUID: PHdM-PhnVcymXSs9NyVuPTCsxm8_lFcO
X-Proofpoint-GUID: PHdM-PhnVcymXSs9NyVuPTCsxm8_lFcO
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fa56e8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ea8k8XiQOFGV3AjeF4IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050200

The KVM_CAP_S390_USER_OPEREXEC capability allows operation exceptions
to be forwarded to userspace. But the actual enablement at the hardware
level occurs in kvm_arch_vcpu_postcreate(), and only if STFLE.74 or
user_instr0 are enabled. The latter is associated with a separate
capability (KVM_CAP_S390_USER_INSTR0), so the only way this happens
for the USER_OPEREXEC capability is if STFLE.74 is enabled. KVM
unconditionally enables this bit in kvm_arch_init_vm(), but the guest
could disable it from the CPU model and thus ignore this capability.

Add USER_OPEREXEC to the check in kvm_arch_vcpu_postcreate(), such that
either capability would enable this type of exception.

Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards operation e=
xceptions")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..a91a42174302 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3521,7 +3521,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu=
)
 		vcpu->arch.gmap =3D vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
 	}
-	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
+	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
+	    vcpu->kvm->arch.user_operexec)
 		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
 }
=20
--=20
2.51.0

