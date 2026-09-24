Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD5407CF1;
	Thu, 24 Sep 2026 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240343; cv=none; b=QGmdJkZvDOQapP2KgwG2p+wBUxePB5b/WEFVInPPCfgh7uw8ubYmKldyduh9EVl01R+CwgKLH1sqcRjJwZHH3/z2FIUnJu1OdHsQebzABZOM95OutVg6IEGsGywbPFWodHOsvMHy4dkNuVmh2xUsHm5YpGj32m8M9k59b73XzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240343; c=relaxed/simple;
	bh=N5xjJ43H6LVIEP47qdjzgN2ngxPJH/ZqiqzQ7X5Sqi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L90SIFxLmDDuuqZ8034uRezp07dlQFTXaTddcEfLlsaTkCd5Qal3AHWpI6E05juPeuIZ1x8ofPHvUXpn1ZdeINoAUM3JWk5mK3HdFoI7LE+ct0yfhfbk+aH+8/v3OuRSf0/iFyxxy4NFg1wF1Typfd1KOGok/KuhAjt96/QnvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N76B7Aj9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N76B7Aj9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bcc41334222;
	Thu, 24 Sep 2026 08:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AfwhzV
	SUaurBzJJbI5e3/z081SfoueGXHXFoKKsRDgo=; b=N76B7Aj9cghQK62Algyacc
	uYyZZAKgYR9aneBT34BSMxprnS12uAkyyI01L1q3ouYwis8iWn2YCBJ0MU2FSc6h
	sFxyhwGCTi2wmkjvxVOfxc4nOmnEVlkTFEcMbjY+2eOQVvNF9CRwHHMO0J0lkAx+
	lxFGq/5fkW0iS5GmRQONEkQpk3bmbbjx8a9sMw5Agk5KKylhmfBHN4LtZjQQCjNI
	dHtjXLT54pYbkvzoWG+scWWLEf6Qdrh8l96R6miHenCsWywvUoe2sVayz2k+EcR8
	G6IBH/SZh/UzIT3KcKJI0ki1YPzO+0cXdptYZSPcFKpo9N09vSgTNCwPOSU3c6NA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsfxv9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5ln1M1497550;
	Thu, 24 Sep 2026 08:58:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8vsm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O8wdXO27066708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 08:58:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6303B20040;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C1E52004E;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Thu, 24 Sep 2026 10:58:30 +0200
Subject: [PATCH v3 1/5] KVM: Introduce file_to_kvm_<arch>() infrastructure
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-vfio-v3-1-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4e644 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=VUxmUKdmKFa5Qofq_fQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uLuEqufaIZ5cs6NYHZQ9U-l5gHNBpHat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX1gL9LwzebFpf
 UQ5EwtFcQeIWml0jVpycKvVrAKxLsoThRLGTo5WCK5s5sDRk3xSo+lvJQq4PlADil9FlF2fsf85
 So6H1qP+pVj6fjo1cT4JiNTAcO4+dj2Ij7Uh/yFPZIjYTVGE5JKb41NSkzLDjeJuNUSpzOx+2vQ
 WUXcp4C1XqU/91Dr/xaXF3xkuhEy0Zwn54n8nm43UbAG3UN3SYlTgOdkUWNYakP9zicM7KPXn/U
 7Hjtc0P+CioVo1pXbjcOX3qjOtnh2B69CJ7A7zgc1Ch4Kn0L5EwUkNw5V7dVTosBMh/fqjAvYxg
 hMcIk7+XZVxBkKNP/oU14ef1TGjqchRufqCyDANYFqvX2314c41ZCCHJfw7DRgkPHJsEAeyoRlb
 KDpO2woOwECmj68S/i4D7ZXEIgs+aHyBQGfyk6e7Sg4R28ARJsFLT9uL4zqD9/VhBhezB6sUrNS
 YuuZ6h8kM6bbyBBRFaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfXwryqhvXVDEPs
 05/A7Y/xxjBsEumw+h3kRWJWwHkjPE3Kd92fkYttPTgMVNoqbx5YQOPqAuPYZh6Vg4HhXe86aDa
 O0PCPZVuSVOrhQFoGkIGD3IOOu/inHI=
X-Proofpoint-GUID: T5-PJYg2jz5ldbzAFUNTefVn7Qg7dTCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

Add a macro mechanism that generates an opt-in and arch-namespaced
file_to_kvm_<arch>() to convert a file reference to a kvm object if the
file handle represents a kvm handle.

Activate for x86 and for s390 (native KVM only).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  2 ++
 arch/x86/include/asm/kvm_host.h       |  2 ++
 arch/x86/kvm/Makefile                 |  1 +
 include/linux/kvm_host.h              | 12 ++++++++++++
 virt/kvm/kvm_main.c                   | 11 +++++++++++
 5 files changed, 28 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..8a7eed5847e1 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -27,6 +27,8 @@
 #include <asm/isc.h>
 #include <asm/guarded_storage.h>
 
+#define kvm_file_to_kvm_arch s390
+
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..e460073ff176 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -44,6 +44,8 @@
 
 #include <hyperv/hvhdk.h>
 
+#define kvm_file_to_kvm_arch x86
+
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
 /*
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 0474604ab8a1..e6d395ede9e2 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -61,6 +61,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
+				-e kvm_file_to_kvm_fn \
 				-e kvm_get_kvm \
 				-e kvm_get_kvm_safe \
 				-e kvm_put_kvm
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..e840ceda9f16 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1082,6 +1082,18 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+
+/*
+ * Architectures define kvm_file_to_kvm_arch to <arch>
+ * to get a typed, arch-namespaced helper:
+ *
+ *   struct kvm *file_to_kvm_<arch>(struct file *file)
+ */
+#ifdef kvm_file_to_kvm_arch
+#define kvm_file_to_kvm_fn CONCATENATE(file_to_kvm_, kvm_file_to_kvm_arch)
+struct kvm *kvm_file_to_kvm_fn(struct file *file);
+#endif /* kvm_file_to_kvm_arch */
+
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..0172ca94f82e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5496,6 +5496,17 @@ bool file_is_kvm(struct file *file)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 
+#ifdef kvm_file_to_kvm_arch
+struct kvm *kvm_file_to_kvm_fn(struct file *file)
+{
+	if (!file || file->f_op != &kvm_vm_fops)
+		return NULL;
+
+	return file->private_data;
+}
+EXPORT_SYMBOL_GPL(kvm_file_to_kvm_fn);
+#endif
+
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];

-- 
2.53.0

