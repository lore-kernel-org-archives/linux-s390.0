Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE473242BE;
	Mon, 11 May 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516101; cv=none; b=LSewg87sJ+sLWAlbETWoKX5awz8YHFrwtJPSOBBgYc1zEpaPapzkEdA6Wc82Uz8Ulwy3tHgshfSyvt1K66oqnFGq1ge+L42w31V3gFV1Z6OLnWqHi4dPwRlftGID68ybq0Vgx6upFdj9e5zZfCUma8rqEUmpd8Mw3JHY6wNbvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516101; c=relaxed/simple;
	bh=wCsIW7f9cVIBT0e1hBzi7cr1PFoP1yoV3YD/CUo+g9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ju6NQ4GhLgkSQD2tg9riSCf64amspale/a6WNzd4/240v3HCKbFgHwUaBF6FiIBbuixmXlgRRDH1HykumDpmWKxEolHymiEdR6c7E31GSWtW2LNiWj//Ly5mezXz2rMmBnkoQUuV+wLH3MWRn750i8Z5h8KuQCR0xO0LVgQ6bCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EgGZ4ic+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EgGZ4ic+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B9gFMG3186225;
	Mon, 11 May 2026 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jvn9UdO/tzb6TnBNzBKwQnTZBXiWI/Eb9wrd84JZd
	mQ=; b=EgGZ4ic+/FpD7J3nAvvMF4/vS35lQ1k4FKV+DHhvUaODoorzvXs/jk6Ii
	w4M5KQ/3PoxNOehyhye8g+UbNNxER4Lsv72hCfKruPZArH3MPbVXPj3i1oI0Ci97
	SzPij3gNkM/7qjY7ilgwse+jDWaVCwmoXr0GLWSsTCcOrdZVZZZGzaUMKXKcYpTd
	G3Y5Z0cNraQR63pBdm6vl2ydIyJM/oiUwUQYaB5Ji4k4v40X+LZQI8/VUvGS/JTO
	03HIxA5h0Tz44GtCHHt9stvaN9vmqAKE4RaMET4KkKRGFG/m7VpihtMW1oa/X8n3
	y/1FEGWtS3re7QFxcJW/jkC/q2OFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve71719-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:14:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BGA0bW020741;
	Mon, 11 May 2026 16:14:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jx17q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:14:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BGErVv32899752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 16:14:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6592E5805A;
	Mon, 11 May 2026 16:14:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FCE458054;
	Mon, 11 May 2026 16:14:52 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 16:14:52 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v6 0/4] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject
Date: Mon, 11 May 2026 18:14:47 +0200
Message-ID: <20260511161451.209464-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NCBTYWx0ZWRfXxCtN0ujU7SeM
 uMmBmsl+N9vczvCCJpyfZUiKiF3XblqXVf8kKscmK/8VPtdzXlF6Pxe3NsdGTzcYE6ZIFcXghwr
 IDNKvEdpXgC78c4MHEd6TrBfO2JvWyBCQbgeOZtq9GFJy5elSr84TrAiAG67tbbhj8Vpvg4hM/G
 YZt8FfY8XWhrw1FJF19VlFfw5bg+fH7Dxhhay2y+V3aXCT6++y9zAM/9JqtcnbFMvnklS4Q4o2h
 JmoWHmdDpJOJRxSIc3DUyy4CLMCVTbv2DEhLxUKnCfrEPa15hQ8eFp7lE50vhqbkNkQU5XlkX3S
 sQSkq+Kgi0T+NLeODl4srHqg5Po5kSp1sROslqeTo8Q0DQap7j0S59CrCV5Esr2i1XAy9yVFmVl
 qqUc1ZkyosoiYVUi7TP94zlU06NeVJUITqYtfGBF2jxp+r4JfWfDHN6sELIZ6rUc5iwzCSVVzLx
 XX68e7Xql60BKByhajA==
X-Proofpoint-GUID: weKbUtcecV3caY2Wqfs0T6cRY3KWSOxJ
X-Proofpoint-ORIG-GUID: weKbUtcecV3caY2Wqfs0T6cRY3KWSOxJ
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a020080 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110174

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
path. In order handle cross platform common code raw spin locks were added.

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

v5->v6: Change one instance of put_page to unpin_user_page
v5->v6: Make local interrupt lock li->lock raw_spinlock
v5->v6: Defer two instances of kfree until after release raw_spinlock

Douglas Freimuth (4):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: S390: Change the fi->lock and li->lock to raw_spinlock
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  15 +-
 arch/s390/kvm/intercept.c        |   8 +-
 arch/s390/kvm/interrupt.c        | 545 ++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.c         |  33 +-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 arch/s390/kvm/sigp.c             |   4 +-
 6 files changed, 475 insertions(+), 135 deletions(-)

-- 
2.52.0

