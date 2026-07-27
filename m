Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1837BE8B;
	Mon, 27 Jul 2026 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173572; cv=none; b=VQ7EKkZdmtaGbD105+1Sw4oeK+rGJqDk7JVDlxaor4VTKRzgRM/V/RTUfEBYJkelruGbxXDu9H6wcxCz7t7sHx7LOdgTI7PZ+gOSinL9dg61si9xMnebhEkGFXcVGqPijuiVndvB7qzhm+o0QeAV/Jh2JtLDVfB0rc8L/BJqNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173572; c=relaxed/simple;
	bh=1X36PawZZmy5XnhKfHNQPOsbN5wgmnc3kAYTJYQiSus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBlhWllqHGXakkz6Lh4fvhoQqBNw/3utpcI0I29mxNJ2Mfthc46uFhXVSxzUdXlhAyR4aP1c2AFyU+buetAQHUwRU7DBDWqPi0ce6eqbpEiTZadQYT2uBMr6VIs1HYYIXj0YO96jze/u9BTgFDgy4pyC+ismcczioTtaZoNwHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pDCvAUtX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pDCvAUtX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDn4Sl513196;
	Mon, 27 Jul 2026 17:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z6QoYynrkN2x9HL+HU1ozZypz3xIgGCzjQow1uPd9
	hs=; b=pDCvAUtXFjA7e9S7vPmdmIn2ofnN7R1t8WWZFxINZYuwJh+u56y6hlMN+
	RvNSFvG8JK2TabFQDsvFkypAR88ur2Oqc8XUGY8/ZjY5sv0wTvQpVZNu6WWvGyqa
	7dO99b7A3MCiGilU2StlhZx2JWGvWXE/xSZCelnjahm7S1J4NeL6GwsHbqq20i9L
	kTSvd2DCLbigoUJvtQLTGWn6Jxxd3IrlRHD85Rm+2CnnpKFRATHXaqe4y2ePWoGl
	Np4EEg2sLfrgQ1TNEZ5z6r0HcP7S+b9NPnFq+SD03rbpBNYREiOTEXQ6pp7OZzKB
	lXq3uU4/mpNGTDlaOogmMoaxGwjkQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc9978-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQJne022231;
	Mon, 27 Jul 2026 17:32:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvxfnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWfVl25494212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD61C58058;
	Mon, 27 Jul 2026 17:32:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 130895805C;
	Mon, 27 Jul 2026 17:32:40 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:39 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 00/15] s390/vfio-ap: Add live guest migration support
Date: Mon, 27 Jul 2026 13:32:24 -0400
Message-ID: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rRSNAg1T9AFIOLMF7XhPJFJ3CPW4qPjv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXwAksqNQ4c/TK
 2plXFe0ZFH1fGz4ZMi7ilqUUtExr8lFkmJhxfEWYIzueQ8I/LyR25+B5Sj814EQ39P74ISahJqY
 f5Ty+6zYiCFWRu04wHYBl7nlukeF9pozM7/5t1ti623TTjIAGhJhhWu51WGZkpnwlrP1AuZ00gK
 t2EHlbyHf9ANe7Kbk5GAK84Jh17CEESfc3KPS2b9FwhIzb3toUcWqb/x4Wiz0MfDbnE41fr4cSS
 X5jc6kwbTdNC+buxsq9zSKdrLtiZkpuXdJTj83CNEzBt5Ka30QF+WLpypxsmSPgU+3m0ruJtXau
 51ip17OlMwFJtVI/8a7h3x0/WLT14M0t5iCvGXc9weGXUyUEZzM7ZBjB+lHawkCZZhYVmCjZQwQ
 7vTSFofq+LsrlffSMy+sQJZTij6kKjeZFfVKUcCmSlBC8N3EJKCkh4HETuhNV56H8L4NP4oq1iU
 nEqthjc+dBxN4CAh17w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX2i9hOeBEyhvl
 ascXPVJ5txw2O/kZ78twrCivmjYuEGiQA8LzgUhuNvkhhrgkCrb9MI4PDQ/5lFTW30m3v16kFnD
 12Wwvu5GvaKy3wbWx5VsRrEd3UVBlfs=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a67963c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7Q6_VbBB8FTHRuk9jsA:9
X-Proofpoint-GUID: rRSNAg1T9AFIOLMF7XhPJFJ3CPW4qPjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

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

Change log v5 => v6:
~~~~~~~~~~~~~~~~~~~
Patch 1: Provide function to get the number of queues assigned to mdev
* Replaced nested loop over matrix_mdev->apm and matrix_mdev->aqm to count
  the number of queues with bitmap_weight calls to reduce the number of
  external function calls.
Patch 3: Functions to initialize/release vfio device migration data
* Fixed error path bug in vfio_ap_mdev_set_kvm function; reset pqap hook
  pointer (supposedly fixed in v4 but somehow got lost).
* In the vfio_ap_mdev_prove() function, moved call to 
  vfio_ap_init_migration_capabilities() before the mutex_lock, and pushed
  the mutex_lock to after vfio_register_emulated_iommu_dev() succeeds to
  avoid ABBA deadlock due to lock ordering between probe and open of vfio
  device.
  
Patch 7: File ops called to save the vfio device migration state
* Removed matrix_mdev null check in validate_stop_copy_read_parms().
  vfio_ap_open_file_stream() now takes a 
  vfio_device_try_get_registration() pin, so matrix_mdev is guaranteed
  live for the entire lifetime of the migration fd
* The ap_configuration->num_queues is now set before the loop that writes
  qinfo[] in the vfio_ap_get_config() function
  
Patch 9: Add method to set a new guest AP configuration
* Restored original version of vfio_ap_mdev_unlink_fr_queues function that 
  somehow got corrupted with last patch submission

Anthony Krowiak (15):
  s390/vfio-ap: Provide function to get the number of queues assigned to
    mdev
  s390/vfio-ap: Data structures for facilitating vfio device migration
  s390/vfio-ap: Functions to initialize/release vfio device migration
    data
  s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
  s390-vfio-ap: Callback to get/set vfio device mig state during guest
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

 Documentation/arch/s390/vfio-ap.rst     |  616 +++++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1530 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  301 +++--
 drivers/s390/crypto/vfio_ap_private.h   |   73 ++
 6 files changed, 2318 insertions(+), 208 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

