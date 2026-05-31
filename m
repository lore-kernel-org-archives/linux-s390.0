Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048628469B;
	Sun, 31 May 2026 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780254240; cv=none; b=pTZlWVYlirwCF4UWM6LlrWDoRjIV8nJNg4cxgD0q+/mDfTqGw5rgXF0bJQ+hs6hXRYzms8EarlsObCZ6vHt5cFMh9JBVBZt99U1Qsy7t7IR3SqvwYTgZhY11laH5Tx8Dm8ZXy3Fkfxr3VQZeDeBHrFBXq7UBv4SIYd+5rNyxx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780254240; c=relaxed/simple;
	bh=xLoBs0/4RYZgm2KRMsSWWSIM1IYm+sTMAqcaPBvPiEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pp2VrIpBq+0TJY9on1ZmRwOy9u4RDttM75MV87xkke266Eq3eqsZSQ9B0u0P56zYRqXrDcjUBXOGsmGZ/blyEv5974LL3m1b6tCRpspAVz7JSbAapRDbqAPs+gpt6BM6cDFLs0fkKLjFt0NLIYtSo1503gfH4RiwzuX5tdl07Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o+UQLYPx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o+UQLYPx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V64xZE2061758;
	Sun, 31 May 2026 19:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=u7/nonqJZr/BG3m9kpHwJoQRIGRdhlBqA845JrqiP
	+Y=; b=o+UQLYPxq7+baRN9IWKjdhIuHC2q2ynjtEnWB8YaSuBTfdnHid7BkwYd2
	Z9WUTxHLECur1MxvFZOHuFoMCIJ61fq+fmslmWHHWaeaQwLRWH6U7CvPb5sTR+ux
	xJGiuumqfPiurRNIjq3H4Vx8T6YmeB0G89cQJ2rVM+9iIxGvj+mmdWMuVUMsaI1R
	vwYfKK7e2N09l9fKfeRfgf1uOmCvRHpf6gfq9eOfMDSwWtWCeMD5AfhfDdXZA3Xb
	r0gjCQvfTVcIVd2ODxYuZCnpD8riDNA5sLeLq7Vq3tZ9M+1LzRyfiOhATuW/0Ral
	au8TIlnH/+9pSo2yncLRY1tTsnaaw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4nhrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:03:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VIsFot006170;
	Sun, 31 May 2026 19:03:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegam8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:03:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VJ3toU21365472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 19:03:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28B9658056;
	Sun, 31 May 2026 19:03:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 681CD58052;
	Sun, 31 May 2026 19:03:54 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 19:03:54 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v9 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject 
Date: Sun, 31 May 2026 21:03:50 +0200
Message-ID: <20260531190353.204317-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D_mbwKzZpvqk5z8UQoo4TSg_WekO0Syx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDIwMiBTYWx0ZWRfXyw/yfJi7HpVY
 rDY+O5/gcitDzP9uINFpdda4XIkZurgGPeK362olg2sgThVEFXTGteBfLWwY7BOvMgalf+l0ZXA
 FFTlgPhkDsWNTuD6bPV94w1Jp+++ZoCqB/sErNC6VBeKspJVFlCGSI5bh6rNl5QZ4OVuEQ41uzR
 cr5Y3AbBfCRuweCBLOqBHGXX0knQbmsNoKfRfw/bUgyh0oyjt7dHZPAJu8Fdr9PgQAH3NXcX2JT
 8kelR5sW4KDniyWc1LFYpbQiQaKjIP1PHPzPRpfC16F9Y6n5s27OT9oW67t4wY4Bz8xLcXmqirR
 FQsa5/bhDZ4BMEnEOafWyF0/0MX39fBz7jM/TeGAKZ4H/b/y3vGfoMWmf+PLn920rXnLSLT9zap
 qUPE307JFLE9t5xGqgQjDahbHR/LuKPvaswfacaWoaHpgFkJWuzzVr6XuuMyMuE2IcWyEY0Uq5D
 Te8amtHoRrZVotj/t/w==
X-Proofpoint-ORIG-GUID: D_mbwKzZpvqk5z8UQoo4TSg_WekO0Syx
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c861d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310202

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
io_set_adapter_int and io_390_inatomic_no_inject. And
counters have been added to analyze map/unmap of the adapter_indicator
pages in non-Secure Execution environments and to track fencing of Fast
Inject in Secure Execution environments. In order to take advantage of this
kernel series with virtio-pci, a QEMU that includes the
's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.  Additionally,
the guest xml needs a thread pool and threads explicitly assigned per disk
device using the common way of defining threads for disks.

Patch 1 enables map/unmap of adapter indicator pages but for Secure
Execution environments it avoids the long term mapping.

v8->v9: Release mutex in register_io_adapter() in exit conditions
v8->v9: Rename masked, coalesced, suppressed to io_390_inatomic_no_inject

Douglas Freimuth (3):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/intercept.c        |   5 +-
 arch/s390/kvm/interrupt.c        | 558 ++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.c         |  30 +-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 5 files changed, 489 insertions(+), 120 deletions(-)

-- 
2.54.0

