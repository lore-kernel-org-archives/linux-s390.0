Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1538F927;
	Tue,  7 Jul 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414960; cv=none; b=XHhpyCQiIANda3FpoIZVPzEEay4emSvLQxtZSIiaYNgcgzKAVVm+LICjcm3VFehajhJl9mBQn4nBCqgfIhRCkuk/x1QODOMbcVzb90ONOCCYZSCaWM6W52UYUcE+6dGBoPifNM8LbeSM1zzMlxrnYvShI1vWS/Sh9Z8I+RWTXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414960; c=relaxed/simple;
	bh=YLkoGTISA/7PcZ4mBq7kQVkx8o9xT8s8PL4U7fcxWxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5PczgK7CYmjS+kmi7rQ13nrdD5fR2VMTid3ROiZ1h0D0knG3qsxjH9M4Iqoeh51ic7MVGj0gQ7zgNgBER9Sl0TYV3IW6AqbOFVAPDBmv+fdsCB2DvnM6VbwzFSRHS6iXkUlvw8MLctF5q9gGcNLQIZkmHKFKAyAWGI9maC1ou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K3Cyaxuj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K3Cyaxuj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IQ042252943;
	Tue, 7 Jul 2026 09:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3cCUa1tHaKKw7cfHjOIkzxGhrw9Q3OMGahIVKjKaz
	UA=; b=K3CyaxujW4RNykw98LX8lqniredPYpoB+m40A1G0/voNpc8MWG2wk61K2
	iIy2Iz9pBXCl4ca6FZzXewm3B4SZv7RaeVxn6QHmRVEDMyjaNCLnF7wB3T7o+9Bv
	xg/aF830s4xWL7ZNUpI8qbn5ykglmRxYk+NVdnjxavCrhpyBGx4a6NS8sfbBdbG2
	drvMAj8cACVT7vWfUEm6+wBSjiuWeAYYbOty0n3zdmmw9+k1BKKaXDl9lZ/bcDQk
	138aSL5vgfmzA0cUAMp/21fsHe2DQAS790KBIEadakhCQ4FcJZwJZFVjuNZXElRQ
	dcfAv9BZ0i3NkHA21tADVpdbC9sDQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stspmj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZCf028878;
	Tue, 7 Jul 2026 09:02:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792StQ53215654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CFDA5805A;
	Tue,  7 Jul 2026 09:02:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7A185803F;
	Tue,  7 Jul 2026 09:02:26 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:26 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 00/15] s390/vfio-ap: Add live guest migration support
Date: Tue,  7 Jul 2026 05:02:02 -0400
Message-ID: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: psdaCiIA1UlFLc0aoOhbchLhXfI2q-P5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX7EBFIIdIX5uU
 VcXHOFUoyW7K5Pn8NIK6ODpRWqC991+6XI0zvR6vO+yzeLUGuF/rE/h5B24wNWl9jHpiMx2+4rz
 3wM72ri6oG/xUqcCWCCZfokqzCo6UDA=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4cc0a7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nNoAnMLGcVWsi4MpGrsA:9
X-Proofpoint-GUID: psdaCiIA1UlFLc0aoOhbchLhXfI2q-P5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX1tKj2GRJsDuJ
 ZDjiMbCoV5wjvnYV++ocGoJsB9pxRjXxsRPg1DmAu7nJn/xVUvZDAxJ+8DK2A6wgSSeTCo1MaOQ
 Og/b1saYi0xnGZhv+QUGf8qyNWtYkgQKH/TQKtQBQiF4vNNppRBN6AgtlllNDOLWH2yy9haIFes
 CEKivwxPz1E+1FKm4qAT9azLNirUijrxnkOD+/cMxJyLlBzPEwsOXTH5seTB+DAtmA/IZGybtp1
 SWi80SbIdM0HVsuwLAIa1+ySlfEdVbtJLD0L3dmkOLemw1Em/hQgE0zvDA5iiSDu7Ak4JCE742a
 G356CKcLNbF7InTMaXYV4RzOo177iIH876bk7fbRRR0dlZMusE6+cyrDdWsdVCIJtiQEI15XtTr
 o0n88tPjnvKQH/QEk+++7kfae4kiQLcbyjdsO+J7FD4Tl7tCXJczhJGpAFHY0sY+8fb5rjCWi6/
 hOlp9560pIKSknXSRGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070084

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

Change log v3 => v4:
~~~~~~~~~~~~~~~~~~~
Patch 2:
* Fixed kernel-doc fields that didn't match structures
* Removed config_sz field from vfio_ap_config structure; it was a dup of
  the config_sz in the vfio_ap_migration_data structure.
* Added a vfio_ap_mig_file structure to use to store AP configuration data
  between calls to the read/write callbacks invoked from userspace during
  the STOP_COPY (read) and RESUMING (write) phases of migration.
* Added adm field for control domains to the vfio_ap_config structure

Patch 3:
* Free storage for mig_data->resuming_mig_state.ap_config in the
  vfio_ap_release_migration_data function to fix potential memory leak.
* Release matrix_dev->mdevs_lock in error path before vfio_put_device in
  the vfio_ap_mdev_probe function to avoid deadlock when the VFIO device is
  released.

Patch 5:
* Replaced dev_err with dev_err_once for the migration not allowed for SE
  guests since SE guest status is fixed at boot time and there is no value
  in printing the message more than once. That circumvents a potential a
  kernel log flood if the ioctl is called in a tight loop.
* Check for VFIO_DEVICE_STATE_ERROR for while loop in the vfio_ap_set_state
  function
* Restored vfio_ap_release_mig_files function removed via this patch and
  again calling it from the vfio_ap_reset_migration_state function.

Patch 6:
* Refactored vfio_ap_release_mig_file function to take the
  matrix_dev->mdevs_lock for the duration of the function

Patch 7:
* Refactored the vfio_ap_stop_copy_read callback to use the new
  vfio_ap_mig_file structure (see Patch 2 above) to store the source
  guest's AP configuration between calls.
* Now migrating control domains

Patch 9:
* Removed filtering_allowed parameter and make it encumbent upon the caller
  to validate the queues are available and bound to the vfio_ap device
  driver and the control domains are in the host's AP config

Patch 10:
* Move setting the mig_data->resuming_mig_state.ap_config and
  mig_data->resuming_mig_state.config_sz values outside of check for
  completion of the write callback.
* Added cur_cfg_sz parameter to reallocat_ap_config function due to removal
  of config_sz field in the vfio_ap_migration_data structure (see Patch 2
  changes above)
* Refactored the vfio_ap_resuming_write callback to use the new
  vfio_ap_mig_file structure (see Patch 2 above) to store the source
  guest's AP configuration between calls.
* Now migrating control domains
* Added check for source and destination BS bits set to 0 if the hardware
  info for both matches
* Added initialization for guest_matrix before call to
  setup_ap_matrix_from_ap_config

Patch 15:
* Added debug log messages for unavailable control domains on destination
  host
* Fixed a few misspellings and format errors.

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

 Documentation/arch/s390/vfio-ap.rst     |  514 +++++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1373 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  462 ++++++--
 drivers/s390/crypto/vfio_ap_private.h   |   72 ++
 6 files changed, 2225 insertions(+), 202 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

--
2.53.0

