Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F33B19DE;
	Fri,  9 Oct 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556097; cv=none; b=G9IhL7/okdNlsqim5jJ63bFw2dYCFbTPyGwLSYA6odsFw7YAvwnoGCGlX3wpzWG2UK4m+eFiicUWAejQa46Lx4fgxXKdE4o83ae9umEawvtk9dZjs/tZ2Gw9xV1axAuNMSXBCcFV/ffJ1/M1eHpf3iVtDuM5HfJw4dwhHY85JI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556097; c=relaxed/simple;
	bh=19ypYp/v4vsKSJ3vvmPf3lDmw28YHQhduPFRx+hyo70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsF2Fknw0B7G8GOGV4ZYQ89zzIV8rJiwajFBQdR983Voo2F0TXX6EQDZisA8eVWMNYajj/aQZg4aoQoBvxcZ3qKkYmVcJf4emmI0b6hJ7vjURZ5RitZthuMMcoHwPUAa9B2zuARajoeyAD5DO1McW5zbQszWGXGsN1xTD6ravgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tubE28ZP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tubE28ZP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZqit3214214;
	Fri, 9 Oct 2026 14:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HB+yBe8DhnFyfwjFw
	XDcZUrz1+z2tOFevwLpJgiOY2E=; b=tubE28ZPEL+FwJ5T8fuxOZVThvCnqK0/X
	v2sIev+4a9DRi05fpW+BjdlrB9Df/n57Uj2fMmC0BtBWKk1osnYZO2DGW5tKAvHK
	LpzY6FEH5lkhbOXfrVAHMCtFzNewJSll36l1PcN/07DRnAjtcpTo+KN5BCGxEcsd
	Z069DweI51gjqIbJmAaPcSCmG0J9TZbQhE9frkozft+vqDKsWhnPKDTJ9S0Okw4p
	f66s/lv7lRcnGdeIaX4KyIj5B59i472FRZ0gU7tLvgEkJmVpqoUble58bI0bjNJ9
	P1gcIE7RiMaUvip58v+x8aegQmwnrOAFSQZNrbyyyfvB9WRPtdjwg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1je9u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DlU3Z931727;
	Fri, 9 Oct 2026 14:28:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s3511yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ERxRf31261368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:27:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A85358062;
	Fri,  9 Oct 2026 14:27:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2479B58059;
	Fri,  9 Oct 2026 14:27:55 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:27:54 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL 1/6] KVM: Introduce file_to_kvm_<arch>() infrastructure
Date: Fri,  9 Oct 2026 16:27:44 +0200
Message-ID: <20261009142749.186650-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac8f9f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=VUxmUKdmKFa5Qofq_fQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX9+Z00LNNH/Lt
 gbXGB8bTatlJXPmLRFk7SKHAndHiA+VnV0wraO7mThQBNeuGqbjrLqdS33GT2YRI4kkT4V8gzK+
 TiddAon5xUtpoMOHV57f8oRmIoDIDe/HjYdiCirgIoKxSvXfUYd3x0V91nSlmWRNOai1YLF723S
 Stil88JUQCov9Yab9lgV4UwcqqtgOf9j8oNLeCOyUNP1E/+6dAsSA3wPIPenUd2RO8kWTLvpeEv
 jQUWTJvJK5pysR8Dgi52/iiBMKinpH91xeP8wdkXOcOg/PNMWAL1hbB3gFXhKf+KDjLNSHNEGK5
 ACcllhaGH5BGlXKk4PbRn+Si9XoI5265HRbyRGPQiLXihSUYM9Qi4swRWBzjgp7NOK44XxP3het
 6aWFkTysKyI1LQwzFgY6u9ae+xVhLfmdv1Enibu6UZDZmx8GVB8ZqDn6BaN/GJdFDWdXpxKI/UN
 XkKyg6MSDm9vuAH34uQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX/TPYwpWJKrwU
 PUgMK+fkzmkVbg0xI6JTEunW7wKDyPEPAKsyhaNY/ZOyMDgcicSNrce+CTTcVJtwesNsQr2r4rV
 MYXPZz7o+ybBO/BdaevKSRnoOJNnBIk=
X-Proofpoint-GUID: AUqiXkI-q3I-b2QZGQVUMU81x0vxKbLH
X-Proofpoint-ORIG-GUID: WMLw_YCYW9YdSkT5tyR5nCB3DaYNpk_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090056

From: Steffen Eiden <seiden@linux.ibm.com>

Add a macro mechanism that generates an opt-in and arch-namespaced
file_to_kvm_<arch>() to convert a file reference to a kvm object if the
file handle represents a kvm handle.

Activate for x86 and for s390 (native KVM only).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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

