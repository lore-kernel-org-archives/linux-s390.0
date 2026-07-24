Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A4448391;
	Fri, 24 Jul 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909652; cv=none; b=Ca/oYXHxbAb8wJCANsZD3hlyoxuW39UaD/73rMmziQcHmfOAKiebP0SXm0Kmfbqm8CRlUkkM1K+drxCaI0kyn7aEdAE9zn/BJojCm3lCbMHWU3pOFejIXm74cQSMIhXn7IlEeylnBguJ+79ueHWF43D6IyhERxky47OUQnmYG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909652; c=relaxed/simple;
	bh=JmZ3zudCrVV+nQUQ7Y0//1KIh52PU4MdyuBrJhs+xZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoCxnU7UGTggR3IQXPLPLwoKt9Ig/UmLQwoit4ol4fGp3k8STCXCLQBBaSrOwTQeu9Zi5EkHhb71d9XxqL38ewnnzvEtP9XfEizc/M7GtShx+K4qxr2FxFo6KejUSvXwz5IebR92h11DCQl04yUoeoQtlLufHumAVURnlDoCzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BPrv863I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BPrv863I"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfep6100445;
	Fri, 24 Jul 2026 16:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sNrw/wR40FJPcuQce9DhakbwLA6BTiuu9h3GWAh0T
	y4=; b=BPrv863InFIqkqogFm/RSzglEOZUM+jDyAn74oA9lymArI5Q/JxDx/uAe
	8CT895vCppcpxgi3tmfYyM91g+D6RBayZhJwNcg9yR2g+zV3rQYXpJ5UcJWwy3UL
	SYDn5vAddNfh/Y2YADuCnzmsXsJEVqLnpTJM/IQ7biaZ149hkLu2aO70UpiiuzN6
	3OjiiYrUjeW9ugIU3NKfgF3OTQqQ5exJZYIfg6sphXjaXlD9oEAhQckR1tD9g3LS
	NPXtAxQse86GogPAc1EtNdgT697d1TJCRhz4XTdGGkKmHiaifk9KHKbSQgcWJ66j
	jahBRcQmiuefUdwFc5yGDLYhwm5qg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8u40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:13:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4etG025347;
	Fri, 24 Jul 2026 16:13:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahhknh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:13:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGDsVE30409348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:13:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE645804E;
	Fri, 24 Jul 2026 16:13:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70D175803F;
	Fri, 24 Jul 2026 16:13:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:13:52 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 00/15] s390/vfio-ap: Add live guest migration support
Date: Fri, 24 Jul 2026 12:13:36 -0400
Message-ID: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfXzJEa0E0f/U9N
 tEE6qWIxlCn4s1flbScvLNKlur/PpHUu0TbOlGdg5yvZo0myChdxzbect7F/Y0Na3bl0MeEtLWb
 n9NAhhRgRZQ9QqpqHOyelUNU9w+52C0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX59RpWygaxKYh
 +unEzQU6gg3dfzUfjg59w7YJp7AoahiafBKaJ1P4bdpG6XFiRdo/Mcp0gxm+1kFlkbZ0A3/d9OY
 hrI7inN8hN7k0d8MvAuNZp82l8R5f47yyhHb5u+tSor/Kd8VTScaN19P84kSPdSt8N185On5hQm
 W1ipJ/ARa6KSqN2J/rcvp1dn0vzHCS/F39b8Aj4qHTIjUXYf9YPvbiwPJ99btsV9pHCR7hy06v0
 etSD/oSsLGea2zyfBOGrO+jzqA/KO/oK/5UjXU1QUPQ4UfxOd72ai3oQEUfY02uH+sbGKRYb13X
 KYJ8KL2igRCbxs3Rg2gMz8XELSvTOxBBKb585KsGfeGjdOtIV/Tt18/hXwBPBpn+TCj+Ge3J1f6
 kdLVjOQiuMqYRquFz8YJojL5BJ4goKImiPytHyHjQq03vpvCMMAmfpCL8RinL/t+aHknVsiFod2
 U7/UkWnpBx/0Z8f8LWg==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a638f44 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=x5IxltesoFo4ZJQAzG8A:9
X-Proofpoint-ORIG-GUID: 7Qsu29rVcvHSFxO0CxzK0m-szJvs_RN3
X-Proofpoint-GUID: 7Qsu29rVcvHSFxO0CxzK0m-szJvs_RN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240145

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

Change log v4 => v5:
~~~~~~~~~~~~~~~~~~~
Patch 3: Functions to initialize/release vfio device migration data
* Fixed error path bug in vfio_ap_mdev_set_kvm function; reset pqap hook
  pointer
* Do not initialize vfio_device migration_flags and mig_ops for SE guests

Patch 4: Reset migration state in VFIO_DEVICE_RESET ioctl handler
* Added missing vfio_ap_release_mig_files() function

Patch 5: Callback to get/set vfio device mig state during guest migration
* Move mutex_unlock(&matrix_dev->mdevs_lock) before call to 
  vfio_put_device function in the vfio_ap_mdev_probe function to avoid
  deadlock situation
 
Patch 6: Transition guest migration state from STOP to STOP_COPY
* Acquire matrix_dev->mdevs_lock for duration of vfio_ap_release_mig_file
  callback
  
Patch 7: File ops called to save the vfio device migration state
* Change data type of ret in vfio_ap_stop_copy function to ssize_t to 
  accommodate negtive return codes.
  
Patch 9:  Add method to set a new guest AP configuration
* Removed call to vfio_ap_mdev_link_queue in 
  vfio_ap_mdev_unlink_fr_queues() function 
* Refactored vfio_ap_set_new_guest_config function to correct some bugs

Patch 10 - File ops called to resume the vfio device migration
* Fixed a corrupted kernel-doc comment in vfio_ap_private.h where a
  function signature was accidentally concatenated onto the @node field
  description of struct ap_matrix_mdev.
* Fixed do_post_copy_validation() to evaluate queues_available() and
  control_domains_available() independently rather than short-circuiting
  with ||, ensuring all availability errors are logged before returning so
  operators see the complete set of problems in a single migration attempt
* Fixed reallocate_ap_config() to use check_add_overflow() when computing
  the new buffer size for sub-header partial chunks, consistent with
  overflow checks used elsewhere in the file.
* Fixed verify_ap_configs_are_compatible() to return -EINVAL instead of
  -EFAULT for hardware incompatibility, as -EFAULT conventionally signals
  a bad userspace address rather than a compatibility failure.
* Removed a spurious blank line before return -EIO in the default: branch
  of get_hardware_info_for_queue() that was inconsistent with the style of
  the surrounding error paths.
* Clarified the QINFO_DATA_MASK comment to correctly describe the
  asymmetric semantics for the classification bits (upgrade permitted,
  downgrade rejected) and AP type (less-than-or-equal, not strict 
  equality), and to clarify that the BS bits must be zero on both sides
  rather than merely equal.
* Added a mig_data NULL check immediately after 
  get_update_locks_for_mdev() in vfio_ap_resuming_write() to guard against
  the migration file descriptor being closed concurrently while mdevs_lock
  was dropped for the copy_from_user(). get_update_locks_for_mdev()
  reacquires mdevs_lock as its final step, making the check safe at that
  point without introducing a separate preliminary lock acquisition that
  would deadlock.

Patch 15: Add live guest migration chapter to vfio-ap.rst
* Fixed the facilities bit range description from "Bits 0-3" to "Bits 0-2"
  to eliminate the overlap with the adapter modes range that begins at bit
  3.

* Fixed a typo: "Destinaton host" (appeared twice, in the "AP queues not 
  available" and "control domains not available" troubleshooting tables).

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

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
 drivers/s390/crypto/vfio_ap_migration.c | 1560 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  305 +++--
 drivers/s390/crypto/vfio_ap_private.h   |   73 ++
 6 files changed, 2351 insertions(+), 209 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

