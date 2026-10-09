Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73741A575;
	Fri,  9 Oct 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546185; cv=none; b=fhqW8x1BSnE9/sxboUVXP+c3/ngnu/3U2r0NovftwnfERrrdDcu216fqsvq1WWn6SeVVBf4z5gQcS99ctm2xXW5ojORZE3LWJt66GOEQGAD4UtQGGRQacbyN7IPnNzrHwOJP+LFyJm3HFqArXsJ6j2EcF2qQr6zPdnHqOrUwpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546185; c=relaxed/simple;
	bh=pA665kRwtUqhps7mRHyc/Lrm2llU6C2TyqhIO2AGCbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wk8UOlw+s40dpOLzd3MBnh+/8FzKeMd7Akk/i4T+il9mNAE/VM1uVCLFgWYG3d0ovtXkF+3M9KytePfzJUfKzec34AbHf1bwoNQ8DmXIX7tFmF6qEDTpm1Wjyw4RAaEO9XsjiS+Z66aTq7NKGsXD+TgY7dGaxINyzuM3RXNsljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9isyiLc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9isyiLc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZaTH3666412;
	Fri, 9 Oct 2026 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gFCv4n+frs8UBSbLy7bbk/mXquihzSLlou76iwBDx
	Fs=; b=U9isyiLcsmqqBYw+JRHXp9/Yj4m5i80Vk6NKb9c3icLd6xWUhIKD6IOMr
	rgpTSygUbl03mPr6Hha+0PVioPCnm/UosWg3712ce81xKjay9yv8QBkSHDalAxz8
	3g/FM/ifYOXBq9zDZhiWfeeBZ91N91QPQ51n4xbr+NUNxRBN6Giv8xfNh8K9w2t2
	ql7PLIHKgSMW2EByNhr8EW3dStxZH+YTwG/3n7OlCh19Nd+X/riB/2t1Re8flwA2
	KakchcFOhdrrAoAALvN406SDw3sgHT88IdUqRrERpDngxOudk/OTee03JZQ20RDC
	+5jtUm053E/fE2vEUEMwnGn+HdTJw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw9pwf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:42:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I1kL559738;
	Fri, 9 Oct 2026 11:42:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd0xad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:42:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Bgl2813238786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:42:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0ABE58050;
	Fri,  9 Oct 2026 11:42:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37B0758052;
	Fri,  9 Oct 2026 11:42:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:42:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 00/15] s390/vfio-ap: Add live guest migration support
Date: Fri,  9 Oct 2026 07:42:29 -0400
Message-ID: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX6gcCFpOno4ry
 cDZh2mo7OXPn4K8FKQEyPKy3XOBglNb6HunsIHyPlTGMTatY4ScPoKh0a0JV+acKsChVgBieoaB
 3i6siN+dLUbQcTDuI09ftwotzDYqTS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfXwdCDWuT2ppWo
 VopGkoqXiNX4NHN7zhqEJONbb1OPLC7I8Lx6YiPsCCDJsJFKbOXqdRKyBk9xvAOADFw8W0/2ulP
 lmwB+0cOrZfViO1LjsFm2Gmp4EaTfwU+h0FLxxYormre6iufNp/LF9ci9jchAhXRjUDgakDSZZh
 +JTcuBwOBljAFOOMW+VaMlXz69wxuWAl7Lx4oabR/PJcA5JNwWXkOVVAbx2J0aLjipdKNnrRw/E
 Xsnp4Kn7GcLy3L6qtcUPz35TUu7c9nf8ilICxj0EMzESOMA/BqScbfk7jI0IKbjwz0i5U9YWwH5
 bMbAAeTCNoB2PuHPFw/JrKeDIrfNvJpCN2NhLMD39/8FXhAIV2VhdodEbC5gGiqggNGZ9BlZ9vu
 eBdO702fe7r6X7uDbQXEy8JzrySdTLLLqxBIhlqZOhLk/t7frXnC452yjSH8MzzO12IwNZeEtma
 sRm/ZrsAEMlDVMZ7RhA==
X-Proofpoint-GUID: q7lZUohHX-yd7yleJMZ1ne2n3-Hv-5R7
X-Proofpoint-ORIG-GUID: q7lZUohHX-yd7yleJMZ1ne2n3-Hv-5R7
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8d338 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kcAen7jC0O3BhFoihVAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090046

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

Change log: v7 => v8:
~~~~~~~~~~~~~~~~~~~~
Patch 01/15: Provide function to get the number of queues assigned to mdev
* vfio_ap_mdev_get_num_queues()
  ~ Changed return type to unsigned int since bitmap_weight() - used to
    get the return value - has a return type of unsigned int.

Patch 03/15: Functions to initialize/release vfio device migration data
* vfio_ap_release_mig_files()
  ~ Removed check for matrix_mdev->mig_data NULL; both callers already do
    make that check prior to making the call.

Patch 04/15: Reset migration state in VFIO_DEVICE_RESET ioctl handler
* vfio_ap_mdev_ioctl
  ~ Call vfio_ap_reset_migration_state() regardless of return from 
    vfio_ap_mdev_reset_queues() to fulfill VFIO contract that the migration
    state on reset is VFIO_DEVICE_STATE_RUNNING.

Patch 05/15: Callback to get/set vfio device mig state during guest
             migration
* vfio_ap_set_state()
  ~ Moved the container_of(vdev, struct ap_matrix_mdev, vdev) macro 
    invocation after taking the matrix_dev->mdevs_lock mutex to be
    consistent with vfio_ap_get_state()
  ~ Added ERROR check after the transition loop in vfio_ap_set_state().
    filp is set to ERR_PTR(-EIO).
    
Patch 07/15: File ops called to save the vfio device migration state
* vfio_ap_get_config()
  ~ No longer dropping the matrix_dev->mdevs_lock for call to 
    vfio_ap_store_queue_info()
* vfio_ap_stop_copy_read_parms()
  ~ Removed pos parameter from validate_stop_copy_read_parms()
    signature because it can be retrieved from the file pointer (filp) 
* vfio_ap_stop_copy_read
  ~ Put a doc block expaining the call to vfio_ap_get_config() if
    mig_file->ap_config is NULL (i.e., lazy initialization)

Patch 09/15: Add method to set a new guest AP configuration
* vfio_ap_set_new_guest_config()
  ~ Removed m_old_shadow since it is not needed
  ~ Creating new patch that make static functions non-static in this
    function which will be inserted preceding this one:
    o get_update_locks_for_mdev()
    o release_update_locks_for_mdev()
    o assert_has_update_locks_for_mdev()
    o vfio_ap_matrix_init()
    
Patch 10/15: File ops called to resume the vfio device migration
* vfio_ap_resuming_write()
  ~ Simplified by allocating a read buffer large enough to
    accommodate info for 65,535 queues rather than mulitple reallocations
  ~ Call mutex_lock(&ap_attr_mutex) followed by get_update_locks_for_mdev()
    at beginning and hold for the duration. We can have bindings or 
    queue assignments changed while updating the guest's AP configuration.
* validate_resuming_write_parms()
  ~ Changed signature to (filp, len)

Patch 11/15: Transition device migration state to STOP  
Patch 12/15: Transition device migration state from STOP to RUNNING and
             vice versa
* Squashed these two patches

Patch 14/15: Add 'migratable' feature to sysfs 'features' attribute
* features_show
  ~ Changed 'migrate' feature to 'migration'
  ~ emit a string of base features supported for SE guests; for non-SE
    guests emit the base features plus features not supported for 
    SE guests 

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
  s390/vfio-ap: Prepare lock helpers and matrix init for cross-file use
  s390/vfio-ap: Add method to set a new guest AP configuration
  s390/vfio-ap: File ops called to resume the vfio device migration
  s390/vfio-ap: Transition device migration state to from/to STOP
  s390/vfio-ap: Callback to get the size of data to be migrated during
    guest migration
  s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
  s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

 Documentation/arch/s390/vfio-ap.rst     |  616 ++++++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |   14 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1494 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  289 +++--
 drivers/s390/crypto/vfio_ap_private.h   |   75 ++
 6 files changed, 2289 insertions(+), 201 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

