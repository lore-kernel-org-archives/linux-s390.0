Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97F3BC68A;
	Mon, 13 Apr 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077278; cv=none; b=BIpCXIAKUAyt1qEFJ4T2wcK3Mr659JMxlfNVXyu/ylQ8EIo1vtI/Gj8R1zp06kYnpXkcL4E65Pd1mekmH19Axs0qyFnWRnA3+2z8Ps1ptTEAb0+eUHu+EACCTJcFBBRWvjM2gSpP1PMxZhYSlIz6HQViUr6Y+QJul/vABFqt5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077278; c=relaxed/simple;
	bh=JrBuAtpSyy+b7wEnmezW/C0R/sIy1qkSlOM3WJIA0pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhvpzFFabmCUXdk+3HV9SOMAQbZIWXxKn6vvahEUwFxQl9fN8wXrx9P+sl0rmwGikmPCLRvO8iuF7bBS12fFUfwZHtJ0q1dkBSaf8dDPL9eunn3LpMAx9CeXev3m/LR8gyMSWZAZcEz5ZVzjdtjbGRIVRFgM57F26+WOuy4FRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FRXteM6k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FRXteM6k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CNo2wD3399128;
	Mon, 13 Apr 2026 10:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lTSyzAjZb2yf0Qmhv
	O0te+2yc3oRERLC1C2HwhYBF28=; b=FRXteM6kjscp9GV4wJGiSE7X+nhAueBpo
	2JCNieLkvErHszLCJOGNxpr33mKITatEN4628jgFKx+V3GTeFKfBqRGiascUMFKB
	1hoPCr3t6ZNXZGWcpBC7vp/ucTWWz5/pwEinNEa+vsrAEbl+C/v/iKPMGgWHfkLU
	GFkFd/rd54GUPxv+/D2FnyIAGABkIm5vMaKi2kErf+At/SVFEiuPpaZj+8LpJtgK
	6NwKaYmKqyB/GNI9wwwMy1UU2Gd7AhqFpfjtaQg/B8JHiJqaGLnn37pwn22oJGgz
	BwGxKdkqa6fHOFqEmClcc/fwh1+++Kz4iAeJlS7Jc9FoU+oou6hjw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17q6td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DATZ1k025801;
	Mon, 13 Apr 2026 10:47:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1chk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlm5225494174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F3FE2004B;
	Mon, 13 Apr 2026 10:47:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114B620040;
	Mon, 13 Apr 2026 10:47:48 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:47 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [GIT PULL 06/12] KVM: s390: Add KVM capability for ESA mode guests
Date: Mon, 13 Apr 2026 12:46:34 +0200
Message-ID: <20260413104721.203024-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX051VYlb51bzG
 jKeiCKXjuNCDuEiZ1NXLDyrdyQHV6H4nGzz09Qa+0aE/0dVwnyhxfLfOBcqslKwPvsbNs/zhkzf
 aAMJFmCwbwiVr4emz10him9bvpk6CsaQVHWjrvrOeDbWJ2piNGLABmmLsfS1xXz7TqkIzhpO9LW
 JSKTs2oq+5P9rua5XUB6URxGsgYEhaQM4y1N4mV/GldTs1OMM+EZbRna77uv8dd/VULk1lgZJyT
 D3nKLObaSLhv6psLxbHrFJ39JZwxS1X8cVhdsh9Ec0vGI/2NnbycUcSFfrlfUuHVPBAiDCS0oMT
 YQNoMrxh+P74unbvRURmUamgb9ARbCqg5MoA4Zun1A2PG0AF4ZrZev+XTucuKCWQg7s3bPS0jjO
 Ngr/x0sHNqncHPB5Q7g/WHXlInQaPpql0jMCg4P/3PhDEp20fm3ztwfMBjjYG8Gdu0JTBYBhYej
 kDQbxQNDfLpfi581EqQ==
X-Proofpoint-ORIG-GUID: RfXyxUkGL0MB_9NF4ol9nyh9YdxRJOt-
X-Proofpoint-GUID: RfXyxUkGL0MB_9NF4ol9nyh9YdxRJOt-
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dcc9d9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Ij0Bwbe-95YJfI5_OS4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130106

From: Hendrik Brueckner <brueckner@linux.ibm.com>

Now that all the bits are properly addressed, provide a mechanism
for testing ESA mode guests in nested configurations.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
[farman@us.ibm.com: Updated commit message]
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 8 ++++++++
 arch/s390/kvm/kvm-s390.c       | 6 ++++++
 include/uapi/linux/kvm.h       | 1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6f85e1b321dd..682ae9278943 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9428,6 +9428,14 @@ KVM exits with the register state of either the L1 or L2 guest
 depending on which executed at the time of an exit. Userspace must
 take care to differentiate between these cases.
 
+8.47 KVM_CAP_S390_VSIE_ESAMODE
+------------------------------
+
+:Architectures: s390
+
+The presence of this capability indicates that the nested KVM guest can
+start in ESA mode.
+
 9. Known KVM API problems
 =========================
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bc7d6fa66eaf..a583c0a00efd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -629,6 +629,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_S390_USER_OPEREXEC:
 	case KVM_CAP_S390_KEYOP:
+	case KVM_CAP_S390_VSIE_ESAMODE:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
@@ -926,6 +927,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		icpt_operexc_on_all_vcpus(kvm);
 		r = 0;
 		break;
+	case KVM_CAP_S390_VSIE_ESAMODE:
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_VSIE_ESAMODE");
+		kvm->arch.allow_vsie_esamode = 1;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 65500f5db379..e658f89d5d3e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -985,6 +985,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
+#define KVM_CAP_S390_VSIE_ESAMODE 248
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.53.0

