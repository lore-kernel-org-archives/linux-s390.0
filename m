Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F6320389;
	Mon, 18 Aug 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535165; cv=none; b=oiQfa2Cb/Z2GhhhG/hRPKhGGYz3Vq6ooFKsXu2uTQvm7vFoAA8PvaJOqwtnvG6wXlEE7Vf0sSgRHA6keanIRfN9t1R3ihoqyDQF64+FAPfi0RiuaLU1Va+askIe+P6p8mgNlMScfnvYHmhE1CeWZ5cEQCPW4OHD74yUtI82R3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535165; c=relaxed/simple;
	bh=nGQFFhDRet+QQmmyPgGcaVDyhxD1RP6/4jpxg1Zy7Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dClkLCY5u8IZTkDI0HWYE+QxdRYM8Sb3zqV4r2/AfJDrAdYNZt/5XLuSUhm3zfdnJxPwTqtIfAFG4vcZA8IvMMgZloLB/VxoI/RVrSisK8Udc3uOh80jHOAjF3gQI5xYH9WID4hVLWf5KcUARmJXQK81nsfU92i0UDIdbkguico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lxvmYFxk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lxvmYFxk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ICrWD7016582;
	Mon, 18 Aug 2025 16:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ygtR6f2nWYzlzt5fL
	2eFvz+eu0ybJnfHHIWv/65pn8g=; b=lxvmYFxkjkMpl0rAUj9QVpStKWwRvrUua
	I7oyLZ/lSfF+Swk06c8zB/oLQ+nF/J00/HZkarFwulLJ8+UlHEs6/FVplOXMdQrQ
	Zhgekoe2lI2k7cuVk5K0ww9kvF0MwPgpqLyQ1aU0jK1f4HcWr6twGDmhyR0/caC0
	8ng814A8K8Ss71XXnGg/RRSBfAWam0UY7VvORHxj4H7ONwCNYezzQkOMJlNO6ifU
	pqUjJ2tA7NnPvCqcHwxjOfSSSXaqY0J8R9wzB/wgzLmnVG27tD/VsWKKWFUFGow5
	4g+O0HYlzj9aUOH6BlxjqXM0ieIJMTA//j2ngSMdkSYZ4feAu1VHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrtd5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57IGamgX027674;
	Mon, 18 Aug 2025 16:39:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrtd5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IFRaAm002340;
	Mon, 18 Aug 2025 16:39:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k712xbum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57IGdDse31851050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 16:39:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CAFA20043;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D70D20040;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 43E9DE138C; Mon, 18 Aug 2025 18:39:13 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Daniel Axtens <dja@axtens.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] mm/kasan: avoid lazy MMU mode hazards
Date: Mon, 18 Aug 2025 18:39:13 +0200
Message-ID: <0d2efb7ddddbff6b288fbffeeb10166e90771718.1755528662.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755528662.git.agordeev@linux.ibm.com>
References: <cover.1755528662.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v-pPmVsfYB8aWZ696MiUmjnkn_I1mE_A
X-Proofpoint-GUID: qXQLAt8GvgBgB0va-hWWdqzwhhp2QqFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX4fbSHZEHXORf
 8ZQ7fcfOW8VZI4tcwzj02pawPeHcEa4Wsit6guhDP78kZB8b1PMUyieogeS7DMT9nqm1ojizMID
 5V1YD9jjlOYPmZEKG1rrjVj/OS5Hcbhpx1ZDSH4MdVaN2qucNtqzMsWsfIBC622IfAYyp2l6W2l
 L2Fr6YAvvxA1sKPXltEXgEPZpJ/uposFoosJb0bkYWF8JGsMQCncxUI3UhFheHAOn4zOjnY7TWQ
 PejEMNGmAdUAiq/rjauWG0onl1GLvmJRVwATw+luOlKL94OFJdrm2LFy+XXyK4QcZlDQCqnAzZs
 wHtElihoYSDX9vW602V+VHqu3Dj2/ndPM4kWyXT46UAUkLwNZsG7LvfjC2cpeY9QzfbRE6Dr4FF
 Pxd/mqd2
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a35734 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=0CqGaNLKB4nZpUE_F0UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001

Functions __kasan_populate_vmalloc() and __kasan_depopulate_vmalloc()
use apply_to_pte_range() function, which enters the lazy MMU mode. In
that mode updating PTEs may not be observed until the mode is left.

That may lead to a situation that otherwise correct reads and writes
to a PTE using ptep_get(), set_pte(), pte_clear() and other access
primitives bring wrong results when the vmalloc shadow memory is
being (de-)populated.

To avoid these hazards leave the lazy MMU mode before and re-enter it
after each PTE manipulation.

Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/kasan/shadow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 4d846d146d02..e2ceebf737ef 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -305,6 +305,8 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	pte_t pte;
 	int index;
 
+	arch_leave_lazy_mmu_mode();
+
 	index = PFN_DOWN(addr - data->start);
 	page = data->pages[index];
 	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
@@ -317,6 +319,8 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	}
 	spin_unlock(&init_mm.page_table_lock);
 
+	arch_enter_lazy_mmu_mode();
+
 	return 0;
 }
 
@@ -461,6 +465,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	pte_t pte;
 	int none;
 
+	arch_leave_lazy_mmu_mode();
+
 	spin_lock(&init_mm.page_table_lock);
 	pte = ptep_get(ptep);
 	none = pte_none(pte);
@@ -471,6 +477,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (likely(!none))
 		__free_page(pfn_to_page(pte_pfn(pte)));
 
+	arch_enter_lazy_mmu_mode();
+
 	return 0;
 }
 
-- 
2.48.1

