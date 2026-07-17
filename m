Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B93B71C8;
	Fri, 17 Jul 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280267; cv=none; b=NdcieEU2AJq7dmBal8SyRG+0yosmrkTbNhiZWMtgYZ6oHH3jgS1rXfS6oAFuxsFiuq1iArvLWTd9vJt2YbCKnul9ai0wzvJBH25xfRN+fCgO8No17djxxEct6Bb5zqjcgN66sDgQMnAWXK02UkgKrnKOeH7oskdlCixH94TtupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280267; c=relaxed/simple;
	bh=lFLNwb4AexnbST9BbaA7u71FO7cg14kSZVtVEI6sLr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMdXRN1sr0+YptvDS8epUkZ6cjvmxb17cQgWEkV0qW30RINihf5Vboe83DezqUZLMqt1/6qgjdeRjYiz93rKIDZhRXSMk0rFp24EWPNnzs+jBWOODl0ajiwQ2Z1/Tfakvr52OT+WLfHQuXBxaMbk2POohSR/CkYH/A7o6uMWFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QubbcDcb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QubbcDcb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6fgh71291765;
	Fri, 17 Jul 2026 09:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iZNloRZKPykXrh0JGiQLXoEVUwrmMHvsiQFMeZqMH
	wQ=; b=QubbcDcbW1NVIHogga0O2oTpGtZn3plessI5L8VKbyL8403kCe7j+5vRH
	66qVpZrrtrJn+9zKW5LqN3ZaiKK/eaV1SroQ6mHRIIhbh7jSyuIWKEggGeFLryxE
	1bES0duLvG5Mu/gfVm1Fzfm5nX/jAOcQwGwq6Ll7lIUmfqP4nM2YR+XWUGHvYSBw
	pxpGITuivVZFXwCjMqpbzXuAHb9M3sG3DmfvDD3/PZxfTpO6LQ23tsjwacZ9wVzp
	EnkhrOAepSaeRPewvkHD3mMAufCYpbsGphQS2pQVgRk3a5+5yiBr4hy5iLg1wFYC
	MpwLfrKrUdJVlHYr/efRCvoT9ityA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxwpvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H9Jj4c010196;
	Fri, 17 Jul 2026 09:24:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwh5b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H9OGsf50528572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:24:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2780D2004E;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E2E2004B;
	Fri, 17 Jul 2026 09:24:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:24:15 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] s390: Reintroduce support for DCACHE_WORD_ACCESS
Date: Fri, 17 Jul 2026 11:24:11 +0200
Message-ID: <20260717092415.3039699-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3WtQ_0wCtl0ckVQqCpxV3F_bcnV3YvLv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX89UYidydxB+E
 mVhWFsk1D0/kmQBGKILaPYoAK7yMTwtgLZXEo3gELmiZ6+yLo8tynon5Xig8Ys9ucTnZ89kouAC
 3qdtfsBa44CJ6p4UaAZgna3nkn++dT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfXyfEGV57gKemC
 MJfmzx/NqATuEo1xZAspfDC8eWUxggY3CYpJOQWBXLHC5wO8ithS1GmTnWoWlo+QbTmV/ysTGcs
 TtSIofmbWFB9TYu+qt1y2toSxW3ZngD6GZq8G0plBuAaUo/s+jKz1g5VyP14DYrpSZASQjHObV7
 bQ3HQ5fHMRe3rq5sqRqfpvN+0Qv/8O38kf2rlcewSTZ3L4Csat5oBe7SvU2KVcUM/71tIWRDerJ
 kUfwYe9x2P+H1AkxwONzLPmSA9v53teZ5fMgiCkNfNj86NnxTrzod3I+qUeo1ccCTjuMdTFPGNb
 +pe9BnET1vg1Ela2i6meS9mHMR6YnztWDQtzS6QAeKe+MnMT52T6n3uDsN6vd/139qCxPlM8iZu
 gmcUHhAVcYCibB8QUJCbOXA9b72IyoCHZDsT+Z/61ZKBSy7wpjotM6pNFj76VLRXUC7VZW5g7NO
 bwwjQ5Ss3S0QgVEqfMA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a59f4c5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=01MaQ8ttZPKmpqd4eLYA:9
X-Proofpoint-ORIG-GUID: 3WtQ_0wCtl0ckVQqCpxV3F_bcnV3YvLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170091

v2:
- Explicitely PAGE_ALIGN size in uv_alloc_stor_var() [Sashiko]
- Document that lazy PTE update / TLB flushing is intended [Sashiko]

v1:
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
 arch/s390/include/asm/word-at-a-time.h | 22 +++++++++
 arch/s390/kernel/uv.c                  | 65 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c                     |  6 +--
 arch/s390/mm/extable.c                 | 18 +++++++
 arch/s390/mm/fault.c                   | 10 ++--
 8 files changed, 118 insertions(+), 10 deletions(-)

-- 
2.53.0

