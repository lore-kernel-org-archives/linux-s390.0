Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76433ED5B5;
	Wed, 22 Apr 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867743; cv=none; b=iOJ9FXMW8ksazCk5YTj/ogcm+7k5nPYXrydjuRC8kr6EsbqIo33XBXYz6ccVs2vB5+kKUKPDXoY04HmjzpW9f7CbHeZI03TTmuPdkFiqLVxyuGWMrsDl181/EygCsTR+O8Sh5akQw6lvHS/j6pYjPTnsAIJLIDjPpm8s06l4IUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867743; c=relaxed/simple;
	bh=3VMSyGTt5XCHxmwrz/FhdjLosMOx8ZpcBL2BtbgrnZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cn8CxBWANHZqy+60ZnGYgVrHNA5qd/+C541ZsAbbvvLoh1L0t5mCpqZljLdTqpjmcoZi81Cj/qvhHItQtH/pAmQ6DQpUJPa8ARFvU6lF89fik3PULvxbhfyI3e0wxC7rScxM6ESCuNNgxZNQ1vZvyz7nIEVWbrH0w7xGt/OTHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l68bLJEe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l68bLJEe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MDha9R1020894;
	Wed, 22 Apr 2026 14:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:sender:subject:to; s=pp1; bh=knfTnT4Sekc/DVGGOOX1j
	87CJkebV6cpruMJ9ZdrdFw=; b=l68bLJEejNBacdfXrPUudNPgaek9VRZRTSvVy
	BM2g4cYH0QTbcHL17BokKyE715gUqSNNtDbcnYXtkYb21PN7VFNDpT6L3vVqdfWf
	C/irjrpT87G1XKmSHvbWKgy0CuUrhspv9A53ZNUT33szJZO5WxYMG/s70UAAaOQf
	rdnwB4KYJYJU5rQh8W4KVl4X3j3RgjHNbFLVljmNeay2/hYZ9kBw5mGi7hPBZvjH
	6m2dBXXcDbySqMzb6k1L7XzGsKrp0BpB2ya1zc8trOJ3HZER+seml1tYqHLAqk25
	rSD+t8OKEXmpqU7CLE6HlioShvKic+OOj+1+7taYkawR+3b8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrbac6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63ME5J2W028014;
	Wed, 22 Apr 2026 14:22:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyaj32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEMEiR35586386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:22:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07AFE2004B;
	Wed, 22 Apr 2026 14:22:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E811E20043;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYSz-0000000FrWj-2ldh;
	Wed, 22 Apr 2026 16:22:13 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Gerd Bayer <gbayer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Heiko Carstens <hca@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v3 0/3] PCI: s390/pci: Fix deadlocks on s390 when releasing zPCI-bus or -device objects
Date: Wed, 22 Apr 2026 16:22:10 +0200
Message-ID: <cover.1776866921.git.bblock@linux.ibm.com>
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
X-Proofpoint-GUID: Lr812lb-u45ejc_q4r_kX8093OpzvZvP
X-Proofpoint-ORIG-GUID: SFI8Pbo-_rClvBeRDyQ72k-szT95Nzeg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX9sKas7Rm9OeD
 aWApXPWrJFmJFW9VTRSRPf1aQo6ow6S2L1GDwNM2CX2MSAH+KabgbUzj8CJitpvuIR+DdGXzTdY
 NkSmURzP1DXSMEHdQdmwcCvAIyzWFKpm4Oddrdjlj1eRlb0OqP2V2ODkLdQONxNUIUg6uCaHYwd
 15+s8E5sGbRSKHY4eoDT1BL0uLQoCg9LyanbfGDqtyzbbdDghjGOPtiXorRW+S5GdoqwI2BnGIF
 iSXx2gJ7+LHFkFtEcxPvyYiu6JIb8958BlL7IRO/xqNy7/6EM0FloBmx+yIB3vVfjZtl+xVMG8r
 yj337rsVxnxWAUIoysNUKiRPwd+DaJB3Jt3ga+5vN6xxuu5CkN0+VZi/Obb5lGV8Z5QC5KeA9PH
 j6MfeXJw6tRyoC6FXtag4AZ/24aZqT7dLz898m74cG4Mq17j8sPuBvzbUKKpyJEDQObCo3I2cx2
 riYM0FXYMy1jA/zaeBg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e8d99b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=JMDAtZ06FB4a80dcI5YA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220138

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

