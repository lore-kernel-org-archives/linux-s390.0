Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DD51CF57;
	Tue, 13 Oct 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905553; cv=none; b=Hsu0fBzaua7K2QA+cm8L9QhOMBUHmy44p7pTYFOMhtihgCpxd9udM0Cov5mKl94O/YOhVHewUPD4FIk7MEA/dkiOSURuht9lgd1T3Td3IwpZpgi7CJOGt9WUqRvkh/GkZFIVjXHDYqygfMEgbNRLqQtZmn3Gml5hyFukjX3rOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905553; c=relaxed/simple;
	bh=LcFvoEE0I4vH9/ZXIhCTM/lSupBjUVvMuttQQF/PCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8kNmqKQmQ7wu/TLKr8DIWWMB/4EkSAerfAs9Ct9cM3scNcJTNSzcCIGBGcC9IRcJY6DHm4+9O877lwcTCg283Jyr/9dtuapyA9ekkiHrRb79QtNA7tjvEwjvhDHlP5ovJ6cfFl2fypgzhZ3J1DQ7j4B+T5E0qmwsSGmjs3vCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DcArjelU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DcArjelU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDo3K2725945;
	Tue, 13 Oct 2026 15:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NKRGIAJVEPpQ0dMpVpO0AAvuXl7HPQkGPXoX1QDIJ
	bg=; b=DcArjelUq5aSZazAn3/kc3zeQOrDKnGo/37dj+8ynNC/E91p8MhhjwKWY
	9K2z1ch3aIgyhUb5AkXb4sfilCWWUQ2cCyOPi+gaTbNQJ2WIIMOf3M6tsJnwpQ6Z
	VlTFh7D+2IvKzYth6DYtLsXRnLpcbYlrfsyRhcCIPzfwaicmI/44Gcpcu/pd/qFl
	0Pv9yLZrz986sTaq/bc9MEigvlYnUqx3TaisKsA8QdN+SHhyw02HVvncxpLjG7sG
	Km2jpz0bdXkDotzat6JntJ5SRi+vj+qzsXe7a5JSDDe1gzMkgsGO6Te6ovdLa+Vk
	EVZw8g08ipUrqsivXuXfhp9Nlhvbw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0enae-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFSdMj1440306;
	Tue, 13 Oct 2026 15:32:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg2eqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFVand28050106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:31:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D5E358066;
	Tue, 13 Oct 2026 15:32:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599325804B;
	Tue, 13 Oct 2026 15:32:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 00/15] s390/vfio-ap: Add live guest migration support
Date: Tue, 13 Oct 2026 11:32:04 -0400
Message-ID: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX7o1VGJxNyJT4
 bB3Ia5mJz/3GI6YvF/mbrgNt7vf1rdO9A0zhYBX4suiliEByKR6pJTBqDog91514KpMUtDSM+dY
 h7bDVNQAlJiJkwAS0KyjGUZHi/PUiZDg7w+UYJF5YyfYtfa5Tk+pN9AvMNhHJBRCsTtPQUlavng
 DB072XfcBcQCo1s2DnRXjWQg0p/KwnCcJf3BpTS0xZANJHby3i7cJjPFZqD+jH7CsrlOoh5J31g
 tmDVR+fFBCfeIGTvEcAgz2ZVZvvHRJZWWuBlHhq7LSvkPeZdMs/jLPbRruHFJnh5Iw0pBSLV1Q7
 7dli8jYN4R+Nffb7Gz5Enpoq2tVYMOCn5/PWyWVtm2MAFkvuujnVtYtcCLSC6FLZL7pc4ROb86P
 426C7+/wmBQhxaIZlTIRYg3RvcQOni96f0To769uocJx050UkadKDPKBJ/8fcXK/IgvWFFF55T8
 e6Aeszgu8wXNaqUTXHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX9uhF2oIFciVS
 W+drLJlySIcSyZUseulpPVTNrkMMXJ3T/Z07xiL+6pdWYvUVVwEmC7/KPMkYI5x2B6u6itwxytt
 uPv/2vIADeVIPiR9pLzLSl509kn0u3M=
X-Proofpoint-ORIG-GUID: gYaWCC8GuWmeln7lCBlelWV0QxPQjuGM
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace4f08 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nNoAnMLGcVWsi4MpGrsA:9
X-Proofpoint-GUID: gYaWCC8GuWmeln7lCBlelWV0QxPQjuGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

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

Change log v8 => v9:
~~~~~~~~~~~~~~~~~~~
Patch 07/15: File ops called to save the vfio device migration state
* vfio_ap_stop_copy_read() 
  ~ Advance *pos only after copy_to_user() succeeds
  ~ Removed the read_pos snapshot; it is not needed because mdevs_lock
    is held from reading *pos through copy_to_user()
  ~ Removed the incorrect statement that ap_config is freed when the
    migration fd is released

Patch 10/15: Add method to set a new guest AP configuration
* vfio_ap_matrix_init()()
  ~ Removed duplicate prototype from vfio_ap_private.h

Patch 11/15: File ops called to resume the vfio device migration
* vfio_ap_resuming_init()
  ~ Now pre-allocates a worst-case receive buffer (VFIO_AP_CONFIG_MAX_SIZE)
    with kvzalloc()
* vfio_ap_resuming_write()
  ~ Removed the multi-phase allocation of 
    matrix_mdev->mig_data->resuming_mig_file.ap_config
    o Removed staging buffer and uses pre-allocated receive buffer
      (matrix_mdev->mig_data->resuming_mig_file.ap_config)
    o Data is accumulated in ap_config at filp->f_pos; the new guest
      configuration is processed once all expected bytes are received
  ~ Now holds ap_attr_mutex and the mdev update locks for
    the whole write instead of dropping mdevs_lock between the copy and
    the configuration update
  ~ No longer calls copy_from_user() with locks held; a buffer that blocks
    indefinitely could stall all AP attribute updates and mdev operations
    on the host as well as the guest's kvm->lock
    o vmemdup_user() copies the user data into a kernel buffer before
      any lock is taken
    o memcpy() into ap_config is under the locks
    o Kernel buffer is freed with kvfree() after locks are released
* validate_resuming_write_parms()
  ~ Dropped the loff_t *pos parameter
  ~ Dropped the staging buffer/ap_config consistency check; the only bounds
    check is f_pos + len <= VFIO_AP_CONFIG_MAX_SIZE
* do_post_copy_processing()
  ~ Removed the mig_data NULL re-check since the function no longer
    takes any locks

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
 drivers/s390/crypto/vfio_ap_migration.c | 1504 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  289 +++--
 drivers/s390/crypto/vfio_ap_private.h   |   73 ++
 6 files changed, 2297 insertions(+), 201 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

