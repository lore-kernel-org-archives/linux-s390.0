Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB63375AE;
	Mon, 18 Aug 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535165; cv=none; b=TPPg2U1twa+iFOQ0K3jacrRgJzJvB4oqRsII6quvK2zbBobnFGEa/05dCG7kgFP0kAxmcHAZg9CrgTH6bDLagdrudN4R7aWt3pjXML73Jaa7DfsZXqfHnEUS2H0ymo9GMxqyKOU4W/IKHbdeHoED41A1Dxjgm3wXn3pnHa0229Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535165; c=relaxed/simple;
	bh=mpfB1u87sCpir7koQbctGn4/9Gel2hPfHl9gL8o2MHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghp+TmEsLbyonmvDs8mHQ1FiMDBlB81my6fjj+warAPpWGx/Z4C06Vb4XspqFB/0OpCBMvaPke30tc6KGTSffIVa7UmzCyrxttk4lXg2jZVEL4n9YvAVrtn5HdAvLizRr3KvDvA1lSrjIWqoBV204/AKiF9z4zvVjKOOhwcUSZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rCfYREu5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rCfYREu5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBDGFK004808;
	Mon, 18 Aug 2025 16:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X5mWAYTt3pdVk9QL7
	e2JJSoH8wb3/z8g6wJ8lfORUIs=; b=rCfYREu5Qq7MyOvBAdmXJ4midpTCBCcpY
	uVocB52FLUGPQHSCf68w/TMDltUEYSAiI/9tesBImZv05t4LFwEi3dc4ZLHtW74K
	mYyTYg0KFB3gqraR9Gu2hGq7r3jblqAwEU8bvqlgscTGZ/FbGpeCUFIDEswI1DVl
	sNjbupnMZVrXPfNBz89jSRB+AuTl3ugdFT0Iyeiz94P0W8xI9U6wnpqsOfKPSf9p
	QiO7rDiPa1HKXnl6dQAXUhXjnxgNWcraEo+iUebLXn/VTgGzIKM+aRLro1/Gub3Q
	cUurFu38xJLlu4HELRvzKKdGDTrMiBCCv6BSqxCxVvMg5gSX8ff6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3t382-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57IGdGXI014615;
	Mon, 18 Aug 2025 16:39:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3t37y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDjfwK001479;
	Mon, 18 Aug 2025 16:39:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k4q0pry3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57IGdDWN59638234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 16:39:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A5E720043;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B30420040;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 41F13E0380; Mon, 18 Aug 2025 18:39:13 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Daniel Axtens <dja@axtens.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] mm/kasan: fix vmalloc shadow memory (de-)population races
Date: Mon, 18 Aug 2025 18:39:12 +0200
Message-ID: <adb258634194593db294c0d1fb35646e894d6ead.1755528662.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: J4hpVGuQdfh190mNZ9y0Gf73Cqn-Cb1F
X-Authority-Analysis: v=2.4 cv=L6wdQ/T8 c=1 sm=1 tr=0 ts=68a35734 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=dvgLwWEeUEcZKFo-wVQA:9
X-Proofpoint-GUID: oXrSUozvY-lHD9pJTMR4C4i78JDGz4zb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX0s0pCD9PMBcw
 9xad7hv3i/i2JIneQGgCajRHsmbtUh6aA7EKw5dA7vDqDl4aRNequOMVtoYfyewAz23njA7MkYT
 V2Z5RQ3cpgQPKLF3lIFz0wAaelOynRQ2tpr7F63lBayIJjAya5hv2gS5BRCodHBVheW3IrmqnWM
 oj9OxSvZ6JcoiKC0FJIebqTen3ZJNHnxsZ+b0C2zbal1mTJzJgb7LJZUy2QPU/s5Gr0CNohWZOY
 HuvKtCPwZVCZYRbhx7o4zuBSm7m67a3Aa/ymI3NrKcR4JZ7sZuwNYWQwI0hgio75S0zM0rqj65G
 83zQFX6T3Isrg8d9s3/5jK5iR4imLOMy97gU1pGQzTri2xlKZxHcC5Do48Um7rwu6BdLX2boIRj
 RxfETVtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

When vmalloc shadow memory is established the modification of the
corresponding page tables is not protected by any locks. Instead,
the locking is done per-PTE. This scheme however has defects.

kasan_populate_vmalloc_pte() - while ptep_get() read is atomic the
sequence pte_none(ptep_get()) is not. Doing that outside of the
lock might lead to a concurrent PTE update and what could be
seen as a shadow memory corruption as result.

kasan_depopulate_vmalloc_pte() - by the time a page whose address
was extracted from ptep_get() read and cached in a local variable
outside of the lock is attempted to get free, could actually be
freed already.

To avoid these put ptep_get() itself and the code that manipulates
the result of the read under lock. In addition, move freeing of the
page out of the atomic context.

Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/kasan/shadow.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1..4d846d146d02 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -305,9 +305,6 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	pte_t pte;
 	int index;
 
-	if (likely(!pte_none(ptep_get(ptep))))
-		return 0;
-
 	index = PFN_DOWN(addr - data->start);
 	page = data->pages[index];
 	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
@@ -461,18 +458,19 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 					void *unused)
 {
-	unsigned long page;
-
-	page = (unsigned long)__va(pte_pfn(ptep_get(ptep)) << PAGE_SHIFT);
+	pte_t pte;
+	int none;
 
 	spin_lock(&init_mm.page_table_lock);
-
-	if (likely(!pte_none(ptep_get(ptep)))) {
+	pte = ptep_get(ptep);
+	none = pte_none(pte);
+	if (likely(!none))
 		pte_clear(&init_mm, addr, ptep);
-		free_page(page);
-	}
 	spin_unlock(&init_mm.page_table_lock);
 
+	if (likely(!none))
+		__free_page(pfn_to_page(pte_pfn(pte)));
+
 	return 0;
 }
 
-- 
2.48.1

