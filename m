Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ECA2857D2;
	Fri,  6 Jun 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223796; cv=none; b=Vre1c2Dqfzkqx/LeuXsegqDt0Ah6hz06Snb5WbbbSNlTkk1mGxCEP1iFwaStpUIh/59ozNYzhXaiBq8qlw8TO7zfO0YDW8Kry3S8xfaHXJG/lMBgE/bqHafXIjAmuYI7Vm9HCA+sHcn0FHbakpuC2J8oki8mKEUXEDb8mHN9PWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223796; c=relaxed/simple;
	bh=wPZ31T1OTJ/lEqz6ozHAKyDdaa1BoP9raSYEep7iOxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q+BVWP5eGOUVboFo5gr78uRVqtc42Zgy5m0Vqogd6Aaf2uO3IX2NIPJ+VQ2BMwf0r/vi4FkctZTL/9WtnghR7Yk2L4PfbSvKmI55YP1lXzMid+17sbz6tFW4NhG6b0FEUjdLfGnuYy0pYSp1VlTqaZrsHmIH7zxrY89BTMMP/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T5EJUzKq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T5EJUzKq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F2CtV025631;
	Fri, 6 Jun 2025 15:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=TuzBtG6emqrxneh2fDnmxB4Z6BX2h3xJtq3/g8bxJzM=; b=T5EJUzKq
	EtqTA02N+jJsUH0CkvRgk1fv15WLosA8bCY1kURIFJZdfbk9DIyKPDud1kMTu5k/
	0eQi6B5OSD8KHFAADkI5neoNz4Wzp+/uCyHdKgDPIRdUIQh9NiFH8XWNqINdLJkQ
	KJPrtSZoaaSb8E5yLU1vDsv7/JlmUy2Jlm0NK12fGCO6m5ARZcwTgffSXBxvFLnv
	9f8Eg3uA+Z+Nr4uOJmFsrsg7lF8oaQihAbC6v3Aag8+lhA2znw5OL16xIEYC2czg
	Pwyw7iPSTIiDP2+ypG/H+b3fQssQhKu4BUsX0TkKU3BO2JeZmRk70Gr8Pqk+ZVSk
	vosucBQYOxhxTA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwuxnmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 15:29:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556Bahn7019851;
	Fri, 6 Jun 2025 15:29:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3pa2td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 15:29:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 556FTmo359441650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Jun 2025 15:29:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CB2420043;
	Fri,  6 Jun 2025 15:29:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD8EB20040;
	Fri,  6 Jun 2025 15:29:47 +0000 (GMT)
Received: from osiris (unknown [9.111.77.68])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Jun 2025 15:29:47 +0000 (GMT)
Date: Fri, 6 Jun 2025 17:29:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.16 merge window
Message-ID: <20250606152946.20790Ff2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzMiBTYWx0ZWRfX+6AjeCkiafZy 8kY89VTwO6fmNLqO9dJk8zt4jmgUo10qkSs1QaZSJgKQVLW/CMQ1e7sQGw/DFfVHPwTPRNaiM/3 IiWgXyYf6lg8NFinTGukk1yHNvOT/BYn9LUV28HTxN9PN1AcARPef+n9Zf0yGq8Swk5+8rkfXYU
 3NWBS1UpSE3u9sszHDQcRrzpJrsbF2QYkX4wHVHswgYDfkOzQWJhXRI7fMLul6q3gODLz5v0/hP zGt1XoydswgiDyfiismH8E1578HPXRQQ5W8UV3Rcy9iEL7g1JQT5jQMXNDzF4Ipku6GIqJY2axC aL9Q0LOE/mGw/HStVYQksP//i8WFK0G4LDN1X+ttWdaEgGxflTcgWoGm6/H2+zeSWdCdrLkm3Tu
 CuZVm+rigb0jnAKenDel6OgIjCa3gBwspvlfytMTEumUGSfKtMbmaGOnbPF9Dv8UzGCJvoAk
X-Proofpoint-GUID: CAJZjNCcqqzX1fNRRpvRxIkmA9b0AUmo
X-Proofpoint-ORIG-GUID: CAJZjNCcqqzX1fNRRpvRxIkmA9b0AUmo
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=68430970 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=8S_yueXukSYS4pLg3-IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=729 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060132

Hi Linus,

please pull two small fixes for the 6.16 merge window.

Thanks,
Heiko

The following changes since commit d8cb068359f6210d790828714081d4ccb47014ff:

  Merge tag 's390-6.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2025-05-26 14:36:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-2

for you to fetch changes up to 11709abccf93b08adde95ef313c300b0d4bc28f1:

  s390/mm: Fix in_atomic() handling in do_secure_storage_access() (2025-06-05 12:29:22 +0200)

----------------------------------------------------------------
more s390 updates for 6.16 merge window

- Add missing select CRYPTO_ENGINE to CRYPTO_PAES_S390

- Fix secure storage access exception handling when fault handling is
  disabled

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/crypto: Select crypto engine in Kconfig when PAES is chosen

Heiko Carstens (1):
      s390/mm: Fix in_atomic() handling in do_secure_storage_access()

 arch/s390/mm/fault.c   | 2 ++
 drivers/crypto/Kconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index da84ff6770de..8b3f6dd00eab 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -442,6 +442,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		if (rc)
 			BUG();
 	} else {
+		if (faulthandler_disabled())
+			return handle_fault_error_nolock(regs, 0);
 		mm = current->mm;
 		mmap_read_lock(mm);
 		vma = find_vma(mm, addr);
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 5686369779be..9f8a3a5bed7e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -180,6 +180,7 @@ config CRYPTO_PAES_S390
 	depends on PKEY
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
+	select CRYPTO_ENGINE
 	help
 	  This is the s390 hardware accelerated implementation of the
 	  AES cipher algorithms for use with protected key.
