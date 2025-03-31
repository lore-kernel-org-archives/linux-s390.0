Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06F1A7046
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417313; cv=none; b=sQlqWMo2t88HPZ/kz+gO/yIFCggIReD0ltJFYX/Xm1Iz13JDZ1BYrGDLXo3mLmNGa7mvot5OkP7qTQTHLV8yCHzoMXEOvXuuWW9ms/s0CbueGHoRJ5eQRmb0CCr872BXpSzWVfgVDFtAhpu2fhtUv8J/JbFtmi2xHE3AcjZEvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417313; c=relaxed/simple;
	bh=CeyvOAzruVbWWm7D3hfFXlUd6ycBvMJ7TKO2pVgCa1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u94SxhVxd0DhPxOAkwUvF2MdbjCKORlWZf7MJQ+mgAckltGL92+B3jf/0b/pO4GLz438gAOgNa3/ZzKwn7NvwAPrtUXojBKlyC80+n3vDMq5q3pvaDg6ZqWxBWNfQFSe0Xk/6VU4/gM+jVyR7dAr0nQ8W7QiYkWd6V3mbzX4Gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QuMwIXOQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QuMwIXOQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V3nMUO026727
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GSk/LwPr2pmO2X+P4j/f9IP8deJBgOyD71vA3tZYf
	tk=; b=QuMwIXOQpxYrBjAUjWL49C1QKNoBV4DSarhyBp+aJuyr0I77UJESkRLZV
	vvp18zDDXnR86yuCiSOkkVXCJ9h9bmclii8prLPq4aZyAKaMDYF0pAwclir9uxUi
	72UnR8jQnyNEyONit3h83ofP5j/ZGSpIjYwUpjZdDJVSyH8XXkH2UYsMTYKZH1B/
	AlgK//vGpkNKSRWiui2O/dOPmk4hi/bImjvyR3RxVBQe/bcX+Z537FU8scjDAlRD
	vsGogcpYL1B4P3pVztyzrqZ2yNGKq15h5cb2g/DAEJ1sCWFR4gPAUf1phMMuP/lz
	U/hE7vo6xOApQj8rdI81pa3cMd8vg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qke9hfcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V5ce17014555
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpkwb1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VAZ5Wt33358438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:35:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF9320043;
	Mon, 31 Mar 2025 10:35:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D70F20040;
	Mon, 31 Mar 2025 10:35:05 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.47.161])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 10:35:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] Remove the need to alloc memory in uv.c
Date: Mon, 31 Mar 2025 12:35:04 +0200
Message-ID: <20250331103505.15210-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e65PiM2qsHPzvWmIeZEySG-1SCKl0vJG
X-Proofpoint-ORIG-GUID: e65PiM2qsHPzvWmIeZEySG-1SCKl0vJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310074

The pkey uv handler may be called in a do-not-allocate memory
situation. For example when an encrypted swap file is used and the
encryption is done via UV retrievable secrets with protected keys.

The pkey uv handler calls uv_get_secret_metadata() and thus has a need
to have this function work without memory allocations. So this patch
extends the uv_get_secret_metadata() function to be able to work on
a provided working page instead of allocating/freeing memory via
kmalloc/kfree:

int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
			   struct uv_secret_list_item_hdr *secret,
			   u8 *workpage);

Parameter workpage is a ephemeral working page used by the function.
If given (!= NULL), it needs to point to memory of at least PAGE_SIZE
bytes. If NULL, the function uses kmalloc/kfree to allocate and free a
working buffer.

Changelog:
v1: Pre-allocated one page during init of the uv.c code.
v2: As a result of feedback from Heiko about the v1 implementation and
    with another idea of how to deal with a do-not-allocate situation
    in uv.c now another approach: The caller may give a ptr to an
    ephemeral working page if no memory may be allocated.
    Note this patch does not compile as pkey_uv.c needs to get
    adapted to this changed uv function. However, patch is good as a
    starting point for code review and discussions.
    
Harald Freudenberger (1):
  s390/uv: New param workpage for the uv_get_secret_metadata() function

 arch/s390/include/asm/uv.h |  3 ++-
 arch/s390/kernel/uv.c      | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

--
2.43.0

