Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885602E8897;
	Wed, 24 Jun 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299979; cv=none; b=BBywHVV9m71CNgACH1pzcWkj4f6PdkW91l1re2SnQfOrUXDPFPXdxRTr6JiXDNNSimCm5VxpSWA4+eScNKpcm5+6ClVFF+WfLqB1UkHGtp42YIJLOZ963fwdy04qiPP2mW58GI1XTdSpLMm/oXQy5pIZNwfeHVyp+Rug1hLVlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299979; c=relaxed/simple;
	bh=MEGh5Wqm2CuGKn3jLVKjQEJz+OoPSWJ/GZQsV9q0mHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxSOFqwXE2MsLdizZdGZ76of0khN4C0N4CB9JY44pFt5CSuE5FwzF+w1qqQpxHncTAk0JS20sobjQPWLVvIHi1PZQJul3e0q5tBZ2Q6UEoyOyIU1bISUqaMg+xGNn2qM1gt4PJAxVOYUAZwtI3bTNEj9DVYXx45/MC3OZwStcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RjP2b6Md; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RjP2b6Md"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmJpF717979;
	Wed, 24 Jun 2026 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4c8GV3PydGKWg5W3KOwq90mZOAzNMZOCpxQMqcUix
	yk=; b=RjP2b6MdArRflFjmx0nLcnTpW2lwMpryAaKcXvLhjle4/kNk+UQdIFz02
	0X6eOJrzP+xz1bC5N3fXWhYKyIWa+wZmFJeknyOByzHe0y2Bp3efBPwCxV/769/i
	s2/clROrK8+8ItgkMDqwPqJa8RUVWZTdp0Bo+I/yWmoyn49MN4RrQAN5ngWGTtLk
	35x035ULhzaJcaXrZgzOBMwvPIGlpy82yB5uVeklJs/OzIJ0o66fd/rIx6bIy1HY
	FXVWHzUmmce7+S+kHorCJ3rx5QBSN1mXTxzLIG6exNIL1EOFFTB718aaz/LSHf/z
	/LQJan+aPwnvXVFCxlyclSOXQ/WSw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3kv5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4eOn022073;
	Wed, 24 Jun 2026 11:19:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg8101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJSLX16974262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53FF20043;
	Wed, 24 Jun 2026 11:19:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 847D320040;
	Wed, 24 Jun 2026 11:19:28 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 00/12] KVM: s390: Fix S390_USER_OPEREXEC and more gmap fixes
Date: Wed, 24 Jun 2026 13:19:16 +0200
Message-ID: <20260624111928.144283-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bbd48 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=mMwgtVGczyN9lTVxpCkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX8dHKpbEpAiZX
 G0V6aVyxxZnsgbBWyv0YeRYux724coCcTjPwWmYSpK2Iw+uqPRBtN6Bz3whzT8yQ0ayo9wKN+Bm
 oBiS7FxKQwWES133khrE8YygRcDSGWo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfXy5CBVEKWycJY
 D+1LUx2izcrj9F/iOoU/g7s6ehqQXUQWXFG/ASX4JwIVyaDFUhNZ3co7u1TY0QEzB3y5t9mbqHN
 l7N+2N+qWr5Y1p72cjQz8Xo5dyZweMqSsW9uT8FZcFBzOlobvkVV5SV46+kmQNDO7XH1QgWQH4C
 6GBmxabk3Pe0GW8EL97/Lszhs4yXT27EE4iVA0nqRxdY/RGDjBHpR5Zk/DEk/S2WxUGt0qWUoXL
 ajlE5rxfp5CZRYgzS8TOKGItGaPbUpG1IuJWqCNHtHOgTpUw0nUVmb3ABImrIgq+bJg2BHQdGFM
 uLjjGbc1MPUOINQj/9Icn6sNmyQSzbd6nAsFhqajCNDlL+ox2bWlZ57kcvB+oc+WglcsHHc6RzK
 W1EiAlJneclbG5eNnBkVdl1Mqqe2aYHW1uiiDxEEKxyAlhonj2DjeIG7vCysSg/5xZiazkKxG9j
 QVBlLlc2FVP0LAFvV2g==
X-Proofpoint-ORIG-GUID: 1-KKaNEhXMPaHKNSDyXuy4xRZJhBMIaB
X-Proofpoint-GUID: 1-KKaNEhXMPaHKNSDyXuy4xRZJhBMIaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240094

Ciao Paolo,

here are some fixes for the second half of the merge window:

* Fix S390_USER_OPEREXEC so it can now be enabled regardless of other
  unrelated capabilities
* Fix handling of the _PAGE_UNUSED pte bit that could lead to guest
  memory corruption in some scenarios
* A bunch of misc gmap fixes (locking, behaviour under memory pressure)
* Fix CMMA dirty tracking

The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:

  Linux 7.1 (2026-06-14 15:58:38 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-7.2-2

for you to fetch changes up to babe08404e1993697a523e60bc0f9d096ffe1ef8:

  KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits() (2026-06-24 10:08:57 +0200)

----------------------------------------------------------------
KVM: s390: Fix S390_USER_OPEREXEC and more gmap fixes

----------------------------------------------------------------
Claudio Imbrenda (9):
      s390/mm: Fix handling of _PAGE_UNUSED pte bit
      KVM: s390: Fix dat_peek_cmma() overflow
      KVM: s390: Do not set special large pages dirty
      KVM: s390: Fix code typo in gmap_protect_asce_top_level()
      KVM: s390: Fix handle_{sske,pfmf} under memory pressure
      KVM: s390: Fix locking in kvm_s390_set_mem_control()
      KVM: s390: Fix cmma dirty tracking
      KVM: s390: selftests: Fix cmma selftest
      KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()

Eric Farman (3):
      KVM: s390: Fix S390_USER_OPEREXEC enablement without STFLE 74
      KVM: s390: selftests: Extended user_operexec tests
      KVM: s390: Fix typo in UCONTROL documentation

 Documentation/virt/kvm/api.rst                     |   2 +-
 arch/s390/include/asm/pgtable.h                    |   4 +-
 arch/s390/kvm/dat.c                                |   5 +-
 arch/s390/kvm/gmap.c                               |  35 +++++--
 arch/s390/kvm/gmap.h                               |  12 ++-
 arch/s390/kvm/kvm-s390.c                           |  71 ++++++++-----
 arch/s390/kvm/priv.c                               |  10 +-
 arch/s390/mm/gmap_helpers.c                        |   3 +-
 .../testing/selftests/kvm/include/s390/facility.h  |   6 ++
 tools/testing/selftests/kvm/s390/cmma_test.c       |   6 ++
 tools/testing/selftests/kvm/s390/user_operexec.c   | 110 +++++++++++++++++++++
 11 files changed, 226 insertions(+), 38 deletions(-)
