Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7EC2FF656;
	Thu,  4 Dec 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866086; cv=none; b=k4CawPDayElefeNYrj8mfu7XBVwP0DdOSv/dQ86ZlyBs0ijsJYAKoo86KRoRhKH/nJp+P6ESqUYabBdMlYT5UqxazgsS4/vB62vwCLJP6sJ9acfCUnCCcauJptka+MpaUvotIaiQjbZvnznUGdypP0BM4nQTElKvo0DocY2erZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866086; c=relaxed/simple;
	bh=wdhhsSsOYeMJOEu2FK6u+XS9XsDi/mI32FKzZYQrYlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eG0tcIYsiLqzxpUF1pPSMF/KEDi//J+Igc07Mpd3ad5CBmKI1mE5/uTwsfd74oB/PP6LuG2XjZGm005JmE5ng6BWjKlyh5Xtq1YnvvUvvMQyQ76paUIit2b0IrXWK5KQ6TzzccGfMOZ6We4DM6+MwwOMzHWpVlno8sDbEJpjxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ks5Vyp7i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ks5Vyp7i"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4E4GBM016366;
	Thu, 4 Dec 2025 16:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+ZcbYV1GUZnWuiiw6bY3ypi76qKiv6NQaK4z7bV80
	ZI=; b=Ks5Vyp7iehWcw/hnuDXQw+w2KpuK53+RpJukdkNcrxmvv3hhzNM8d6B3e
	JlHNQT7p6BOedqAWBX3mUcnFhb6QcapIFDb2wBFZ7+2lB7hWyT+tFrRzg+59crws
	U8qBzg4vszdR7iP6pWofR2ow+CXRznoJSYPm1ds6ppnJRlrwXP9relKe8OMjb3qZ
	w1n9v0MB4KtupzhblB+4YNEKMbHC7lddqcIDnMap49Fh5y1WdHA1grDiEJsr68is
	pZzIoCLMqhQfcD6z0Ln3WP+Zqf9OtkG8TK5BzIoENlI6BKgrmRUSq/U+tXS0s8xp
	Vy//bw+d4wVjs5XCm9RAUFwkHk89g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja1e3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4EgpYo024111;
	Thu, 4 Dec 2025 16:34:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5srxvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4GYXIf47448488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 16:34:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7251F20043;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4285D20040;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/3] scripts/gdb: Improve s390 support
Date: Thu,  4 Dec 2025 17:34:22 +0100
Message-ID: <20251204163425.370783-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4EgzNVa8dbLVQIyJCms-N2bZQVMQwfzh
X-Proofpoint-ORIG-GUID: 4EgzNVa8dbLVQIyJCms-N2bZQVMQwfzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX3saL1YHK7TTQ
 ZUggw9hYLl5nFysAUM2QEJknFVE5vObIRO3t/Ol2RgqBIYc/1YO5q4CbQdoihKFmBAf6r7hlMeM
 n/wPoZORd25TKY7pMihUK8NOgXrO/fMiLo1SIiVkypFzYMVmEYTloQLEVRfyOCcu1WT7yBePQWI
 qMmef0PgqxmEgGE+3zwNtXsW8z/oo3WiOwxWtlzrczmBJpWkTOnQG0/EiTt+ewmlnRcJt8gVOli
 OoUhSsTXUeJBp1ef1cLjzhx0EfNOYdaWGr5DuJSGvkpmBp/sliCWMj/GvDw8DSYRmVcf/mqUak1
 /quHt8pClJsnBRUSjNZsZF/VSVXrStmYP9sdmToKrmVQTq8awC2hr0yIoAEX7Hte8B0LZzRvWtQ
 P/s6EIe74fCbe/2cLfwYP5ENkLNNJw==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=6931b81e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=5JnHKwHQ_0YZkFCFDA4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

Patch 1 adds $lx_current([CPU]) support for s390 to obtain the task of
the active context or a specific CPU.

Patch 2 adds a $lx_lowcore([CPU]) convenience function on s390 to obtain
the s390 lowcore of the active context of a specific CPU.  It is based
on functionality introduced by patch 1.

Patch 3 adds a $lx_cpu() convenience function to obtain the CPU number
of the active context.

Regards,
Jens

Jens Remus (3):
  scripts/gdb: add lx_current support for s390
  scripts/gdb: add lx_lowcore convenience function on s390
  scripts/gdb: add lx_cpu convenience function

 scripts/gdb/linux/constants.py.in | 14 +++++++
 scripts/gdb/linux/cpus.py         | 67 ++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.51.0

