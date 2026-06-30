Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723553F210B;
	Tue, 30 Jun 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816104; cv=none; b=Bnqvr0QG7W34bhi614vmTV/kVKZTvyaf5bLOg5icjQEUT9cNPa60+dSAzLzZ8T4sDG8Kbs/XZ2xLkgMAJNRGZvZR/Obzvef2MTC2nRovTjlnP340Ce2SNQvX+Mzuoeq/udHVk3391YHKFSA4q9/aBPLWZg2Rn2+757HLbuvHFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816104; c=relaxed/simple;
	bh=ZIvXvq6nnKTJeLIW92KlzZrJPjCNg7udVtqbk/gsrYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAH9iUPJxzreqMZahCmTP5ZC7/8pTWpKXJ6MG4fouqX0RmGQIaLa/Q80ZpKRIX19gyybQl55peULw8EgPSbxCo5Qhkr6nA7k9v7xlSWfRj2FBTkCKaupK5TECZ+XAf0j8aybDc7VJ+O4AS9O50uP0/s1+9tIjhwbxaw7l+katRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aejNkeTT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aejNkeTT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n0Fx1843238;
	Tue, 30 Jun 2026 10:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z8Y+4DNue6t6ikEjdqBq26zPKqaNoeTuK9+/m6ew1
	5k=; b=aejNkeTTXFG/TmXYhqGsa3d2XABBWIT0PVp0E0RU4cftJ7B2Lcse95O8d
	Zh545H7+Mp5Vwq1rQ348KDTbBow/L2R1Z9Xl+k24SzDp1jn80sCrrC/tFXXoofeR
	QZZjjBuILt+UEdZQy0zK+51vOZauTI7Z8Ot4XZq6+9sA26+uv4VTe+TBmlNBYDgn
	vuS+bwFQ1TqI24aBy79HzMF+YOmf4ySb3X79VluVFvyyUQ0xj043pd1DX/OdHWaO
	6J/f2lkJfeW3M5JUt5C8JVBlVghjo0b/5B25w4AO05fR9vwYLzDxANmxeBK9krOi
	0yzdCl/5iB4JOJiA77IJncuJIVPXw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx5gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYe2g007613;
	Tue, 30 Jun 2026 10:41:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh9n2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfY1C54723066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40ABA58065;
	Tue, 30 Jun 2026 10:41:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F08758052;
	Tue, 30 Jun 2026 10:41:33 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:33 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 00/15] s390/vfio-ap: Add live guest migration support
Date: Tue, 30 Jun 2026 06:41:10 -0400
Message-ID: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439d60 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=cy8oYacL83B0Yxhi5C0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX5oSkGnlF0bqV
 IyuSfT9rouyugLEvw6UbBDPocaWVaLAD+pxYRU+Ln+j0MLVyvgmIQa81EFQhrhEYIHDx1dtXI7R
 XtdNrgmm5/7frc7DiRj5XcpdNNa5u48=
X-Proofpoint-GUID: YfyeDavuc7Muz0Retkq7eW5KGWOgwl5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX4drMhsindUXx
 XQLFhRKv6Q6eL67tIWZQYIjdsjQ0PfnMDEKxGY7XvFHVyvXe11s50TJu8+wOFyYVmx3RhsC2wE4
 F5mfUB85clRXJ0h8WEFkJQeL+YR5Yixb39if9J7djmU6mekUNqn79fqWK0sBcS7ieKOBiw0rLst
 iEL2KpgW4SGJ/3Mve5DGTkLjL0/SthWU6RTdrk76pQkIKByBKDHy0LjyptxIXV0VVcYKR8nzWTA
 9PE9xtxVsBq9XgyXSewAGEbdWPWsQL6R/1W0qBN+QZawp/DsEPa2cpltesntvqbJ3p9LSE5lqhV
 54+6Hxjeo67HFVTdtZfktNQZZbbdDO3F6mSO1eL95lzSMTBbbs25ch8XQdo72Z6DQT0DoEkC60y
 IS4y/6XyfF434pJVRg/kKOaBJeNhQBV/xwtZNvzKkccMKSuiEfZjh/UUhW9UhxQJ/33loBGuYHW
 bfWp7MtnnUnk1LGPcCw==
X-Proofpoint-ORIG-GUID: YfyeDavuc7Muz0Retkq7eW5KGWOgwl5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

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

Change log v2 => v3:
~~~~~~~~~~~~~~~~~~~
Patch 1:
* Removed this patch because the hardware info will be retrieved using
  PQAP(TAPQ) command when needed in cases changes have been made to the
  host's AP configuration since the mdev was probed.
* Removed #include "uapi/linux/vfio_ap.h" from vfio_ap_migration.c
  file

Patch 3:
* Removed vfio_ap_migration_file class and replaced with file pointers as
  there is no longer a need to store AP configuration information which
  will now be retrieved from the mdev (during STOP_COPY phase) or stored
  with the mdev (during RESUMING phase)
* Added padding fields to struct vfio_ap_queue_info & struct vfio_ap_config
  to ensure alignment

Patch 4:
* vfio_ap_release_mig_files function now only needs to fput the files used
  during ghe STOP_COPY and RESUMING phases of migration since there are no
  longer vfio_ap_migration_file objects containing the file pointers as
  well as AP configuration data.
* Removed #include "uapi/linux/vfio_ap.h" from vfio_ap_migration.c
  file
* Set the struct vfio_device migration_flags and mig_ops fields from mdev
  probe callback prior to call to vfio_ap_init_migration_capabilities
  function so the VFIO core doesn't see mig_ops as NULL during the
  registration.
* In the vfio_ap_mdev_open_device function in vfio_ap_ops.c, make a call
  to vfio_ap_release_migration_data if the vfio_ap_mdev_set_kvm function
  fails to clean up mig_data. This prevents data leak of mig_data if
  multiple opens are executed.
* Call vfio_ap_release_migration_data if setting the KVM pointer fails in
  the open vfio device callback to prevent leaking the allocation of
  the matrix_mdev->mig_data pointer.

Patch 5:
* Combined the state transition checks from STOP_COPY to STOP and RESUMING
  to STOP into one if statement since the handling is the same.
* Squashed patch 16 into this patch

Patch 6:
* No longer copies the AP configuration from the mdev to a
  vfio_ap_migration_file structure (removed) and simply opens a file stream
  for STOP_COPY phase of migration.

Patch 7:
* No longer copies a vfio_ap_config object retrieved from a
  vfio_ap_migration_file structure (removed) to userspace.
* Now creates an vfio_ap_config object and obtains the hardware information
  stored for each APQN assigned to the mdev via the PQAP(TAPQ) instruction,
  then copies the vfio_ap_configuration object to userspace
* Removed dev_err messages from validate_save_read_parms function to
  avoid kernal log spamming.
* Add check to validate_save_read_parms function to verify that matrix_mdev
  is stored as private data of the file object and that
  matrix_mdev->mig_data is not NULL since we access it in the read
  callback.
* Release matrix_dev->mdevs_lock while copying AP configuration data to
  userspace in vfio_ap_save_read function

Patch 8:
* No longer creates a struct vfio_ap_migration_data object (removed) in
  which to store the AP configuration data sent from userspace during the
  RESUMING phase of migration.
* Now, merely creates and returns the filestream for userspace to use to
  restore the source guest's data on the destination

Patch 9:
* Complete redesign to better comport with the VFIO migration framework
  whereby the vfio device state of the source device is restored to the
  destination device. Prior to this change, the destination guest's AP
  configuration was acquired at startup from the vfio-ap mediated device.
  The vfio_ap driver would only verify that the source and destination
  AP configurations are compatible.
  - The source guest's state (AP configuration) is read from the file
    stream and validated
  - If valid, it is stored directly in the ap_matrix_mdev object and hot
    hot plugged into the running guest

Patches 10 and 11:
* Squashed patches 10 and 11 together as the state transition to from
  STOP_COPY to STOP and RESUMING to STOP are handled the same way (also see
  changes for Patch 5 above.

Patch 16:
* Updated vfio-ap.rst to include text related to design changes

Anthony Krowiak (15):
  s390/vfio-ap: Provide function to get the number of queues assigned to
    mdev
  s390/vfio-ap: Data structures for facilitating vfio device migration
  s390/vfio-ap: Initialize/release vfio device migration data
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

