Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978593;
	b=2Y3AF89dV2vZpMeodrgXu3W+j034Ixms4YaB1l8iVzaixb9eHZjdTuJubKGjrsl83yqW
	 OJNLrQJ+MpCNf6N32kBwri/FkPZndvrJjhCdCDzTUCZCHfQHj1+aFJKBt5X+dA7YHv/2M
	 5WAknjFS8ZrQBkYhnHbBRnVWquKnbZxD9eVDgc5uVBuQ779LYAZCsxzOApagTsiP/Vsf6
	 cJjGgeUdXObpfWfvYaW9VYtsnUw2Gv1hqEb+cJiRpLWi8SZ9cw+hOpDlNpM6snSDewji8
	 xGSJer+x5250etBc7axpqo65kXcjW1tjpv4fiqqSPWd/ELs6HcP4JRZxQ4nFW85mQ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978593;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tfAMwDsZx9hT/XT628AckVBYddl5CGish4/yfUGXFg4=;
	b=h3a+6fAc+/sJC8ry7kK5NwVdtdH3sWspjSz1XP5OiZCi8YF7R5akE3vyzQB/aqTXbdIK
	 jD/J4kldStvOUEFPap1kpNPx7yYho28rcyNFSGxxc6VmNyedyK1D4HfUxENUDp70QrML2
	 b1BbYiQw05tehpvHFIXd3JX2x9l3lhfIruI7HsTHV+ub3hJKSmOBK2hdc9jTcInNhYcLO
	 JOjUMi3BvtdBinJ9LMKha8zz2cUX42f7fPgIOsoeQ23P8U/llFY+nfH7Lon4y0oF91bhT
	 lkV734F3ElBHQSpt4IcAkdWD0+v3GgdC9x80Y8DjghT/WzEmelBRO/wzM3fRL+LqDTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zf7qdpzC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51115606A329;
	Fri,  6 Nov 2026 15:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51115606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zf7qdpzC
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE8de2726615;
	Fri, 6 Nov 2026 15:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tfAMwDsZx9hT/XT628AckVBYddl5CGish4/yfUGXF
	g4=; b=Zf7qdpzCbBNyMcToiJAdlFPy8Cblfy7mTCGX9LZYDQBNUJhzehWVwvppw
	iW0ekfBOAZkzI0thgMECD/wUif0jVyycFs2LNMaxbRYy1E6+q1RHRrpvhr09+axB
	wEFiAL22p8DtJM4O0uWvVCpfV+CZkvHYghmhbzpCW2XBWIYG4slQ55RI8KtjnJ2I
	0nD0fejpCCXBCLm7wjwSbvmOBgNbZL3ZlOyks8VqkcLCsZfNs7lIqTkNp/HXiuku
	ja/0dsKCXKJPWvxRe76VxR2aX3RNrVH1nMvyCvEG4mDCk9yPdtUVZ70qEuFD3WRE
	sL8R0/VjvD5j7Ulc0RqI7mf0vsiaQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9d559-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FK8ka3577932;
	Fri, 6 Nov 2026 15:23:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v7wrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FN2hI10814116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45FCA5803F;
	Fri,  6 Nov 2026 15:23:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F6BC58067;
	Fri,  6 Nov 2026 15:23:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 00/14] s390/vfio-ap: Add live guest migration support
Date: Fri,  6 Nov 2026 10:22:45 -0500
Message-ID: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aedf0d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h7Q6_VbBB8FTHRuk9jsA:9
X-Proofpoint-GUID: CWR6mAbmpXK2w4Sa_8Bpk1MwRhTH9Vy6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX3V9d/64eskif
 iYKsAtvWRHtrRM6wWanrHAbkUuIhYC+D5aO9LC2C61b/NSy1dz7nuB3szx2ibZIzMKHbnxXJino
 /bhzislqvMcKug0ABFsJAcvq6S+TxvY=
X-Proofpoint-ORIG-GUID: CWR6mAbmpXK2w4Sa_8Bpk1MwRhTH9Vy6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXw9+aNWYI+UJi
 H5+ELuezPZIozi+6JsrBH/OkEs1zcG81ayvY3CV3AfoV+CSdFi9BmhI+jSRLWxiK4oHn0s7zc4P
 8AUHQ8E7tudigJpFl5AoNXAcTz4RLRDk0J3fgGY6QZc933JbxfT6hYnSU6SLOVD5deeDm16w+RT
 /SQHWohCFa06i9ULUdkGLCzgnoYhfBVzuw2Lrf2rLOuFjOWYuuoDy7krfcf8uUsPGTaJM/u8z/w
 /s4w1kKSWbU8L0i18nV141pyBQPbDFH+s4yBiSI1bqounxugRg0h77RJZ2Lr9yGJa7mt1oOxxhc
 UGO31XqorpZtd78YHAEuQWJCw6s2HAkqDtMxIAX39OEpiIal0yINt5zHGxvKblV0rsHgk8hQkpm
 XOShiEZEm9ZFb48HiWTjOaTccBF0MQSNNbeUoAMuLVFYR1hW9eDmxRvaYjUkml+nk5+VBP/m0rN
 yEpeqJKOFxQn+VlN46g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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

Change log v11 => v12:
~~~~~~~~~~~~~~~~~~~~~
Patch 02/14: Data structures for facilitating vfio device migration
* struct vfio_ap_migration_file
  ~ Changed ap_config field from struct vfio_ap_config * to void *
  ~ Updated kernel doc for @ap_config

Patch 03/14: Functions to initialize/release vfio device migration data
* Fixed commit message
* vfio_ap_release_mig_files()
  ~ Fixed kernel doc
  ~ Rewrote kernel doc to describe that the files are reset, not freed
* vfio_ap_release_migration_data()
  ~ Added kernel doc stating it is called only from the release callback
* vfio_ap_init_migration_data()
  ~ Return 0 if mig_data already exists
* vfio_ap_mdev_close_device()
  ~ Removed call to vfio_ap_release_migration_data()
* vfio_ap_mdev_open_device()
  ~ Removed call to vfio_ap_release_migration_data() on set_kvm failure

Patch 04/14: Reset migration state on VFIO_DEVICE_RESET and device close
* Changed subject and commit message
* vfio_ap_mdev_unset_kvm()
  ~ Removed calls to get/release_update_locks_for_kvm()
  ~ Added lockdep_assert_held() for mdevs_lock, kvm->lock and
    lockdep_assert_held_write() for pqap_hook_rwsem
* vfio_ap_mdev_close_device()
  ~ Take locks with get_update_locks_for_kvm() around unset_kvm
  ~ Call vfio_ap_reset_migration_state()
* vfio_ap_reset_migration_state()
  ~ Updated kernel doc

Patch 08/14: Transition device migration state from STOP to RESUMING
* vfio_ap_resuming_init()
  ~ Dropped ap_config->num_queues initialization to MAX_AP_QUEUES
  ~ Updated kernel doc

Patch 09/14: File ops called to resume the vfio device migration
* vfio_ap_resuming_write()
  ~ Copy into mig_file->ap_config buffer without dynamic size bounds
  ~ Evaluate ap_config header fields after offsetofend check

Anthony Krowiak (14):
  s390/vfio-ap: Provide function to get the number of queues assigned to
    mdev
  s390/vfio-ap: Data structures for facilitating vfio device migration
  s390/vfio-ap: Functions to initialize/release vfio device migration
    data
  s390/vfio-ap: Reset migration state on VFIO_DEVICE_RESET and device
    close
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
 drivers/s390/crypto/vfio_ap_migration.c | 1456 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |   71 +-
 drivers/s390/crypto/vfio_ap_private.h   |   12 +
 6 files changed, 2092 insertions(+), 106 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

