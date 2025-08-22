Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12E2FAC05;
	Fri, 22 Aug 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866178; cv=none; b=JXmhsGUSRv0tbCywgihDnRkYiy8vjLLJY53g09NcOdL0r8Bd+sQ6RsnTKB3VtPbjtqW9tx8hRPaj8tu5TgKnAdChq342JDEEB7DAy7FEKzfMGRfWV/5HSXvC8Ll98T85OmHSc3l5M2Rl5VitrfsRkB5Z30bbBv/L6CvKsVpIhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866178; c=relaxed/simple;
	bh=2Pcen3q4foG/eRUKPISujfcNjIjScKd45S56kiA20oc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L2VWaroWe95Zf5QKzMCsVSW8GomjkoXDXqV9p6YNycHiSiE4Gk+AR/PEY+BSTu6avwLFlj9xr2Q2RVMw/RQawvP8K9UUFn1puYb0YJ4ztpoOytPlF79bAH45jbFjtMVH283APO0qnkSkfLTvpE/In4vPBqTJBmFhiyoVylXLbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mw64tLfn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mw64tLfn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7wc2Z017900;
	Fri, 22 Aug 2025 12:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=VqYJdzYdyS6foVhsU/DoXgnLdWVkJv9bPd1pUCDC2Dw=; b=Mw64tLfn
	DK9Jb+81HkV0+fm1epmtGO8nEOYaRdn8+6bk46NrLSD1L58VLRbgikoc2zx4Pfol
	ycPjLG4RF8hpRoEBJBW8XYBxFygAltBp3dAnHjkVUBPA1u4S+gIis9vufzMVlCUb
	GQDx5T2i8VnI0XEBl/tJ3SwNfbCRI5CULR+2Ac8wGSpIW0VCKGg8oOu4SMHu6lww
	Hb/lT6KIpdwk7S+SXWl9A//FCELp8fEP8UP7xok++/wA7F8DklNc9jY0Aw+4D2WQ
	qNkTagEXWDWxRRFor5hZHfU4TAJPTMPKpDd9PqCcOGJSDRc2pBurfQVePVM8hzDj
	JmBa/uCU5eJv1w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vxeff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:36:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8gIek016030;
	Fri, 22 Aug 2025 12:36:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42d93h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:36:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MCaA4t16777498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 12:36:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BCB920043;
	Fri, 22 Aug 2025 12:36:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 204D220040;
	Fri, 22 Aug 2025 12:36:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 22 Aug 2025 12:36:10 +0000 (GMT)
Date: Fri, 22 Aug 2025 14:36:08 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.17-rc3
Message-ID: <20250822123608.142112A72-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ABcUcuYgFeLH5SRvBDzyqTIe2YtbTaUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX6UQ0oOLWMBkK
 kKrqn8wF1B5VTNkb3Rf2BUgyR629ArHxrwdqY0LroqilrrEFucaETnoH+BrvTxM+FZyK6guhQws
 45ik64SYVQvA3J9TJ3eoWJZLVLNog2EPpUIe7KA9ACDO5jDq9u/yF7RlVpJ1yVeqk2Mo9gDOxBY
 BJDrMfyDzyznG3X2YMK6Ltl4b8wGVUA4/OyRE/26/o1vBsDeSGQsJzP5mFtumg5dJeE7pEUgmqj
 kLka9bKzhUaJyRPZhlihg8X6JnBb69Rh2e8yqfo1ZyER9L2yK30DjJynh5eT1Kx2jdxkNsj2Psz
 W+7BsQwYxHlGjItBbx0CrPWsKg5dmSvdQVBJGQQ9yg1wi3l3xP3tcHy1ZMOpaaDRCfhYFhxgD+T
 76fCLe8w86KSyQ8sjlmcSk6nzmQorw==
X-Proofpoint-GUID: ABcUcuYgFeLH5SRvBDzyqTIe2YtbTaUe
X-Authority-Analysis: v=2.4 cv=KPwDzFFo c=1 sm=1 tr=0 ts=68a8643f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=zGN_lDc1xwhrvwUN7M0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Hi Linus,

please pull s390 fixes for 6.17-rc3.

Thanks,
Alexander

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-3

for you to fetch changes up to 3868f910440c47cd5d158776be4ba4e2186beda7:

  s390/hypfs: Enable limited access during lockdown (2025-08-21 17:46:14 +0200)

----------------------------------------------------------------
s390 fixes for 6.17-rc3

- When kernel lockdown is active userspace tools that rely on read
  operations only are unnecessarily blocked. Fix that by avoiding
  ioctl registration during lockdown

- Invalid NULL pointer accesses succeed due to the lowcore is always
  mapped the identity mapping pinned to zero. To fix that never map
  the first two pages of physical memory with identity mapping

- Fix invalid SCCB present check in the SCLP interrupt handler

- Update defconfigs

----------------------------------------------------------------
Heiko Carstens (3):
      s390/configs: Update defconfigs
      s390/configs: Set HZ=1000
      s390/mm: Do not map lowcore with identity mapping

Peter Oberparleiter (3):
      s390/sclp: Fix SCCB present check
      s390/hypfs: Avoid unnecessary ioctl registration in debugfs
      s390/hypfs: Enable limited access during lockdown

 arch/s390/boot/vmem.c                |  3 +++
 arch/s390/configs/debug_defconfig    | 33 ++++++++++++++++-----------------
 arch/s390/configs/defconfig          | 34 +++++++++++++++-------------------
 arch/s390/configs/zfcpdump_defconfig |  3 ++-
 arch/s390/hypfs/hypfs_dbfs.c         | 19 ++++++++++++-------
 drivers/s390/char/sclp.c             | 11 +++++++++--
 6 files changed, 57 insertions(+), 46 deletions(-)
