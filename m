Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147448C3FE;
	Tue,  5 May 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002656; cv=none; b=Tw5+Wl9UADwnZb4rR0fsYXn+rq7wh4yKgVyHr6lL9FYTltKpKtRMjpdqZ1QMN1EbprASCF2e6Em4dphDew41PdMCc65RNK8bvF+xk75mNg2piCS2AJM6K6HG/0pmerXjcive1Ya8yOjZkmGDLbCGrkNRucSgnt9rDsPKPLvJWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002656; c=relaxed/simple;
	bh=7A52QdmTtnfkkYblXKVrDUaBE+IRjKJZzBt1P8NIdxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gcqr9md3IFVeX7Krg+8FJ5DrQ5qpp64ZFhJB5KahLWFRKHPNFE77LUO1WfhPFi8SJEZwtwdfSuI+/bk22mLUzv7S4ZERjwFESE28X/k/nLp4ONDTh+yGjUYSaDZMvWZmGWL/E/u6ca8cNY8vzgrifNCvvZZjRVyvTsWxCcNfV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mSEh623O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mSEh623O"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Bxhvq815633;
	Tue, 5 May 2026 17:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LL18L0moSgwBxznS7+sTFzEkUNLLluIZUYilNvkFx
	gk=; b=mSEh623OFnirDQc2Xart3qtb+ZIVWPIHmn3X1Si127LnjQWeCk+Vnuxds
	cpNy+7K5Vm5klipIsEP+q4gjsOCJ9RYzWZ25tdnahdyEmuMyG7EXXvNzAdu+ozUP
	yVAvX/ItrfHqyqnMI+Ur7I0a+KcBMF5ArZWK9DPY42Eua07KN2I4QapGbdtk//cF
	K5TzCRRLHwtYRYpRayvoM7avl34R8zA94TgcJ5jNpEXs50HU7aAkCVMFNKIS7Bjm
	NAF0erhQvyjaECoG86hZscMDnIQZxORqzlxiKSL5Ny4y7AtAfxTObaGbycAJ0QvE
	0AjKo3a5e9JYjhPD7tARWQWzvF0/Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1d0j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:37:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645HOdHp014423;
	Tue, 5 May 2026 17:37:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw2txh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:37:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645Hb2LP18219728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 17:37:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3685C58059;
	Tue,  5 May 2026 17:37:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E695804B;
	Tue,  5 May 2026 17:37:29 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 17:37:29 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v5 0/4] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject
Date: Tue,  5 May 2026 19:37:24 +0200
Message-ID: <20260505173728.160562-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ObdfPSVvH46SJAyd0lQqbsXlHAXijy67
X-Proofpoint-GUID: ObdfPSVvH46SJAyd0lQqbsXlHAXijy67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfXyU/nBf8MEaaC
 0WKjMDlnTskV9J+CknYAKJ40V7U1i43wn7BHa0sB5zHZXdR8/0/C4xfoQiW+oh30pkfBimKlST0
 SBMfmFV/lG0UyfvSqYq3DLvFxzfdemEL5MRGgHsFqvS2p3dJItp239C0RFr8cUxRyYBPzwLjSLg
 TBt3Ypp9YXEHibXyHYV7pB1hZv4AIjZy/3bmBaFOK0W4UfjstcJNg4C6/WK52DIGblOfg2B7FQt
 0mSm5RuF5O4NuoKQwB8TY7TrcuE+2Bgdv5exQj/v5TOZ5wd/zYsgVEjsU5RKA788y/SYgZvW8/0
 BsV+3h/AaNOYPG5t0RSNr4jBJ0og4OFM3SdgY88IZS4YnSVIhm0eqOV0fgI4eIr4Lr/mv36+0/7
 Uw4ulL9cwtlWB97JSf6/Bd+AQkjwFdHYCTNfx1KIBcLkYuqqA2sPGY1cWS8tOOUxgAlJ9S5XvC1
 G7szCvaCQxLgNHVO8UQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fa2adc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050171

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
path. In order to handle the RT kernel case, raw spin locks were added.

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

v4->v5: Replace get_map_page using pin functions FOLL_WRITE | FOLL_LONGTERM
v4->v5: Add shared function for destroy_adapters, unmap_all_adapters_pv
v4->v5: Upon failed injection on fast path clear the summary bit only
v4->v5: If allocation fails in inatomic, clear summary bit and do slow path
v4->v5: Change fi->lock to a raw spin lock to handle the RT case

Douglas Freimuth (4):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: s390: Change the fi->lock to a raw_spinlock for RT case
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  13 +-
 arch/s390/kvm/intercept.c        |   4 +-
 arch/s390/kvm/interrupt.c        | 497 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |  31 +-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 5 files changed, 444 insertions(+), 106 deletions(-)

-- 
2.52.0

