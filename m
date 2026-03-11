Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B926286413;
	Wed, 11 Mar 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235678; cv=none; b=tl5xJ3y5u2AaSJkqcdhnZNhmRp+Z+ju5LNE6ExfnfNJCmGaO4AlOsoSEkqCaitV0A1MzSEcSFZKp/4dKjZL9CtVodAtcUpwT4GEqsWHjqbnUnm1Bs3AhXSFOa86l+XlOfSqq/4aUyumlrn63mGi4nQ9mF/thc6cckzT+c8hGcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235678; c=relaxed/simple;
	bh=6NxmqlUfm+UNg4WwvV00EBR5jJPdfhn2Clgy3/mcJfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mgNCdrghk4VKsY390MfPIjebynfpozZ+HhFxwWwsESnbEd3rJqNqKESLkIZHPzfqZ2qwRyCWtoLwZINCA65UJ3dudFOQctxpMWNh/p3m+dxQzuYpJQHzPgSuY99Ijv9FW0BKte5tosc2BV52fhl1w7GNViaPn9oT8g3S5BLbgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLmaQOPQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLmaQOPQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AMaYDp1554633;
	Wed, 11 Mar 2026 13:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:sender:subject:to; s=pp1; bh=Cb/4Td+JSRqMPsZ0d7aGW
	26j7JgyQHw/RXoTafA2lhc=; b=kLmaQOPQ1r8UhU3WXDKMHK/jjBvoR6jKjWKNF
	R+MY2k88xGw/gHTGX/Toug30CSThyJwkDAAliRnULzeM6+5jF8M8/d4/QZvCq+dE
	dH6n/EhXnWVwtm4LuFZzPx1A46vGXmXOyZpOJKjU/GcYlMppnTCW/0e4mFnzEZ0b
	tbEROsOQ/DlWW61pLcAfBj2zPHF0gqSk8E8FkzDcyDjKZZR60ZbNNZVexC33RhSv
	afcn/zV5Rfla1uS9N1lOw5kAbvrval7UIBs+szs14utgeRFX/M9NaSkt5Jw4Tz38
	34dsKGPuAjqfIm0mucOxUU70f8lZXrSZMofCjp+ocySPnhq3A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mqgph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BC1Uao023013;
	Wed, 11 Mar 2026 13:27:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng6hrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDRp4B50069798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:27:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041D320043;
	Wed, 11 Mar 2026 13:27:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E493E20040;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w0JbK-00000008V4P-2fS9;
	Wed, 11 Mar 2026 14:27:50 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 0/3] PCI: s390/pci: Fix deadlocks on s390 when releasing zPCI-bus or -device objects
Date: Wed, 11 Mar 2026 14:27:47 +0100
Message-ID: <cover.1773235561.git.bblock@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b16ddc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=JMDAtZ06FB4a80dcI5YA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfXxvlL2b4mfW/C
 d6geh0VyB41TbiTY8nsk9kKeQxWb65xr+0WyR/pK/IrIV+R37PUlSVhk13/H0FYVVTvmTqDU+XM
 StltjmJ58V5h+jf8XxuWYCa6t0F9MzMJvIQ82dsL1Kipmta3SPE1Vt7A75TIDGkzFfhnj2yZgWf
 LhBcpp9o4eWG/h574JRi/i01Gwo5Z/pzX5w83B5T8ANfCOVGopiWMMJrmYqdO39Yw1om4doHaSg
 FJi/IzsO7UprjPy1y6Hz6MzQAXf6IsrKp2mBjcdCL+RkZbDBFGwaQugBky7EI+IMr4JdXDs9kyV
 mzpUGUq6nDTb/arfFiGkE399bCM68Y71K9n/pe7oBPH+Vl+UDZeqOv0UbkRQRYubvXvZ22V3h6x
 yc8ex2nZ+o88PKA5SFfZnIYKlp95ICXTOakK66bjLHV15uszPvIFUFN0jtsQqzXZOHwhCNrMVhv
 zf7WnRmu4o85Xa1nh6A==
X-Proofpoint-GUID: VOom4uZTh8ElUAODU5dvj4tkn20q5WT1
X-Proofpoint-ORIG-GUID: MmzDM71byiYMDkgpg3S1Y3kWOuXMZVSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110110

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
    https://lore.kernel.org/linux-pci/20260310074303.17480-2-ionut.nechita@windriver.com/

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
    * disable/enable power with the hotplug SysFS attribute on PF and VF;
    * run `zpcictl` with `--reset`/`--reset-fw` on PF and VF;
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


base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
-- 
2.53.0

