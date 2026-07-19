Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604A1DF27D;
	Sun, 19 Jul 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466017; cv=none; b=IF0knl1bz2XP5D7jGgbx9C9XeX0PgWDx9v+iCoNM0iH76Nyn2No0oi0CAfacmOEnUpaGrKekcDus2w/zkSyXUwyhlXGJsZrCNggajCD8RZrwjVWMwVCmUPhue/wWcYaRwATBbMiC7teyoRng+zOQcrJ/6sB54+hlob7YFs3EGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466017; c=relaxed/simple;
	bh=kt/IaOFVul557FqevKqMSkljaUYBNNzywr8px+IDhvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je7Wrc4iXQMNfGOlMRIZOi2mkXeCJfUreTdf0lKjhU6pihNUgOPCXaZPPxCcxL8IE+Z6unEK6nCSx+/WEiQnqznraO7NKBgtklDEwQWlty52UsTxu9lcL5k0XgDV3Mq3qFEOCg8wLvCEjKLjCYax367V/5+34yTKCkO3k5NgXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OEz0Ssav; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OEz0Ssav"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JCU6mq3506843;
	Sun, 19 Jul 2026 13:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t4ZnftpYbbLC2ucKQ
	zkh5yaupKRJNl/rZPqRGt4bVm0=; b=OEz0Ssavvf0eL0N3MNTkq84ajwuMINaaB
	mXwb77sOcEuwyjBySNuxcFj0nltjbzsQVZZ3wqh1T8pYlUzOd8yPJ+Znp5mPjnmz
	P5Fo2CjUwf8dzfHYxgjgRHacueumlC0tt2xNXHOm/rK8+gDdoLYdPTEpkyrEHao7
	Q7eQ+DuY/89tJQCJHsATOGYd9suo/+UG45Does0SxpcqdDo4f44YfUsRGo84CY+M
	sv8YEFCCgXB0AKsN8JTUdA0V//bvZdiEYTXm7BqGYg93beb983nuiDlYIx1Dchpm
	ZGr6VdS9A1b8KchCxIBPJQPfg6UadIq24wMqx8/xjDmXSq+cL7z3Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7aguc1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnm8B016589;
	Sun, 19 Jul 2026 13:00:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjhnbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD071F28770666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C15C620043;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 947FC2004D;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] s390/mm: Remove folio handling for kernel faults in do_secure_storage_access()
Date: Sun, 19 Jul 2026 15:00:05 +0200
Message-ID: <20260719130006.3882764-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130006.3882764-1-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HdzJ4nCBagG-a5Uk_vx2k7ou_2_r0wzc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX6lHvXA3mwblq
 BIATkCJdKnPKqRKedeeLl4OW+R1hF+BBHBz0hIJKa5S12Bk96WeOsozGOxR2UBBELj/ST8oBEdy
 eh5uzo0FdaCmucFFWbf5Qz6SZiFW9ZiBnaz88LWvdFn10Dg67SiuxjJqdsBWuP51JgF3KlYe7sE
 lnLzsJItjcOUZ95d495EjUCAVkPFEOKbk8O4ZioCOfAkLzXJ3fueHjYL99XsI2jqFAuy/PN0dp/
 OK86+EEFmMY7NnMLkaRqj9roqcEUp9c8FnKwhsBqY/1LBEc9P3VCiUpxwBpbOYWO2RovYhdYIo8
 Hr7fOCJD1kzTG4Ejiuy7VzOegAZ0NYXjhnHCs4VY5V8t1za/iASQojiqQi80tajFEsfrv2S8A+0
 zn/Ev6kZj85K6MT3wjhhcYnlPhqdin0Bx2870DN9tJxK73Ir178rm2WL7dat3TPnEW/E9b+Eq4Y
 qUYiaJDsJ39x2QJ1psw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX1cXHJsoyz+eI
 f6KuZEiHhTk+xdYrwEEPRYeLgfrSPtRnQlZ5dfdaeDZ1xH+S/mLliILdsByJnAw1Qp2qePDyvcA
 +jFCTu0D8QXYleSgCXli1TaHSf7IRTI=
X-Proofpoint-GUID: HdzJ4nCBagG-a5Uk_vx2k7ou_2_r0wzc
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5cca5c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3bIF1FMAx5P9TMvWi0MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

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

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index e650cdfa2523..776549d55c94 100644
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

