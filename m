Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013238;
	b=bPHjnK/LCg6uhTUdoenNAiSo8txbw+MrOMnhJ2GKYngSov/N5AijlS1yj9at/cDuGhAF
	 X9s7y+ahHm/n7DHFgl5RxkkIw6Pq66l98BGGz6NwBOKW6yvjXlM6/f8qg4ncN1Op/6h3Y
	 PR3axvzZc1Ut+KY/XVoVSQJ0zOnjNejxfouKH0MTant+t0GkUzfbq+9TKxrXCkYR4gYBb
	 uWKTIZhI2yTmlN7I0lDhA0YPLhdoFoXMcBGNCXk54vM+tSRkx/a9phpUh/mu/9PoVREpV
	 FzP6mzWiUxhAyi455jhYPhYUO15qcVlKUal9PSleN+LcIMk+0fOQPy4BA/l3JlYGa/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013238;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v9nbg6m+9efy/te3y+DaI2YCbZLSLlWcfv+mYgHg51c=;
	b=Qyw+izc06IQikCujddrFjhkdFhuj5Ug5ix5f7/Dd/vC8/HqZpahBBcSoufsvyoLOpl1M
	 XgojbUGSsjIhtdvm92T5BBo5cbQOW0t2XDFG9A6u6wXYrrgP60bY0Ajg0FUIzSitNskx+
	 fAUlcp+cVVF1LSzN9oynB3r+KxC46EtQh9hE2czleEz7MGQLOKydoqhkXUDKbbNxT0hDk
	 BXwXVFLvqmblmPYJFOpwt/Iv5/A1uirp/4UxQpa5qWS6XqzwSDWKvdKGF1T/6oi3yRanZ
	 W3NOlXHBAyhzMohV+l2ry2CM05yVvYjXufSZUazmYP/o++1v/uuuWh/+UhaLs7aqnDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AueW+azl;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593D606A325;
	Wed, 18 Nov 2026 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9593D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AueW+azl
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQXoK1373932;
	Wed, 18 Nov 2026 14:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=v9nbg6m+9efy/te3y+DaI2YCbZLSLlWcfv+mYgHg5
	1c=; b=AueW+azlEkjoZr3tFUQ2uOAIvRMbLermEhDgYyQb0Qd3H2xTUW1ru09kb
	VA4L02Qxl+bpEckKXk4uGqH2kNQoo+mGJ9iTPkBSbscanmVtVwTMu8RfpTM/krb4
	NFlCJaqxJUuAuBoHBP0gyUqE/2bCkdqhfMy26oeoJ/YqqPV3QHRyA+Hjd9XTo0Wt
	Z/u3c/xFmEjcrbfNQMtFL0DJXOVrYvIFABVtbm++hvtqwXk8X9r1vb1O4UKxmtmw
	az0PdEkhVbMkwKTJ3HVV7GdEjzqAMYcy7e47xJ3lmFANSdGJ8br7A6T7D93f6+Ke
	kTeTV3l6T/hpCFBrim1nXHP3kDXwA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nax6c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYus13470661;
	Wed, 18 Nov 2026 14:47:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt8swa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElAPL42926444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2546E20049;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0310120040;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:09 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/8] s390: Add __must_check to set_memory() primitives
Date: Wed, 18 Nov 2026 15:47:01 +0100
Message-ID: <20261118144709.202520-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfXxTVIxN89Af81
 toz8dF/qsrO85dyHqkO+jxkM9JLM3wlLT5vIkEeQcwEHAyim5GtvGZi/jUz7GQYu2qndWg6MQxw
 tPT3QEN3Irinbbe7UjG/d2szxP4GE5/cSkeeRSkSjR6v7hqsQc52vS8owPjrWklkhqxXM5TOLNQ
 vx00rKSSvAp+SvGdTCKptn26AhxPUleGXcq9vZ95N/8TVWAWVBjSdUIqNAWSPIkQPGHQjLffC8D
 yZ0c5IkAWhUZp1zCyLh7QMkF2hXDlZiQbr2Mso0CrzJYMiefL0KJ/lFkcsfgsmG+QCkdcJzCjH6
 L3e7Kh25T1Zbtx9YsKbszwm8ovC/v7tnpyWY7v72deljpZgJ/mkonSbtNBdizJrk7e6HUyooORo
 meUoQ8j3MiwFmDld5Alis1Cg/jdv+YXw4wo8marEvu14VO+pJn1E48O/z9mmCoBBW3zfNLOPvqA
 Hmkp8xEhAYvLT9zEYKg==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afdba73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=QAXv03ECi1vvrnh8ZzYA:9
X-Proofpoint-GUID: U-iT1ikapygm237stZoS8hf8jpvbn_wH
X-Proofpoint-ORIG-GUID: U-iT1ikapygm237stZoS8hf8jpvbn_wH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfXwBfcPr1R7jDp
 HR0rQ+Nd7mPoGoekey0A2HuGtWidybdYf793teyXt1kJWSrs78BcMiEIs2HDPO4yT7HPiBAX++Y
 f1MjPDSyQXyf3x4ks6nKBOL4ZGa/CN0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057

A small series which adds missing return value checks of set_memory()
calls to s390 specific call sites. Also add __must_check to set_memory()
primitives in order to avoid that new unchecked callers will be added.

This is basically the same what was done for powerpc with [1].

Note that this (trivially) conflicts with [2]. Furthermore the kexec code
is the only call site which for now only prints an error message instead
of really handling the error, since error handling in common code is
missing. That needs to be added with later changes.

While doing this conversion I realized that s390's execmem support also
can be improved. Will happen with a follow-on series.

[1] 2abbd6d5fbe0 ("powerpc: Add __must_check to set_memory_...()")
[2] https://lore.kernel.org/all/20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org/

Thanks,
Heiko

Heiko Carstens (8):
  s390/kfence: Add error handling to arch_kfence_init_pool()
  s390/kprobes: Add error handling to alloc_insn_page()
  s390/kexec: Let crash_protect_pages() warn in case of an error
  s390/module: Add error handling to module_alloc_ftrace_hotpatch_trampolines()
  s390/mm: Add error handling to arch_setup_zero_pages()
  s390/mm: Add error handling to mark_rodata_ro()
  s390/mm: Add error handling to vmem_map_init()
  s390/set_memory: Add __must_check to set_memory() primitives

 arch/s390/include/asm/kfence.h     |  3 ++-
 arch/s390/include/asm/set_memory.h |  4 ++--
 arch/s390/kernel/kprobes.c         |  5 ++++-
 arch/s390/kernel/machine_kexec.c   |  7 +++++--
 arch/s390/kernel/module.c          |  7 ++++++-
 arch/s390/mm/init.c                | 10 ++++++++--
 arch/s390/mm/vmem.c                | 14 +++++++++-----
 7 files changed, 36 insertions(+), 14 deletions(-)

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.56.1
