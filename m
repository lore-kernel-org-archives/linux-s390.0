Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3630E0C5;
	Wed, 18 Feb 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424421; cv=none; b=pceUUqpWKLEOOVVo6DxHcNAP1jrzRQcHrllZ1st1dVCNaZhnWig1WXQ3gB+apbTHxXIf/AI9wlHqiLKYZnAzh7egDLTk0fHYDrom32YodZP4c9+U6mTZ0cnKrc9q46Ac/FppB/mj9abZy81Z69znrcdWKq+igmKzczqfQbjLARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424421; c=relaxed/simple;
	bh=aspdksGBWTg3VYyb8Z28WrgvZ1NxQYBgy3gLjvxtXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYIFejpiDh9fXKnOpzYPdXi2qUhwFcPoGFnQAAq1c30XXq5bw5CL0QjKv4exnQRyAbMcGKiTym6pezdBo6fhhd121rGLPlDxdvDAJl09/8yH7PSHvfs5lU0yyE9MELEru2la/nYs8dynVTCrqsfWszlPjpO7GLGS2GeZG7buh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EsSqYpTW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EsSqYpTW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I2kGqm1967517;
	Wed, 18 Feb 2026 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BPwkuhxgNRwb6Hsz4UWmB/WTSpuTkRkXstM9RVNPo
	AI=; b=EsSqYpTWThUM7N4+JirBfLQHuP9swDZ0vbpatzcxZ0bpf498StNw/XIBd
	lmBkPJxwTi8Tvw+Bd9ZmbmyzRuWTyMYLHbODn3f7Vw/I3+pmZpFPH+OwbQ3EOnsc
	d8xzpfKlpUeS5XGWQv73BfmEppxI6Jj1REWUpY2XdSdaI9nKuwukga1vuiSFoPvK
	boDsMDi5WpTqTWBMO7HKL23mCBmkHMNbqq51Ql2IkIQ5Ql6htuMVAhsShiXbdffc
	+SNO+KaKJ7kF0feC5pjwpeE7xF3fUbcA0jYtkdoMALlFbVjcZKkXDjUQtK8d8872
	lGdKW/hBR+MX+IJdQvetWZaHAbyWg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6ushd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDVQZu023972;
	Wed, 18 Feb 2026 14:20:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4583ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKDOv33882616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50B4720043;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E0420040;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/9] s390/idle/vtime: Minor fixes and cleanups
Date: Wed, 18 Feb 2026 15:20:03 +0100
Message-ID: <20260218142012.863464-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=zUv34SalRBigAxX05AgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfXx9RkSAigiprt
 N+HjkQliu49HMvfPL8Zwq3XBv8yeziLfKONiuDS6lRuUzsBXDSHYRa4I+4roFWwXp4BnO8xe1hZ
 X0PX33Sv+iKAQbkosUxGyxW2Ku4IlAkZPc0bHGZMbm70G+jLh+IvuOpBTp6dck56+BEI8Ut5nD0
 AYl4V7iGfUNaWSI3tunK2cd2PoWkUPCTR0r+0FuVjJjOAfAUDRpOcE5SZQVBT4eSUdU3sO074+a
 yVjhv0ygBvC6OKK5zDOtTBdW902dse6KWr1fd3dr6KhbvR+NOwzbQKOQZntjnD7q7O5SidK7lSQ
 gRddV37LZK4pJYOxjfdDsAqw1HDl2+QqXNQ0s1TwyQIEVFY1ttcfITXz4nXHut9bndPs+QnTWbY
 7zEqxPi//9MVYQ6kkRqsuhP7FyBASTUDKo7PTW4H2JF/HYxoN34/ZkjUspisa/4rjASQiTUPRl+
 AN7fV+kerCXwdj3S/3g==
X-Proofpoint-ORIG-GUID: -mlACNNxRXfOMG_ntvvjxnaeMwyPYWMJ
X-Proofpoint-GUID: -mlACNNxRXfOMG_ntvvjxnaeMwyPYWMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

Frederic Weisbecker's cputime accounting patch series motivated me to
finally have a deeper look at the s390 cputime accounting code. The result
are two bug fixes, which are not at all critical, and a couple of cleanups
and improvements.

Heiko Carstens (9):
  s390/idle: Fix cpu idle exit cpu time accounting
  s390/vtime: Fix virtual timer forwarding
  s390/idle: Add comment for non obvious code
  s390/idle: Slightly optimize idle time accounting
  s390/idle: Inline update_timer_idle()
  s390/irq/idle: Remove psw bits early
  s390/vtime: Use __this_cpu_read() / get rid of READ_ONCE()
  s390/vtime: Use lockdep_assert_irqs_disabled() instead of BUG_ON()
  s390/idle: Remove psw_idle() prototype

 arch/s390/include/asm/idle.h  |  4 ++--
 arch/s390/include/asm/vtime.h | 34 ++++++++++++++++++++++++++++
 arch/s390/kernel/entry.h      |  2 --
 arch/s390/kernel/idle.c       | 25 +++++----------------
 arch/s390/kernel/irq.c        | 20 ++++++++++-------
 arch/s390/kernel/vtime.c      | 42 +++++++++--------------------------
 6 files changed, 63 insertions(+), 64 deletions(-)


base-commit: 9702969978695d9a699a1f34771580cdbb153b33
-- 
2.51.0

