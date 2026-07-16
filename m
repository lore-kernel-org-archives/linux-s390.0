Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C328505E;
	Thu, 16 Jul 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211285; cv=none; b=VXEFV4XJZypaWN8s4iG8rlHkLlgxapdHHy7SsL7qR2D0bpDV/SthPNCSFlfqZ9QBXnyK3qi4Ria7MNaftaxpWQLYm9sPEz4OBowoML8eE0jExnY8rBS7YgoQSvnBF/DmFgGCyk9wY8imQXnJAL0FAjzXfeDNAo9m61yqiBRogHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211285; c=relaxed/simple;
	bh=DDjONqUKh1hp2G21MPk/CiB7qLlj029twdZW8XQQ7WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJ0RB3Hcdtd+2/b3TIB2AMzxV782CMwZQRAo0PaSMGICV/lBoZmw5+HDjgH1Uq3XlPtlSdnKH/arGneerH+sPXUEiHWYXVQ2BxxMb/IkCw7PMIx/BWgYdVdJReqYKobxz2GKwVX9IJ0HHsyDclqKr8I4lbg2T+PDHeQ//iIwNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NwouuUZv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NwouuUZv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfbJV1469470;
	Thu, 16 Jul 2026 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6TL1hTjtqeybxqz72lzEpwWLgTsvlQZPmLkgyL9yX
	QU=; b=NwouuUZv0rf5gW/Ib0ljGGT1UyeZjAVkr+Q8CofhAtQpHud/5RDqZXlnp
	Eh6+tYzkxjBMbsoyihuanwr6RwXgDZt58XoIq0Y22iCXVE6jK8X5J97ZDdefrrzb
	oqjOzmtZOnOSHOwMaLrgRIMGoWdzwEBaXAb2pndkcBHPxdKyUScdyl+jpByGJ4xV
	RV9Kb3ppFH3n5rdPA2dFqoxe/49aJocATBVNu42mDNNhOQvfPB+LC7q+lw3Y3Yin
	9OCMK4qQ3ZhW5oYnNsZma/xrhbSZp7ryXaZUdhjV/kwo7sWG8c2SvIuMZBZ6h7Ok
	6P/2dM2+GqeG6FtLF4tht6ZbqW/PA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33hss7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GE4YRA023646;
	Thu, 16 Jul 2026 14:14:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyd1hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GEEbRY32047540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 14:14:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD8F2004B;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C6720043;
	Thu, 16 Jul 2026 14:14:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 14:14:36 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] s390: Reintroduce support for DCACHE_WORD_ACCESS
Date: Thu, 16 Jul 2026 16:14:32 +0200
Message-ID: <20260716141436.2125703-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX5p6vGFNito04
 CzyUZ9buJKdVqdacC1zaeRBctFjat9LS4lbH4TA21B/CKzIGN9ZyXwYzw28rvOxlUL7ntxocMKO
 2xhDD4sqIFfX5D2tIY0X8/jYCDAq10g=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58e751 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=s88hA1X5yvA2iI4I3ysA:9
X-Proofpoint-GUID: TEIPo7He5tazw0HlIdL3ammqhHIsLvtc
X-Proofpoint-ORIG-GUID: TEIPo7He5tazw0HlIdL3ammqhHIsLvtc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfXxxdejVX4Ekv/
 dvSVmUFPmpYt6HtaFN72/LQ3PZS43wZZCen/+EvpD3PYvmjL3CD0lf/Tgr2s9uLeJ7nanG8ylIC
 zx2LLHl0eWAFDt1i8rEoGjy7NkQrSIsU1OuXnIGR0laAh4tOsqBNtkzsPueqQ9i+0WH1HMeSODn
 nu2woGuUKJTCnnsQCUUN6bUyp+6YKXY/+Ao64e4p4Sps5PRU12h+g1gvUVH4cGnX4xR2+1ZmFHB
 XmT3LXYQy6htc4uT8BGLGaLJlRwAf+ARWLEVbpyhthX0/MO9cLq0urt2m6J8+Xd0/GP40hlqBH9
 xX1rYoc3xKrEZfqRk0rIYDr9X/wnVHSt16VjJS88dR7T9KR+NXshsVGS6D5Ne9yXjgr/Pe3jnaP
 uUXIB7iGvD+6ylosaSBMmkW12JM1107TTyBiH330/rQskW3msN/GD0C/p6klXRAaR4IznAZr+d6
 GYgV8I/miF+6/OB99kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146

Support for DCACHE_WORD_ACCESS was recently removed [1] since it caused
problems with the incomplete handling of secure storage access
exceptions. It looked like fixing the exception handler would be a larger
effort; therefore support for DCACHE_WORD_ACCESS was removed as a work
around.

Address the potential problems that exist with secure storage access
exceptions and add support for DCACHE_WORD_ACCESS again.

In particular address the following problems:

- Reading the guest variable storage area via the /proc/kcore interface
  results in short reads. Address this by using a VM_SPARSE area for the
  guest variable storage area. VM_SPARSE areas will be handled like
  memory holes (zeros will be read).

- Fix handling of secure storage access exceptions in vmalloc area.

- Remove folio handling for secure storage access exceptions to avoid
  potential data corruption.

[1] 37540b8c287f ("s390: Revert support for DCACHE_WORD_ACCESS")

Heiko Carstens (4):
  KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
  s390/mm: Fix handling of secure storage access exceptions in vmalloc area
  s390/mm: Remove folio handling for secure storage access exceptions
  s390: Add support for DCACHE_WORD_ACCESS (again)

 arch/s390/Kconfig                      |  1 +
 arch/s390/include/asm/asm-extable.h    |  4 ++
 arch/s390/include/asm/uv.h             |  2 +
 arch/s390/include/asm/word-at-a-time.h | 22 ++++++++++
 arch/s390/kernel/uv.c                  | 59 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c                     |  6 +--
 arch/s390/mm/extable.c                 | 18 ++++++++
 arch/s390/mm/fault.c                   | 10 ++---
 8 files changed, 112 insertions(+), 10 deletions(-)

-- 
2.53.0

