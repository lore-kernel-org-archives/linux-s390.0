Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2B40DFD6;
	Fri, 13 Mar 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425866; cv=none; b=hJhpo96QABhLDzGoyzh1nEE7n6CIi50xY8PUTGqlz+Byx8YVcrsEb4ASRgrMjg3oAbxBotTrldBL4uOY6hkQ01tK9jVkGa7OKPAq+1JIqcLzTHoqBPOoA8f4e2XUH7BXTKtM4nBQvEO1wBsSwoVdgwwZwlOQ6b4fMmVJHWTlfq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425866; c=relaxed/simple;
	bh=ewBybKSZBNkuzfv5AgnM6SB8NyOMRYBP3JmbtspERMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MrrnVg+cTkRHBNA7uIezcWUhHaLwRJNxV7Wbn/bLugumRNNWAQBhyYCUwGr4MJJ6eZmQ8FzI2ixh0VqE0WwHNIfaifipjE5WwFQiMwOe7mJljE6DRE+jY3Pei26ucJNTsEZeG3+PSs34qzhPEG7QBAVdXkEeWjmtm4jOtcvkLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OB9IfSzq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OB9IfSzq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5nbiW2206095;
	Fri, 13 Mar 2026 18:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=oSk2f8JcCo++tTBK0U4R0XE/Z3QTjO/BWsy1/4InFBE=; b=OB9IfSzq
	oC43+BVT7uGsunB39f0R+tLfgJOjfuW9owD+w570LgmlLJulK8xWtuTUnfTx4x7X
	Sg+F8YyDg1K2BCq41XFY8eISkbeIXsEoCbBEX6/kDac1mNFPXI70kO09kSbaz+JB
	1TMHm0xFuGTXDv16GWG7z99JR7WXY8X9s3Z/3YX1afExHRPaH+BpK7FsLuJl0pZN
	uImF2z1dfajmLVLm4He8zvFKS4N3BEZxrZkdxhemE/2G3eEbyOdaPJvIHYxDVG5+
	vV5pUbUzytbzidItVjfz8V9OJBK9hS0ei5kRyJ2I+yGasIt+nCW1ofcWZ1tY3yPR
	rUT3Q1N2TvAsFQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98gusf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 18:17:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DFUZHO006042;
	Fri, 13 Mar 2026 18:17:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qty1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 18:17:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DIHcbc44761500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 18:17:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E47552004B;
	Fri, 13 Mar 2026 18:17:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743CC20043;
	Fri, 13 Mar 2026 18:17:38 +0000 (GMT)
Received: from localhost (unknown [9.111.83.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 18:17:38 +0000 (GMT)
Date: Fri, 13 Mar 2026 19:17:36 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.0-rc4
Message-ID: <ttbuo5c@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b454c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=l5hYWNgtuDIZ4QzA88cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 84tVP53g9vc-r84R8cZsbxOW8lLimw6S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0MyBTYWx0ZWRfX4YIceIbMk1iO
 bK6WrOR1+kQdqQbJqrEOZZ2loby4Kr3XujD7iQjiGTK/d7H5YRHLjqqJKPteBKAF4TA6zn9b8dT
 jfTVPJFWnD6KXRozxqdUIiQ9V0dXoZ1JlaXxkbOP6307u6dk8uTMplfgAtqh8apdF1PuDqwn/xL
 p/cH35u15FjW7siSZO0fhSyYE64s3r8rN1Oo/tgpS/gys1u0Dpzf/dGTTL38zw9SwJg7IqHR/xe
 5Q33ZWSk54CE5sSWNyCcMXlaWTVZx6LVaHTwvz4fISbblLwsbOnkhjK1PqDSAco+l4zr59Cbkp3
 /srWrgjDJrKnUe2Tiggtqn25FNzndfaORfOM5EttA53xUwbOZhs5+CAXxDQZPVeYZiQ+VlRS4cZ
 w848N8yR+/O3L0HxkW16aEhvOiBU6xOERIYm+1HamWSlWOZYCbsoYhcp0BFBEl9hXzhpKypk1LI
 ufUu8jxeo95uPgE4bHw==
X-Proofpoint-ORIG-GUID: 84tVP53g9vc-r84R8cZsbxOW8lLimw6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130143

Hello Linus,

please pull s390 fixes for 7.0-rc4.

Thank you,
Vasily

The following changes since commit 674c5ff0f440a051ebf299d29a4c013133d81a65:

  s390/stackleak: Fix __stackleak_poison() inline assembly constraint (2026-03-03 16:42:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-5

for you to fetch changes up to 598bbefa8032cc58b564a81d1ad68bd815c8dc0f:

  s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute (2026-03-07 22:41:10 +0100)

----------------------------------------------------------------
s390 updates for 7.0-rc4

- Revert IRQ entry/exit path optimization that incorrectly cleared some
  PSW bits before irqentry_exit(), causing boot failures with linux-next
  and HRTIMER_REARM_DEFERRED (which only uncovered the problem)

- Fix zcrypt code to show CCA card serial numbers even when the default
  crypto domain is offline by selecting any domain available, preventing
  empty sysfs entries

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute

Heiko Carstens (1):
      s390: Revert "s390/irq/idle: Remove psw bits early"

 arch/s390/kernel/irq.c               | 14 ++++++++------
 drivers/s390/crypto/zcrypt_ccamisc.c | 12 +++++++-----
 drivers/s390/crypto/zcrypt_cex4.c    |  3 +--
 3 files changed, 16 insertions(+), 13 deletions(-)
