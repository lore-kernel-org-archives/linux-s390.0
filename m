Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425000;
	b=4Z4nenvw/7a4tMyYtGhxTiYhc1HcQThVAYzbAuIiedSQZ8scrI0WjtVoc1ESPOI/Knw9
	 s/XwRLBQmEeu3HpVSkaxu/inFt7bkciIFjTXntA9iPI6OgyUadNA4q98Pi3dcmQdXdGJc
	 XMqFDr3u6jtPrmHvPFszwE/q6tTuRcQ8H6wgluONGCfjtXrtWerlH5LCaY3HOJHcp3rWP
	 Uxx8LbV7tN/ttlpFhQuLcBTNNfgmaBk9ntrpJLLk3wnuml/b9KS1rt3n54T16PVOy1J09
	 1ykIQn5Y7cXPrUiPaApeeL1RWaIb6URKtikQgWHLkun/0qRCXQJZ92PtXzSZ6CmNGjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1OYlMqVxmreQEAJwG52M6TsnjfE3/VsBgRd8k7XJlTQ=;
	b=mYtTWSH1wrGsq8MjqYmxR7RIKx21CUzk6pOuWA037l6HCGjmYxz0lQAL8Z5Nct5PFoI9
	 uprlwiNMJEG2SmNbMzjP5qATuAoHDEHhE68BZeiMYYN7za3aaQpLGtZrMTn1myijzXF7H
	 LnqeNfTVSL2Lc9RrFi1XAKRIqkyMcT2i/M1Ue6Aq3MHSqFkgQD/as1lk3cVimbd1Yh0LW
	 nA/87YMNnsooEgn78K9hVz640dr37XVtCUi059liM9VL7LBTm97VDIa/2vZRaDRN0UJo6
	 EFI51/Ohb0gM0vQ1lzq6wTt3fuE3ainJjK9TeG8iZqLf413kKkJQRcxWaV2/+M5YGwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DAqLHKDh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481C606A31C;
	Wed, 11 Nov 2026 19:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C481C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DAqLHKDh
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiaj31888036;
	Wed, 11 Nov 2026 19:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1OYlMqVxmreQEAJwG52M6TsnjfE3/VsBgRd8k7XJl
	TQ=; b=DAqLHKDhaaP5irz0QL701YKgU24XFuPqaeZSMtJMP18N9qd+ZqfZFotq9
	YPlBoHtlI2haK1PBDYogoR0jWVTJl0T8yUumop6l0KX27MvEBzG0RRfT6rlFVktw
	qPaKaJuMrFPimyZghcKoZfY+36gS1lzOcDsm5e0hpOXRmAMalW8FqkpCaIY50M9H
	pnquo3oeYUWhkKzj95CydGCIl7P43PqXR6hqHhgEveIubo7BEOAMIhtUGNOy8olQ
	6v3RD0BjpIRakIJ6u1yk2TsoY/z7ddY2einICpYTL+dzOHn6PmwMB9sVkUr1B918
	9b1pKMgYSozjEz33WcJm79e/dyXGw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq74191-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ4N13822817;
	Wed, 11 Nov 2026 19:23:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthv6s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNA037799616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E78158065;
	Wed, 11 Nov 2026 19:23:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8982358052;
	Wed, 11 Nov 2026 19:23:09 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:09 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 00/14] s390/vfio-ap: Add live guest migration support
Date: Wed, 11 Nov 2026 14:22:54 -0500
Message-ID: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX/i6QduJn0T4x
 ycLTBvN5/wuO054Z3GO5JHJUOKMIYBQ5y3ys/n12tUxWhJnYPXwx+imukRGXPzmJY0ayXXeI1XW
 3CeSAv70E+5jbC3iCv+X8ECk1j/Dryc=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af4c0a1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=XCssrilYV6wRj-C0hOMA:9
X-Proofpoint-ORIG-GUID: afz4RzWNx85EgT5v4zpNoOIPONJ4btDy
X-Proofpoint-GUID: afz4RzWNx85EgT5v4zpNoOIPONJ4btDy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX7+sPV6B0jkNC
 AbUUwncxLlEwNYRUDsGG986/6qIiQTiG7i5Ge7MX+DQYRZQn9bbEUORsI+uAn71WF0GYQ766zQ0
 98DUDBs79KbV8iyQct+/7/XOwbDXp6RNWODVBv+S32lK7B6lT2/YLDptZCtwMbwEsnndbjUi6Lw
 x3Jz5khNJPhYqt7lnmk4jm4WbXd7EA0nBPXJX3kCJX/LvsMfAS94kIVcT2pRSGImza7Sx/t6o0n
 y3bqqVPzvI+Vb1sZIP16Rk/kzU+7oCztpkAifwDdxTh5wJJ6VYG2DcugFVEOYw0FSKg21XcQm1y
 KANKUHxClaVcZ1hTqLHGyJ1zmHNwtDgXi+hz6KilhuCmoa1a4b628GaWQzCk+Y62XuwjhrJN4ri
 +skSsYwYBtmwwGkPZLzrFLe3oRnkyxCSRGevblyUxKEzL2+vc+Y+d7afwZzdX8+w9YvRBm4eHwL
 KC7wVWgHs01RzCmOdNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110076

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

Change log v12 => v13:
~~~~~~~~~~~~~~~~~~~~~
Patch 12/14: Set up for vfio-ap device migration
* Fixed commit message
  ~ Removed bullets for initializing mig_state and
    resuming_mig_data_complete
* vfio_ap_setup_vfio_device_migration()
  ~ Moved below the definition of vfio_ap_migration_ops
  ~ Removed forward declaration of vfio_ap_migration_ops

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
 drivers/s390/crypto/vfio_ap_migration.c | 1454 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |   70 +-
 drivers/s390/crypto/vfio_ap_private.h   |   12 +
 6 files changed, 2089 insertions(+), 106 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.53.0

