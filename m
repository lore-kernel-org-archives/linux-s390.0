Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A13126DA;
	Thu, 23 Apr 2026 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988412; cv=none; b=SfKcfc8BRSkHv7IWizOho9VOGCGzbtK3POLgi0gt1cA32Bz5GidTycvZEvb4j1Vu5wLDt8ny3XPijMhlHRLbg31MjeE2lnIp8tSmff7VVHzSA1ecOOMkvgCFU5hx+p2HrYema7M6gqoF/CItYUVN+1Wg+E6QQZjcxLoWBOx/g4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988412; c=relaxed/simple;
	bh=7QQI2cLRizJ3B9L2teZ4EZmnF4p+ep2iFxZBXnDp5EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGySxBZTjZi1yLLaAvoZGl8YEgr+D1asQv1PscG36ykAlkqbddfqwE4xtFlySlFLfAP3oBy+OfxmA91Uwprbe/h7IB+n6m7wKcis6sjJdPv8sXCE4P0dKSm5z8MoEcsJmByhh6qq3FkyUjkF28Q69Y5j8y8dcwIGqwwpA42aTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JmjbBknB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JmjbBknB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NJdVZZ3229299;
	Thu, 23 Apr 2026 23:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0oCuxI3hB2N3tw0dwDVM0HW3sjNYpZ1N/cO8OjFkI
	6Y=; b=JmjbBknBB+/2Ptg/j0yYVREwjIxX3uh0cJrKunP/CxHN76I2qOh4KZ7yQ
	VfqmSQKiETzQTndMVuNMR5jbOfiYcOQoQ1rCjT+ZhVcQPk6R1qPM10H8MRkA+tow
	KI3zZDpgBqsnhXAuDu6AGqNAlqm4qrCzfMJHlMZQm7xtEozzsG92Uh3S12KqiEZm
	FteYiyo5ogi8zsq3jTuSG++teIrZc6adUwfMfa0Kqgu8Nt15gOArZdLHdDIWyJNX
	msnEDEHkfu0hX/0CfEIt5EqtY+gst/f1EVCjtdP1l16AV80pnmcAA3MgftOTe5fR
	uehn2bnRfU59MDaBazfbpWz1PEgug==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2b9bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 23:53:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NNoWrq032037;
	Thu, 23 Apr 2026 23:53:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky8pq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 23:53:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NNrQlL14353130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 23:53:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 351DF58056;
	Thu, 23 Apr 2026 23:53:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DA7D58052;
	Thu, 23 Apr 2026 23:53:25 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 23:53:25 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v4 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject 
Date: Fri, 24 Apr 2026 01:53:13 +0200
Message-ID: <20260423235316.3665-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ONdcotTjzxdj6s-Ap0vKM-gwCnr08CEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIzMiBTYWx0ZWRfX+e/BFjWjUOfW
 S8QY+JgNAOpv6kf+vVPoiN1xFDQCfWZftZUVT5+nFlYrEL7iJ7SQSn/HDcDj3jmyHVzGYNpUf/c
 91zpVpTXcoduF1Y2SJUh3TV5ww+sxNm8EHB5TLu0iwhVGtlCGJYiycCM6QSeNIpSG5nPpflCVaf
 8e0/bmOfKu7Q82ZEIvKxBEQ7TSlS9BAftDICLYBj81cgkZ4GR12pR3U5WpPQfft4Kv45OgpyEHN
 f4wHLtx5jyUEZc+iKtdvKp4hysNxB80nJT+SpgpKjaUCehHuWCGWXEEbiGy2rS0Xf0IPyuTu6La
 kZW68c4zzHvS/rONeTaoysU6VjHd8vrKZ48tpkY42aXS/aAiwuFW2YZAgDuODfM5DZoGw+SlRp/
 mvJSquacbYxZX6D1HtoEiDNo8qz3DzDUzZuRgTMT1u0FaaJVT4i+R9uwSKuaxs6fnh3TIr7c2NS
 oVsf+6IpdFDdeQSFnuA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69eab0f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-ORIG-GUID: ONdcotTjzxdj6s-Ap0vKM-gwCnr08CEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230232

S390 needs this series of three patches in order to enable a non-blocking
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
paths needed to be changed from mutex and semaphores to raw_spin_lock's.
Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
but we had to implement the fast path with GFP_ATOMIC allocation. Each of
these enhancements were required to prevent blocking on the fast inject
path.

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

v3->v4: In kvm_s390_adapter_unmap mark_page_dirty using guest address.
v3->v4: In kvm_s390_unmap_all_adapters_pv mark_page_dirty using guest addr.
v3->v4: In kvm_s390_unmap_all_adapters_pv decrement nr_maps.
v3->v4: In kvm_s390_adapter_unmap hold maps->lock through list deletion.
v3->v4: In kvm_s390_destroy_adapters hold the maps->lock until list empty.
v3->v4: In kvm_s390_unmap_all_adapters_pv hold maps->lock to empty list.
v3->v4: Change maps_lock and ais_lock to raw_spinlock for RT kernel case.

Douglas Freimuth (3):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/interrupt.c        | 401 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c         |  56 ++++-
 arch/s390/kvm/kvm-s390.h         |   3 +-
 4 files changed, 402 insertions(+), 69 deletions(-)

-- 
2.52.0

