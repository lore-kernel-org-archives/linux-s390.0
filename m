Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED1237164;
	Fri, 27 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012515; cv=none; b=sMrDbB+fhQFr2R24LAaBcX7MUIsNiOHdkP//waXNl/I1qL0hAFVemnMlWa7RbDlBfdfEU8/7S90+Wz7k3i74PbJ/xJth7z4OALn9nHwhOX7NWOnmUUxl9C1RqZQmzhTWU7d8TZh4+/HuEe7TksoAt1P+OFfDYMds4sQPLbZbIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012515; c=relaxed/simple;
	bh=DI6dsYu4kQgpnaRia4IpKX7prmm2uj8F/0HVOrRH6CI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U5lS6Yynxp/WzGBkgNQ15rS+kPeYR/vbHMNOao7vpRyPgs/s24GQFE1jicJ+iuqDNKris1FqqXLuJC0BoxD0cmH24S8QY5GDSyL3vfNrGNCywbXXJSIGyoPWm0ZJKwKZnX+DbrUfziAWJgjI6dKwJ/55i1POLKAmbUe+pWXpuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eLtUEvbi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eLtUEvbi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QLbw2o010678;
	Fri, 27 Jun 2025 08:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=lKFCoWumeX6i41q6QCz+fyt3hfK6+kplYjOdsf8CfYc=; b=eLtUEvbi
	wAgBa9DZJvuq500WiPQoecVF3wlc2wEpUdNogCfrXTQspczp/eM7f8pkqN/KRAs7
	2wiHLZNUEJ46WkTam37qBOYAsW4EEUvYgEk3+rVnFmGuobIf8OSts+CmnoFC6BEg
	5PgOHDKxdtEI3phmtMhW0l3yYpX1D3MUqTdtZDkurQ0VSHoQ/n/Tg858SnAKObGJ
	SssiOCKBUYMVPcqWG67a3uJr56Ze9coLB8m/vUTIpVOND6nW2fWBhtJmSxOXiHN0
	23h1gJ+sz/aw07H0FCdOrd51TKyOb/dyvXncUuPS3cYnvnTmLWtoiy9RbMcRaqca
	vM6m74uJye1b5w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphswka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:21:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5XSks002908;
	Fri, 27 Jun 2025 08:21:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmk334-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:21:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55R8Lk0p35652100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 08:21:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B21420043;
	Fri, 27 Jun 2025 08:21:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BCD420040;
	Fri, 27 Jun 2025 08:21:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Jun 2025 08:21:46 +0000 (GMT)
Date: Fri, 27 Jun 2025 10:21:45 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.16-rc4
Message-ID: <5038bf76-cdda-4ecf-a9d5-b5ded666356f@agordeev.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BfYhlY6uWN4jzswOzc6SlrW3D0pcGyRk
X-Proofpoint-ORIG-GUID: BfYhlY6uWN4jzswOzc6SlrW3D0pcGyRk
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685e54a0 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=jgawQoxS9akQ2SvUetwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA2NiBTYWx0ZWRfX511zUGP3YHrh BflqcgVVdKHMbv2uFW3LQrGDZOVyjFlmfCxlxqn2DnVSW/yfpUC7athVUeD8BNOzVUu8EVFvzy8 N/vLxF3VOceEohimfgeclOnkl4cfkru1nJiQ7r/9NV4PQh+tZNTk6TGMOJ42jMAiQ1nXqJHtbrn
 7C+qEDilSUxVma+9jn9lfcjnYZOy3+WGXyyTOFqNLGxVYlJwbko2L1NRsG0XTJDDFLg2h3uTQY/ ZuFNrCf3NXNr6q06boc77u+EICCzxHJjRY1Dv4L14NVFOisIo9IS0uREz0LID4rrbXVjbFxMh0c apE3Cp1KhBMVgZypgOO/IdqxcPcu43Nj4W1cYiJs3mbcKnwmzxtaAhM22oH57oddgAw5CNroyWI
 d0W1RveblVS9kYamqmOAebLPrk8NBp7H+xjErnpTzNdoaFpUGh6RFSxfDvNN1YZLa6bNHGdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_03,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=545 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270066

Hi Linus,

please pull s390 fixes for 6.16-rc4.

Thanks,
Alexander

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-3

for you to fetch changes up to 7f8073cfb04a97842fe891ca50dad60afd1e3121:

  s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth() (2025-06-17 18:15:25 +0200)

----------------------------------------------------------------
s390 fixes for 6.16-rc4

- Fix incorrectly dropped dereferencing of the stack nth entry
  introduced with a previous KASAN false positive fix

- Use a proper memdup_array_user() helper to prevent overflow
  in a protected key size calculation

----------------------------------------------------------------
Fedor Pchelkin (1):
      s390/pkey: Prevent overflow in size calculation for memdup_user()

Heiko Carstens (1):
      s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth()

 arch/s390/include/asm/ptrace.h | 2 +-
 drivers/s390/crypto/pkey_api.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 62c0ab4a4b9d..0905fa99a31e 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -265,7 +265,7 @@ static __always_inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *r
 	addr = kernel_stack_pointer(regs) + n * sizeof(long);
 	if (!regs_within_kernel_stack(regs, addr))
 		return 0;
-	return READ_ONCE_NOCHECK(addr);
+	return READ_ONCE_NOCHECK(*(unsigned long *)addr);
 }
 
 /**
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index cef60770f68b..b3fcdcae379e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -86,7 +86,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)
