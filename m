Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0C411F93;
	Wed,  2 Sep 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384257; cv=none; b=GQgntLMEd34zp6GBEF/sIGJJayfXc3Eav9QqZyhoczyiBm9Joo2LWIQ+YF1sufh4ZSU/fGK4ialTZGldEu7O9EaCOiLbWz2QIFsle1ozQbvEfdvTIgKk6/P1a0+ybyqGGsUQrz/l9QWRte+zKtCQDpY+FCskgOEXRf5cTCXbxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384257; c=relaxed/simple;
	bh=Aes1VozQrQ/3rC523a8mwSqYRV6p1DJz2SVKttm/2p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rq1mH+eWguB0FWG4ztvlvATbL1R0HKwFBFLBUlVr13qTaOHTMJ2Rsh10iD8CGkHhX8HLxg2S3lqZrm0PQmzLjURBBDuTbuKBNQ2GtCCcVCMxoxOH8/u0+zyUU6AJ0S3qyMLPBvSAx7d2+6rZUV+8cjaMGzhy10caa9upa4UFRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sz3HHQnQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sz3HHQnQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KW4mj1049324;
	Wed, 2 Sep 2026 21:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RaNJzAnxtmxJPnmPtPfMtc1+vgP3mJhHZlkRhYZIm
	U0=; b=sz3HHQnQJRFuWm/UQ66Iqv88Vij04WfJ14ODRxjKgkS7cRZjHZ/qUbAEm
	32MOzCRjnZIYkXpkvpKF99b8qBiocx7+Go2OUnz4+6eCFpgW6djK0YHuzTl2yabx
	kKm/NciHT3nEajCTZWu/0e8hii8IEtWz7UQ/bqXTH9Wo1yK26vCsXQoH8R+Qf0IH
	3MkM9D+h3fOtAfUOheBIkwcUNU68IawYG+RYxFYyEbBNB6Y/ZKL7dKArF+99O+t9
	/+QAx33N3ns0VH0BLRNiHvnxrMIusavsD5lxdCydlxIr+cBLlDu/ANChAWLbJ6ep
	wzONXDL0zvTy08H+hmMA6ZcOu2Xhw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq551mru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 21:24:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682LBOeU009275;
	Wed, 2 Sep 2026 21:24:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hmdwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 21:24:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682LO2wn50528580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 21:24:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF46520043;
	Wed,  2 Sep 2026 21:24:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 485B62004B;
	Wed,  2 Sep 2026 21:24:02 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.87.158.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 21:24:02 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 0/2] s390: Warn if kernel command line contains non-printable EBCDIC characters
Date: Wed,  2 Sep 2026 23:20:16 +0200
Message-ID: <20260902212400.674450-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX54ZZ7kO1RzSP
 NkxpMwLB3fJxG0UDsKpTM9BlSVO5Eyo+52X6zayQmnd6P/HBc0cXsiz3VbNB9Kfnj/63VUSy0Z4
 TK1lWZRH0A+7wC6iRPsqI2Tzn+n0KTkvhgmAoOMmKURANyqNVOMQ6g4yWtI1PDgtTKF0cQBtWrt
 sChYO2tRIdPTOy2uRB0qnbgpkS/RGrlSQjQibTHBXUoUGPi5BTKv3tEhVXsWt+l3wXN4r9pvW0E
 ZpA0SmkM5DJvvBrJcZa7qblXCAcRFznbK1MlB0uCGPpgl4tpGoegtyjzWATeLlKVg9vE5fiXKT3
 /SOnd+g6XH7YYzC9L/s8Mi/xtoIzOn16UgllQLLzFAEUbwLkPT31Q+OhkiDu0z3NGZI8ziF0mkz
 vdT0F4mGqNv4ln7ZSjZ/7Wzr3zTtOvi8z+LMUmCv6HQr6QBI/PtBbDdHuVQAGYXgY4WbpWRMgq3
 nBN3fvRnVUMeaLlxjtA==
X-Proofpoint-ORIG-GUID: xSy_sljBpCWE_75ZekpKSUv-hN7YLIIX
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9893f8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=I9JzLZ9WWtcXjXHc-4gA:9
X-Proofpoint-GUID: N5zxKbW1nM8uKIf8qGYbFU3MPBMWaLK2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfXxpdAUXdRr3VU
 aM8oeLRLITj3eAgvLcoEEnmvi5u7oJC1csTI9fO2epY14hq6rnsX0rdf89Pa9Tpp/tD3NeHpiWp
 tXAWr3Ml9VX0SIl0hxfjQjBC/7ILnLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020186

v3: https://lore.kernel.org/linux-s390/20260828140057.1728173-1-iii@linux.ibm.com/
v3 -> v4: Switch to ASCII subset of EBCDIC (Sashiko, Heiko).
          Add and use isspace_ebc_asc() to satisfy Heiko's comment
          about newlines in v1.

v2: https://lore.kernel.org/all/20260826150702.949956-1-iii@linux.ibm.com/
v2 -> v3: Check whether source EBCDIC characters are printable
          (David, Heiko).

v1: https://lore.kernel.org/all/20260825150840.537653-1-iii@linux.ibm.com/
v1 -> v2: Account for newlines (Heiko).
          Minor stylistic improvements: inline int i, bool return type,
          comment modality.

Hi,

This series adds a warning for unintentional EBCDIC -> ASCII kernel
command line translations. Patch 1 adds EBCDIC character classes.
Patch 2 uses them for determining whether the command line is
printable.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/ebcdic: Add character classes for the ASCII subset of EBCDIC
  s390: Warn if kernel command line contains non-printable EBCDIC
    characters

 arch/s390/boot/ipl_parm.c      | 13 ++++++++++-
 arch/s390/include/asm/ebcdic.h |  6 +++++
 arch/s390/kernel/ebcdic.c      | 40 +++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.55.0

