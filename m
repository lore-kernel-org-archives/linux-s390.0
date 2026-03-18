Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAB363C73;
	Wed, 18 Mar 2026 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821177; cv=none; b=D0S96GILU91Fmti3bukSVAMT65qBPyZRO4R5xxOhvEw4DbOadbRivaBPNgcNkAxd7lxcr1Hhf4rmx/eUDZMGck3Ov1tAIINrEK7VmDw2NiLi6IyVghAnG6uLdgBINlmMTqSsrGxDBuU/l5NtnTv0pJud/BWeYyHPLzGoDPu3ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821177; c=relaxed/simple;
	bh=PV/TBstO0wNsJNSuksdDnOmm8n6LY3KuTcp5tRvkMt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6rxO8bc85qvVfpggtqCjaTC3+b7zcFTMgPKn5hmtWR/JbBSN/7hfEoIDmVLjO0mk4F3UHUTHSpyVE8YwtvegrmDtkiLegy08fEwMNKfhIKAPz0agrCr+PbLq2wrDxp5wQ2ICmCX5YVKQ5xOwBwV2kAiIajw4iiOaotMVpC27Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tZUfMJXW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tZUfMJXW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HKEnO31466854;
	Wed, 18 Mar 2026 08:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vr60p70BipR+G7lwRSHUso98AQBcebpTsNC+VwbKK
	TI=; b=tZUfMJXWeZqUYdXE6qpCHe7gbPPNpkVSt4HdoYT/mn9BJC6BwNFxIVHn8
	FhjStByf0eNNmnJOUxOv3WP0uYJmAX50shZ8nDknJAFh3/8irJFxoaI0Kn4Su8hS
	tEqJkYhxzoHdd5VuiUVu7HhWcb58J5JckbEvw3ErVaZCgLax7IcTDiO+rkYcY356
	1GbB1ixCYjErE0r/+e6kI45es8379jjQgedDyr2FAmEWjFpMll84cMrlUbZMoXxI
	fOCfSHyl4hR9S4eSvIb+YTs89pA5q9xBKAfeL641PQACf3xgurAa+5CYCOsPAAtc
	BYO1b1fxRRsXl1rK/sTDgH03wbhRw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfk4d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4cmFT013997;
	Wed, 18 Mar 2026 08:06:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy5400-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I869Kh4784906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:06:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7550458064;
	Wed, 18 Mar 2026 08:06:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F09C58061;
	Wed, 18 Mar 2026 08:06:07 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ibm.com.com (unknown [9.111.93.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:06:06 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [GIT PULL 0/6] KVM: s390: Fixes for 7.0
Date: Wed, 18 Mar 2026 09:06:00 +0100
Message-ID: <20260318080606.2450514-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zL11FZ9VXFmuxtBZEMkLs6svMftpDjrs
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba5cf4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=iiqISpq-karmuahrZ-0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX0HZqSO6rmx34
 u7FzByyLy45SxkrvsjIvuVT+MFS1sSmqBJ7TRpsHPTrTIcekGrDmuaQGuWUGicjcE+pJzAorjWg
 FPPypPXe378PeatodXH1ND4CnTlOqiu1vfseqS9+O5IrVrPmqS3LYDFWIXQ5tJWl2eDOz4trQOM
 gptWhpm8jHg0zOC2eUa9F59kr8fSA5NU7adkzJDxf7Nu3u0Bxkb/UrwI+w+7Fo7zK4ZVyW8++Fo
 dTHVubil0K4l0VM49YJqVA/9U8rGtYXGvx0nNwb0xVd6CkBp8pIocTsn3AZ+X7L+sJOOXR7zMSZ
 DXahe/IRJgNhkuIXE6vFS1PQJq0Thl2rPkZ/jQYZ4nwfhtmEXq/MMOat/xUnQXIn6aRfRqWEQJu
 xsgP/WKnK8TIAlKWcGStHWlHa10BR9q/x9jAyRIS3P50r9ITPIozfwaj9vCH0DCb6VX0IIOK0dy
 mu873MJc2KBdl705PWA==
X-Proofpoint-GUID: zL11FZ9VXFmuxtBZEMkLs6svMftpDjrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064

From: Christian Borntraeger <borntraeger@linux.ibm.com>

Paolo,

here are some fixes for kvm/master. Also with a first fix for the memory
rework, but we know there will be some more before the 7.0 release. Stay
tuned.

The following changes since commit 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux (2026-03-05 11:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.0-1

for you to fetch changes up to ab5119735e984f6b724ef1b699c01479949ed1de:

  KVM: s390: vsie: Avoid injecting machine check on signal (2026-03-16 16:56:39 +0100)

----------------------------------------------------------------
KVM: s390: Fixes for 7.0

- fix deadlock in new memory management
- handle kernel faults on donated memory properly
- fix bounds checking for irq routing + selftest
- fix invalid machine checks + logging

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: log machine checks more aggressively
      KVM: s390: vsie: Avoid injecting machine check on signal

Claudio Imbrenda (1):
      KVM: s390: Fix a deadlock

Janosch Frank (3):
      s390/mm: Add missing secure storage access fixups for donated memory
      KVM: s390: Limit adapter indicator access to mapped page
      KVM: s390: selftests: Add IRQ routing address offset tests

 arch/s390/include/asm/kvm_host.h               |  3 ++
 arch/s390/include/asm/stacktrace.h             |  2 +-
 arch/s390/kernel/asm-offsets.c                 |  2 +-
 arch/s390/kernel/entry.S                       |  4 +-
 arch/s390/kernel/nmi.c                         |  4 +-
 arch/s390/kvm/gaccess.c                        |  6 ++-
 arch/s390/kvm/interrupt.c                      | 18 +++++++
 arch/s390/kvm/kvm-s390.c                       | 16 +++---
 arch/s390/kvm/vsie.c                           |  8 +--
 arch/s390/mm/fault.c                           | 11 +++-
 tools/testing/selftests/kvm/Makefile.kvm       |  1 +
 tools/testing/selftests/kvm/s390/irq_routing.c | 75 ++++++++++++++++++++++++++
 12 files changed, 129 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/irq_routing.c
