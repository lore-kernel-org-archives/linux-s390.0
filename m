Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3F3DC4B1;
	Mon,  1 Jun 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327816; cv=none; b=E8eoD902WjZF3REwQRWDzxwOJlJZmHsrJqsrSG8gsB1gA6qRndXJ6u1t+Ol6rWlqG9beQHJ34kIlRvly+ZSdfs0Z7w8QVmzn+pKpEzmW734hiHrmNiqknqaJr6ZtZI2xnSlrPKNVPVJKmN2ZBrCrPfY8X0MFrHqBEIEFEUPzq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327816; c=relaxed/simple;
	bh=8CYjYz9HAXrOkjBw1aCHLcJbD5CJzQVlQdaF5xfDY1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eua6wEHqOBxeTVI/9dns3a7qiv5q7DBe/GbUhbisUypYVZxDI8WjGqfk8tWDT8TFLMtHVKnnGoUtgLCTGtm7vCcwlvOci/3/+x6HodfsM6CSjBScKbQ7E4Hf7IjO++o1ig90VuRhtorVAriSsxoF7GiPrJnWgd0KGpr1oVl+3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lud+W5px; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lud+W5px"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651EpJGH2190646;
	Mon, 1 Jun 2026 15:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CzvVPmwU861ysRE6OGTQUccPIaD8AXpTtcvBuNpQI
	sw=; b=lud+W5pxyKTrQIRT75gCuDUxt+ltGxAU4exMLdd+I7lGvgWeZKU+l56yM
	X42e4+SMgnNT2xPotONrXwnKD32F6vFAPq0JIW+krL/F2Qrj8wcWYMNgyrrVP7XX
	axuIs6E20cvvIfChySE7rlwgDy9fkduAhe7YWyBbZQQlzDvSf75TZZD3XvobRQ9R
	3JNnjbs/NhU1KndU5EKDPWyaqsdGzZ4+JSQxVBYTL5bp22iKxkr9WmL7lCzx7OKW
	4ytq7FoKDYHPk8rIbUMB9JAvQDEZ7kBpPec18HoeNbHCEs7p50eGpZn5wje9RuKM
	ZPQmUWuzoHw1i2zYm8UYv92a+jpxg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae17s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FOKxL026051;
	Mon, 1 Jun 2026 15:29:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q6yjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTq5V30015754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B6DD20043;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D465C20040;
	Mon,  1 Jun 2026 15:29:51 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 0/8] KVM: s390: More gmap and vsie fixes
Date: Mon,  1 Jun 2026 17:29:43 +0200
Message-ID: <20260601152951.196859-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1da576 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=RDX2kTa0qNrNx1cvdRQA:9
X-Proofpoint-GUID: Wcj4gJuZMu9NlehUJ0PzJo26HJjjkVXK
X-Proofpoint-ORIG-GUID: Wcj4gJuZMu9NlehUJ0PzJo26HJjjkVXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfXwT0z/ECy1P/U
 Xstc9GGoV2WTHHI65Ko7AuEdBcexsMwo0Mkx7YXdKKJ2MRYV1KGkGjyykxnslY1DvRsubXIc24e
 VTCc73DDh2X39rejvmlhNBZ1hR9Z5GOJZi8IvVFwgLev9nxF1Z51MIa1eOG7zaSmUpkCLby+9Cb
 YhZ4I0v1kBw5iLoapyL3FIUh4p7xWH28DdsgjTYvdbQC31+J390T9WjCrpHRtR5U7PqtSwuFyub
 /W3cOunUHLl5+xR54Zs0QzG6sjnUwvXrqzGvF1nKeZ//2aZlkFO7XW7W79KdIYYDbVD5wPm3Ykm
 tW+tCOROQdGB2I3ZqX/lfu/4GE/t+PcHry/kFqzoquOCSFoVmYm4IEnp+K8tPadlhYwYbGot9zP
 e2xF78CyYEiBQJyJPLFa6TAqa4bLYQLqjUQ+r/SkU2UO6wsZiaf/NhEMb8oJ2xlLVeLvp9wY7bU
 BuPO7B0F0DD7HSAW78A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

Another batch of fixups for gmap and vsie. Some minor fixes, some
not-so-minor fixes that could have caused guest corruption under
particular circumstances.

v1->v2:
* Reordered the patches
* _gmap_crstep_xchg_atomic() will now attempt to clear the vsie_notif
  bit when failing due to unshadowing; this prevents potential loops
* try_get_locked_pte() will now return -EAGAIN instead of NULL if the
  pte was reached but the lock was contended; this prevents potential
  loops
* _kvm_s390_pv_make_secure() will now attempt mmap_read_trylock(); this
  prevents try_get_locked_pte() from potentially racing
* Take kvm->slots_lock instead of kvm->slots_arch_lock in
  kvm_s390_set_mem_control() when handling KVM_S390_VM_MEM_LIMIT_SIZE,
  and also take kvm->lock.
* Minor cosmetic / style fixes.

Claudio Imbrenda (8):
  KVM: s390: Fix _gmap_unmap_crste()
  KVM: s390: Fix _gmap_crstep_xchg_atomic()
  KVM: s390: Avoid potentially sleeping while atomic when zapping pages
  KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
  KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
  KVM: s390: Fix fault-in code
  KVM: s390: Lock pte when making page secure
  KVM: s390: Prevent memslots outside the ASCE range

 arch/s390/include/asm/gmap_helpers.h |   1 +
 arch/s390/kvm/faultin.c              |  14 ++--
 arch/s390/kvm/gaccess.c              |  11 +--
 arch/s390/kvm/gmap.c                 |  19 ++++-
 arch/s390/kvm/gmap.h                 |   3 +
 arch/s390/kvm/kvm-s390.c             |  30 ++++++-
 arch/s390/kvm/priv.c                 |   8 +-
 arch/s390/kvm/pv.c                   |  21 ++++-
 arch/s390/mm/gmap_helpers.c          | 117 ++++++++++++++++-----------
 9 files changed, 157 insertions(+), 67 deletions(-)

-- 
2.54.0

