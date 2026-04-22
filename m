Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160143ED5D0;
	Wed, 22 Apr 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868672; cv=none; b=Wc4iGUqEtMyXh7qCtbkmMLfA42tSYVJe+84v+jyOZ6dkxcgGdWNDWYhtWC1sJWVzkHkefFpkUhou8hD5CMLrCG9zK0WjEP2HdZ8dpjw7DjvvvudKwMXVO8MchEpb1pDzwerPWnm+2ucjnkINwkFQO+LkKy9vq1QFmLkUIVJDlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868672; c=relaxed/simple;
	bh=33EgQN26Xxd5Ks7c/ykIJAyHUAsg8qpeDluPXSuJIvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IrY8xtsAVzKGDxAXdY4tZLGNnn8SGlB7xrn4ddNM3S7osoU8YB4ZkvCU2f55DVfn5o48CPgALret81HR27sEcKUobZeCniPea5exB0QRLbx9ihv99jPIJQXXFB6PRZ/AwvxbReLWGwwGR0Zvc99FP/S2V76O0PYoyfK5CRcjpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ggOgOW7w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ggOgOW7w"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M9TIOu679442;
	Wed, 22 Apr 2026 14:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:sender:subject:to; s=pp1; bh=vCCYrAPwjC/qINFXdV4HT
	YLirNcNvgax6KGkH1qZofE=; b=ggOgOW7wQoRhgBerwn2GndueQdhAPsPAFMLsG
	gHisGbGoNcmkFkzFf+QVh/Xs1y1PVbX+hxFQ7rAA/MNB0ZUnPyogv6ECSfZeUeWc
	ahdFLQ0MX+9sAUWtQ3cnyv+HU6ota8Nxy1wWpaWCIQe30cyHWRZ649qsrhuNBhsK
	byAUOopLhF4ouSmcYZyJ08oBgRZtcUhgfr3NiB8QBdogjdSgas6fq14wMw7Cq7xj
	BMQjN/ps3sXB4UL3Qnor498k2VPsWqK0lp6Qk26tGHRSCen37qvJcUY0EkPPEC86
	AG/FThRBFGkOrx1uLPSeOeSbk0wcYJTZRezDfk+5sYJfNkHDg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7kpwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:37:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEZHt3004189;
	Wed, 22 Apr 2026 14:37:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky2m48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:37:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEbjr450266586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:37:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0252620049;
	Wed, 22 Apr 2026 14:37:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E265B20040;
	Wed, 22 Apr 2026 14:37:44 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:37:44 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYi0-0000000G4RU-2nmO;
	Wed, 22 Apr 2026 16:37:44 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v4 0/3] PCI: s390/pci: Fix deadlocks on s390 when releasing zPCI-bus or -device objects
Date: Wed, 22 Apr 2026 16:37:41 +0200
Message-ID: <cover.1776868550.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-ORIG-GUID: OpDXUWlHl5XYubkYNzAvSJK_TyBoZeKs
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69e8dd3d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=JMDAtZ06FB4a80dcI5YA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3LGuYnMTa5byWmypE0IEziIk77MXlAIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX5ZqhrIhAr5S3
 Q5I0TX/rm1LVNUv/QEYv94UF2Y+MszJtzkWbzCyy64mKJPKCzHXgXPC3SsRKl52TzThm8PzKkFa
 Ov0WT0i6MixKD8WFaWokqTQJkU4hPgGbK3TVidpxbM9DYa5WSmO5cXlKXaJ3mX1oivQswOKr3VY
 0yHubxGyxf2gAnD8hwBgzTwGEqEEC9JU4ePHIv17aOx44a2vq0s1hr6B2ooXMdxWwheqC4J1MT3
 vuMuuDZtenJxre7fsEQm5v5JljdccZ+ghhI1KKlJ2pjUZxXy9y57gKsDwl6RW+a/HH0MT2lfuTz
 44aWATgZAkjgpXzqtn4m+ku3bA2OBg0phKlKuyg14TcLJyLKqY1uC4n9tAOTxjPuyBtaHWPlkJj
 MLLtvsdcxA/KMo+ZS0fDo7Vabdje91mfTwyEFeRJguSbaVgiu0xBw2wM7tR8Zk1VsLXXn545EmW
 XNo4UlMaDQdaMx3CnHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220138

v3 -> v4:
    * remove internal tracking ID from patch 03
v2 -> v3:
    * added Reviewed-by and Tested-by from Niklas
    * base series on current version of Ionut's patch series
      "PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock"
      https://lore.kernel.org/linux-pci/cover.1776839248.git.ionut.nechita%40windriver.com/T/#
      to prevent small merge-conflict in patch 01
    * adapted description of patch 03 so it reflects the point that the series
      is now based on Ionut's patch series, and certain deadlocks can't happen
      anymore (recursive), but others still can (the AB-BA cyclic variants)
v1 -> v2:
    * combine patch 02 and 04 - fix and use of guards [Ilpo, Niklas]
    * rephrase description of patch 01 to point out that it is already possible
      today to lock/unlock `pci_rescan_remove_lock` anywhere
    * added Fixes: tags to patch 03 - the fix

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
being visible in the same instance. This left us with some blind spots w.r.t.
the locking issues here.
    This is now changing, and with that we started running into these
deadlocks.

Please Note:
    This patchset strictly depends on Ionut Nechita's patch that makes
    `pci_lock_rescan_remove()` reentrant:
    https://lore.kernel.org/linux-pci/cover.1776839248.git.ionut.nechita%40windriver.com/T/#

    Since the discussion so far sounded positive towards the change I decided
    to base some of the changes in this patchset on the assumption that his
    patch gets merged before mine. Otherwise there will be recursive deadlocks.

Patch 01 helps us insofar it enables us to use lockdep annotations in the
         architecture code.
Patch 02 makes it possible to use lock guards for `pci_rescan_remove_lock`.
Patch 03 goes into detail what deadlocks exactly exist today, and fixes them.

I've run a /lot/ of tests with affected PCI adapters:
    * enable/disable SR-IOV on the PF;
    * run FLR reset on PF and VF;
    * run Bus reset on PF and VF;
    * run s390's recover SysFS attribute on PF and VF;
    * remove/re-add PCI devices via the `remove` SysFS attribute;
    * unbind/re-bind PCI devices to the vfio-pci device driver;
    * disable/enable power with the hotplug SysFS attribute on PF and VF;
    * run `zpcictl` with `--reset`/`--reset-fw` on PF and VF;
    * remove/re-add vfio modules with bound PCI devices;
    * run Configure Off and Configure On on both the PF and VF from a Service
      Element.

There is no more deadlocks and no other lockdep warnings I've witnessed.

Benjamin Block (3):
  PCI: Move declaration of pci_rescan_remove_lock into public pci.h
  PCI: Provide lock guard for pci_rescan_remove_lock
  s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device
    release

 arch/s390/pci/pci.c       | 11 ++++++++---
 arch/s390/pci/pci_bus.c   | 15 ++++++++-------
 arch/s390/pci/pci_event.c | 28 +++++++++++++++++++---------
 arch/s390/pci/pci_iov.c   |  3 +--
 arch/s390/pci/pci_sysfs.c |  9 +++------
 drivers/pci/pci.h         |  2 --
 drivers/pci/probe.c       |  1 +
 include/linux/pci.h       |  5 +++++
 8 files changed, 45 insertions(+), 29 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
prerequisite-patch-id: 04db39c9d883c6d06c9b2400fc445c62177f1c5b
prerequisite-patch-id: 68e07de292969a95b72a26153893281558c3eb0d
-- 
2.54.0

