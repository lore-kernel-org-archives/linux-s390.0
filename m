Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB23375CF;
	Fri, 20 Feb 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590823; cv=none; b=j4AQRvBeUC7ayH2ixINKkfZzbPi1wkWwfrOjDWfZNnQvE22MrRLrbb2Z8U5sdjS9vbiBgNNI037/ksu6oX3RTbY33kg9BPKWo1QlUpA244AhBYO9zYl59zB5w0UlC9IZPMvJOfCoWrWP3zJO+8CEVLSb1qch70K9E643+kv5UbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590823; c=relaxed/simple;
	bh=RjsVhALP2bqD2Xk5PYhwpIsl9m0Msz75G/T7voWwyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NuFg5QAG0n61BHlIT8gAM8Vbzn7kXZl1Wrf9PwoP8u8bIRL+752JIb/XhLUBl4s4zN/rm0+kt7aqv1EjUaNQfAW5YW+cKV5HwN+vClZCW0uJGou/q4FNyS8Q82FjJOm10mPZMjn49w2W3+sEov53/a5+ow0QduLq7gGDr23CfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=llXwUcv9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="llXwUcv9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLjU1Y1271274;
	Fri, 20 Feb 2026 12:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=CnOCGye257NB2R08hUoS3H1/3d7V
	ts82x7GG3HFSKeY=; b=llXwUcv9WwlprbqRDjPHLJPAYy10MAzv7KDCnD8sBOjA
	Yb9J2FKkj7LJPUTMD7pFIGzUzE4DmsRCIzTCGPR5YeY0TQYkqilZhg6r8DaN6Mbt
	uy55r1Gq6JjLOdeRJ6oECa4BbNWjzo58BGr3bruz1dWDeJwDGd+CZzT0PCSn4+rB
	9Pk02YkUl+NJmCR0eFexNBYcdT1ZauJAXw/z6FMTRgWAvc03jyr0utFRpXSqzMj8
	2MzwHwO6igk2MqtT9/YBdi6wiYfzwTT0QgJI7H9DBo6hNIU6PCs2hxCpCYS2Q8AC
	pWaPA2lhxs4pqoGvCDiI1b0jqJo6jh6aPor/6uTf1Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4ksfsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 12:33:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KA7bix030615;
	Fri, 20 Feb 2026 12:33:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45gcbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 12:33:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KCXZWc46530828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 12:33:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4819720076;
	Fri, 20 Feb 2026 12:33:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E149F20075;
	Fri, 20 Feb 2026 12:33:34 +0000 (GMT)
Received: from osiris (unknown [9.111.35.31])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Feb 2026 12:33:34 +0000 (GMT)
Date: Fri, 20 Feb 2026 13:33:33 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 7.0 merge window
Message-ID: <20260220123333.20950Aed-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEwNiBTYWx0ZWRfX14AJf7eAIXIh
 8OJdjCaO8PTvLv3zR7aD4um2iWFZ/D/s7BCl6ouu8GZJtOY78yY9RMv7Bebm3pFLGLWePV6WvkI
 yxAICMKSVmR3tf/oD8ZFf/v8MZQ8SgNg/yfFUz9V2zibsHUkto1t6Mu2uUH+Kg7wbUI6ID6Ii9X
 IX2a+aJh0uupD5oC/MkJVxGWzr96iWPFn9KJb8fFkTpEtQdeTBK/vsjTGQE5JYOF5UCuzOvxwrf
 qv9ZHVvkOygqq2NneGp3L23BPCHsd/H5tw93nEOo+QJueP7NXT+Y1JvBmW0ZeNzuUy1RG2aZjJV
 g+VXOSBPIK9onUelg4/7wU8l2hjnc1Xh2ILltyx3A4ctWOjxxlw9uBffaDJsxN52/PXTYJiZ+Yv
 X3XUNOCEdxGdLi5fVu23HWlVwO5C+DTC2qZHkxs478VufVZ+8FpDzZCCU9jeq2ROnSlJgmKg6GQ
 NR9vAL7Th6l2FupvlZg==
X-Proofpoint-ORIG-GUID: iqUqrRrOepRCSfEy_6sQ75CoUL-pL0VW
X-Proofpoint-GUID: iqUqrRrOepRCSfEy_6sQ75CoUL-pL0VW
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=699854a3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=8gtF-JmJ9gvJfZN1qHAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200106

Hi Linus,

please pull some s390 fixes for the 7.0 merge window.

Thanks,
Heiko

The following changes since commit ff661eeee26038f15ed9dd33c91809632e11d9eb:

  Merge tag 'cgroup-for-6.20' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2026-02-11 13:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-2

for you to fetch changes up to 123d2e75a14e8a21cecac3f3452221ba901f8111:

  s390/tape: Fix device driver name (2026-02-19 15:28:00 +0100)

----------------------------------------------------------------
s390 fixes for 7.0 merge window

- Make KEXEC_SIG available again for CONFIG_MODULES=n

- The s390 topology code used to call rebuild_sched_domains() before common
  code scheduling domains were setup. This was silently ignored by common
  code, but now results in a warning. Address by avoiding the early call

- Convert debug area lock from spinlock to raw spinlock to address lockdep
  warnings

- The recent 3490 tape device driver rework resulted in a different device
  driver name, which is visible via sysfs for user space. This breaks at
  least one user space application. Change the device driver name back to
  its old name to fix this

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n

Benjamin Block (1):
      s390/debug: Convert debug area lock from a spinlock to a raw spinlock

Heiko Carstens (1):
      s390/smp: Avoid calling rebuild_sched_domains() early

Jan Höppner (1):
      s390/tape: Fix device driver name

 arch/s390/Kconfig             |  3 ++-
 arch/s390/include/asm/debug.h |  4 +--
 arch/s390/kernel/debug.c      | 60 +++++++++++++++++++++----------------------
 arch/s390/kernel/smp.c        |  2 +-
 drivers/s390/char/tape_3490.c |  2 +-
 5 files changed, 36 insertions(+), 35 deletions(-)
