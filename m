Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72C3B71B1;
	Mon, 20 Jul 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537923; cv=none; b=U+kpwbgOa/LzdbPBLC7jJeZFRx7bQjxC4GtdjxFu7HdnOPOg+929mPzQ3F1i6Qs3lvZ9P4mOHmgd4AYJT3OyZmYAJhpWuVp3RWtN8Pl2CTQoqQO0zVnzA5uiD0AsJEK+gMahjAyGMEPEup7oT5Eq5VSgIigIZAx8VSRcwDxqDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537923; c=relaxed/simple;
	bh=2Mvr2aM+Okn6Eoocy0JzIG4MQY1TWan1vMVEGgo4EdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFtrC3oYry4TkiuE3ZYR4eProtrBUuaJHnq64zrYY5OLmPklFRZkm4ZM0SBr1E9rEHGs8K5VR70NYgsEsPrpiLqA0Tkqs8xQQ7VRvA7+YsfJcaoVgTdahXACOrPCK7QVi4B9tyduwLVp1ct+mky2PUwVNJgcZJAM1jt95qOUEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KYvUP02P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KYvUP02P"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fiY81469886;
	Mon, 20 Jul 2026 08:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BvQ4XfaSURMM524T2
	d/WdRXrto9t8TDVudWJ2Vk7l6A=; b=KYvUP02PigdD0RjuHTGCI8bcGovutFLcN
	vdBaAmZO6CSd/7EPXn5HCqZ2KlEgeeGLHTTYGHd3UheZ9YVuBO35JUq3NNJPa0Xy
	fFURk76ZOhVviEso/zQL3pNDlP5cmF4tGLsDV9BTZAbCom7AvNaXSgvsHtYGRgvF
	L+7AHouReiO0X9T/qkN4jH3F7lufDmioboBtekGS1pv4SZlRh5hlLJymma3qjqC/
	tsl2FakSN3O159Kk6gPDeP5vYYALOwu+CFuCrohOLDv0kddAfuoJLn2w/Tzs+Qb9
	xd127zPoUc2IbZCl/qNW4R5JMg2HUj+ofyDGrxI2pgjmoi2fRz2hQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790pma2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8nh7S031459;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4n32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wa5C50332154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4052B20043;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 156C720040;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] s390/mm: Use goto statement in do_secure_storage_access()
Date: Mon, 20 Jul 2026 10:58:33 +0200
Message-ID: <20260720085834.898025-8-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DkiE0FkIQwj-qSfwOa1dqU-N5cJlqqSD
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UvXp18jeiaLpj9j1RWUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXxd4J4b5NAcpX
 fVjnYpNmyWqJZi7hkSDTychSJFrCGx5NEWXGCwa1KlH61LrzURIaZTKraVcM5K/f3hcp/EY2+pV
 aNgTJBizYOThVM9WTubhub3du6oVl1Y=
X-Proofpoint-GUID: DkiE0FkIQwj-qSfwOa1dqU-N5cJlqqSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX7clRZPeF0DLs
 CcB9ygWaeo/sEFkU5dLo+3EWP8C5lo+AvR1aM6MBSJ8yfUvC7QDfI8mSqP+VYmbO0Wrp1bjSHkV
 Oya0+U89nYE1FUzG9itt8mEDs9letPM3Ktkm7IhF6TJgDMCiD/OplSQV+8QcqABpli4eTonNIr+
 Z5zvia84elfM2pN6ISRanmAtS0ePAJhTvMGBAaBdychANn3LQIsk3GJjNHy28t45kmmm/0C/UTN
 0bkKp2MmWQpN4nLbVyQVH2yOAZ1nbRdJ+v2TbktsP/FR0M8sj3ae9AhTG08IqJJTl6N1TcWYYGJ
 tw0PA1/myotmqFL6qYqlP0R4VPsWYELt+Xu4GryfQWPahWits/linlpJaDvssQVA9f4s94BtJ6F
 sJ5y9aWCCfUo50yC+2JLbMYiOuBua7yxoYAc9TctKyHP68098uyEimD+VMTe8KJmykwztSBB3eA
 Z8PHPB3wuKPyDuQGMYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

Make do_secure_storage_access() look more like the do_exception()
by using a goto statement to get rid of an extra open coded
mmap_read_unlock() call.

Just cosmetic, no functional change.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2a9b9fb30d09..666fe8e99480 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -453,10 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		if (!vma)
 			return handle_fault_error_nolock(regs, SEGV_MAPERR);
 		folio = folio_walk_start(&fw, vma, addr, 0);
-		if (!folio) {
-			mmap_read_unlock(mm);
-			return;
-		}
+		if (!folio)
+			goto out;
 		/* arch_make_folio_accessible() needs a raised refcount. */
 		folio_get(folio);
 		rc = arch_make_folio_accessible(folio);
@@ -464,6 +462,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 		folio_walk_end(&fw, vma);
 		if (rc)
 			return handle_fault_error(regs, SEGV_ACCERR);
+out:
 		mmap_read_unlock(mm);
 	}
 }
-- 
2.53.0

