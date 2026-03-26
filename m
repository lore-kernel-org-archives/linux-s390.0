Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A339150F;
	Thu, 26 Mar 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489376; cv=none; b=I/90MyNNjxdXzoRQ//0c/UMiLaYKB6halZDOjndRJA12uBLTudDRg9fqB3EracVIXEMMLYSn974C/qbYwQIDp3dX2YRZNXLnDKvRxarhA3XLVBXcylelNuoQw/0UL+KeObMqqTZQ9v47wvCpnjBsfEdUPCXm/7GiKoMGX7fi4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489376; c=relaxed/simple;
	bh=2fowJEG8rRhtTI/6iU69A8g0uKCR0V3UAVSVufvWIzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNRswvkByznFCIfA+iLa0OB+80KOd3Vph3ugbsRYBBApKwfiT0vdt6lgjVf8qciCyAhzsd/GCTxSc2grn1wtAPbKJ/AnTJ/+/3cighUlmXqi5X4h/aA5UDbbiFCxSDHwE+oVbVoARIMxylVRINnFYELdvdauEvEG9gvLBXboTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buroMEP8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buroMEP8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q0623j4120967;
	Thu, 26 Mar 2026 01:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/u5NrMI8clTWghOwOGsCa1cUL4F8GHfZuHae2epzX
	u4=; b=buroMEP8dsexPJMldLtZb0rDj1insIEMY9ziWCcv/5vNoahfRjQyMRuO1
	XnkF7bZCiQSLI8h2AkZwgjflw8Wj0Ix1UEfHVvh2prZAPPc37Wqfn/ZfEiX7ycIf
	Tx9Q5f9qoG8+AVjWTNeI+kDx6I/64gpDyDO+IgwQz3n/MXGmxPMxWjWJFVagttyJ
	O2oxScbzKKnDe4bh1TwdqzytuPAJON/3utu0dF+wlHyCBghdup6o3L0/kS7KLial
	w015cZfOUueCNs5WX9BSF7dPLkZbWMA8iQV2pLYwT8ZKjT8vR7Fhp9Ldv87ZIk3Z
	8mlhlWyEtV+ELpAf1CGTGHHD3yhLg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa35yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:42:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q0I1cY005964;
	Thu, 26 Mar 2026 01:42:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ys48k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:42:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q1goWJ33096204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 01:42:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23E125805B;
	Thu, 26 Mar 2026 01:42:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9E835805C;
	Thu, 26 Mar 2026 01:42:48 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 01:42:48 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v2 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject 
Date: Thu, 26 Mar 2026 02:42:44 +0100
Message-ID: <20260326014247.2085-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a4krK5sPoF8B1RFb6DYH3rh9ujBN0d6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAwOCBTYWx0ZWRfX7S1vCh39fqd7
 gXsDz2uUNo29Q1yfja9+6ZhJmAOH436CoERHk0IORmmieKjFzIkFDiqn6RRGoSSQwaOEBM/a5jT
 bn+BwxcmddTxcywio37Kr9sb97dP8JIhqKq7LWdve+I2pWelPRybQu7zqYKbODM1kq1PnexOnCs
 XOqt/bsJUPKecLNWWNtn81gjS4b/BHMDuEGNQYxiMmbPmpc/jCVSZ/TITncObJuPWt78yNbzfzT
 srODVFX+yHMsEBIZSR1AIyaD7aNkde9zQzUVL9BXisS13pG17N7equ+T1K125z3w1h5ApRdy0/1
 6KBQP4suqd1R77t7+qDHYWRln17TN4oNYFBhcYpv3KAjTbo7qrlTdaKG7tLCBxhfr9WsGARU7C7
 no5J6+dixsHz9zzYVepNLQhp/Zt/AtFFcVmAPXLITrcu+FUQMOdoWaRGZYzYHPN3FoBNPjbosv4
 x67o4ZTVdLjkFnBjQng==
X-Proofpoint-GUID: a4krK5sPoF8B1RFb6DYH3rh9ujBN0d6X
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c48f1d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_07,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260008

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

v1->v2: Added kvm_s390_unmap_all_adapters_pv() for case KVM_PV_ENABLE
v1->v2: Changed semaphore to spin_lock in Patch 1 and Patch 2 
v1->v2: Fixed a build break in Patch 2
v1->v2: Added KVM & S390 tags to sub files per Sean
v1->v2: Rewrote commit messages to more clearly describe each patch

Douglas Freimuth (3):
  Add map/unmap ioctl and clean mappings post-guest
  Enable adapter_indicators_set to use mapped pages
  Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/interrupt.c        | 366 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |  44 +++-
 arch/s390/kvm/kvm-s390.h         |   3 +-
 4 files changed, 356 insertions(+), 68 deletions(-)

-- 
2.52.0

