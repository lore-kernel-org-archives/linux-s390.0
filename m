Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C13B71CA;
	Fri, 17 Jul 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280268; cv=none; b=ESO4YFvy2atnRF3I9mQwNLaS27HuUjm4zpQHzTZMfJ7Ps8gqPuvRljb2p/COX/vmjGYFtAu0iPR/22renyCJRmz8t7V2+a/iNztm3+YH9Jze/e8V+xosQLv/PQbSsfBQun4/7n6DByP55Ki9fk25eR/mmpNmQB2cbmQo+02WfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280268; c=relaxed/simple;
	bh=nCBnP0pOnJQlo6E6BFjw7Gts6aQqIaZ/ZGXDg8wrSMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIRI2hdLsMF5w47V71qSdVnTH2TBn8TuKY0PmTfcf70J5nV5vEMGbVfn4/SshJOaR9N8LoCPQ0LTyI2B+l+6vAJBR8TTDiiZNJ49u0irReujeM3tDN1G/bSMj4s3NtkoJ4Jdpf9B2W4BRh6tegiP1HD9eXBSxM6nWUwj8Dz0mz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1eBoxr1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1eBoxr1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6fsod1278635;
	Fri, 17 Jul 2026 09:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nxFeAPIZEhenzqh1F
	UCHdB2mNGb6NeQE4O3cleETzqU=; b=h1eBoxr1g/PBuiMIFILwtZWApcU4ZC9+n
	wbwi5NUIAP8nDrcDZClWLdiGLTxm3aeloN5X4WfugK22LBIGG2Q+wbIQXkAH+7AF
	TETZGfUmtO98Qeifv8MXrz1p7U0oAaXZ4vZDXop0gvvBVfIYgUeuC5fCVvB1dT5o
	4YnfHIfuTSqIc5M71dZ0Q1EakObh8gY3N9Nn+gufMTSpzcgjeP/JoNr4y3QJXgP4
	EU6/A+B/x2g0bQbXAf+Ft/nQEtD2D9GVP1JWWy8PAwbydP5TzB6JxpmLxcl7sEs0
	Z/cHRB7btUdpNTVXVerNn7tbSRiLLRUeY703T1X9O40Vv18RbkiJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc4qjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H9JgbF026627;
	Fri, 17 Jul 2026 09:24:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uygqxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H9OGrP28311854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:24:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5FA52004E;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC412005A;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] s390/mm: Remove folio handling for secure storage access exceptions
Date: Fri, 17 Jul 2026 11:24:14 +0200
Message-ID: <20260717092415.3039699-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717092415.3039699-1-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a59f4c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3bIF1FMAx5P9TMvWi0MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX2M9BqecEAyPC
 iYeGfzB9XSSzk4Kj3zFGPd5FGd4xB03QcK/a1EKjCdlzDcCl0TuMAv2FOlMEW2Z3avOI+38zFlr
 s1KoSCD5fEr0shfQBAiBU6NDsAAUgtLBf1Gv6uTzWj2q1j54HV2DUiWyTUCI//5J8wVCqNd9HVj
 6qx7yoyKfQaX25T0Grjk29DcXW/F2betAJK30onITHGBl1oanQNl+O4b8wk9GtVgt5cH8VMGUdr
 7nzTnSPBK4LcA3MCyTj9x0a9HaVC4+QSWkzqJ4DP+7uiz7HcuzX6PoyIFibXlmQYNCf/XbbgDYz
 xTYMekagXwNx1qtzsGanM33O2cXHcj6gyCaXu1W0QdfLyVtCX0TiBogY5AaLSuKEMI5DnQpjHUv
 JbClXKIgo4Zf/1KXsnTE3JupuRcGlMei3KubpMWa21SvlSyNj00JbHmA9dQ1qnay8Vi/v9Qsh3+
 mRdgx9x0JRG16sR+uvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX4o8D/OOdhJUs
 TD6H3NU5aCnWO94RdO9zS/kYG6EkZW5sIq2q9PSA+8k8nvjp7yrsCYOqgYEP/dwzAeXmutx91XW
 Th0rULWxspkTbHEbbNGrX0q7PoosNuk=
X-Proofpoint-GUID: g6C1jmzNJQSjpZFR5xXnJNpDYYkyky7H
X-Proofpoint-ORIG-GUID: g6C1jmzNJQSjpZFR5xXnJNpDYYkyky7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170091

Remove folio handling for secure storage access exceptions that happen
via the kernel mapping. Using folio_try_get() for exceptions via the
kernel mapping is racy: for example such an exception may happen on one
CPU, while a different CPU frees the corresponding page. Subsequently the
page can be part of a folio of different size, before the faulting CPU
executes folio_try_get(). This may lead to data corruption.

As of now this scenario does not seem to be possible, however with the
upcoming load_unaligned_zeropad() this is possible.

As a side effect PG_arch_1 is not cleared anymore for such faults via the
kernel mapping. However given that this bit is over-indicating it
shouldn't matter.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 392e46742039..db77c8c0023e 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -440,13 +440,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 	if (is_kernel_fault(regs)) {
 		if (is_vmalloc_addr((void *)addr))
 			return handle_fault_error_nolock(regs, 0);
-		folio = virt_to_folio((void *)addr);
-		if (unlikely(!folio_try_get(folio)))
-			return;
-		rc = uv_convert_from_secure(folio_to_phys(folio));
-		if (!rc)
-			clear_bit(PG_arch_1, &folio->flags.f);
-		folio_put(folio);
+		rc = uv_convert_from_secure(__pa(addr));
 		/*
 		 * There are some valid fixup types for kernel
 		 * accesses to donated secure memory. zeropad is one
-- 
2.53.0

