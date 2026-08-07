Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7792E7391;
	Fri,  7 Aug 2026 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141127; cv=none; b=lw6kJdgXb+r6soe6XFW1qN6GO9YOESv0eBbIx6Kp1aj8ChyG1P9mVWIMnKvRV3vYRHFetPMhhleSDTN1OL9xYB8rVswWh1SWowLmfwtOrFmntVZohsAM73wE5D7cW2XFLhK4vNZ3tLykWZqcz6X9KLr0TR7ugT4XjkGWJdvD6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141127; c=relaxed/simple;
	bh=EW12MWPq3d+9hgE4Ijby3yJ0byOPesMxp/U/VpfNe6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ls/WhClU550ncvhrWES3aN49woAwAx8W+Bz7cMN6ix8imgw7qXS5WjL39+GsMtG9xOJ0HrajXDyOjWykULIVy/K3c8BpI6U3n5aT3psMM8J9t47gX4ZSRgCaQwjDiY8wN1+K6as2cdA2ByBwxCqU4PKYkZOS+1LwQVmYCcPAYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+NxyOE/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+NxyOE/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lm0dS2570465;
	Fri, 7 Aug 2026 22:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZRfyOJLJC0Iyeh7zZPPvsLpmP8wEmSs4cAbyZownj
	R4=; b=J+NxyOE/vwBpnPznSzsKgtwc9fpRYHzcPdVFARczwzKZKFfAkegXXsWLY
	IdeqMsPW2bbiylA8F4oDAvfE8CUCqg0mTlprLBr2vnO0CJlPExt2cLevhR5M3TqM
	Tq/yP+DxJkoTlyYDskMVUo9H+OOwz558paYJ0kaMs4mXcID/n+buS5m3DE5awfKS
	D/rVgwYJHr43Qajue3Pe2iFinq52akQCKcIDFRB5ynQ3Q8psu9nJzDKzihQOS8bF
	T+oJG8oRKGFQUk63qqXhyMqjqhu/ZP8v/Drgeg4DKSo42Fxj/a4PlGbjP1mv06tu
	NNEQ8zQ61pW8P5YT0Oc4vEX6rFN1A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02e1jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBL3T019966;
	Fri, 7 Aug 2026 22:18:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu01etw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIaaB31982332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80E458059;
	Fri,  7 Aug 2026 22:18:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C78A758057;
	Fri,  7 Aug 2026 22:18:34 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:34 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 00/15]  s390/vfio-ap: Add live guest migration support
Date: Fri,  7 Aug 2026 18:18:19 -0400
Message-ID: <20260807221834.562851-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a7659be cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=C5EjuoxQYgLz5e1J3lgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX5HrK65oHnMGH
 N/Nc/z02J1wv7iVy8QT5gYNH3Gl8hUy8oAL4FzcAvU5O9Ep90nYzv9gfEUzmZBg01rQK+76XgDE
 jU2muj9fH2uRp1L45PhUuBjiwiCQwj3rU1rda4IpTqLEB73kACl7izpW8hagnKy2u8AO4c2YBfW
 giJFapyrQK9vDnHVfDg9lYJQD3RhmxzjskTqxj3kM8xnEadZ2M4/17LlLUcDiU6Jm8Aku5+kZFs
 LS+laaH9VNdKLEHhfm43whbeWn7BQ4UfC0uWNzs6lJ/NpLOkO71cu99m4i1EBJ7ZTJRVBuMZaKY
 z4s465LGR4PnOZCVh0NfzhTOHyHP4IyRUWVB/u84aUyEGinwzDtGvl2EjmRaQ6CRKMP3beI5F5v
 sNyGgjRORr7DmRfbJTghdNl++086M8skaSR+BHI1i5L0A0u95NWpAUFloAMjxG3kYMpoTwok0on
 3pJP3vQxJ/yQRobJMdg==
X-Proofpoint-ORIG-GUID: p4RGNRB9kOD2uvkqlsWtqa2UPkbOG-dJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX5eZQ8Vh8C6Ez
 3BWVUjKGBDqE7ac608lI7lFMNdz3UtrgIyaMiUuD6v24ty8ORdq25Crn9JKMjM6lt57L63MNJwZ
 WjjrDCsv7u5zeTibdAaADjtuhgvvOU8=
X-Proofpoint-GUID: p4RGNRB9kOD2uvkqlsWtqa2UPkbOG-dJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

This patch series implements live guest migration support for KVM guests
with s390 AP (Adjunct Processor) devices passed through via the VFIO
mediated device framework.

Background
~~~~~~~~~~

The vfio-ap device driver differs from typical VFIO device drivers in that
it does not virtualize a physical device. Instead, it manages AP
configuration metadata identifying the AP adapters, domains, and control
domains to which a guest will be granted access. These AP resources are
configured by assigning them to a vfio-ap mediated device via its sysfs
assignment interfaces. When the fd for the VFIO device is opened by
userspace, the vfio_ap device driver sets the guest's AP configuration
from the metadata stored with the mediated device. As such, the AP devices
are not accessed directly through the vfio_ap driver, so the driver has no
internal AP device state to migrate. What it does migrate is the AP
configuration metadata of the source guest.

Implementation Approach
~~~~~~~~~~~~~~~~~~~~~~~

This series implements the VFIO migration protocol using the STOP_COPY
migration flow. The key aspects are:

1. On transition of the migration state from STOP to STOP_COPY
   - The vfio_ap device driver creates a filestream for userspace to use to
     read the guest's AP configuration from the mdev

2. During the STOP_COPY phase
   - Userspace uses the filestream created in #1 to read the source guest's
     AP configuration
   - The vfio_ap device driver copies the source guest's AP configuration
     information to userspace

3. On transition of the migration state from STOP to RESUMING
   - The vfio_ap device driver creates a filestream for userspace to use to
     write the source guest's AP configuration information so it can be
     restored to the mdev on the destination host.

4. During the RESUMING phase
   - Userspace uses the filestream created in #3 to send the source guest's
     AP configuration information to the vfio_ap device driver on the
     destination host.
   - The vfio_ap device driver first verifies the source guest's AP
     configuration is compatible with the destination host's.
   - The driver restores AP configuration to the mdev on the destination
     host which automatically hot plugs the AP resources identified
     therein.

5. Documentation
   - Add live guest migration chapter to vfio-ap.rst

Compatibility Validation
~~~~~~~~~~~~~~~~~~~~~~~~

The series includes comprehensive validation to ensure source and
destination AP configurations are compatible. For each queue, the following
characteristics must match:

- AP type (target must be same or newer than source)
- Installed facilities (APSC, APQKM, AP4KC, SLCF)
- Operating mode (CCA, Accelerator, XCP)
- APXA facility setting
- Classification (native vs stateless functions)
- Queue usability (binding/associated state)

When incompatibilities are detected, migration fails with detailed error
messages identifying the specific queue and characteristic that caused
the failure.

Configuration Management
~~~~~~~~~~~~~~~~~~~~~~~~

This implementation does not prevent configuration changes during
migration. Configuration stability is an orchestration-layer
responsibility, consistent with other VFIO device types. The driver's
role is to validate configurations and provide clear diagnostics when
incompatibilities are detected, enabling orchestration tools to implement
appropriate policies.

QEMU patches exploiting this series:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
https://lore.kernel.org/qemu-devel/20260409141352.997844-1-akrowiak@linux.ibm.com/

Change log v6 => v7:
~~~~~~~~~~~~~~~~~~~
Patch 2: Data structures for facilitating vfio device migration
* Added 'magic' and 'version'fields to struct vfio_ap_config to
  handle ABI stability across host migrations.
  
Patch 6: Transition device migration state from STOP to STOP_COPY
* Refactored stop_copy file release functions

Patch 7: File ops called to save the vfio device migration state
* Drop mdevs_lock prior to calling the vfio_ap_store_queue_info
  function and re-acquire it afterward. The vfio_ap_store_queue_info
  executes the PQAP(TAPQ) instruction which could consume a 
  lot of time if there are an inordinate number of queues for which
  info needs to be retrieved. 

Patch 8: Transition device migration state from STOP to RESUMING
* Refactored resuming file release functions

Patch 9: Add method to set a new guest AP configuration
* Removed !q->matrix_mdev check in collect_queues_by_apid function
  as it is not necessary because all callers pass a matrix_mdev
  obtained from container context and will never be NULL.

Patch 10: File ops called to resume the vfio device migration
* Replaced pr_err calls with pr_err_ratelimited calls in 
  report_qinfo_incompatibilities() function along with all of the functions
  it calls to prevent the CPU stalls or a denial of service attacks.
* Added a scratch buffer that must be filled with vfio_ap_config header
  information (the new 'magic' and 'version' fields (see Patch 2 above)
  as well as the 'num_queues' field before allocating a vfio_ap_config
  object.
* Added write_in_progress flag to the vfio_ap_migration_data structure to
  reject concurrent write operations. This flag is checked when the
  vfio_ap_resuming_write() function is called and if already set, the
  function will return -EBUSY; otherwise, it will be set.

Patch 13:Callback to get the size of data to be migrated during guest
         migration
* modified vfio_ap_get_data_size function to call the vfio_ap_config_size
  function to set *stop_copy_length
* Use struct_size_t function to calculate config size

Patch 14: Add 'migratable' feature to sysfs 'features' attribute
* Do not display 'migratable' feature when the system is an SE guest;
  live guest migration is not supported for such guests.


Anthony Krowiak (15):
  s390/vfio-ap: Provide function to get the number of queues assigned to
    mdev
  s390/vfio-ap: Data structures for facilitating vfio device migration
  s390/vfio-ap: Functions to initialize/release vfio device migration
    data
  s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
  s390/vfio-ap: Callback to get/set vfio device mig state during guest
    migration
  s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
  s390/vfio-ap: File ops called to save the vfio device migration state
  s390/vfio-ap: Transition device migration state from STOP to RESUMING
  s390/vfio-ap: Add method to set a new guest AP configuration
  s390/vfio-ap: File ops called to resume the vfio device migration
  s390/vfio-ap: Transition device migration state to STOP
  s390/vfio-ap: Transition device migration state from STOP to RUNNING
    and vice versa
  s390/vfio-ap: Callback to get the size of data to be migrated during
    guest migration
  s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
  s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

 Documentation/arch/s390/vfio-ap.rst     |  616 ++++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |   14 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1762 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  297 ++--
 drivers/s390/crypto/vfio_ap_private.h   |   73 +
 6 files changed, 2557 insertions(+), 207 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

