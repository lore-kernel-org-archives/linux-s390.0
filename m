Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52347DD60;
	Wed,  1 Apr 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065211; cv=none; b=Ey+VxzhDuoCUrVeItCqoAwkeEoWWZtfg+W8JoHAipqlOXirynMBXj/m8JfKUD19We2eeDRNLuzim4HhRpZCsgQpz7tUnk/se1QtqzyUyRhoVKfzqyMzVwjBOieMigsxGNBmBZafEOSZg8ZpouI+AJG855B1hQ/cafe7JIkBSPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065211; c=relaxed/simple;
	bh=ch4ggYUqYHObvYkuHI5s1gCa+C/o/y4xPgQzr0CF0xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=towH/q9u9pOvs+SXTMQpXiujD3xSdVBZFJbULrPQ4fi5/6OXNgK5jwmmzN9t6NI//N8abWHAGEE4kYVCLll0smravPNt1xApP58+25AMomcvNGgoRC/gzPhwtupBoYrl3lRCGsy8N6V0rCcDvCu9mj5t/yPB8pgu5F7yh8qCjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HWCcsDos; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HWCcsDos"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631BUZLS330917;
	Wed, 1 Apr 2026 17:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KnbZ9vCiZHFFfPhHWWf64gpOMzm4LMedtbQtnSZyz
	mo=; b=HWCcsDosv/ouYka1UbcLOUYbx8qWqcjU1s+PEWJ5qcpSa8f/iTnB6mWgk
	5BNxQQIqhLBSlitKcolR2qj5YmtLffNBib9RVI6REaUfkW9NcpxqpRUpO17Gv/ow
	ie5AoZ6p5m5tIIy1nw3o5bgOsIuSUkm9ug2/Srq1K6Gmq2YVlznV5H9G10Igt380
	KpkIsGDpzFqdudmxe4MGfIlYPJpv++/MnelDnWGL94BkY7IuiMSIy/3yerOwa+Mq
	i1jbadGi9oViLPXmY2EYeajW74AyiXMcUcUUMAJQ3Ls3Cx+PXEfi+vko58GtQoL/
	dY/mXO+1W0sN2gjXmZTIBhPqy+lZQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgrunx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631FYUXZ022165;
	Wed, 1 Apr 2026 17:40:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan6qdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Hdv7u37880096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:39:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E5120040;
	Wed,  1 Apr 2026 17:39:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF542004B;
	Wed,  1 Apr 2026 17:39:56 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.24.224])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:39:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 0/5] KVM: s390: Enable 4k granularity for memslots
Date: Wed,  1 Apr 2026 19:39:50 +0200
Message-ID: <20260401173955.314821-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX0ddXVnPpGF5n
 eMXTylt9O5fB19b4AfbkDLLzS7eI0y8XE2EpQFiYUaTAtI88SlmnJivnQdVQd3y/I2zhh4xwelA
 KxiXSWyy/37SGUEFt5oaEw+CmG5RsrJDd7FPiWtAMg5Gc9Oqpgga0NcRZpXoBdjcpsnWDcLxNIq
 yKPSwvxWsyL2aN/hXO5fNx/SezlQFNlwxxH65zUTt6RfKCtoaGCCzVc2Jj+U31MNkaHURJ5U1xy
 1NeSFVr1mynZ7kwe5Xw8gu0bEGirOMaX3Xfq8seb7uYFNIrQ5O2ZluCAFykZ3rQsdfowYmXikA5
 iR6Sqk+1zk2bFeKmHe46VUy8CvGRXrdODNXYs7pXweyWqSN8tEJhedHVs7iw2ixNjq4b/DGraB8
 zNQ6D0AmDBu3TZQ1WplGUqL1frFyEHKSU8eSPiP5t9By7FaFDMQXGa46kn/0sVIXnSaunu5RV9g
 B1Cis+/ZuvRSNUki8Og==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd5873 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=vLom9edpMwVfNJ_xIb0A:9
X-Proofpoint-GUID: APi5M6RT3cNxayYTYk4H3P6k8t05BN9H
X-Proofpoint-ORIG-GUID: APi5M6RT3cNxayYTYk4H3P6k8t05BN9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162

Currently the memslot granularity for s390 VMs is 1M. Both the s390
core architecture and virtio-mem only support a 1M granularity for
guest memory.

Notwithstanding the official architectural limits, it can be beneficial
to support memslots with 4k granularity. With the new gmap code, this
is a quite simple change. This allows us to enable more existing
selftests and makes KVM on s390 more future proof.


(Please note that v1 of this series was not sent publicly)

v1->v2
* Fixed the first patch (thanks Christian)


Claudio Imbrenda (5):
  KVM: s390: Add some useful mask macros
  KVM: s390: Add alignment checks for hugepages
  KVM: s390: Allow 4k granularity for memslots
  KVM: selftests: Remove 1M alignment requirement for s390
  KVM: s390: selftests: enable some common memory-related tests

 arch/s390/kvm/dat.h                           |  5 +++
 arch/s390/kvm/faultin.c                       |  2 +-
 arch/s390/kvm/gaccess.c                       |  2 +-
 arch/s390/kvm/gmap.c                          | 32 +++++++++++++++----
 arch/s390/kvm/gmap.h                          |  3 +-
 arch/s390/kvm/kvm-s390.c                      | 20 ++++--------
 tools/testing/selftests/kvm/Makefile.kvm      | 11 ++-----
 .../testing/selftests/kvm/include/kvm_util.h  |  4 ---
 tools/testing/selftests/kvm/lib/kvm_util.c    |  9 +-----
 9 files changed, 45 insertions(+), 43 deletions(-)

-- 
2.53.0

