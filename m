Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5333B6CB;
	Wed, 20 May 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293091; cv=none; b=jlAlcnKNJdpLqKGAii8FKEOa9F7Ql3zluhYgd3zDDFbnWEqmsaQnG/TcewgdHnVkMaipHQUXY0CKVEPj9ddJ3MSlbCel109cjtHp/qSOZvKxQrzsw27MByfwM/0gaLy/s3kgoaX0abaFEQTvOHPW7+vYRq6JaF2xAJw19/S/Lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293091; c=relaxed/simple;
	bh=2aAoTcOVCj+dizYAtlEEWZyZLjKTfiPC9zXzKktQC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJ7U6Ws3dg+Xi2hPmawnEb2fR//URD+LCDprORMBpf6mJakQU6DgAUK1p5DQXL3f7OqFLZTWnRny1MP8iVFpktC8phOXYzTR2dalVoDEbpB/v70aDWH0cuzErki+XG5BZdZBqMZVTYr/cISQRnszW1usjnN7ITbGigINC2GdDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NlmJWk0l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NlmJWk0l"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6k2n8513145;
	Wed, 20 May 2026 16:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=owEgKHAd5aGo3ZO09aDCmsCevicYYsG3xJOZMY+h3
	6c=; b=NlmJWk0lFJwcXtGA266FKOs5DU5ad4lx74ykXANqwUxvC/E36pMD1PhQe
	EFrINV3iDJ5X8lWJ/bfP0lo97iHqJW7kc5acnE5RiATfyJw5JOZ8DTT8b+G6aHsQ
	u94ZX9K01jDYyMNp7qsZ2cxeJczHFg66JvhyE+rUOr1bHZczMKQE7Xx7X6uBkdZp
	Yih6FLlF5SA1m/wCz+CuvXQ8AAgYSTX2pOY76eLURgqqz1kS8RneFlsaRc+neRfY
	1OYVdXR4P15i5z/dTt6qnaKMkqM+lJ/OfnOcPE8LzIlgFipa5w5NXtw3+AzWGVBz
	BbExDL/VFrQ39lPsfXvFA2GO9LDyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752waa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:04:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFsEwY015474;
	Wed, 20 May 2026 16:04:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk82vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:04:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KG4idI30343834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 16:04:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21F8D58061;
	Wed, 20 May 2026 16:04:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D5E5803F;
	Wed, 20 May 2026 16:04:43 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 16:04:43 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v7 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject
Date: Wed, 20 May 2026 18:04:39 +0200
Message-ID: <20260520160442.1051999-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ddb9e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-ORIG-GUID: qo0hC0qy2bDGVlyG-bgBGbY4U_Cq4I6R
X-Proofpoint-GUID: qo0hC0qy2bDGVlyG-bgBGbY4U_Cq4I6R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfX/JVTq50iy4HJ
 Wm3Rok8LhXtxzbIO7halHTB7TkJGcIiw6X4O29W7+XjBaDydUqj3prd89Zx0As0gCAKrA5ad5wf
 J7wMlnsGXq0tX6Y5ZSb7SeRs+06EBf39eT6utgHS1X5Igi3VdeS+4u1foONW7KAC5AoCkfbnLNB
 iWl1jlqfc3SnimmQJMumnvIdVzJ1RNRArGfRYcc3p5uuY4WnR5scEQmWozAGJYNzI3jq4aB8hj8
 UtcJCfSCUITmevOBqcCKD2awYP/u4PCBX+RUo+o/tqrmwHafBdaPrhqlf68i64o2zWb3jnLORO+
 lo46y60nHT55AUgVmoPnfSCu7H91PGMhx6/OZMod0gEcTKqc0+3Lhbuolg6fYZWGh0ylSfVgX8V
 B7AQI5XHKL9tz6w2wEPYoI5+hvpPL616sLxvpUYAyRw1f3kk2wLfOJhqeBziuUCPAUIHV8Pzaex
 RC7xBEnMqupclqcKMOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

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
io_set_adapter_int and io_390_inatomic_adapter_masked. And counters have
been added to analyze map/unmap of the adapter_indicator
pages in non-Secure Execution environments and to track fencing of Fast
Inject in Secure Execution environments. In order to take advantage of this
kernel series with virtio-pci, a QEMU that includes the
's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.  Additionally,
the guest xml needs a thread pool and threads explicitly assigned per disk
device using the common way of defining threads for disks.

Patch 1 enables map/unmap of adapter indicator pages but for Secure
Execution environments it avoids the long term mapping.

v6->v7: Drop all raw_spin_lock in previous patch and make them spin_locks.
v6->v7: Hold the kvm->lock in register_io_adapter.
v6->v7: Call kvm_s390_unmap_all_adapters() directly in kvm_s390_handle_pv.
v6->v7: Simplify unpin logic in adapter_indicators_set.
v6->v7: Make the caller of kvm_s390_inject_vm() kfree(inti)

Douglas Freimuth (3):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/interrupt.c        | 444 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c         |  30 ++-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 4 files changed, 418 insertions(+), 72 deletions(-)

-- 
2.54.0

