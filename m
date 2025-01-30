Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE01B21A9;
	Thu, 30 Jan 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252699; cv=none; b=DwfTaluOPHd782/KZfM06bAdbb7/YIEFA6STxteDbOzrTCYdP7xWeZGbmiCkXOzsBJyLHbyh9y9MogmYKAqWSi/ZAyfjlVvFuzFtNNtBNPyRy5zbTZjtYUqgAvhXc/iH8aJqTyGleSVUDzkl8da29BVNGl+UEOlq1fXGWbyCPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252699; c=relaxed/simple;
	bh=n/LcRtXMjHIBZmfXW5+BwKQuQnjfWqlWRR1TAj6XDD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u2S35T27ryRHB9SDGROs6DX+Bf/9DdOn0fKDWX7VsfpzuxpKKDXE3Y4ODYipBbCVYjrCBj+79/0UPvOHvX2jGe7Z2qsDXSbKNmqzZVr9MoHCoQQkxKezl05ylvSh5edmuxOkgRj4XEkrGlzrfjAQfSeU2an2vn/Mu/W2yr/Euug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gUy56tcx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gUy56tcx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UFdqHf010446;
	Thu, 30 Jan 2025 15:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=ZKU7hEy+vGXN8d29tMsqQvnGmvAKMQaF9f+zSgbzPxU=; b=gUy56tcx
	6ZnwVJMcyqlh7wqVxoPK7EUsk2VOtvFKisKP7n8uBhyr/U6lGqx5uBPUCBThWtos
	GLXXB7El6P+JT0Dqm7EXDtl4jQGq3RxGvzDj6RXFty+vNT25irz+FD6rhBGqfeqa
	wF/gpF8aLjbe5d2VM63M+in9Nv3g7G/lVHn6VzIB/+uqy15otjvQVBKY9VKUrcHQ
	6DuFiHlxlsGKAODvNNG339JfhaHWqTsdmXRJfaF+3joYGStnQWQYLM6Z+XuqOcvW
	JYJ3OEK9kmOVTQYZL6mWy+J4qTn11jFCWM7Rdtx6hWpAdePk407zG4MLCZjZecjo
	UdFubqaSVJwxIw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gc8tr2ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 15:58:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDhuuD018905;
	Thu, 30 Jan 2025 15:58:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd01pfbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 15:58:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UFwCHA47317390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 15:58:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EECB20095;
	Thu, 30 Jan 2025 15:58:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7306720093;
	Thu, 30 Jan 2025 15:58:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 15:58:12 +0000 (GMT)
Date: Thu, 30 Jan 2025 16:58:11 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.14 merge window
Message-ID: <Z5uhk4LusN5aGRwM@tuxmaker.boeblingen.de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wvA2dZhlPIxAS7imSY7F4eZsMbWIhx9v
X-Proofpoint-GUID: wvA2dZhlPIxAS7imSY7F4eZsMbWIhx9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_07,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=696 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300117

Hi Linus,

please pull s390 fixes for the 6.14 merge window, which address
issues introduced with the merge of ftrace-v6.14 tag [1].

1. https://lore.kernel.org/all/173807816551.1854334.146350914633413330.stgit@devnote2/

Thanks,
Alexander

The following changes since commit 2e04247f7cce8b8cd8381a29078701691fec684d:

  Merge tag 'ftrace-v6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2025-01-21 15:15:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-3

for you to fetch changes up to b999589956dd3ae096b7d67b6fee4e9989a2e430:

  s390/tracing: Define ftrace_get_symaddr() for s390 (2025-01-29 15:12:40 +0100)

----------------------------------------------------------------
s390 fixes for 6.14 merge window

- Architecutre-specific ftrace recursion trylock tests were
  removed in favour of the generic function_graph_enter(),
  but s390 got missed. Remove this test for s390 as well.

- Add ftrace_get_symaddr() for s390, which returns the symbol
  address from ftrace 'ip' parameter

----------------------------------------------------------------
Masami Hiramatsu (Google) (2):
      s390/fgraph: Fix to remove ftrace_test_recursion_trylock()
      s390/tracing: Define ftrace_get_symaddr() for s390

 arch/s390/include/asm/ftrace.h | 1 +
 arch/s390/kernel/ftrace.c      | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)
