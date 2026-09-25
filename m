Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5347884D;
	Fri, 25 Sep 2026 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336285; cv=none; b=lPbT912ugCRCAJX7gTcb+TR/iqvgQJJBzHou7kaFh5nuIKfSizeESmvfEJRbPhzl0nh6LNxNdsPUH1aVkGiBgfrY5b1GfSTP+gX7O6NFpKLuOj8Zce/+zKK2rpkBUhfIdCbfgziYIkktW1q9RZX8Vy53wIh98vg/574pQRRt1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336285; c=relaxed/simple;
	bh=SgEJM7Rpcl/YHpOtbQVaiw01leZ0qS0pmckOsgvMIns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HM/jmv+Ld9B41gav89jsAdff33ZWyq132Hnahqy8C3Fy7OFM9f50P4cwswCApPyov4bYeHJ7buBRmWEFjwgP6ihQiVMwtz6tOfSqePzsW5l5I2Ozyew3rEBqFglNkRqSrPu/jJ3O0n1RCyvxH01iJq2mT4ptnjUXoMkdaYRl9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JOK5vUuO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JOK5vUuO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a8nY3083607;
	Fri, 25 Sep 2026 11:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=qgGbYR9rcdDGRmN0LRkPW1ak0KyPeAc2I5WPHXzZtR0=; b=JOK5vUuO
	nVeaZwsZbPYLsilpd2bg7Z4wd1dJGljKMItcaPGZfBJN5prImMNGFBJfj8yIM0oz
	kQUELGoxPNEJwq4Gq4vzeiziPracoUzb7SOhMzVuiN4+PsXl2SlR4uAdhUGO+pJC
	9VrIQG7DpP8zkyiQARBqRrqMMGf/tLX8rBdlEPgGWu0A0aWAWtz5RWOD9mgg1tYS
	kLa+/mb4IrRzOKqBCnztNlX9KuzVzyRwPdeGLpM5hYc1RG9g0HOCygs5UBRRvVkJ
	HOmOLm60lpSU1QI+20pqwfsDDpOlrkrZSPC3v/Qu/U9UHwqfXdshfwDsLGifCzna
	Wa7pTMKEw3yGSw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqwrkb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:38:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA4pe23297092;
	Fri, 25 Sep 2026 11:38:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qt8ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:38:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PBbvNK45613510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 11:37:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DCBE20040;
	Fri, 25 Sep 2026 11:37:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D71BE20043;
	Fri, 25 Sep 2026 11:37:56 +0000 (GMT)
Received: from osiris (unknown [9.111.31.68])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 11:37:56 +0000 (GMT)
Date: Fri, 25 Sep 2026 13:37:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 7.3-rc5
Message-ID: <20260925113755.23528Bd0-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab65d19 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=uZmPj79w9o0VtV-uL_MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NiBTYWx0ZWRfX7Tfr+vfZLTJT
 d+r6qj/lyTl+uyzslz2+/jzQ6UhJJ55gsqSnCGN3LNiAmdoxTI6nAyZjVbfxZRxlzpccVJpvfM/
 vl3AfpO2cLo6VteUZjVhamoNmhBDrVIiIL6fdgXjvG4Vu95hx4Eo/87zbYeY9qNzPjqK6fl/dVE
 n+j9o05VRpIFioeZG8BbNpTjSwFq5p1ORPgmcxY90dcg9tEw9Diy1J78iO6dPWiw4SlJAQjpd9V
 Cp5MFLTK/h6ceZGr8GIrnwgwlq5AnPxEwlz7ZeRj8rY5/huEayU9bIyp2wqA7eBigFVCj6qJGmM
 lWsHdu4nQpCNXtxbTFjrjYyFxN83Cg3FTmvcnbzXm8CVSfgGH+/cTo9+cdwuFBSrTwKHIeZffDC
 9zotilwJZ572zM8hRhv8AmgFkwoefbmQeGWMeUfbPr5uc62gZgIVZgc48rhXo+9pU4lrVsMYZH3
 sP9yTXHRSviOEdm5DBA==
X-Proofpoint-ORIG-GUID: _sY6eahOHCCJfBouyEa7pLDuAI5gDDED
X-Proofpoint-GUID: _sY6eahOHCCJfBouyEa7pLDuAI5gDDED
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NiBTYWx0ZWRfX4COIy76PJxZu
 ZmyLDCnvknTOE3sOixz0Vu4ylqeZ66vMIRslysQ6OP2RegkaBanzMQFCHiDFB5yybPY+6ZRqu27
 M3Jju/AjrRk12mCla6X2iJFpiIw+Ras=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250046

Hi Linus,

please pull s390 fixes for 7.3-rc5.

Note, I've seen your reply to Jakub, and admittedly not all commits here
are really important too, but I didn't want to remove them and rebase in
order to keep the branch and commit ids stable; but your message was
received.

Thanks,
Heiko

The following changes since commit dc2136341be9835e70ba7c6b36904cf3683fd029:

  s390/crypto: Enable CONTEXT_ANALYSIS (2026-09-08 15:53:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-4

for you to fetch changes up to 5b76268dac968612f7283d59b539036de955b7d9:

  s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str() (2026-09-23 16:43:32 +0200)

----------------------------------------------------------------
s390 fixes for 7.3-rc5

- Fix several bugs in PCI error recovery SCLP reporting: don't report
  success on skipped recovery, report errors when no pdev is associated,
  add missing device lock, and fix struct pci_dev reference leak in
  zpci_report_status()

- Fix several bugs in CIO code: fix use of invalid SCHIB data, guard PMCW
  field accesses, check device number valid bit in PMWC before accessing
  other fields, and fix NULL pointer dereference in
  ccw_device_get_util_str()

- Fix virtual vs physical address confusion in channel measurement
  facility code on kernels with CONFIG_RANDOMIZE_IDENTITY_BASE=y

- Fix couple of bugs in s390dbf: fix copy of failed static debug areas,
  skip view registration on failure, and reject NULL pointer in
  debug_dump()

- Fix sriov_numvfs attribute name in zPCI documentation

- Fix typos in comments

----------------------------------------------------------------
Hemanth Selam (1):
      s390: Fix typos in comments

Karl Mehltretter (1):
      s390/pci/docs: Fix sriov_numvfs attribute name

Mikhail Zaslonko (3):
      s390/debug: Reject NULL debug info in debug_dump()
      s390/debug: Do not register views for failed static debug areas
      s390/debug: Fix NULL pointer dereference in debug_info_copy()

Niklas Schnelle (4):
      s390/pci: Fix leak of struct pci_dev reference in zpci_report_status()
      s390/pci: Fix missing device lock in zpci_report_status()
      s390/pci: Report SCLP status on error events when no pdev is associated
      s390/pci: Don't report recovery success on skipped recovery

Peter Oberparleiter (1):
      s390/cmf: Fix virtual vs physical address confusion

Vineeth Vijayan (4):
      s390/cio: Fix cio_update_schib() to not cache invalid schib
      s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
      s390/cio: Guard PMCW field accesses with dnv check
      s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str()

 Documentation/arch/s390/pci.rst    |  2 +-
 arch/s390/include/asm/debug.h      |  8 ++++++--
 arch/s390/kernel/debug.c           | 18 ++++++++++++++----
 arch/s390/pci/pci_event.c          |  7 +++++--
 arch/s390/pci/pci_report.c         | 32 ++++++++++++++++++++------------
 arch/s390/pci/pci_report.h         |  4 +++-
 drivers/s390/block/dasd_3990_erp.c |  6 +++---
 drivers/s390/block/dasd_eckd.c     |  4 ++--
 drivers/s390/char/raw3270.c        |  2 +-
 drivers/s390/char/vmlogrdr.c       |  2 +-
 drivers/s390/cio/chp.c             |  3 +++
 drivers/s390/cio/cio.c             | 11 +++++++----
 drivers/s390/cio/cio.h             |  5 +++--
 drivers/s390/cio/cmf.c             |  2 +-
 drivers/s390/cio/device.c          |  9 +++++----
 drivers/s390/cio/device_fsm.c      |  3 +++
 drivers/s390/cio/device_ops.c      | 23 +++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_fsm.c    |  2 +-
 18 files changed, 102 insertions(+), 41 deletions(-)
