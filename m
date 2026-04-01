Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363163AA4EB;
	Wed,  1 Apr 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056362; cv=none; b=gYQ+UpogwoCG1AognBqv+vr9YdtBa0t+LYdbt6WBsrhM6bQ9Sp94TNvOjA7hfSjEfAsgV7Tx6kmzDxtQUk+kWXV7Q8f9F5TVZo8lbnFUxQiGX6t/a/6ckNrtFHLNhKMN+rU8huhfKN8Me/8iorpteZGD5ONjZEde5Ky1F9pcvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056362; c=relaxed/simple;
	bh=kHThjxwvmqkYVV3mkA6wOuw4mX1814E/BTGu2uWgy10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVUBrINLDQ1gtD1IaHc5u1EnpZpZ6E7o4+fwv87pg0FxsQbZkmiZWu5xb7cPV9llHIAHeWAq4QG5wY6l6FHLgnoVZTVzIzoQbfiycnOhfAsSr6EvFWKn7QimHCeOBPFTi4aZ+puDG5XNmfburxrMMnSrEY/doTHDZtfZgbKf6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LT7GGQdE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LT7GGQdE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Bx6L64003715;
	Wed, 1 Apr 2026 15:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0cZkdDUWhrJVrREU7
	YZv14wGvAQnE8FB0w/BLMulO2A=; b=LT7GGQdEQyTO7urzdewe3QYfbq/Br5h6Q
	499NaxLcLNfwZVKHl3fnCcjV0GjAqgrkdXDHs0vjlJVB8Sw9DOBbRyyKP3UYScbn
	MvGkjKSMEg9uSGInrKozLd+vuNJ9e0TJY1LOv1YSSnUJwLlJ5ZMk7iILBPW+9yfF
	q7aB6Ug0ZWyKq0QdEXc/Pra94bnX25I+xPieb+EBhLyq//ZLXuG6v/OHUgps6Hi/
	4xRmNa9lGQwy0MUMHAbRVzNg5+5sBdN0pO7v3fdCQmCOBgD1eojI+UBBsR7txJ6f
	up/86HpPMWshEdhXlH/5NKXH9ZkuEpsIo2mBsdWpxmELactcOHOQw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcg3rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CEWC2013898;
	Wed, 1 Apr 2026 15:12:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkp2db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631FCOHX49480110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 15:12:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D54AF20043;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA83520040;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 91A75E068C; Wed, 01 Apr 2026 17:12:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 4/4] KVM: s390: Add KVM capability for ESA mode guests
Date: Wed,  1 Apr 2026 17:12:21 +0200
Message-ID: <20260401151221.2272408-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401151221.2272408-1-farman@linux.ibm.com>
References: <20260401151221.2272408-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd35dd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZXKDrtGt6P313FoxNToA:9
X-Proofpoint-GUID: bZKD5kGx9kGiP4safMM9FUd-b7NXaOUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfX50/zkCyc21Uu
 E7GjZKM2qtduT990BZcNbNPtR5yJpFtcvrJ1ZHIwIFEbAW6dqBXBwZ9A5P3Z9qWoSMlFqozIHqL
 n75HGYBH0un4ux0oaTuijR5gB0B/VcOJnUA7d5idRM5mkaVcOsHxsMF0z9ViwREQbingVoOsX3o
 M6FU9WHQc5u8k+FkP0zMZBulmEU0A8mvejI5PRh25JTyzaQUZdZZA/dJxC1CU7svcJ9x7bZ607o
 KmBUSj5N/bnoLwviJnOLxno0ROVCmSR6LPS7R7/UINTdtRFG75TXcoZfowrfyhKPoRLHeDWYF9I
 A0ho2IywZxB8yyniMM8FlMVOlZX+39+32hUbnG8UZp65BHf+FmQNv51QNmFL8HS82ARSVDUpelt
 psXptGh1N/DJAVcsuRKrg+faeDbcuwvEeM5hStu7NCq8v1GQPSZ/pmVOHNcuBF1tmdowQhIvdr4
 uODNUDZrGQ/Yso2C4JQ==
X-Proofpoint-ORIG-GUID: bZKD5kGx9kGiP4safMM9FUd-b7NXaOUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010138

From: Hendrik Brueckner <brueckner@linux.ibm.com>

Now that all the bits are properly addressed, provide a mechanism
for testing ESA mode guests in nested configurations.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
[farman@us.ibm.com: Updated commit message]
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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

