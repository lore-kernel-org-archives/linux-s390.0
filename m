Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FC4302F0;
	Wed, 12 Aug 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549332; cv=none; b=e2g6ZAWGe3bKZDm/3QdLsZ7rIvPXhu0O2NqDbo2gyVk1VxvZz03SPbA2YVLRNddhXjE6UsI9mxEBp0E2jnzVKaFLaF26n6XjQ1Dc34+pPGJYtdoOayCxG8iyFfTE/vQ9EMO1jKKugDwRYK2DrZEwS52cB2Pot2BsQWH4hMGxz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549332; c=relaxed/simple;
	bh=toUuq+e8+AhEgq4luBQMAPg2nLKcYYOSDvgjOF8SIYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO0jEli9g2PT/jiW+LvL8v2xCBsZHGe5ArfURgmdquyj9jIbcNS5IHvPIdcOiNrKeXyVJfNbdi8buvAIISzHtJc8pN3Ms/VdRp51SgEKngHAqA0un1cAXVAuETENXHQHZFC5ANXfP14Xh7en9jaX4+1AUYmRYgbGXCKYTKAb940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZDCY0KHp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZDCY0KHp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1uFi3594446;
	Wed, 12 Aug 2026 15:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FXg4mQ5ABYtlMNvWj
	pCpG3Ntfpr0j+KTb6BbqGNeJIo=; b=ZDCY0KHpMU8MmeBfRS6QGw///hNC05IK/
	dBu5SEQIVK6ywmHcxyWsE+DCII0pokJDWCKBajygZusqYZp39qfDJEZLyJ/+Ivj6
	4lnlRC61OdbTiJMWiKr2Tof9e+uHjb0pTQSnAZgA+Nznp/F24n9Dxr5O6/OZFjZY
	FfXTUgGI4AvqHlZWAtf5Id1C6IJmip2T3bGmz0pLLhPdUq2XCRePD3YqxDwzf//3
	0Xya2y8n9GfaqA9b/HeiWDDMe576wDzcl+wdVG3SgqiG6MPeZZQQmnSkxl59tRiV
	gQRaxKOaoqeqw4hEsk7mfdjgZZrSCOSGyrxcsPk5YlseYIANDdA8w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32e1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQGeB021692;
	Wed, 12 Aug 2026 15:36:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6g4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaeEK31130130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 912B220063;
	Wed, 12 Aug 2026 15:36:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41B502004B;
	Wed, 12 Aug 2026 15:36:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:40 +0000 (GMT)
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
Subject: [PATCH v6 22/33] KVM: s390: Prepare KVM/s390 for a second KVM module
Date: Wed, 12 Aug 2026 17:36:18 +0200
Message-ID: <20260812153631.3376090-23-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c930d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=m33X-YrdrFVFgJ0cfecA:9
X-Proofpoint-GUID: sYLW8VJ-mz1HbBc_1dqJ-6AQWIHpYnSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX9zZF7x4XLFTE
 QcKiZ7F5+UvLQrlCiYPhvrRqg5Xr79Y6QuGeTyZgbzJFhKRdeL+9lr/4frbiEQoU+wEisdbuuU3
 HDqS4JDk/4rbaoJ9yKYEoF4wsbX/G8q1pchaonPc4fi3s6So/lguJ0sOI210c7AyVjOjh5y55ZF
 d7ZQbmxga80OZOTdjZBq5pctMkltUydyDjJOOn1SW5Aa8Lfy2xrv3hZ8IVSZ+wf92QSINknL9BG
 Bhfp06UeSTFxLNPPbm/NZ3QLUg1aRmUxaLrzbkf4mBadaSVr07zP9H8VOC5tM/E7x+GAMK7C9vx
 qZzo/PC7O2YiKT2vZGlfAFiKPSOMg74UmMQhK1ftutYk04wkac3wH7O7RWp6V9XxqTXr9F32dxc
 1+/yWR9f74G4RX+PeSRx10ehPrz/WoT/iRizZYv7SRymTVk/i/b/Jc0tGF5Vknkmplk9ccfFgWH
 AOF7Wt/FZIAPuuZtBkA==
X-Proofpoint-ORIG-GUID: AU-9JOyLvryHb86NGv5uDMXjFShF84y8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXylZPU5qhyBZW
 fbC5/BKDb9fY4B5/4pyxSD6eK8QZjc8Hj6uYWVgyKZZx1tzKt3BT/BZa2geJCvqUPj2z46TcsXy
 cNNbSw6pm4en88xvosDt9vfmm2On9Fw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

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
index 1d0d94f000f7..d1e736e1f06f 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5868,6 +5868,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
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

