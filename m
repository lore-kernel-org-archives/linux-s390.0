Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BC432BD8;
	Fri, 31 Jul 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503386; cv=none; b=g7TxZpd6ONy6XlddSIUF5OCE5fs6ezlDE7ZTFUxQ/x7SgkfP0wrwMcMbobuTzT2enMGUJbqJA8+w97Ed4auOmyq/I3dWGibg3Vi96CPN8qNJjcMq8NMRcxlMpLdTRsc/fUcyV1JOAV9+NvOqf9SABPn8qseTxyH1OYuhgLzLSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503386; c=relaxed/simple;
	bh=fPy6BToqWSVFi7Y8MD2LUMyFUKrIGQ+wREW0W/OqWns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uudBx+QD1aOM+idDvjiA8xsyZejPdDT8P3uQ6oSOHLzZjqNFulOnnfVR0hNc/9Ae+rTLV7UL/X7+F4ZDAM/ISADkUr4Q7WtO0ntuaNEqqiXSh2EfbU/ObDpkaXLYmgqWc0wZCmrwt9zsUAxvRov2pY8Man60B3g6Quu/ec6K/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dNGUpXhf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dNGUpXhf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBliK81672742;
	Fri, 31 Jul 2026 13:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2gSaLBoMbRJk0858C
	Xqy4+SLu/lbitIoLn80Gt6/yDs=; b=dNGUpXhfOvRJGFuIelKol659hb+NjyKHT
	JxwlwSeV6G2SMSFPSWDmw9lc/4E10qIHwBcMO7+jlocWLZ9BbLpA/2FVhY3XiGDh
	7cRSQEJU0XKpqBDiAYdRB6YPk1Q5VlUn0LT3aZk6ueamMWoGXBPQx8xi5Qu+AAjk
	Ypzuz8jwxDsILS/pmX9RYt8QncQUbe5Q8OQ7r4B44vNyZADcyB4zep493O0Zm7tN
	JzqqOK1WeQgyDyJZ4f5yx+4+RfLeAKTC2Z5DmMQ+3Az8LN36dfC2mGkn+0LQ2sHV
	WuxnxvqqUTg6OpQJ5WQTyOxz1u10ctyTPxwznglKTI3F0NM6UcRBA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p43bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuf3N013237;
	Fri, 31 Jul 2026 13:09:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg087-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9Cfg28705030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203A220040;
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C852004B;
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 20/31] KVM: s390: Prepare KVM/s390 for a second KVM module
Date: Fri, 31 Jul 2026 15:08:48 +0200
Message-ID: <20260731130902.654679-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxvu3QdrVnJRF
 G1P1zhJkRc4OD/4/VTO0jLV0BgY7D02WGhE7XIhLk6z6IiFWrx5Rz8WUDuHaWBt0QuzVQsP41sF
 tDxs5gCUrXO/xBS3qEfygF6DLKq6leU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX+1t/x45wPYxS
 OCe61xI9WFRYMNx1UG2XCYA/WpIHH9kcufgOKSBZa456PejCPHquUqb3UYhXlptxNYlY0w7Hf20
 SVtg7OWzCywcCyvHtgOvXvffs4A+4MVWHbHzsFAA7Ad2ZeK+z9M1DBkav7cQuHOeO6KIQxyB/+5
 z8Gz6UEjEuHmTBfEd6nfLNraf+O0mnAeWeFVNvnxQqOF7GvCJeWfTqc1gwfRStFIZMfLHZrBjo5
 r2dyBNxTDYc+joCsQVG/nisg7cHyJxtSSLPUf7qF9QcDCFq6nqaHqbEbDnhvU5msW7dwyHaB2CL
 /9C1L1TPIN+11/9XP3sI/ze3KJmLg5gOzZ9GIeHManjeUst7zgFkSY/4fpCWY3e783BO64PCuc5
 QY8W67R2VJvO+h9yibm2zvnfpZrEizBxWn9ZG3yr4YrdsyTPUAwEl8ySSKkqePvEzfuOvPMs/ke
 noJV2U9VGN/UXWoFPyQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c9e80 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=m33X-YrdrFVFgJ0cfecA:9
X-Proofpoint-GUID: Edqq77U__IiVRQ6VD88KJjp55DSkAmU4
X-Proofpoint-ORIG-GUID: hQRBE-RHYqs791nT1usmcThQoNWi3Wbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

The second KVM module will have a different Kconfig set. When both
modules are compiled the Kconfig sets get merged and the native s390 KVM
needs to implement functionality required by the respective config
options. Ensure that s390-KVM will still compile by implementing a stub
for kvm_arch_vcpu_run_pid_change if CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
is enabled and defining KVM_NO_MMIO to disable KVM_MMIO.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h | 1 +
 arch/s390/kvm/s390/s390.c             | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cfd95df60130..c753dc816b02 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -29,6 +29,7 @@
 
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
+#define KVM_NO_MMIO
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 87d4b25bc849..0e43754d9cf5 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5829,6 +5829,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
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

