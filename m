Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557D3126B2;
	Mon,  6 Apr 2026 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457871; cv=none; b=u057HA5WE8Tt4iQs6WGZJGztGzMwbnO4QrerK1hfCKEeYFLx+jLgPeMRL421CHIjr8MnvBhgzCCMRqqtCP3v0ab6Mjk3JJRPcTeVIW+TtzoJ5O0+YI2lS5LQArDVJKT1kgPip1ec+1RsZVFCLkQhvjOoFMEnD0t0Hau+yaiV7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457871; c=relaxed/simple;
	bh=xBiYbcmfcZuadP8wiwj4VGW/TWn9TXFVtcfpQN+Okgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvHWxCix4iq666d7fWIOeVKsy/3koSYg0HSLkMXJScEbubEsGpqdMpaF5AcW1AUkcdUn7g5niFz/SMIursh81dbbYkjYAlc+kpUs/cfZDACQoiDeiRC2kwwcQuThkraV3HBOqI/YtjgOmV1vdc/+Vtt3fxp0UlJzH0ldJ3uhTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TdS1eLJ4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TdS1eLJ4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635Au0mq2351743;
	Mon, 6 Apr 2026 06:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ga7VvpdR81DKe0/HtY0tpstVNEhGxqxszae3JL5f9
	r0=; b=TdS1eLJ4xXaItfZj7S50O+fMv7j1gas3eWje+PCF66/Pne1WzcLIeEEep
	hqNKVDwR7U0sAWVVT8/l5NC8Lmt81WVQXPzwC6tc1NFjrM+nMlx5vyj4cVqtNAM0
	cZoWewF2Au1W1MiZtet2R403cp3GMDFEApMf9MHjoe3vU5J67Gsh426jW9kHb1lq
	BYJPrpyTuO7I9RSdttbA3tESctWNEmhV3+gnF4ejO+UF50l7JGDeCPMJsvL8Dyoy
	m4RDym/2KFoEba9/0cli7LpPIa5RPjkV5ixU3BjqePQ3Xy6p4YtXHHOh/xF7tlzU
	PRzi2YXfOzzZPfZ9STSvhabYlvLsQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bw4w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:44:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6364NM4L018525;
	Mon, 6 Apr 2026 06:44:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcysutjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:44:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6366iNGV31260990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 06:44:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C8658058;
	Mon,  6 Apr 2026 06:44:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D044258057;
	Mon,  6 Apr 2026 06:44:21 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 06:44:21 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v3 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject
Date: Mon,  6 Apr 2026 08:44:16 +0200
Message-ID: <20260406064419.14384-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uEcFIhycftF97XYFl12cIJMoTXSXvna5
X-Proofpoint-GUID: uEcFIhycftF97XYFl12cIJMoTXSXvna5
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d35649 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NCD-c_4OtPvmz__zez8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA1OCBTYWx0ZWRfX+jdRWL6RMGju
 IkM2Jd50CD6WBZkw4Dn0v22GZudoTdg4Oy8rALfpVX5HAR9qlw4949t+Y5t3PIlWWjjuWMfqg/e
 OaCuM9YBfaUSDT60UKWytru/w7wT0mFkGubsJ3RhkeL/RxVZH+1/B2M9MdvHm0SfDWHYhgllMBh
 UqENO2fxfLBU2DzozuzaZSW5Fgg1BEMg06z8ejdTklhONc9Z2xsvgriLi6em3s2mbJxyZkv4QoE
 JnTwzMdXg6v1ipQCEoTXaSQHZKd6SaEl9aikgV326moalRXjrxCn5MviFwPql2rfrQAlxKQXcgA
 KlyOaXDTZHlQL5I4vf0yOtVgdDzwxJ4CU8X+Jlw1OKKLKD8rarO8RfCR2dcpV5COWvdcq2r2W7q
 vkfuh/ZieXiqxDsQqJmjF3KV3LmTuSKLNnrQsRCBb71Th9DrO57MhWXk06nYlv4x/+pH5B088pc
 6BuKOxGgVjUdb/Jfhcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060058

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
paths needed to be changed from mutex and semaphores to spin_lock's.
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

v2->v3: GFP_KERNEL to GFP_KERNEL_ACCOUNT in one instance of allocation.
v2->v3: Fix alignment error.
v2->v3: Increment nr_maps after new map added to list
v2->v3: kvm_s390_adapter_unmap do mark_page_dirty and set_page_dirty_lock.
v2->v3: In unmap_all_adapters_pv do mark_page_dirty, set_page_dirty_lock.
v2->v3: Move kvm_s390_unmap_all_adapters_pv() to after check if in pv.
v2->v3: Move mutex_unlock after map/unmap in modify_io_adapter.
v2->v3: Add spin_lock to get maps->lock in kvm_s390_unmap_all_adapters_pv.
v2->v3: Only put_page(ind_page) if !ind_info which allocates ind_page.
v2->v3: Move the spin_lock inside of the adapter_indicators_set in patch 2.
v2->v3: On last conditional in kvm_arch_set_irq_inatomic, add else clause.
v2->v3: Clear ind/summ bits if inject fails upon return to inatomic.

Douglas Freimuth (3):
  Add map/unmap ioctl and clean mappings post-guest
  Enable adapter_indicators_set to use mapped pages
  Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/interrupt.c        | 392 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c         |  51 +++-
 arch/s390/kvm/kvm-s390.h         |   3 +-
 4 files changed, 387 insertions(+), 70 deletions(-)

-- 
2.52.0

