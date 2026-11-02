Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632573;
	b=JY8OAdvpmW15yhjag81/jN7a3lKjZ53Y1kK57OGdnAuY02AIAO1URohvD1ikh8H5Ehw0
	 OwT2lNtp3BESEVIY77tIti5ym74UbDV+b36pYclPnmramh8cQpbxW4/IUMcLa2mH8uzFn
	 cFfIpYkFUfzognN4P1/pKw6zzF/hY//d2GLxVDIA2xCF7wPV2WfO/kpBrJ05++qKrpkTA
	 aGkn1ulI7k3skSdzaT3Q0bRcRkTdFvTDDxSFcpCIuenLYFgo5ZBeaTtULo+XWCXupm/Jc
	 tcq9tEpOpbKbKcjLhUS1D7z8yCYyXQ9BOfGi12IpJGmWR5wR+4Sg4Ii34WUuzZUim5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632573;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=h9bbix2n7wEKy0tlOGWDqQzwFia/tRcv2jWixARk/sI=;
	b=oViNZbDa8h5BgPPcvxT+8ThSpIHEpROyGh2TTLUEp4JRl1pYR0RBDKKoS3aSvUwzMgrp
	 E17wt2+1j54E40Tuq89yoNIUdR0mRNsGVQI3scUIjDlVAR2VcVAh/tyWoVSNtz5ewOZpw
	 if9RRLulIJdKFWCVKuvpOLE35SkDxnRiiZy6JrHfOHBaPCJdV5JOctL4wAZYxcJsJ8rUX
	 teqeBeZba9EfyKbBn8GxBsTJUeOWQ6rONE2tOVdfWo+VgqnQCBnF8WDUNs+BZeKYivMqd
	 nz/uM8BZlOoBVq9afGCHvbLBxg1VSa4/Dhule8dRo6SjLmhH7ADTzGNvN35f2YsUnSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Zl96/EIH";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE7607B468;
	Mon,  2 Nov 2026 15:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23EE7607B468
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zl96/EIH
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EE8sI3103375;
	Mon, 2 Nov 2026 15:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=h9bbix2n7wEKy0tlOGWDqQzwFia/tRcv2jWixARk/
	sI=; b=Zl96/EIH2er4RIjktjhVplpFP9c9TSL2Ooe+pjKyC+Gn7MxJauAtfvilf
	jG2qQsAdgc0nXKsHDwSJNtTLqJGF1IplU907Adnw7q4wVA7vUB2Qs+SN7poexECF
	n8rqGW9xOknMKM692wevWBGtl87gho546sizHzwcrSn47rQZhUegh8Afptpw61Ny
	ZdNKZqmFVp24/Q1wHL0cczXdlGt+64hNG+MI+28JI9RgpoxU37kn9yBqlEm0KIr+
	8GajvNPN6CcEACr3MKpftCp1IWD2EY+eKiT28KdRb7ro79R4jMgW1pYC59AKlIXa
	CfBIEc0nxkDWWLc5vKo0CPUdta6VA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826h8rn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp6Er1068906;
	Mon, 2 Nov 2026 15:16:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gpd1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FG6XU32178848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4806B5805D;
	Mon,  2 Nov 2026 15:16:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB5E58064;
	Mon,  2 Nov 2026 15:16:05 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 00/14] s390/vfio-ap: Add live guest migration support
Date: Mon,  2 Nov 2026 10:14:40 -0500
Message-ID: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ojJmKAXCezYSGXR6uuKVq-6aHGbVk0Qk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX+jhaDHJq0luG
 fD/LQ+qv/SIkPzQANSnEGC+QplDZTLag6Vp+Taih3AF2lXpTLna8TzQCqyfRsE+3DuwUgV2YJZt
 wLZROGQn7v9U76jbPb2GrNThNgRp3KTb9YEYr1b7hzWmq1Vz2X71UJizuFfb4XqEIPxcm6AMs4H
 YTZ/Nw483DNxKrf6OqEbv7uFZLzTBS24NivA4hb11TM+4xjNo9mkF+2O7QPPSzLAeZ5hZ/a24cu
 Ke+0BgyqtZI2sv8tPawwqH85PEV3fr77FycrwtntUazdHrjm3OJfKSlsijNpNS815JVLw8AgZL2
 vKRRz272xbM4L43lPiEyCcJygyy4/q1qLxOYuOwXk4E+gYNtSfn2kexW6RM/hv8EGvxrCuLUJn2
 mXlvT1z7mUzedBMvDSx/cbN6u3DD86U70NF0pew4b78EwiOpeh6wQUv4e6SjT2z4tem8Sul3UXf
 ZabINAy7h9rkwyfdAGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXx3HjAYNyfGSw
 ZcXkU+1sNVFTEGBbM9CkJW4LbwpaO83dyqY0DBmMke195SrgsB+OQjqnzrHSlI4FwNT6NOrmDhn
 ++ni9wM6exmIEith9AMGqDU736GCDtc=
X-Proofpoint-GUID: ojJmKAXCezYSGXR6uuKVq-6aHGbVk0Qk
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8a938 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KmMA8GJ9NQQKUm569E0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

This patch series implements live guest migration support for KVM guests
with s390 AP (Adjunct Processor) devices passed through via the VFIO
mediated device framework.

Background
~~~~~~~~~~

The vfio-ap device driver differs from typical VFIO device drivers in that
it does not virtualize a physical device. Instead, it manages AP
configuration metadata identifying the AP adapters, domains, and controls390/vfio-ap: Add live guest migration support
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

Change log v10 => v11:
~~~~~~~~~~~~~~~~~~~~~
Patch 02/14: Data structures for facilitating vfio device migration
* struct vfio_ap_migration_file
  ~ Added @matrix_mdev back-pointer to the owning ap_matrix_mdev so
    read/write file ops can reach mdev state without storing it
    directly in filp->private_data
  ~ Added @lock mutex to serialize concurrent read/write operations
    and ensure f_pos is only advanced after a successful
    copy_to_user()

Patch 03/14: Functions to initialize/release vfio device migration data
* vfio_ap_init_migration_data()
  ~ Initialize @matrix_mdev back-pointer and @lock for both
    stop_copy_mig_file and resuming_mig_file embedded in mig_data
* vfio_ap_release_migration_data()
  ~ Destroy @lock for both stop_copy_mig_file and resuming_mig_file
    before freeing mig_data; moved from per-session release
    functions vfio_ap_release_stop_copy_file() and
    vfio_ap_release_resuming_file() which are called at the end
    of each migration session, not at final object lifetime

Patch 05/14: Callback to get/set vfio device mig state during guest migration
* vfio_ap_mdev_set_kvm()
  ~ vdev->kvm changed from struct kvm * to struct file * following
    upstream KVM API change; file_to_kvm_s390() now called to get
    the struct kvm *
  ~ kvm_get_kvm() / kvm_put_kvm() removed; file reference holds
    KVM lifetime

Patch 06/14: Transition guest migration state from STOP to STOP_COPY
* vfio_ap_transition_to_state()
  ~ Pass &mig_data->stop_copy_mig_file to vfio_ap_open_file_stream()
    instead of matrix_mdev; filp->private_data is now the
    vfio_ap_migration_file pointer
* vfio_ap_open_file_stream()
  ~ Changed first parameter from ap_matrix_mdev * to
    vfio_ap_migration_file *; uses mig_file->matrix_mdev internally
* vfio_ap_release_mig_file()
  ~ filp->private_data is now vfio_ap_migration_file; reach
    matrix_mdev via mig_file->matrix_mdev

Patch 07/14: File ops called to save the vfio device migration state
* validate_stop_copy_read_parms()
  ~ Added mig_file parameter; validates filp against mig_file->filp
    instead of mig_data->stop_copy_mig_file.filp
  ~ Added lockdep_assert_held(&mig_file->lock)
  ~ Removed config_sz overflow check that was masking the broken
    EOF logic (see vfio_ap_stop_copy_read() fix below)
* vfio_ap_stop_copy_read()
  ~ filp->private_data cast to vfio_ap_migration_file *; matrix_mdev
    reached via mig_file->matrix_mdev
  ~ Acquire mig_file->lock before mdevs_lock and hold across
    copy_to_user() to serialize concurrent readers and protect f_pos
  ~ *pos advanced only after copy_to_user() succeeds; mutex_unlock
    added on -EFAULT error path
  ~ if (pos) return -ESPIPE guard restored (stream_open() passes
    NULL for normal read(), non-NULL only for pread())
  ~ pos = &filp->f_pos reassignment restored after lock acquisition
  ~ Restore v10 EOF signaling: clamp len to remaining bytes with
    min_t() and return 0 on the subsequent empty read, rather than
    the broken eof-flag approach that never signaled EOF when
    QEMU's read buffer did not divide evenly into config_sz

Patch 08/14: Transition device migration state from STOP to RESUMING
* vfio_ap_resuming_init()
  ~ Changed parameter from ap_matrix_mdev * to
    vfio_ap_migration_file *
  ~ Store ap_config, config_sz, and filp directly into mig_file
    instead of via mig_data->resuming_mig_file indirection
* vfio_ap_transition_to_state()
  ~ Pass &mig_data->resuming_mig_file to vfio_ap_resuming_init()
    instead of matrix_mdev; removed the now-redundant assignment
    of mig_data->resuming_mig_file.filp after the call

Patch 09/14: File ops called to resume the vfio device migration
* validate_resuming_write_parms()
  ~ Added mig_file parameter; validates filp against
    mig_file->matrix_mdev->mig_data->resuming_mig_file.filp
  ~ Added lockdep_assert_held(&mig_file->lock)
  ~ Moved NULL check on mig_data before dereference of
    mig_data->resuming_mig_file.filp
* vfio_ap_resuming_write()
  ~ filp->private_data cast to vfio_ap_migration_file *; reach
    matrix_mdev via mig_file->matrix_mdev
  ~ Acquire mig_file->lock before ap_attr_mutex and mdevs_lock to
    serialize concurrent chunk writes on f_pos and ap_config
  ~ if (pos) return -ESPIPE guard restored
  ~ Replace get_update_locks_for_mdev() with direct mdevs_lock
    acquisition; guests_lock and kvm->lock are not needed because
    the pre-configured destination mdev model never modifies the
    guest APCB during migration write
  ~ do_post_copy_validation(): replace assert_has_update_locks_for_mdev()
    with lockdep_assert_held(&matrix_dev->mdevs_lock)

Patch 10/14: Transition device migration state to/from STOP
* do_post_copy_processing() wrapper collapsed directly into
  do_post_copy_validation(); lockdep_assert_held() calls moved
  into do_post_copy_validation()

Patch 12/14: Set up for vfio-ap device migration
* vfio_ap_setup_vfio_device_migration() kdoc
  ~ Removed stray "Enable" word from description
  ~ Collapsed double blank line between description and @matrix_mdev

Dropped patch 09/15: Prepare lock helpers and matrix init for cross-file use
* Removed: get_update_locks_for_mdev(), release_update_locks_for_mdev(),
  and assert_has_update_locks_for_mdev() are no longer needed in
  vfio_ap_migration.c; vfio_ap_resuming_write() now holds only
  mdevs_lock directly
* Removed: vfio_ap_matrix_init() no longer needs to be public;
  it was exposed so vfio_ap_resuming_write() could hot-plug the
  source AP configuration into the destination guest, which the
  pre-configured mdev model does not do

Anthony Krowiak (14):
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
  s390/vfio-ap: File ops called to resume the vfio device migration
  s390/vfio-ap: Transition device migration state to from/to STOP
  s390/vfio-ap: Callback to get the size of data to be migrated during
    guest migration
  s390/vfio-ap: Set up for vfio-ap device migration
  s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
  s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

 Documentation/arch/s390/vfio-ap.rst     |  643 ++++++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |   14 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1454 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |   70 +-
 drivers/s390/crypto/vfio_ap_private.h   |   12 +
 6 files changed, 2089 insertions(+), 106 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

