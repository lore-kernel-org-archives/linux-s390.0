Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB637646C;
	Mon, 31 Aug 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187715; cv=none; b=foq8Vrgr3XMTWRy2+xj+O2CcovPRSFdPAlB9IpYa7bAOrLR20EFU5nt2cvJECECjhKHZHzsJzCwTAS4DKWaIN+0ZqZ2imzyPL7l+KHo5srE/rO28UUESCpB7U6YXY8dhI19fKcXInNHIs380WCgFpArZi582bk9gltpYEKhafVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187715; c=relaxed/simple;
	bh=CeH09pt7vIYul3jPdQFCDPibyk3JwItNfJmX1KxMLRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUYbWms6I9HUpM13gZ+zk4s0ZvqFiBQ5pemCtkb+qlqibyRBNLmxC2G5TthjQEGpKTUNKpa98gzd9WeDipDTkvxh6qJL6gd5GM/Ce0x0P56eHXOA0nG7tOCL2vYnJWjI/JDV//1vHQwx43i1vBusYNhnmpt5EcPexMOOS2SCABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fmw8/Zgm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fmw8/Zgm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ0862525249;
	Mon, 31 Aug 2026 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lm81A7q8yUyeyAYX/
	W1p02VJiYIZujE9pM4JMcxdrYw=; b=Fmw8/Zgm0hjQ/jjbUirB02oIHKuby/ol9
	VYBKs7fj/fdDP7WC5Tk/gU0mP43hBEJ2BcLJDBebtzDYGwtnVsRQ43s4Cc/wJ1aq
	oSXctwlJl+Wjg/hxj32kWqjt+n/RNNc/HFqQeVNoT/zylezGfuxokdFBQnxxudxk
	ayu9+kta3SlVwZDMqLHJAwGmRUOTefkzf7cO6oy2usX6WuFG3tNh7QkTNB1fvBSJ
	Opxe8rPBhZ/N4NmQA7S4/LuFOA3v1J8Ss5ENGgdvyXge0k/PH/KchwK96sgyaSvz
	W4faU19M0OIfWN0zgwW36YPxvM49yUc96layQyKNFdkI1wgKl0zVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54hyay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfdOW000453;
	Mon, 31 Aug 2026 14:48:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg694q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm4WG37093718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 893B02004B;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 204302004E;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
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
Subject: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off MMIO independent of Kconfig
Date: Mon, 31 Aug 2026 16:47:40 +0200
Message-ID: <20260831144802.834315-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXyea0EW5cY30x
 R49s/wnf8QDs5g7TqQFqng8ArIqTQk3isFN6UaHvz1tEQKd+RH9kHil67Awpz/e9REOfRRDIr9g
 6lAJ5uQPWf0KbOK6Z9dPcVsu6YumhLfv5Oplsv7ccgFR+1c/rRX3YOFbezUWiig/hyOhraSalzZ
 xxsUWFIylv2dyFTucrbowZov3whamCdLUhvhNHpMV6lDU5p4YVooys/P+3jfud/oxHTO/yJqLNJ
 mRo4Ij4VNCmh7wvkSX7PFBvdj7iUuBYJKGwZZpvioqzCPNMLnfSVTnUJv/IQa9XB2w7tYfBMZY4
 hySG8k8ZZbqMWoRMJJITNb+OEdqYSDb7HC/SOq+IlfMlUsvCjWpKfmwx3uzqO2yph99X9Lkx2uZ
 H81Zsq3pulkJyxGZfYCVerUMC2EnA3UBsn/P7GP2EtuOK8VcOJl+iRsylWet4FIj3y/YJVuyq3r
 jYPifPWqA5KKlq4g9Og==
X-Proofpoint-ORIG-GUID: YiytUqZHHjArbaiFh6H0IRcZUVP0zVLN
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a959429 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-AqJVl6EvvwGbS2dlloA:9
X-Proofpoint-GUID: -RNe0SPTagOhxDtVZBKNWb90rqdgXg6b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX3oWhY03thxTU
 dficWllLcdrU8C3uEMdu0kV7weYDkukeDdGX1qheMYqxEcuYlfRpRB3uGpkmHROTnK/k/wyAeG5
 0b86hX4m+G3nyt9NP3zbZwTxMuPnhfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

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
index 823b693d89e6..7f37d3b5af48 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4061,7 +4061,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4902,7 +4902,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5243,7 +5243,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5577,7 +5577,7 @@ static long kvm_dev_ioctl(struct file *filp,
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

