Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD7455615;
	Mon, 21 Sep 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980030; cv=none; b=LcaEBDlk37W/XZkCKzsXZy3t1ktkLHG4zwExjextnX7ztnFyQgzwn92wx7HnaOsW0IdOF6QcMws0hH9ZN6Epv1tFHHm/fUEzg+Izm6u/Ob4Rsh5GdBNyfZXEm646C8Ys1Tr9+qAXlEHM1R1nErbqOA1OCgPRlVsM2DGGUlp2zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980030; c=relaxed/simple;
	bh=CU2p66a7Bh2hInESuyFErw6hGRfRKdymKRIcTARoync=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSUCqvzEw/g9mQozfhPpee378C4kfARw5PWorSiwQgQ/LESMOn8gu4pfoGNjRiDSspEG33Jy+AEGbdty13rZcBvQg3RkXLJlwwusb6KUkeNOhi8a9WlTlEGBAiqwuJ02IDiwSE4b63mAeHRfWsakIaNXOX2xaXnntiOSna7H3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b3jcm0Yt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b3jcm0Yt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZVFu818931;
	Mon, 21 Sep 2026 08:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FG5BYxKUSf8nWrIQfYiXk7yGV/0wl3Z2ePfFSPi1l
	8A=; b=b3jcm0Yt0Lro4S4896rjyXEuPmTDFqrU8usax5o67PjFxN+9ZyjsbPgMA
	KDYlK94FgRKVgxHHWKCxvTO6NqZZuTcbcB8immg5Xx8SNMwKuouzvYPw+L8ZiTSb
	0wrpTecTydHCJIOZTKMBfEyrhLlF/k9Csddvn6NW01cxRbZ7B2MHoAXdHeCHcqsN
	gmdCGtPukQ5jtX1sz5r9NQd479BgxjBOoRMZTQkfRE0LtJRLVO2V/gwUqEzRO4Fp
	ZkKanFMFyrbvJB5PkULLJOGhChDw0cOpg5jsKE9XfyQq8Z+YDI5jdWSICEO9tehc
	seRTiu9GROsljCUmCUxGebD4xtiOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27jpd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7Hjqg867875;
	Mon, 21 Sep 2026 08:40:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vckk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e66M46334416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ACE520043;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDD220040;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 00/11] s390: More this_cpu_*() changes
Date: Mon, 21 Sep 2026 10:39:54 +0200
Message-ID: <20260921084005.4022574-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ehex6lYSB3JqSoaXYzYaPOTJzSoXRDvY
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0ed6b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=D0pyD9DYDlHxKxV_1YgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX9G7NcuXQMIgv
 Vv/dPq3B5WZb8DgHchCJXT0vB94iHBXe4FNwCarz6Em8Xnkj/4RO+NX7YQFTP+067HVAtdQU2Hz
 W8bbLwHg/PU2dORW6iAESIyfUEqZY2d03CDQqFLhz+u+urnC6odHHZmLYOlm5m6OAtxu8ds0gvX
 hqmCNgch3inohpTbYJ9+UpjfIUFMk9vYUI5mVe+Jr0OoJuykKVDIHty6tBuAmeaZ2rZrZ5cxtK6
 39HgfdMSt+G1IE58ThkyR+9r4H+MvUqMYNUIdmIxMeRsiXvSIylbIE3+/fZyXfb5JSKOCRHj72U
 psrJfStt/gt4jJF5mGfmeoAOmcKcopW4EnyYiexZlXgIAuWr+qazKJn4yoovqeCx49BlUZ1YfJ7
 v3S6WLJmZswYnoUlTOO3S9Dr0t2Od0K021WpY7tEMoejqTE3DgGnDKb4CcFEkCP4T7GIMsA5NOt
 qnyKb/6RhhaiO3gcdZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX7eXCHdWfXIka
 mRlLFR7w6sK64tTtVCZryyIq87JAmVi0zgdu520vP8VdzTZmCHyyaH6+z81acFnBdgRJ+ZPK6Tx
 cvOy6pibEbcgONGZ6OLxtPLDIU7fDgU=
X-Proofpoint-GUID: Ehex6lYSB3JqSoaXYzYaPOTJzSoXRDvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

v3:
- Add various sanity checks to enforce correct register usage
  [Mark Rutland]

- Use %N instead of %M operand modifier to access odd register of a
  register pair in inline assemblies. Strictly speaking this is not
  correct, since %N is supposed to be used for DImode operands and %M for
  TImode operands. However both gcc and clang handle them identical, and
  there is an existing user of %N in the kernel since many years.
  Therefore use %N to get rid of the not yet released clang 24
  dependency. [Christian Borntraeger]

- Use la (load address) instruction with base and index register to
  generate a CPUs percpu variable address instead of agkr. la is
  available for all architecture levels. This removes the z196
  dependency as minimum architecture level. [Christian Borntraeger]

- Change coding style at some places, and fix various typos in commit
  messages and comments.

- Fix compile error caused by missing semicolon.

v2:
- Yet another brown paper bug: Re-add CPU migration check to last
  patch. Unconditionally recalculating and updating the percpu variable
  address and percpu offset register can corrupt previous context
  register state in several cases (not only the single case reported by
  Sashiko).

v1:
Most of this is only about cleaning up the percpu code after preemptible
this_cpu_*() operations have been implemented. The first ten patches are
all more or less trivial cleanup patches trying to make the code shorter
and more readable.

The only non-trivial patch is the last one, which converts s390's
this_cpu_*() operations to use a similar scheme like Mark Rutland
provided it for arm64 [1]. This allows to simplify the irq entry and exit
path, however at the cost of slightly worse code for this_cpu_*()
operations.

The simplified irq entry and exit code seems to be worth it. Usable
performance numbers are not available yet, however I don't expect big
difference to before.

[1] https://lore.kernel.org/all/20260904161758.376504-1-mark.rutland@arm.com/

Thanks,
Heiko

Heiko Carstens (11):
  s390/percpu: Fix comment typo
  s390/percpu: Add sanity check to GEN_MVIY macro
  s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
  s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
  s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
  s390/percpu: Rename inline assembly symbolic names
  s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
  s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
  s390/percpu: Use percpu code section for this_cpu_xchg()
  s390/percpu: Use percpu code section for this_cpu_cmpxchg()
  s390/percpu: Rework to simplify percpu_entry() and percpu_exit()

 arch/s390/include/asm/entry-percpu.h |  71 ++----
 arch/s390/include/asm/lowcore.h      |   5 +-
 arch/s390/include/asm/percpu.h       | 354 +++++++++++++++++----------
 arch/s390/kernel/irq.c               |  10 +-
 arch/s390/kernel/nmi.c               |   4 +-
 arch/s390/kernel/traps.c             |   4 +-
 6 files changed, 248 insertions(+), 200 deletions(-)

-- 
2.53.0

