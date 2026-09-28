Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8505342CB3;
	Mon, 28 Sep 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600860; cv=none; b=hgYuWCPzLyATzP18jDlvXr+t7zRaKeIEOlVtvLSw059Ns+C7Kc3/F6bq+dECfqJEltmGK/jPOpXIgRRqFwd0Az8QYn3ursQR8EgN2waJaJpiw0p7t85F+ME8BlC+TBif+nFgSywWx9SfeDZSsG0wmAV3tqY19cSsVBKOWkKPQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600860; c=relaxed/simple;
	bh=eNSLBM68o3uL7AE1H1rfme5raxdSsyCkCnns2hVYH8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qwg2EdyyyMi74sa6tfc21RoKYtC8Ggye60yu6shWMfVYymJf0vMPFTNY+kXW6VNeInF1GqyFb4v6VEqmHQDEX2NnZokXM0Xjt5c3Ct2JJmRMU6NqpYyNksWkNg8jZ31cOfOZTVoEePP2sIuwkrihfKi20VV+RPzsWOW/v1LXSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiEu8g/s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiEu8g/s"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZWPb1047068;
	Mon, 28 Sep 2026 13:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RIkmhq
	GyevWqPgH8Mh3BVT1nbCwPHPnA2qGuYY/811w=; b=DiEu8g/sfQr8E/h2Kjwsfn
	zpOwzOcu9SZ5ULrS/v3PSnLm5DS9VhntI0R1M9BzQwmlgzl0QlzaJvo4WqBVNDV5
	M/VlAFJpWYgSKNIZUSJhH0JSCaLvS//PiyELkXoKWh8GFygwKoxPpgSbcf8NTjen
	LAYSUvfn1qGaYm432hXxPyIYfCLmQ8ha5VTUgbqEjweNtBdDBPHBgCky4wsUojDR
	3UYRRU3EK1t6LeEm3+iXQUW2X5rMmAwPePPCi2p9dXtXSvBD1NqQ83pantM2CsCf
	lIwyi1FdO/ZyAYtgL/rthnjsBBoL0dd8uzxDWjXyxwmguFq4Xq11eIjymbpth2Qg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j51g55-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHZl22943266;
	Mon, 28 Sep 2026 13:07:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg54h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SD7FeS47710690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 13:07:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0146D20040;
	Mon, 28 Sep 2026 13:07:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC88A2004B;
	Mon, 28 Sep 2026 13:07:14 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 13:07:14 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Mon, 28 Sep 2026 15:07:02 +0200
Subject: [PATCH v4 1/6] KVM: Introduce file_to_kvm_<arch>() infrastructure
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-vfio-v4-1-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX3xygYv3utvLU
 W6HH+z72xFzPlQe9icG4lXMNxyXvY+EJmLP2kANmx7prwqubREtLoZ14stH4g0jmkY6zLfqKRk5
 ZV6UPLzSAGhXNQOlMgeaWTzpah33bPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfXzsaaO3ywd6sY
 wpF/zX5MhIDZ3w8YisulpVkyY48mOg/8iiFovRag4+PbH8UqJLpZac1w3KACBYJ3veDhV1L0KUI
 JJkA5ltC+q8npjDFfpygKCiwTRSV+nOWfI/a7N2nCyDK4Ry3ajZ+57P/acURgDHK5SgcYG47wU0
 tw8Bdao8ukEhVLvwlWDeq2RWsIN/MaLem5ntTbYKIcY1SZAHc+qLNUi2WreSivD59kJujJUCylo
 BKcOjZwCDKJDnJJOajeAh308BwOk/SJVnaD2v7YAI3yVpjY+gKXEoRgh7X3QKn47aVLWWQujbP+
 axiXRtWWU/GYRxKcUGBr92mNUAlqeBhmzSXp0r2BFQAyHuzDIWQe07f6zKUlGbTDCbvexueivOu
 TKB+DGEnZOAoAtnhUV/33pqkTIkiP3k3b+mWgtcbViDEHzTlc/cRG2hMVb09fUmqK6cV4v3pbAF
 uJJwF3vahSmWfWCbygA==
X-Proofpoint-GUID: gP1owWNOuqAP5COjtLtA6Ye1zgTseCS6
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba6688 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=AxOYn98-_IzFSfPWV6cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2uZsZ8qMYX_yORY1Yj74wTQmPGYmZmsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280052

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
index cf7fe835c4ad..bc3abfde8393 100644
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
index 85f42289748d..07fc874a38e1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5519,6 +5519,17 @@ bool file_is_kvm(struct file *file)
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

