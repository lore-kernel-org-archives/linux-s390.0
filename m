Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094F2FE056;
	Wed,  1 Apr 2026 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009373; cv=none; b=uHmVOtiWsQ+/ZSyftBPlqR6y8jVzaW+T3mhcoKBwb7NFKZ1g8hZG7U+6EFZ6ysomJAjgekI7c0z9n5A0YhrTwBrhPzYmjnZN4fuC4GFLsknHQKA/jOeWhgCVghMYNux0Ku3vRPjqmXROaDrgc6gXL7/3WMzn3fmA1LnRKZZAers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009373; c=relaxed/simple;
	bh=6wzjWq1DR1feu46Y8bZBHZZQHr4vSwIrFR6UEJTo3UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2rxihm7pn6jfyF9XQ7xDdr3Nx3YroQZHcC3Qttx8CwQ12BzpE/WL8DDNrZbqBuh6bn0Td0D6g1mmhNZQog4F+hmWBQexp8iPdHTgmUq7RRIfCpnU76p/rM+bf95WhKWxmacpYgtQtTlF4lijhuXxz3VEVFAXJFmol+z3Q0Akyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j2rULiT0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j2rULiT0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VKXk2l503870;
	Wed, 1 Apr 2026 02:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GZ/glIe8zbQqJu1c0
	kVXs4ZP8azQ46k9ZeHGbbWReec=; b=j2rULiT0bxynvbkpwbkONJFz/ujzDftyh
	1JyxRGOJFdqJINpzBpckjez77RMCmhT1wQug3y1AezZUNNxShYFGOyfFIcgjfwCh
	6yM4FPWnuWBvBARjTdnwn/2TheIcflETyDBqCM8EZMa+ux5hpgSmhN2jFZQK+7AS
	S8sKXROA8OBOTT7WbdZtgpnVaeoVPnq3/lVdPMs53p5WzKyv2YKr09JqV3y+I0cv
	/gujx6ZO+TtLdEKm/LINgzWJLSSwjPho3SYKcpJ+94heKBmyQW1AIKHzjSHWp1yP
	JZOzd0rmesOqn9brXK8Ad9e63MAx/f3VCu1kDqwztzFHMhdmJ3tSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q364pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6310BJDJ005952;
	Wed, 1 Apr 2026 02:09:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy3u2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63129Hfj30802256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 02:09:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5A820043;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F3B220040;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 86886E0AEB; Wed, 01 Apr 2026 04:09:17 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 4/4] KVM: s390: Add KVM capability for ESA mode guests
Date: Wed,  1 Apr 2026 04:09:15 +0200
Message-ID: <20260401020915.1339228-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401020915.1339228-1-farman@linux.ibm.com>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FgAX_liOj3xsJHv5r_RhEIJcLskUhdeE
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cc7e53 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZXKDrtGt6P313FoxNToA:9
X-Proofpoint-ORIG-GUID: FgAX_liOj3xsJHv5r_RhEIJcLskUhdeE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMCBTYWx0ZWRfXzPbgwj/yZ63A
 2TbE71oPA2JjA4pNDvRj7IwcSR2w9jTHkAMZDJT/ojB+OEDNMQx13yN64cV+flzt29qi11r+Fx2
 nliKJ1rVCqGoiXT3WFM1p3XiyT3SbeWoMBuNiJW97dGx+R9OM6DTXXCuyFirvyOQo62G1+M4ghD
 fviOalQtDgoeHGwijBmqGoJuRcd1mkJS/trbgROd15D8B1oqOzA9PbvWWlluvfWEs6GQKNUuUcG
 W3xtABz+ZfHrdxWFYU6HRmLFGnIEFkRFxVFHysd8oYDNbwWY+0nvUyVi7d9tY/PyFsO+LSUGgLf
 T0nl2deR4zAINi9tQFSXgBJrnjfnEz6R1QZ8saFFvQKDrsyyLT16y1WoyajyKjwZZHXLMKRCgkm
 t6yHMWm0tdB7gapKOXd+nq8rEhaLTb227l4fGSWAr3rbRwpFLSvgU/yU5IMzQ6DNc65P0wOeTzn
 o+/hSvRq18foyqT1pmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010010

From: Hendrik Brueckner <brueckner@linux.ibm.com>

Now that all the bits are properly addressed, provide a mechanism
for testing ESA mode guests in nested configurations.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
[EF: Update commit message]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 8 ++++++++
 arch/s390/kvm/kvm-s390.c       | 6 ++++++
 include/uapi/linux/kvm.h       | 1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
index 032516783e96..feabfee0f714 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9436,6 +9436,14 @@ KVM exits with the register state of either the L1=
 or L2 guest
 depending on which executed at the time of an exit. Userspace must
 take care to differentiate between these cases.
=20
+8.47 KVM_CAP_S390_VSIE_ESAMODE
+------------------------------
+
+:Architectures: s390
+
+The presence of this capability indicates that the nested KVM guest can
+start in ESA mode.
+
 9. Known KVM API problems
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d7838334a338..3856af54b6fe 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -629,6 +629,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_S390_USER_OPEREXEC:
 	case KVM_CAP_S390_KEYOP:
+	case KVM_CAP_S390_VSIE_ESAMODE:
 		r =3D 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
@@ -926,6 +927,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)
 		icpt_operexc_on_all_vcpus(kvm);
 		r =3D 0;
 		break;
+	case KVM_CAP_S390_VSIE_ESAMODE:
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_VSIE_ESAMODE");
+		kvm->arch.allow_vsie_esamode =3D 1;
+		r =3D 0;
+		break;
 	default:
 		r =3D -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 80364d4dbebb..9710184d883d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -989,6 +989,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
+#define KVM_CAP_S390_VSIE_ESAMODE 248
=20
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
--=20
2.51.0

