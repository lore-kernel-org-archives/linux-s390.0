Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E932DF3D1;
	Tue, 23 Jun 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228822; cv=none; b=OxfLm3RTmQeAgaKFf5az5Rgg8WfaOdoYl5ftbn7fwtf/BFAzew9v9U/NgNMcWuYlF42Dakr2mkiUBWTa+rCtj6Hv7+0LKZ4fcj/U2KKORuPTzHhkyrPsE/Ci8i7ustwgJNn6ljWsVK0J6Amg7jaBEsYomEunP/a/TjGSNkjVgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228822; c=relaxed/simple;
	bh=zMb4JMcqNOUUKu9q8iYdXNELDyKmghjDhaHYYN2Y0vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDXXmMWgei6HonMlxATboplnTOKLZ5n9ztSeiif8xeSAV49l3XFjQ6PkL0hzIprLAQEQKPEki0jg4XorXDlK48NEclQkLizViTDEdC+DYwcqh3Kww4v4FSLD8xg5fysZjHsPpm5MFT9bElm2O3csRhzj+L4OArPU68Ym1+gZ3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JsrMvV9f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JsrMvV9f"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmsrI1858181;
	Tue, 23 Jun 2026 15:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Mlc6ZlMa0A0ekqvBdNdop9mOs93wmTzB4d6Ete3Yo
	t4=; b=JsrMvV9fQRmjEH7byVv4v7PdPhQLwIvKjjWy8xNY4oduF7oSosZQxGAmy
	dGyLZ4svuwIueM8KKjobL8YnRD4Paa/QYVc3W9XcQsV/LpZ6SM/32gMe5XM9qsVf
	g4Z3du/+TH4Kwq8gKsPRzzw7Mj+mkMPGtxmE08og8mKlnidZs+ZxUYX6j5Q1mSgC
	/oNB6asWIyZ+ZYLIIBIVAKvk6Sy6vnn5SirZ3+AA9sOl25ysEvQgXEan1r6SfDm0
	adD+ROICTjK0yo6R4fz8+q8CLY8NGfD1iUdpiVLW/YA7jJIPCJEwvrQ//qs+uGN5
	DpDZ3Bla9KVoOJlA9IRNHD8ElljcQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hqmps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJc4R027624;
	Tue, 23 Jun 2026 15:33:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qc7kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXVwY27984132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FBC120043;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E04A20040;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 00/10] KVM: s390: A bunch of gmap-related fixes
Date: Tue, 23 Jun 2026 17:33:21 +0200
Message-ID: <20260623153331.233784-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3GmfOKAf_GSML5p_9VfWXTdz28MQyTb-
X-Proofpoint-GUID: 3GmfOKAf_GSML5p_9VfWXTdz28MQyTb-
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3aa750 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=iLwnI1K-hrd9xSQBnUIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXwyaiJMZrfvLW
 ZMIT7nNzl0uc8Gw9DUUgDker6qBAou28maWhk58B29NLMeBzQ3tpzpdYBq4+LIGSPhRdZ7PAG3o
 5HwAiN34ihxA8rkGNaIuVpJNT95jsgKAJxHMt9XFIB7pKNmM+dKopqfSTxW0BN5bDLlc4wIkimu
 PVvzLB/Zegqz2VqCzE5h6AMPlunZ7zjl4XdvWkcOTsMGMNj9FDC+IemBHcJIgOQ9401WKkUyaup
 uL8AJufXgW2tjN4MNOaQjiQ0/vZLZk9rB7LZwHjvi6WMA3Ec+FV6JtI1aA+w1HHxl5i58chnUyE
 FpoMR0RoU9nGIFPHLEVPi47QVBJUKNeMKGFjhkKLF1SsbdoQTI7G8yuc0PipioP53W6LhU6Qdi/
 KxJnXcGaizmSUUtzyc+WHYVPiGvykg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX8V9thiOMIQIO
 yaTFAPBqLnm6oX8qT1ZDb5aICRcIp/R+/pLnSJ9Z7InfTKPQGLhmPjvOY51vz9AX4Xxh/SBNX0k
 YrlIzn2pxTQH7OHUDBq8tq3pAgBlAnc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230126

Fix handling of _PAGE_UNUSED pte bit. The bit was lingering around
longer than it should have, causing issues. This is yet a different
approach from the previous version.

Fix some cmma dirty tracking functions.

Also fix a few other small issues in gmap.

v5->v6:
* Move locking back in the individual cases in kvm_s390_set_mem_control()
* Add commends and rework the handling of cmma dirty flags in
  kvm_s390_vm_{start,stop}_migration()
* Avoid potential deadlock in the unlikely case of a nested guest running
  with a real address space

v4->v5:
* Make sure the counter of cmma-dirty pages does not explode
* Improve comments in cmma selftest
* Rework and fix locking in kvm_s390_set_mem_control()
* Do not return success if an allocation in kvm_s390_set_cmma_bits() fails

v3->v4:
* Improve/fix descriptions of patches 1 and 3
* Fix handle_{sske,pfmf} under memory pressure
* Fix cmma dirty tracking and its selftest

v2->v3:
* Fix _PAGE_UNUSED in yet a different way
* Fix a potential overflow in dat_peek_cmma()
* Some minor gmap fixes that are not actual bugs yet

v1->v2:
* Completely different approach, entirely new patch

Claudio Imbrenda (10):
  s390/mm: Fix handling of _PAGE_UNUSED pte bit
  KVM: s390: Fix dat_peek_cmma() overflow
  KVM: s390: Do not set special large pages dirty
  KVM: s390: Fix code typo in gmap_protect_asce_top_level()
  KVM: s390: Fix handle_{sske,pfmf} under memory pressure
  KVM: s390: Fix locking in kvm_s390_set_mem_control()
  KVM: s390: Fix cmma dirty tracking
  KVM: s390: selftests: Fix cmma selftest
  KVM: s390: Return failure in case of failure in
    kvm_s390_set_cmma_bits()
  KVM: s390: vsie: Avoid potential deadlock with real spaces

 arch/s390/include/asm/pgtable.h              |  4 +-
 arch/s390/kvm/dat.c                          |  5 +-
 arch/s390/kvm/gmap.c                         | 41 +++++++++---
 arch/s390/kvm/gmap.h                         | 12 +++-
 arch/s390/kvm/kvm-s390.c                     | 66 +++++++++++++-------
 arch/s390/kvm/priv.c                         | 10 ++-
 arch/s390/mm/gmap_helpers.c                  |  3 +-
 tools/testing/selftests/kvm/s390/cmma_test.c |  6 ++
 8 files changed, 111 insertions(+), 36 deletions(-)

-- 
2.54.0

