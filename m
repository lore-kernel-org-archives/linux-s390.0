Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D704248B2;
	Mon, 27 Jul 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170858; cv=none; b=J4WM9bViu36jzo2MTseclNVevxMTFTaDKossPmNi9TjCNds25m4snGFP4qExSB3rkMYKDiXLz3xANjbgNhCplJaXuJ0hYfc5LgwnUhBbxQVL3SWlcQrFHMKib2UTwSzh/+pyDB6uSDyKpTJDPR5MEs8P3GxYcn5dIllWeHw3Fvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170858; c=relaxed/simple;
	bh=GKUuih8FLSQIXzYJ8A91hXfdj/jiaygYOjHPY8y901s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJY+XZuQnfGrevEUs7lq4TdvXK0BaNjgNno3wAhUOKgo0j6152CUEXDf6UKsiPStOfuBx/6NkrO9maf+w3dgdaJhKAxRvgKBx8KsTRnIcdqIxMXEt5aOnPLVsirawtSjdxdoRTLBbs60i39Xaa9mR9yKOkoCndX1Ddex424hqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GLtv9kED; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GLtv9kED"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDngXc2299023;
	Mon, 27 Jul 2026 16:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YfMKgFgPu36R/c/cK
	1cSiKkgs6kEmixC2VaHx0Z0eo0=; b=GLtv9kEDJEmtHsVGyPt4uSrtUZR7DWE00
	8VvyXM6XCfmIos8sEuYX5CYWNKQkmU78Hk9uhKe59iQENsptuidSEqybnkx53NKG
	gaQ7wND5XCuRCBNg8E74R66Xs25drG6xEvPFZVY3bdC7ee00n7XLdY00ZG9uWmYN
	LWVlqXFrJGZ0Zgg5IxpDrb+O4ZrQgatECVBuupEIgTk2T+6DS3OvDnfnTs88ZbcY
	U6SUJFue9C4kpN5hKTZkx10HPWJTheEw7OQFRAhEIqDyHE00sZOer2DozQ7Xxnjq
	N5dTPQd5XaEATJbX0Bcmbm8qsVJj+y4hJIhZVS0kVUW01yMSxq4rw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0n1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGfNHW032665;
	Mon, 27 Jul 2026 16:47:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwwar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RGlM348716702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 16:47:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5470F2024C;
	Mon, 27 Jul 2026 16:24:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9502820246;
	Mon, 27 Jul 2026 16:24:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 16:24:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Date: Mon, 27 Jul 2026 18:24:27 +0200
Message-ID: <20260727162430.1599396-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727162430.1599396-1-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1NSBTYWx0ZWRfXxfZObd4qmOOP
 aWDDoVUyf9XDyVPpOIPGDUnuiYpDSJ7a9RyWqDpUqD110cjOPIF+HGfl6U/wau1Bv+O2z6bVRFd
 aJju3qbN3VXd01EjTS+q6LDSRinLNcg=
X-Proofpoint-GUID: PGbtKjaEVNyWueTQGNdkNsEwZFHgMEox
X-Proofpoint-ORIG-GUID: PGbtKjaEVNyWueTQGNdkNsEwZFHgMEox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1NSBTYWx0ZWRfX7Iut8yCvWmTf
 /906ukcMpaIpxppNATL9R1/LLzgTKa6U/T2HZ0haQ4tHrYKcFGNxZtCxuhcCG409A8U42mWOzon
 4IY0cbd+B68w8Rp0Y1jnF1Oe0eEZu82VET2OFUCjxiX4GPLrIfby8szT9DN8V6GsT/6WpqFQDxX
 CgS8FK9sPObP0/iQ5wC/Avics+Edje0A69R0QAOr6pZsNKvrGudlcdpolQQSoY43iQzbSuRBXKR
 9EC9pbDBp1x9u3iuXdQi/0fOs20OKHpGJvaM4dYJOD3+kX0eYldKGc1CIUiUXbzxfJhTPY3+Goe
 A4k70LmEbuiIEbX29q48N+ATaZGqgRbAS+wnEoTefS5DU16o0o1cAR6CiG0TGg913XuXUWQa7GH
 TsOkTdUXeokyEBQRiNDYuT4C3wCeYzXCdVWO+mEY268g0VXNuhG1UofuiJ0BhkXytOObGq3MRRg
 dogZm/nm8ObC8Ld+cFw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a678b9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ZrKzavLDTR7iG4YESrAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270155

The comment for all cond_resched() calls in crypto code says that the
process should be scheduled away to avoid instant re-invocation of a
callback. This is not what cond_resched() would do or did.

Replace cond_resched() with a call to schedule() which comes closer, but
it looks more like this code wants an msleep() call.

Note that with [1] cond_resched() is always compiled away and becomes a
no-op.

[1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/crypto/paes_s390.c  | 8 ++++----
 arch/s390/crypto/phmac_s390.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 8cfe6166c193..d02de945f864 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -555,7 +555,7 @@ static int ecb_paes_do_one_request(struct crypto_engine *engine, void *areq)
 		 * To avoid immediately re-invocation of this callback,
 		 * tell the scheduler to voluntarily give up the CPU here.
 		 */
-		cond_resched();
+		schedule();
 		pr_debug("rescheduling request\n");
 		return -ENOSPC;
 	} else if (rc) {
@@ -821,7 +821,7 @@ static int cbc_paes_do_one_request(struct crypto_engine *engine, void *areq)
 		 * To avoid immediately re-invocation of this callback,
 		 * tell the scheduler to voluntarily give up the CPU here.
 		 */
-		cond_resched();
+		schedule();
 		pr_debug("rescheduling request\n");
 		return -ENOSPC;
 	} else if (rc) {
@@ -1129,7 +1129,7 @@ static int ctr_paes_do_one_request(struct crypto_engine *engine, void *areq)
 		 * To avoid immediately re-invocation of this callback,
 		 * tell the scheduler to voluntarily give up the CPU here.
 		 */
-		cond_resched();
+		schedule();
 		pr_debug("rescheduling request\n");
 		return -ENOSPC;
 	} else if (rc) {
@@ -1572,7 +1572,7 @@ static int xts_paes_do_one_request(struct crypto_engine *engine, void *areq)
 		 * To avoid immediately re-invocation of this callback,
 		 * tell the scheduler to voluntarily give up the CPU here.
 		 */
-		cond_resched();
+		schedule();
 		pr_debug("rescheduling request\n");
 		return -ENOSPC;
 	} else if (rc) {
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
index 03ca33ffe6cc..bddfdcee6cb3 100644
--- a/arch/s390/crypto/phmac_s390.c
+++ b/arch/s390/crypto/phmac_s390.c
@@ -895,7 +895,7 @@ static int phmac_do_one_request(struct crypto_engine *engine, void *areq)
 			 * tell scheduler to voluntarily give up the CPU here.
 			 */
 			pr_debug("rescheduling request\n");
-			cond_resched();
+			schedule();
 			return -ENOSPC;
 		} else if (rc) {
 			hwh_advance(hwh, rc);
@@ -916,7 +916,7 @@ static int phmac_do_one_request(struct crypto_engine *engine, void *areq)
 			 * tell scheduler to voluntarily give up the CPU here.
 			 */
 			pr_debug("rescheduling request\n");
-			cond_resched();
+			schedule();
 			return -ENOSPC;
 		}
 		break;
-- 
2.53.0

