Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171CC2BE7DC;
	Tue, 26 May 2026 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760410; cv=none; b=N33WLJkaXUsDlgpSuXnCszUlqfwqEi8wVRpiritxSbHw7MxVQY+1Wr8mqjucVRzZZkGsUDnDR1R6h9V1umRkVslC1eyghMbtyT8Ox9JmXgXfY8DFn9DTV7bqJMKaW7nHbGrzgM9dlWWAYPWGL3bl0UnnT+76Leg70o87QYDWk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760410; c=relaxed/simple;
	bh=QDTne/z60YHCeM9oRRKDRXF6WppDju3v66X0XmAeoho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cE/y+b74j2VibGYQMPNPh7oUCuhia4JRS+8P7ebBsuTJGpID7siCDhbfnhPpVItQGCL78jRBeUGPaFIReDKia1uXtfbR+5EnW1RXk922FxJr8/mq5Hwm9Xpo4sB2c1n9GhJZxVcaCuAsXHCGpnVkCKwagDc66yiNNCJQfM949pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PpEhM8ex; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PpEhM8ex"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PC5YCL2569393;
	Tue, 26 May 2026 01:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6uZwnpDv+SBd7nnmr0ShhubKq9ar
	JpfrwlMQFuzlUlI=; b=PpEhM8exW5y8J5hsgzZ/7s3taW/8acMCglylUZ6csmH/
	w5M14Pw5lFfGcD3VMOoHpGx0Yz+1FdZO3DhUC9DDwgYRVI2JDh5u+kmQuSeL2/6Z
	dXL5D4cQa2cND/kSi+FQaKYpZaTLmUi+9phU07mgQ/xUtGwLn3QB4Nmbu3YYxBMf
	J+9c5iPTdtJlb4OpRqfiJBw4BaeLDqOaMA6OxpWIyzBsg0jZgspua84m9XyglO0T
	MhToGBdoSTqD00oQeI9moSrs/n6v0Q9KH9X3wOsTc5C3vWGJ/pQmNqYGWIPH4BgA
	jkwD8FmnTKIaLXFxbYmBUujnFpay/JD042MsPSu5Bw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nuhy2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 01:53:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q1dEaQ031637;
	Tue, 26 May 2026 01:53:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebr2gy6xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 01:53:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q1rOpO27329064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 01:53:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0E65805D;
	Tue, 26 May 2026 01:53:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D036D58052;
	Tue, 26 May 2026 01:53:23 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 01:53:23 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v8 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject 
Date: Tue, 26 May 2026 03:53:17 +0200
Message-ID: <20260526015323.207343-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAwOCBTYWx0ZWRfX308E79GmhOEE
 MXcMdEzvq6bQYFa1f0JBqW0S6/RfvHr4CI6GjyV/CNu/W00A66U/kkk1XVouVym2He62sydO5Fq
 Ht48Zzl10AhsTUb4v6oHIjBmtWrRuhNY7nCRNxuUO4YlDRNkBLkEoXqZ94hxkdWgYMxRjiRfC2D
 YnS49jpzvg5TEWbJi7+5BD7yVIsVA2yzOjmNW2W9jOE5YQfHuvnDU+UYunsfRFAz7f3qhq3d/Cf
 Ati4eiQFkemcMGyVE4GnpcMKMf36eWy+M987S+VmPtBDlqUPkoDFXbky2VEMS7PMUERDVP4m7lZ
 QwKg5TLAEFex4ULelDepuGOgabccpPtBjJ5L0h3iu0MJo5agpGxcnq4kRw2LYLK3re2kI3ctX4u
 2lDmGtIdHKUVKuwv+9Nq/u9YfgV8qNR19juDTc4P3Sej7B5P0UV32/N5GxWtm/JlYhCiiu0hDvC
 DQvFO9A9M9HzHYaKeYA==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a14fd16 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NCD-c_4OtPvmz__zez8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aILvAhV6VEuOKxtXP0-8fK-cXt-xkWVL
X-Proofpoint-GUID: aILvAhV6VEuOKxtXP0-8fK-cXt-xkWVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260008

s390 needs this series of three patches in order to enable a non-blocking
path for irqfd injection on s390 via kvm_arch_set_irq_inatomic(). Before
these changes, kvm_arch_set_irq_inatomic() would just return -EWOULDBLOCK
and place all interrupts on the global work queue, which must subsequently
be processed by a different thread. This series of patches implements an
s390 version of inatomic and is relevant to virtio-blk and virtio-net and
was tested against virtio-pci and virtio-ccw.

The inatomic fast path cannot lose control since it is running with
interrupts disabled. This meant making the following changes that exist on
the slow path today. First, the adapter_indicators page needs to be mapped
since it is accessed with interrupts disabled, so we added map/unmap
functions. Second, access to shared resources between the fast and slow
paths needed to be changed from mutex and semaphores to spin_lock's.
Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
but we had to implement the fast path with GFP_ATOMIC allocation. Each of
these enhancements were required to prevent blocking on the fast inject
path.

s390 doesn't support a PREEMPT_RT kernel and this patch doesn't either.
Given this fact, we are not using raw_spin_lock instead we are using
regular spin_lock.

Statistical counters have been added to enable analysis of irq injection on
the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
io_set_adapter_int and io_390_inatomic_adapter_masked_or_coalesced. And
counters have been added to analyze map/unmap of the adapter_indicator
pages in non-Secure Execution environments and to track fencing of Fast
Inject in Secure Execution environments. In order to take advantage of this
kernel series with virtio-pci, a QEMU that includes the
's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.  Additionally,
the guest xml needs a thread pool and threads explicitly assigned per disk
device using the common way of defining threads for disks.

Patch 1 enables map/unmap of adapter indicator pages but for Secure
Execution environments it avoids the long term mapping.

v7->v8: Move acquisition of kvm->lock to top of register_io_adapter()
v7->v8: If !summary_page WARN_ON_ONCE if set indicator but not summary
v7->v8: Remove kfree(init) from kvm_s390_inject_vm() default case
v7->v8: return 0 if !level in kvm_arch_set_irq_inatomic()
v7->v8: Use irqsave/irqrestore for spin_lock/unlock on fi->lock
v7->v8: Modify statistic name io_390_inatomic_adapter_masked_or_coalesced

Douglas Freimuth (3):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/intercept.c        |   5 +-
 arch/s390/kvm/interrupt.c        | 525 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |  30 +-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 5 files changed, 467 insertions(+), 109 deletions(-)

-- 
2.54.0

