Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0174746CA;
	Wed, 12 Aug 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549045; cv=none; b=ir2GQTJgsWvHtfd86EjO6pm2wccKhpjVnTPgNDYFIE8g0i6zo4/tyJLp9CPj2BSghlEy0SfkcQE9MlXHkwuiFfh4HCKC4rJQeogjExZWG+NuxncaqFuXyyhPpBIECzRq/4VC6mqU2A2MINX8yqNZLwIt6UPXBLDEaZgAIcQVwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549045; c=relaxed/simple;
	bh=o+ArixxhzEvIDUW0yFjfwDcFjlvFs2gFgI8Y/2J+6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TktGk/KJzMB7TEmGtl+3v2TxMQl65egwXifh2Lsd2FxZNhAxHCl7bWMMWPrd1h7OEF6lOY/ak4Gd+FCgqFTyl2mDQU1UnrKRPZIbp2q7Xif1j171kbiLMpGKX0GW6dhNup1z/6/D4SWhQoPgz5DrTDJCjOMZgqspl9zvKQb3NMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pM73YVOr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pM73YVOr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1dBi3717242;
	Wed, 12 Aug 2026 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cl76esLcWjymMPYNC
	2q4aJds0FA9d90E9bv8u7T8wTk=; b=pM73YVOraZ9L4kLBoj7bQdvCw+V+QsHuH
	IrxygcItbD1PcAMFNwfUnvcjYarpJuQNiSNnQsK5d+EOnkbCO9SBdNbZMf82N0vn
	zqUdOTBMxyDIwNSsKpAtkq8SGD/5/z6G9G0rEBluf9S7u8DLwh/FqYkowkWDky/w
	IuNgGKFRt9B91ogZOGWeYIFKcw/2ReaXPs8V0QVdDcDwgn7IaT9sVViE0a+TGCfS
	0LCxR4WFVsXgTtlEJQKXE5Fb5F90YpomIjvc7f/GtP6eaH6P0Yle/ea4KzZxNJ44
	iY5bMfJeYtQdU1y6BUdqf305mIWdj57MA9IneA8gpcZfMZ/X0DP2w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwads4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQHmj011835;
	Wed, 12 Aug 2026 15:36:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6usv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaXaZ23724610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91DE72004F;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C89A2004D;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 03/33] KVM: Allow KVM implementations to switch off MMIO independent of Kconfig
Date: Wed, 12 Aug 2026 17:35:59 +0200
Message-ID: <20260812153631.3376090-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c9306 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-AqJVl6EvvwGbS2dlloA:9
X-Proofpoint-GUID: qeZTNIEAxa3y3BEKND009Oy6PQoaMMSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1yLHaTv0/gQA
 AMe15tA3bTGbhZnvvcori5MJYebtr9sb1pUlWB8Ufe2n5CXZpLh4c01kq/w88si3lLSP7hm731N
 gdlQgkRlnVFKKlImeOiVbFIUrwuKEaCXXT4h9aMQnZC4FEtaPxlbjNkEQn9Ju5iyv4WH7jXPxK7
 PDzPNN/CVOC/eLgmhqOuOKGjCAp585gt5oSsUTw+bGQOkg5T6h6pXwPlq8ZtH7H+txTDn1TxgAb
 bb/Phj7J+f26hKARCjJE7uhVX+5lTTRqBKKjFMf2t5QVvaTuYu3tWcy+gZYOzG9JVSWAY66wpYZ
 f6q/uWCkg3aku/jLvj2u9J7k9GQuUWNzmcRxuUfuLNEbeKgzxndxAz9ovdjuL4rUWJj7vjZwtl+
 Ci8qxxE2v3M+WcVw/5LKOmZ1OgcuD90pyIzg+tyl0C6AxjeHqfZrhSeqeS8C2Zyc2qr0j0vONO5
 tyZ9mCQQc1ALfU1eQcw==
X-Proofpoint-ORIG-GUID: M6iwbjeeBzLS_qIaPi5H-SJ8HN70rNMe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX+h4ZucUGWXEY
 Zkqpw0M33aL9ebdwLcLV+rQfSXMyq4uvM/OMagy2Lzg9UkDofeaAf8hGIPFkcXDYQMx91W9GFoa
 7yaBcIPGPGYaDmk5wXZOponH040f7rg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Only defining KVM_MMIO is not flexible enough for multi-KVM systems
where one KVM implements MMIO but others do not. Solve this by
additionally testing for the non-existence of KVM_NO_MMIO before
including MMIO code to KVM.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 virt/kvm/coalesced_mmio.c | 4 ++++
 virt/kvm/coalesced_mmio.h | 2 +-
 virt/kvm/kvm_main.c       | 8 ++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 6b1d90161099..8ff9d9a6f47a 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/kvm.h>
 
+#ifndef KVM_NO_MMIO
+
 #include "coalesced_mmio.h"
 
 static inline struct kvm_coalesced_mmio_dev *to_mmio(struct kvm_io_device *dev)
@@ -188,3 +190,5 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 	 */
 	return 0;
 }
+
+#endif /* ifndef KVM_NO_MMIO */
diff --git a/virt/kvm/coalesced_mmio.h b/virt/kvm/coalesced_mmio.h
index 36f84264ed25..826af421a5be 100644
--- a/virt/kvm/coalesced_mmio.h
+++ b/virt/kvm/coalesced_mmio.h
@@ -11,7 +11,7 @@
  *
  */
 
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 
 #include <linux/list.h>
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0b34477bf325..a5dcb38e80db 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4063,7 +4063,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4904,7 +4904,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5245,7 +5245,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5580,7 +5580,7 @@ static long kvm_dev_ioctl(struct file *filp,
 #ifdef CONFIG_X86
 		r += PAGE_SIZE;    /* pio data page */
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 		r += PAGE_SIZE;    /* coalesced mmio ring page */
 #endif
 		break;
-- 
2.53.0

