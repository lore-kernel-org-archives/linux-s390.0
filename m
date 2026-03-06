Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AA411610;
	Fri,  6 Mar 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815764; cv=none; b=GFB0qSsbPG0hAByUGPR5/tEWr3mFjyQxRnkRx1vJj/B07Lyg7/R7HBapYgb8ny36ZG6517nw5FP0KU1wU8kFYwRO4qXJvFaiil21ajd4ZNJiLiyJXWV2tBGcQJbrKS3HzekPqXcJ7qhUbkJGrwTb50e/tg2GNl1YUeGeUqBSNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815764; c=relaxed/simple;
	bh=wVpBn1KtXljwo64NYNj/CEx9OQFXjlLJOc83emEoWkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qx21ikhjiHCgwq8/wK/41vu5/e2+2r20USWj3hFAnn6VtIzrEvqDNgurj8P7DSKnBj0AhekWQxEgc6gNYDMKjun3XobZJn9Fn2F0ue0dVpyFV01ncnjBZSjc8wIB5xDFZXyoj7F5hsuiZc8VZFK6ABXJr45saRp03ooF2+LKj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ez5Xkq/g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ez5Xkq/g"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Bjm6p2804450;
	Fri, 6 Mar 2026 16:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:sender:subject:to; s=pp1; bh=PJhvCtnEX5yJ3ngTJW9Y6
	rDDl3M6sykTPZkpzoafMh4=; b=Ez5Xkq/gvDTEnGFw8TNYY58SjqSLsj9gBHdit
	GM58goIZ5zVtMph+03aOuyppXwwUW8KgE+lGPMKjofwPvG3JlMWOZiFQRGGTtiJk
	dsFacAkQnt+JL2yZCZvWhgaLdMFC5rT1+yosne0SIfN8+pbpFG4BrB/LBk6B8bAD
	SH1GG/qoN9eIYrOMHO7w61//lchWy5wZEEnmUfhf6Y4Uv95MDzeTveKOL+FWT1Ol
	wT1U4wwPRRsWYF9ORO0ErAchRRGhs//yUnDanmg59sjenk52hUr3muK5nZ986lVY
	fYHIruV4o/OywO6vGxrw7OVZXbFllSy4VHZuMs3jl50P2XG+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd9h9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626ERFuE027658;
	Fri, 6 Mar 2026 16:49:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjrdv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GnHA244433702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:49:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 597DB2004D;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450992004B;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vyYMW-00000005i32-45AQ;
	Fri, 06 Mar 2026 17:49:16 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 0/4] PCI: s390/pci: Fix deadlocks on s390 when releasing zPCI-bus or -device objects
Date: Fri,  6 Mar 2026 17:49:12 +0100
Message-ID: <cover.1772815642.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: IBM Deutschland Research & Development GmbH,    https://www.ibm.com/privacy, Vors. Aufs.-R.: Wolfgang Wendt,    =?unknown-8bit?q?Gesch=C3=A4ftsf=C3=BChrung=3A?= David Faller. Sitz der Ges.: Ehningen,    Registergericht: AmtsG Stuttgart, HRB 243294
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: q6IRAdM3moCqHWnWBZBqLCGcUpRZ5aQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1OCBTYWx0ZWRfX0t0fBkAn0t+L
 ufaEuIkghYQfAUjClDEfMC0HbV97swMeRs/ZrmFXmFvjWeZVMoKIWY4fegboKn3xB/eaxc/igjO
 ycq/ztyFta2I0ZXlwQW/S5LnFXM5QTgweF5qM/Ijjd4r3HUXDHyr+KSWz81hQlWaNUOOu3P+qYV
 PzFGbPNByDALJZc1bjChfk3hf73wFGoILvfQal5TAU6/Io5Rx3Zvfki2mGP18Bw2dpiGmh9Dfjj
 fiRH5l2u11DMrm8ug+ONhakNQaaanH8XxgQXtW8sXA2SQqY3k954vSemUMaHwAfLmozh8C0AbIf
 UBCZk4GoD3B7+2/zV57HvPgWyMc5ybmvarAA7iY7Aergkpq+HcfpyIcrZ537lPe8px2dnloGdKl
 GIFA6LF8d2Yn9cLojX4ZwrCnHyi7q0Kep8QcvwKVTiHtlhrwlqyvIBpjsX31N7crs/TU/2nQrG+
 rVSHKmpeu2YyVf4ghRQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69ab0592 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=4syw67VsA1-2dhGIdQYA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: lAocdsuGgqoxvC0lt-GA92aA26EkhXU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060158

Niklas already mentioned it in his recent comments on discussions about
`pci_rescan_remove_lock` here
https://lore.kernel.org/linux-pci/286d0488aa72b1741f93f900fd5db5c4334a6f50.camel@linux.ibm.com/
and here
https://lore.kernel.org/linux-pci/2b6a844619892ecaa11031705808667e0886d8b2.camel@linux.ibm.com/
; we recently found a couple of deadlocks in the s390 architecture PCI
implementation with hotplug events on our platform.

So far these have not been observed because on s390 it was not usual to have
both PF and attached VFs in the same Linux instance. So far PCI devices have
largely been either available as PF without SR-IOV, or as VF without the PF
being visible in the same instance. This left us with some blindspots w.r.t.
the locking issues here.
    This is now changing, and with that we started running into these
deadlocks.

Please Note: this patchset strictly depends on Ionut Nechita's patch that makes
             `pci_lock_rescan_remove()` reentrant:
             https://lore.kernel.org/linux-pci/20260306082108.17322-2-ionut.nechita@windriver.com/

	     Sicne the discussion so far sounded positive towards the change I
	     decided to base some of the changes in this patchset on the
	     assumption that his patch gets merged before mine. Otherwise
	     there will be rescursive deadlocks.

Patch 01 helps us insofar it enables us to use lockdep annotations in the
architecture code.
Patch 02 goes into detail what deadlocks exactly, and how they are fixed.
Patch 03 and 04 make it possible to use lock guards for
`pci_rescan_remove_lock` and make use of them in the s390 architecture PCI
implementation.

I've run a /lot/ of tests with affected PCI adapters:
  * enable/disable SR-IOV on the PF;
  * run FLR reset on PF and VF;
  * run Bus reset on PF and VF;
  * run s390's recover SysFS attribute on PF and VF;
  * disable/enable power with the hotplug SysFS attribute on PF and VF;
  * run `zpcictl` with `--reset`/`--reset-fw` on PF and VF;
  * run Configure Off and Configure On on both the PF and VF from a Service
    Element.

There is no more deadlocks and no other lockdep warnings I've witnessed.

Benjamin Block (4):
  PCI: Move declaration of pci_rescan_remove_lock into public pci.h
  s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device
    release
  PCI: Provide lock guard for pci_rescan_remove_lock
  s390/pci: Use lock guard for pci_rescan_remove_lock

 arch/s390/pci/pci.c       | 11 ++++++++---
 arch/s390/pci/pci_bus.c   | 15 ++++++++-------
 arch/s390/pci/pci_event.c | 28 +++++++++++++++++++---------
 arch/s390/pci/pci_iov.c   |  3 +--
 arch/s390/pci/pci_sysfs.c |  9 +++------
 drivers/pci/pci.h         |  2 --
 drivers/pci/probe.c       |  1 +
 include/linux/pci.h       |  5 +++++
 8 files changed, 45 insertions(+), 29 deletions(-)


base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
-- 
2.53.0

