Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125E463B98;
	Thu, 24 Sep 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267404; cv=none; b=ZYPT0q/7ih9L6PJIkhBYqB+w6vUdvwqdZfBdlDd4SMF+sL9tRi5eeLG1dRwsjYJq2UF4Vx4j1aQ7VRBpYulYC1Ir59iKNP/ds2Cy2W3638o5UvQy6GYgFvdzBFbuoNqSRDsV88xN1YsggTFA/OpXYPzRFo6rYW3j+rfvi9N1dEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267404; c=relaxed/simple;
	bh=t/kgKxNvzlA2F1VS8lICmvW5W8rdSwL5OoxIma+6HZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AAJEKtkNnxKxF/3vQ0Srnpq9Z2qebI134nohsUdC0CTSyw4mNhDB7q1bnojaiWRHL8Y8SS6r38ZmpHRfLfCH5FQiFoiobKVfwiHd6w6tps/BXC4S3SbyGjW3nOgAdv3x9zA925Bb6gMNYKc2XNYnUxLiFoSHdTmuiQIkQLg6EuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LpJiz8Ie; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LpJiz8Ie"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5vBv2538154;
	Thu, 24 Sep 2026 16:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:sender:subject:to; s=pp1; bh=C4ELuXh1D7CKRRwj8eZLF
	1wIEE1xOj1RLeIBC0siBv4=; b=LpJiz8IeBJVlYVuW9gMLjZBnLAaVevW8gPLxW
	3WddvJUtYpntmPwkCBDgb5aKWJcCUHBkPgwC1lJP/wQRet3gDzuOd7OEZQUKLNP4
	jGawXf1gkHrsgX05rWCZOMO1Imky9OyqBpuWDAYAAlbFS4m7feUW54t53teBOEEN
	XY2xoN7+qg2nyPWcvDT0lJbbZvp7m6BcgwjrKlb6TRAEvkmGQ2owjTgtB9JxypNc
	51PDwWbaj/9EJvdvKx/0CJRICqJwTgvTa8mOfKaYJsPsztrOjCnrtSJzV4FzkR76
	KOiljOPe64vlTl7keUAtV1fRDMTmwXgqywVpBMHzS7/gZjl6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1smc7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlbMg2307413;
	Thu, 24 Sep 2026 16:29:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2xjg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGTWGG31785710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:29:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10BDE2004D;
	Thu, 24 Sep 2026 16:29:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE8D520040;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9mKB-000000094DC-2qpN;
	Thu, 24 Sep 2026 18:29:31 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Benjamin Block <bebl@ategam.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-intel-xe <intel-xe@lists.freedesktop.org>,
        piotr.piorkowski@intel.com, Farhan Ali <alifm@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>, Guenter Roeck <linux@roeck-us.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ionut Nechita <sunlightlinux@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v15 0/5] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlocks
Date: Thu, 24 Sep 2026 18:29:26 +0200
Message-ID: <cover.1790267348.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-ORIG-GUID: 2rvEigGoucXQGU66MwSzE4D517dA-_1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX9hmYtEd+ttGH
 0MmCbHByQXcOPrJaPmCPVzHD9+O3J0TblP+Lp0KABCc6eVU1Rbbehy/o/uQtkqSh2+6qjqIItf4
 Z7em2+CjyYvbdbfiIVs6wne3QrSZJfbtBh8/LNWru2XMUCeqLIQik+yrfwLd+Efc3nN8sqAEdaG
 ggN3JhQxyjfh10mcO6fRuhTBXapX2MRgqhkWvszCnrNXUMPwFFjsYyJzmu64dhC43wf24lI4nOn
 +dYr4x44WBvDV66UP6phnTjOhW0c4UR/kNnV2pXDeLckHnTjfj34ofkHX7KZ9y2gLEk78/MEQJE
 1kxG8sz9oI/oans3FtYsnPbUxIdCYsxYSufE5bZzSBUQVwFWudygE3npCVjeQ9ZPo4rxN3jdruD
 cYXUjhJc+0Uspqp1/cle7WrAHy+jzm6A2r/o9droXGJHhK7EI9QfGhiPEjqGPFhy2p1iiosaIRF
 QP4FmZXb/mFgPjfgpww==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab54ff1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=yfx8I6Aa3K8YIESsMmEA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX6G3sjORkeyQ0
 enHiaWmCYl2CbiB4Vj1k1CUnIhFF0danVjY7w2NHuiY4pg8/9hfJFGBhuaMX5BO0zDZUnTgaR8A
 N3Iw/Yijdcfc0DjJxJ8KpDFyir+4a10=
X-Proofpoint-GUID: Dm6ZM7v9TOrnJSYL_KFOcQEOIevKrTBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

Hello Bjorn,

This is the continuation and combination of two patchsets from earlier
this year that try to fix races and various deadlocks involving the
global mutex `pci_rescan_remove_owner`:
https://lore.kernel.org/linux-pci/cover.1776839248.git.ionut.nechita%40windriver.com/ [v14]
https://lore.kernel.org/linux-pci/cover.1776868550.git.bblock%40linux.ibm.com/ [v4]

Since we couldn't make any progress since then I decided to rebase and combine
them, hoping this would "revitalize" the topic.

v14 -> v15:
    * Rebased the patchset on v7.3-rc4
    * Patch 1/5: changed type of `pci_rescan_remove_depth` to `size_t`
    * Patch 1/5: changed accesses of `pci_rescan_remove_owner` to use
      READ_ONCE() and/or WRITE_ONCE() since they might happen outside of
      the lock, and so might be subject to tearing or some such
    * Patch 1/5: added comments clarifying that access to
      `pci_rescan_remove_depth` is always protected by
      `pci_rescan_remove_lock`
    * Patch 1/5: since the only Reviewed-by was by myself on the last iteration
      I removed it
    * Patch 5/5: fixed a bug with the use of scoped_guard() in `switch`
      statements -> `break` doesn't work as it seems it should, because
      `scoped_guard()` is implemented as `for` statement
    * Patch 5/5: fixed a bug in recover_store() where it wouldn't reverse the
      call to sysfs_break_active_protection() in case of an early error-return
    * Patch 5/5: since I had to make these bug-fixes I removed Niklas'
      Reviewed-by

Overview:

Patch 1/5: Fixes a regression introduced by
           05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
           that moves the locking of `pci_rescan_remove_lock` to a higher
           level in the call-chain when enabling/disabling SR-IOV, but by
           doing so removed it entirely from the driver's .remove() call-back
           call-chain.
           To add the lock back into that call-chain and also prevent
           resulting recursive deadlocks make the lock reentrant via the
           existing functions
           pci_lock_rescan_remove()/pci_unlock_rescan_remove().
Patch 2/5: With the locking back in the .remove() call-back call-chain
           it is now possible to trigger an AB-BA deadlock between device
           driver unbinds and concurrent PCI device removes. Fix this by
           unbinding the device driver before starting PCI device
           removal (and locking `pci_rescan_remove_lock`).
Patch 3/5: In order to use annotations like __must_hold() or assertions
           like lockdep_assert_held() on `pci_rescan_remove_lock` in
           code outside the PCI core (such as PCI architecture
           implementations) move its declaration to the global linux/pci.h.
           This doesn't increase the "surface" from where it is possible
           to use the lock, since it is already possible today to grab
           the lock from said code with the functions
           pci_lock_rescan_remove()/pci_unlock_rescan_remove().
Patch 4/5: Provide a lock guard for `pci_rescan_remove_lock` so it is
           possible to be used in the linux/cleanup.h macros.
Patch 5/5: Fix several AB-BA deadlocks in the s390 PCI implementation
           involving `pci_rescan_remove_lock` by moving the lock to
           higher levels in the respective call-chains.

The race that is fixed in Patch 1/5 has been independently observed by
multiple organizations:
    * IBM (s390 platform-generated hot-unplug events racing with
      sriov_del_vfs during PF driver unload)
    * NVIDIA (tested by Dragos Tatulea in earlier versions)
    * Intel (xe driver hitting lockdep warnings and deadlocks when
      calling pci_disable_sriov from .remove)
    * Wind River (original reporter and patch author)

We have been running this patch series for several months internally
during our development on s390 since otherwise we would routinely "kill"
our development machines due to deadlocks. I'm not aware of issues with
it that were observed.

I've run a lot of tests with affected PCI adapters (some of which are
specific to the IBM Z platform):
    * enable/disable SR-IOV on the PF;
    * run FLR reset on PF and VF;
    * run Bus reset on PF and VF;
    * run s390's recover SysFS attribute on PF and VF;
    * remove/re-add PCI devices via the `remove` SysFS attribute;
    * unbind/re-bind PCI devices to the vfio-pci device driver;
    * disable/enable power with the hotplug SysFS attribute on PF and VF;
    * run `zpcictl` with `--reset`/`--reset-fw` on PF and VF (s390);
    * remove/re-add vfio modules with bound PCI devices;
    * run Configure Off and Configure On on both the PF and VF from a Service
      Element (s390).

There is no more deadlocks and no other lockdep warnings I've witnessed.

History:

PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock:
Link: https://lore.kernel.org/linux-pci/cover.1776839248.git.ionut.nechita%40windriver.com/ [v14]
Link: https://lore.kernel.org/linux-pci/cover.1776756380.git.ionut.nechita@windriver.com/ [v13]
Link: https://lore.kernel.org/linux-pci/cover.1776755661.git.ionut.nechita@windriver.com/ [v12]
Link: https://lore.kernel.org/linux-pci/20260326083534.23602-1-ionut.nechita@windriver.com/ [v11]
Link: https://lore.kernel.org/linux-pci/20260318210316.61975-1-ionut.nechita@windriver.com/ [v10]
Link: https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/ [v9]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/lkml/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]

PCI: s390/pci: Fix deadlocks on s390 when releasing zPCI-bus or -device objects:
Link: https://lore.kernel.org/linux-pci/cover.1776868550.git.bblock%40linux.ibm.com/ [v4]
Link: https://lore.kernel.org/linux-pci/cover.1776866921.git.bblock%40linux.ibm.com/ [v3]
Link: https://lore.kernel.org/linux-pci/cover.1773235561.git.bblock%40linux.ibm.com/ [v2]
Link: https://lore.kernel.org/linux-pci/cover.1772815642.git.bblock%40linux.ibm.com/ [v1]

Benjamin Block (3):
  PCI: Move declaration of pci_rescan_remove_lock into public pci.h
  PCI: Provide lock guard for pci_rescan_remove_lock
  s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device
    release

Ionut Nechita (2):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs
  PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
    in remove_store

 arch/s390/pci/pci.c       | 11 ++++++++---
 arch/s390/pci/pci_bus.c   | 15 ++++++++-------
 arch/s390/pci/pci_event.c | 28 ++++++++++++++++++----------
 arch/s390/pci/pci_iov.c   |  3 +--
 arch/s390/pci/pci_sysfs.c | 25 ++++++++++++-------------
 drivers/pci/iov.c         |  9 +++++----
 drivers/pci/pci-sysfs.c   | 30 +++++++++++++++++++++++++++++-
 drivers/pci/pci.h         |  2 --
 drivers/pci/probe.c       | 28 ++++++++++++++++++++++++++--
 include/linux/pci.h       |  5 +++++
 10 files changed, 112 insertions(+), 44 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

