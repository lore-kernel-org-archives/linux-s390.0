Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59ED376A0C;
	Mon, 31 Aug 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187716; cv=none; b=pl3fH6luNhekKjCNLsSHJgZsIjugHsOzofcOZ5Jy66q/q3vH3FZRaM9mY9myTtTcCsTWCMm2EdQ0tR24MwOmBkU6omK2/pMHWBAl1kbEnCDV0Vycb++3MGjEeh4CgzAIScqUTYqW+yeeEIONtM+QyNEDbFT9x6tH5/4qy30+o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187716; c=relaxed/simple;
	bh=6YXLXoVkYM7VWNHYea2pkhZPTP32ewjhhhJu6DgMJy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtlwJHp2HMe7GJa9F4yjy2PAjsQTbS4mbXL5/RL5GjSQu0m8/MV1NhmugojNz2oMHZprzI7OcY8DnIZLt4v5iy2NTiM+qYEuVrzohjsScTOqQr29ubdZLSX1Gt6G+PPOEVI/FU9YSbbakn9WpRadR1vaW/YQc3Mm2/OKOZJRmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BCa1/JBC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BCa1/JBC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9ow652812;
	Mon, 31 Aug 2026 14:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1P3UO6IfWZPSKnMp1
	j4c5L7mrnouk9JbKlUKtFhJ2tU=; b=BCa1/JBC3YnAoNfZ2NNrwhJS69aGph0e7
	ihLkq6GmnhF0zDcR6YbBOTbPtC1/HwI8oFQ5BqW2Mud1Ufp6KCmiDcUX3m6wEu6u
	+dH3+lI+BaGwXWg9zfPAx8dnhCk4BV4OzaTV66oot1kCzvdRRW6ebrD7rj47yW/x
	3JUM9X9lqX6ASF/80e4uV+JHoePQFrmpXBG9GV01JnT9aStUFIe1O/yZmr04ei+M
	p1uWRri95vI/Qf9AAOKR+UpH8PXAdtdti3qkQyeIjdZ5MiR8LdzKIIHBxHvRKD/G
	/uKvcDLYYkqbL4kTslTYdKYSeoIufTseHDKCxiazEwpgjJiXW5vMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r1xus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfics000505;
	Mon, 31 Aug 2026 14:48:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6955-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm9oK17301836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F99220043;
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CBC32004B;
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
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
Subject: [PATCH v7 14/23] KVM: s390: Prepare KVM/s390 for a second KVM module
Date: Mon, 31 Aug 2026 16:47:51 +0200
Message-ID: <20260831144802.834315-15-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95942e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=m33X-YrdrFVFgJ0cfecA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX3BbrAGFertYJ
 P9NDlfIhGqvRWkFjQCMLjT2pDEgZiT8JwNFuvfWSeLwB7gi1E6DFVg/P4dyUREP8SZhL0FSlZdY
 OsiRMU5xwVKqQzn8vThDArsXe0Lz0IkJtvJewKznTv5P4LCiMcc6wYfL28WmIR9BzAg47vrrzwD
 P2q+cCQorwmN6xXqp8L55l7kZUa/DbMh6BfWIjQDn9EwLpG6JGIpIJ3rjMsecK4yNISSEkBx+cI
 aNhm0WX1qhjUYZ+CBnmJnRLryCdgh1XgVUCYfmrDiIDSyZgoPK0Ele/t2vcHL60D+yMgxnKTQ1x
 4zEYBztcB3WRCt0U5rpph7F6dnFvMSzbV+tL5DIz3I+Qask2HTuu+ZCJ7p3+goLhL3sCCQExaU2
 FYLTtdTtVWoWFbURySMut1FhSI4+pAK6tsd6I6D1piP6CNRz8f91j6Pj9wNFu8r20bHv97c4kOK
 3uxCo8RORhr+C0PFdmw==
X-Proofpoint-GUID: A7e99TjC0FXe58-GIop_ZnTb0VBCrpMC
X-Proofpoint-ORIG-GUID: IQ84wxL4bJFlgPBhpxz6T78_KO9pFfYb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXxntVxCVh4Zwm
 NqUF6G51YJZZ+jcsxSjbZFyu+90Y6yLyKtQ9hjtPuZD51MJswq/5bbcIi3V3wv0UsF/fmvVKRWq
 4H5YVAYCmL9j/s4v46iQv7HXzaqTtCQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

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
index cd692f8fb764..207f44cb86d9 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -29,6 +29,7 @@
 
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
+#define KVM_NO_MMIO
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index b0839e887221..697be391f0aa 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5873,6 +5873,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
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

