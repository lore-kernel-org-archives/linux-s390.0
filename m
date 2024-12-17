Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CC1F76BF;
	Tue, 17 Dec 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447340; cv=none; b=FVUugFMzw+7XhtAIa54HAzEMec6rbWsq7Zc7GaeIKXPsKfFswBLtxFVPZYrEV1JcPQukjFPyZF/2pxzQ5zAEwPfriU9M2dAYCbkIHwCrhPl2vBCQJg1knc1Du31MNae0HnnjY4G04A8Ccu1sXJ9QnyALJwz4GaqVxPhR+zVeej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447340; c=relaxed/simple;
	bh=DZPGLCtNSOyLqhOuehDqWwP4FJ4wG8X6ArCtEnT8q3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XaYwsN4HC4QVyiOvOeb9bP+q96JXEsAAcKG5/s0AAjkvhYNmdvdj4KK/FIaDh4g6Vvr/i0v3DW18Bv5qHNaDcV7196E81lsa3cZO1vOPpoGNDFZ25Gfky0LiWcpRugFj/WaeMFHXi+Mv5wIBVfeWyElNaDdavActKnTIg+Cj1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U0tPmYZh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U0tPmYZh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHE6Gsi020811;
	Tue, 17 Dec 2024 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=32wTygDdwBYAlFTBZycaIuXeyZSOIIiZG2ZaGNls/X8=; b=U0tPmYZh
	PVMUCHwrtag4pjvVK07s/ziAmZJga1R4pFe2WBgAB2sbDic2gHaAzj9LIISKTTXH
	E3xHKTU3H/+0G5XgUyD3UoJbQUf3zJ3zQtnQ130yYcLFY0S3kLLtoRgdo+dxBTbP
	t6a7RXjl1wS0l6qhJ13bgliPmZKVKDUg7MQ+hSaTgCBRSDfc+gkuitCsw+lNvoof
	WUF6HVV6JNwNA0DQKOqcSmYVi5EaAGytp5vWa8f6CCdX7iYq2AdqFA5gfnDb7z4m
	HDJA98N4djWow6S3bnGqxwbhQbt2xEZItEeWfCeHeQwiaHdQO2+MNCF5iSIDSRdg
	kourj2S911I0ig==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kas4r8hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:55:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHBw8lv024026;
	Tue, 17 Dec 2024 14:55:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukb4xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:55:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHEtW2S48562462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 14:55:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 397C32004F;
	Tue, 17 Dec 2024 14:55:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12BE22004D;
	Tue, 17 Dec 2024 14:55:32 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 14:55:32 +0000 (GMT)
Date: Tue, 17 Dec 2024 15:55:30 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.13-rc4
Message-ID: <Z2GQ4oCwZobLsNpp@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j408HSxV70waxB74PLldNLurh9qp0RBj
X-Proofpoint-GUID: j408HSxV70waxB74PLldNLurh9qp0RBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=975 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170115

Hi Linus,

please pull s390 fixes for 6.13-rc4.

Thanks,
Alexander

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-3

for you to fetch changes up to 282da38b465395c930687974627c24f47ddce5ff:

  s390/mm: Consider KMSAN modules metadata for paging levels (2024-12-15 23:35:09 +0100)

----------------------------------------------------------------
s390 fixes for 6.13-rc4

- Fix DirectMap accounting in /proc/meminfo file

- Fix strscpy() return code handling that led to "unsigned 'len' is
  never less than zero" warning

- Fix the calculation determining whether to use three- or four-level
  paging: account KMSAN modules metadata

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/ipl: Fix never less than zero warning

Heiko Carstens (1):
      s390/mm: Fix DirectMap accounting

Vasily Gorbik (1):
      s390/mm: Consider KMSAN modules metadata for paging levels

 arch/s390/boot/startup.c | 2 ++
 arch/s390/boot/vmem.c    | 6 +++---
 arch/s390/kernel/ipl.c   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index abe6e6c0ab98..6087d38c7235 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -234,6 +234,8 @@ static unsigned long get_vmem_size(unsigned long identity_size,
 	vsize = round_up(SZ_2G + max_mappable, rte_size) +
 		round_up(vmemmap_size, rte_size) +
 		FIXMAP_SIZE + MODULES_LEN + KASLR_LEN;
+	if (IS_ENABLED(CONFIG_KMSAN))
+		vsize += MODULES_LEN * 2;
 	return size_add(vsize, vmalloc_size);
 }
 
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 145035f84a0e..3fa28db2fe59 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -306,7 +306,7 @@ static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long e
 			pages++;
 		}
 	}
-	if (mode == POPULATE_DIRECT)
+	if (mode == POPULATE_IDENTITY)
 		update_page_count(PG_DIRECT_MAP_4K, pages);
 }
 
@@ -339,7 +339,7 @@ static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long e
 		}
 		pgtable_pte_populate(pmd, addr, next, mode);
 	}
-	if (mode == POPULATE_DIRECT)
+	if (mode == POPULATE_IDENTITY)
 		update_page_count(PG_DIRECT_MAP_1M, pages);
 }
 
@@ -372,7 +372,7 @@ static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long e
 		}
 		pgtable_pmd_populate(pud, addr, next, mode);
 	}
-	if (mode == POPULATE_DIRECT)
+	if (mode == POPULATE_IDENTITY)
 		update_page_count(PG_DIRECT_MAP_2G, pages);
 }
 
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index edbb52ce3f1e..7d12a1305fc9 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -270,7 +270,7 @@ static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
 	if (len >= sizeof(_value))					\
 		return -E2BIG;						\
 	len = strscpy(_value, buf, sizeof(_value));			\
-	if (len < 0)							\
+	if ((ssize_t)len < 0)						\
 		return len;						\
 	strim(_value);							\
 	return len;							\
