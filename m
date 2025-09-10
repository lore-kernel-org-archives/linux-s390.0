Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019B2D948D;
	Wed, 10 Sep 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517146; cv=none; b=Gxr6bvEO9e13gfotNgvcK6QDNAOIub+gdyopWZfW4ZnuyNRw6X7btrUGLgFtA+MrO5/SVlFwb8WCIDYyqaXp5GJYWr1t+dm8rnof10FurZdsFCAx2OJeMujcdOL+kO+BCBoxGDDy2Lmv8JX9tAjvshCRfJEhCf6B0rT7H8V7HSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517146; c=relaxed/simple;
	bh=kxir90F44KW2WQa+mndrKbn36XiiF9IhahTlDyP/GJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmI3fIBeR3Hl3EXanRb1gFbN/JO9h3Dz2/3a11fD8M83qbaIf3oKLzK5yniXIPdDgTwuGMjdudB793AIct3ShMi4THq02GY9vcvXCD2uq4c2BaW5KqKTPe6CRYDSQL59p5L36PWVneyeZDs4znWgjIZP9o6NsMb+7ci4OHsLTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n/D73eo1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/D73eo1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAHTwn021580;
	Wed, 10 Sep 2025 15:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CQi6oVVC5XMtnrgfA
	2tLpNm0t2lzm3Aj0aYsh0tBSVI=; b=n/D73eo1+RHv99T0hLLloJK48WObDQJCm
	cz00ejBKVHQUWnQsgVja2z2ZR5gGq3tUsUs+uJ6bb9JNwQA0l220CyG68Q8+uZx8
	lVwR3I8ImVZGEsj8I+Cj2UcRkT6kL9jDDHzNxuPhW0KFDmAh2Zlz/rQXlp/bpGJ+
	ZAqNVbC7SRhAWGwqGUAKNGUjDGHJEEy2QWDV1SwuAons3LRvuoQ2Q+PTT0E8aKoz
	upH+Px7ijZOGGtJWLBtUI/mxQZonVmnqR/3xp92IzklV4CjJGp7kVtev1kW14i7w
	BxNGVGGSpBXjYM4SvKBqeibDIzJd89AE0Zm1JW5bReae3jHptdvZw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsxkad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADNFed007895;
	Wed, 10 Sep 2025 15:12:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109ps47u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AFCHcB50528708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:12:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E75820040;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A73920043;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 2/3] s390/bitops: Limit return value range of __flogr()
Date: Wed, 10 Sep 2025 17:12:15 +0200
Message-ID: <20250910151216.646600-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250910151216.646600-1-hca@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX2jEc0WQkcs22
 yjPhhZvHO3QKvD7YLnacAyfCYq1QYUHgvjUw28bJKSCPSlJbMmGxxSsKbewjCM8McX8KbgZzfza
 mFKpEzEkxb+Ebvc5RKJ0mZl6+geOoLpP8HPxjC0OMVMe3nFObGPVM7HyG70z0oaTBK5Kl036o4Q
 o9sSb+45ha7O673yYyp4KnrhYpqVDs4lL+xopYXetAaYD9knCbiJaAlJ0R74KQ7JTdOHuQ0lCDj
 vuV+bCyTHibfmijBAXROksxvXgYfBvZotwYhGi2l2q4Kn6frvjq+RLJMCl6g5rlrlA4Ep4qFIQr
 x/agAJxMIPYk53btKSC6NY5z0g0ZmuOm38wDjgenAP7lzvE2CAtQAnEfymWYPsDxINMPnK/QJ2B
 IDQhZCVh
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c19556 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=jVWh3qmyqVVvmCHjMMEA:9
X-Proofpoint-GUID: kg3hIjSwwj5TS1qQVncmy_sNdagh5Ub1
X-Proofpoint-ORIG-GUID: kg3hIjSwwj5TS1qQVncmy_sNdagh5Ub1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

With the recent ffs() and ffs64() optimization a logical and operation was
removed, which allows the compiler to tell that the return value range of
both functions. This may lead to compile warnings as reported by the kernel
test robot.

Instead of only adding the not needed mask again, also add an __assume()
statement to tell newer compilers that they can assume a specific value
range. This allows newer compilers to optimize the not-needed logical and
operation away.

Also change the return type of flogr() to unsigned long and add the const
attribute to the function.

With this the reported warning is away, and in addition the kernel image
size is reduced by ~4kb.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508211859.UoYsJbLN-lkp@intel.com/
Fixes: de88e74889a3 ("s390/bitops: Slightly optimize ffs() and fls64()")
Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bitops.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 9dfb687ba620..46b90b545986 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -130,11 +130,12 @@ static inline bool test_bit_inv(unsigned long nr,
  * where the most significant bit has bit number 0.
  * If no bit is set this function returns 64.
  */
-static __always_inline unsigned char __flogr(unsigned long word)
+static __always_inline __attribute_const__ unsigned long __flogr(unsigned long word)
 {
-	if (__builtin_constant_p(word)) {
-		unsigned long bit = 0;
+	unsigned long bit;
 
+	if (__builtin_constant_p(word)) {
+		bit = 0;
 		if (!word)
 			return 64;
 		if (!(word & 0xffffffff00000000UL)) {
@@ -169,7 +170,9 @@ static __always_inline unsigned char __flogr(unsigned long word)
 		asm volatile(
 			"       flogr   %[rp],%[rp]\n"
 			: [rp] "+d" (rp.pair) : : "cc");
-		return rp.even;
+		bit = rp.even;
+		__assume(bit <= 64);
+		return bit & 127;
 	}
 }
 
-- 
2.48.1

