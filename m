Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEA3D1702;
	Mon, 20 Jul 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537924; cv=none; b=TYfCcbXi9lr64nkInTbVaVZUsKL1x6FviHzWXqj/SotkTkzHf7O/zKpHYErGiDpW7fR5tjZnFx3C9k9PrXlQG4ulaUU/tMZryfLBbVXD1vT9nUlYW8+EW9WH1thY/nAE+BrvbihMHukmZpwmfZXzwJPuQR6O5djuiLWamFN1JYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537924; c=relaxed/simple;
	bh=0jK4btx26Jwvi041xJirsZ+ydMijoK3qrmHGRRxWCAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXYlh90FK31pSR2yuUkIZarfisWmbS9gXhhPjU4fw9KK3ugU/s6PEC4MM7zysPqTNGsMyUdKVQEhBoHGSNIs5q3kqCFskJ1DuW64Ukq3lwBtzuydUE6KddI7eOYWlF98155KEifCWCoBNnrGcmVerYaZk001hZD2wpA08UNBBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eoQ0+K8p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eoQ0+K8p"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fgSY3777204;
	Mon, 20 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4fpnUxdPoQ8eIU2iD
	+oHnO8eayYOZEM4N/oAChWRqac=; b=eoQ0+K8pcivB8skUxJs0in3IYrSKFWkUO
	+Q7bfrhw38ZnFYmh9WECgM+LT27TRdUekR9Kw0zDuRO43FvTN5bUtPobWZOZhpNm
	5cGfHf8M8OLYFNq5AAbjsN69knx5rd0YZqShjXMeCBbJav3IAOWMXHw9n7K5kVjX
	pwNFEStMkjL6tUP3Hd6lXkF5COSYnVeMQ4GzZvmNVBoYNe+hTIHh2tvrYfn6Ic0/
	85549TW1GgccMBa9Ldt2LYO+VDTcF72PC1e4HvAG5ytGG1v8TYlbdpsnsL90eLdE
	26JpMIwlw+B2kuzp1LBZGIJxHHXnhnGSvvLcmUdl8hq5eAq5WmItQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a6m82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8ncpR012379;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjmu3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wZla48103692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AEB420040;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F7442004F;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] s390/mm: Add missing mm check to do_secure_storage_access()
Date: Mon, 20 Jul 2026 10:58:28 +0200
Message-ID: <20260720085834.898025-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qBknqFVvGJvuyJGJ_poysOAQP8y8yNTg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX8qcc1XCDpWlz
 Knc5r4lVNyRveDbkjqfE65CoLmGonppSDyp7mvnf92h/MWJr3IbbmUmiUz8dMLZ8qbhXnMUjgvQ
 7RswxQv/s0hhgBMgdx8JGWtuS/B2qgg=
X-Proofpoint-GUID: qBknqFVvGJvuyJGJ_poysOAQP8y8yNTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX4mn/TrsGws8V
 Xfg0Yu3ZPgewTDYJL8QY8BPJ7ULxzUioSPZzib6dF6MLCLpKZKtKFSId3LVqfOD5NJMDqophQd9
 /tejSLfDOOY517rYffb5KVxhAD2ieTPPpC9Cv1ReK0Obmmeo54RZjk2FL9X39B+YBIgnbd62RJx
 wUTMbMN+mu9LF0u5wj1LxDp4OC1kCvSZuO/96ymF+kY9yPQOnPNXB8Fuynin0/b6Z9ly1Q5I98l
 AGL992tVYDZiQNkW0q+OLb+ki3oGIFwbbz+5/4sD6U8WNfn+azvo77/icFUY6XS7GQLDqqHmfbK
 qaWbTuKT9PzhXE4KAzlWTNjbIZ0N6h42/Fw5s9uqSNNoXzRnrMRAe4DvXmrEm4jUgUjLV5xvzCC
 YC9AlBiWtdti6gy+Hz/01uhK+yhW5bVbv2XUg6tZEZhFNlflHBB2j6sDtOaYxfHDsr+EX9m63b2
 2JVe9j3K3cGLv5g0+qg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ee2akQ2MmfY_TRJwXSkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200096

Similar like the normal exception handler the secure storage access
exception handler needs to verify if mm is not NULL, which may happen
with kernel threads.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260717132345.539A11F00A3A@smtp.kernel.org/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 028aeb9c48d6..2839d7a64401 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -409,9 +409,9 @@ void do_secure_storage_access(struct pt_regs *regs)
 {
 	union teid teid = { .val = regs->int_parm_long };
 	unsigned long addr = get_fault_address(regs);
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct folio_walk fw;
-	struct mm_struct *mm;
 	struct folio *folio;
 	int rc;
 
@@ -453,9 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		if (rc)
 			return handle_fault_error_nolock(regs, 0);
 	} else {
-		if (faulthandler_disabled())
+		if (faulthandler_disabled() || !mm)
 			return handle_fault_error_nolock(regs, 0);
-		mm = current->mm;
 		mmap_read_lock(mm);
 		vma = find_vma(mm, addr);
 		if (!vma)
-- 
2.53.0

