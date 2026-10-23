Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777447;
	b=xhcc+bxD8qm/aoGSgKTxrVaj6+uXl2suLaYetau+vnSLSYSBplN6ovzK6UI57AwNEJsS
	 8mFd7izA+vFCL+dY3/IIPfN7wYFp1etLoLfrL4YJKp5CnMtbqMOfsxumleSKCO+mh1oqC
	 C2WWMfb6tHyi7yIE+y/cFzOWOXQ49NN0e4fah9CT2bgyhK/Rej7kuI+nyfVgosSDC3Xxd
	 rw3Ap2QuBuKMyt/phYdc1tPZzGTjFdNRZu1sL+n+BUGcLaSefww4PgI/4trveHp4CXMVs
	 jqxFwp90+OCEqW9WsQNsEQSb1011Tz6d9UkLVNzQenMOaJLDGn3CoIgRCCqLjz5BDMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777447;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7QxEHtJrM/CQ0kNFrkZZha03gYJgTzI6nedwytrlWaw=;
	b=LhgXxGcisGwcpeT73f3dGNy2I7sUVdp0QEBA8VaBvovzdQMQZ35PaoVAfotp93pGXpdA
	 EXGhhkkWnecEcH5wK/PoLt/3bCX7xfpylmeKXlOiE/iCKeYMOFfOEA5BxXyrV+SrJ2JbV
	 Nz3EyVC49RHNPqcByIsyfJGtfYBkOg9eml2Gm/1kynNoFLArbAd7tX2fNG0OnNkv8z3kU
	 tDcYxjnKWeiyhh6DtSEYVncoMjRnbdtYcvVkMQss+ND4ATrHFc3TCRSYXIfLFc/ZAYRZm
	 dmNgfwsibAsbCMN5GgsGfFR78mx8HJi3A2+3CWPZLp+lSCHcKetmfOGLjsQShJa5VZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=szSeLZHy;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E80606A324;
	Fri, 23 Oct 2026 17:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E80606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=szSeLZHy
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoUr51896006;
	Fri, 23 Oct 2026 17:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7QxEHtJrM/CQ0kNFrkZZha03gYJgTzI6nedwytrlW
	aw=; b=szSeLZHyXdR76LC0XIdJJDquxxry6YTCGdVnPSa/NewgToMMcYRd0VYEL
	pW9CibpphV0b5VwPdaS9x/FFE+61+BIX8W/r0d5E9U2zGNGqI4XK6e6/4dC5RzVA
	T8S0RSiDuucTxKFHKRjYMNoR8t6Syqgv6HDfZqnW47KWIVsBmWGS6CoitCrKvWtH
	RgrcEtW2u0dB8ZmVhsekEqbrywazNag/fCDCGb/CtV/ZcRAtFui+eT2hZG8XrXqm
	h+pstYfSnTjhajzLZCdJ1bb6gkNMjexkhOjlscoFan5UqZCCO4HPfw8EXnR9EuHG
	Ou6pj92J1iHB4lkbmg3mxdHr65/eQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bxrr2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE64Ak2220899;
	Fri, 23 Oct 2026 17:43:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x6a21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHhpuR1835884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:43:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA4C58054;
	Fri, 23 Oct 2026 17:43:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1E25805A;
	Fri, 23 Oct 2026 17:43:49 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:43:49 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 00/15] s390/vfio-ap: Add live guest migration support
Date: Fri, 23 Oct 2026 13:43:34 -0400
Message-ID: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: 5Q_5NTQoiYUAUoMfxfgqNZiMwiZe1TKD
X-Proofpoint-ORIG-GUID: 5Q_5NTQoiYUAUoMfxfgqNZiMwiZe1TKD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXz33qINKU+9hN
 +D4/HL0ldPcO4nq9j6QLqfWgAVnLxFvFe2bT1mc6IMhCimN+mfgeO90i2l8bEjy0RNEJTUnrsTJ
 o9URK6Eyq9SeDSgvtyfxFy3PYqclKjs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX/D1LjCGdJCel
 Y1qATxdbRsDohrR4F4IVGJnknZRQGyNwZlK6c0FY00TV8mlEjs0TxHBIqgRSVcjrIWAxBCbySU/
 oGzIPOm99BTk1R62kEE2yjGUseusE70jWdEQ7lk7q5W/YGNDzJatJa3fpaSlRNflT83fslreK/U
 KtS5+f3ERx8S96Kj4lcKJ4qWHAt4LmEfU/Cd3O9tAAWhMqEy+ouazx15K3p77UZoT9JDwNgpzDt
 1IqW/NPsaY/S+1sgy1KGHiWi1HKlZydc8BuLMgyrvMtpOcFD5SdB9H6dTsb+vCBPD/incNwsApj
 u3YEdiTd59zPUjhON3oMsDapnkt90xyjS5WTys7RIL+TASaDxMiPtArvgjUetszAMfduvfDwJfk
 0BBdzPJ3F7rhwK/76tccLtUiADYPlJlgoL/GxuwbswQI7fVagNB+v5xy5hAgYmg+lJykmuyk9vM
 LnWiWxTCNcRpbEDAUnQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb9cda cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JInNsHStqSfxb5grjLoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230067

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

Change log v9 => v10:
~~~~~~~~~~~~~~~~~~~~
Patch 03/15: Functions to initialize/release vfio device migration data
* vfio_ap_mdev_init_dev()
  ~ Drop unnecessary matrix_dev->mdevs_lock around migration init/release calls
* Deferred setting vdev.mig_ops and migration_flags to patch 13/15 so migration
  is not advertised while callbacks are stubs
* Fixed kernel-doc parameter tag mismatch in comments

Patch 04/15: Reset migration state in VFIO_DEVICE_RESET ioctl handler
* Updated commit message to clarify that resetting migration state releases
  open migration file buffers while retaining mig_data

Patch 05/15: Callback to get/set vfio device mig state during guest migration
* vfio_ap_set_state()
  ~ Removed dead/unreachable branches

Patch 06/15: Transition guest migration state from STOP to STOP_COPY
* vfio_ap_stop_copy_read()
  ~ Added parameter names to function prototype to fix GCC < 11 build errors

Patch 07/15: File ops called to save the vfio device migration state
* get_hardware_info_for_queue()
  ~ Use ap_test_queue() with the T-bit set instead of ap_tapq()
  ~ Accept all 5 architecture-defined response codes returning valid hwinfo
    (NORMAL, RESET_IN_PROGRESS, DECONFIGURED, CHECKSTOPPED, BUSY); unknown RCs
    return -EIO
  ~ Removed retry loop and msleep(), eliminating sleep-under-lock
* vfio_ap_stop_copy_read()
  ~ Copy data into a bounce buffer under mdevs_lock and invoke copy_to_user()
    outside the lock to avoid holding the lock across user memory faults
  ~ Changed *pos check to if (*pos < 0) return -EINVAL
* vfio_ap_config_size()
  ~ Changed parameter type from int * to unsigned int * and dropped (int *) cast
* Incompatibility reporting
  ~ Report APQN in error log when AP type mismatch is detected
  ~ Corrected QINFO_DATA_MASK bit range documentation comments
* Dropped unnecessary compat_ioctl file operation

Patch 08/15: Transition device migration state from STOP to RESUMING
* Updated commit message describing state transitions
r
Patch 09/15: Prepare lock helpers and matrix init for cross-file use
* Updated commit message to clarify that assert_has_update_locks_for_mdev()
  is a newly introduced helper

Patch 10/15: File ops called to resume the vfio device migration
* Switched to pre-configured destination mdev model:
  ~ Destination mdev must be pre-configured by admin with crypto resources
  ~ Migration stream contents are strictly validated against destination
    matrix_mdev configuration and shadow_apcb; stream data no longer mutates
    matrix or shadow_apcb
  ~ Removed setup_ap_matrix_from_ap_config() and dynamic guest re-configuration
* do_post_copy_validation()
  ~ Validate stream magic, version, and header consistency
  ~ Verify that incoming APQNs and cdoms are a subset of destination shadow_apcb
  ~ Enforce that all passed-through queues match the pre-configured matrix
* vfio_ap_resuming_write()
  ~ Changed *pos check to if (*pos < 0) return -EINVAL
* Fixed stray colon in kernel log message

Patch 11/15: Transition device migration state to from/to STOP
* vfio_ap_set_state()
  ~ Reject transition from RESUMING to STOP with -EINVAL if the full
    migration configuration data stream has not been received

Patch 12/15: Callback to get the size of data to be migrated during guest migration
* Replaced size calculation logic with direct call to vfio_ap_config_size()

Patch 13/15: Set up for vfio-ap device migration
* Set vdev.mig_ops and VFIO_MIGRATION_STOP_COPY flag in vfio_ap_mdev_probe()
  once all migration callbacks are fully implemented
* Cleaned up probe function comments regarding lock ordering

Patch 14/15: Add 'migration' feature to sysfs 'features' attribute
* Renamed sysfs feature attribute from 'migratable' to 'migration'

Patch 15/15: Add live guest migration chapter to vfio-ap.rst
* Corrected erroneous sentence swapping source host with destination host
* Updated documentation for pre-configured destination mdev requirement
* Fixed error code and console output in incompatible-queue example
  (ret: -22 / -EINVAL)
* Synchronized kernel and console log messages and format specifiers with
  the exact strings in drivers/s390/crypto/vfio_ap_migration.c

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
  s390/vfio-ap: File ops called to resume the vfio device migration
  s390/vfio-ap: Transition device migration state to from/to STOP
  s390/vfio-ap: Callback to get the size of data to be migrated during
    guest migration
  s390/vfio-ap: Set up for vfio-ap device migration
  s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
  s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

 Documentation/arch/s390/vfio-ap.rst     |  641 ++++++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |   14 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1419 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  120 +-
 drivers/s390/crypto/vfio_ap_private.h   |   70 ++
 6 files changed, 2111 insertions(+), 155 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

