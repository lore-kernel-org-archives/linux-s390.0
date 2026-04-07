Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6C2BDC05;
	Tue,  7 Apr 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595072; cv=none; b=ZBSw/omd+hYwJip7PH3dk0Cfs0TD5MwOXfkpWW0b3zO7MAXOPYYgSh3HvauZm4IZpIuawcHHYcW7RJfeg/tkoe+j03DlQK/0C1o9ud9zApoRbCFBRV4UIGBDz112iguMAQbhkUVSmukoOc491h5B3I960eThLMLxlN+xT6ZvX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595072; c=relaxed/simple;
	bh=vwIMkNDmxq3e0iqUh3k+MGmogbITT6kFRsLOOKNrDPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B79eW+2HRj5eH20OBElKpDvAnCiamzSqYJ1wnXHLCjqIMf4uEkoAV9jSQ+hghPlhKvFY3f5sPGB1xIml0ysVGwpAbdmcVawmJ8HJerg9bf2E/Nt7+siPpk4cftPpXM4tCbBaitW8T6U/1+QRNDJiLWC06kBY6ih/afTguJvm8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gP2DOvmb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gP2DOvmb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637ESRFw2590966;
	Tue, 7 Apr 2026 20:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7JBK563Wt3NdaHpK7+KJRUtgWIqZ
	AWbcUKXngcf+NRA=; b=gP2DOvmbWTBLczurJ+SsJzrrre180RCPmcmOzRWIaMH+
	l0yUQaf26K1/rnwGT1JxKx7l6LKELgeQanZH3IFHRwJlb0/PD8vWjhUWgX0RrgQ8
	pt1G1ynySFdq2TR3Fs1bZxMEAVlyK/cDrc32TM+noMD0xZiyXFSM5E7V8K8cGReu
	IaVtGK93/BV8RsriS6fvbOHSbmFSnHErFwVqZccHwdEEDscf6ktraS3wb2jhJTqP
	5P/LAF5ftxuysM1+0apv6f1hBYtGmcTxK7oj7C0vra+OWL1snpBhcbMXIrIIXcru
	ehipCY1/wgALOoL2SQE8Ah+8lsO6lyMzvV4LRtJH/Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e53av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IgUHm013824;
	Tue, 7 Apr 2026 20:51:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf44umm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:04 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KocwT30736906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:50:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB0055805D;
	Tue,  7 Apr 2026 20:51:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FD0D58058;
	Tue,  7 Apr 2026 20:51:01 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:01 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 00/16] s390/vfio-ap: Add live guest migration support
Date: Tue,  7 Apr 2026 16:50:16 -0400
Message-ID: <20260407205100.331150-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eeEJaV10Cg12Re5O8XtcinqNCmF6MH0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX9cU5iWf6Uhz3
 y6ZtB+jNMEnEeGRreD2GJgsg8CFjwFudWnTGYNzsv7XRMCMo5bRge0OdxoOPJCAVFQxmuRptbEn
 cm7vFqJ/iL0CWsgHy93jCwqrnDfBymnh9oc9CoHIRwbnuG3TAJ7dedqme6dG+yPXOENAD2SBTVA
 Jbb1KnLoqcF2NhoIJQK+ma743M8iKOEbB0tYSLF3GnYs2CzvN6/oMLe16Uw7NJzS06/XJa7MgHC
 jFQNPrKKddS9blDNq0w8SHh32fAkEdTHMHT2WwKZiKa1vIeW7ekvsWJ1c2kDoP6z2rUakMMjDuR
 3tn4YZDovhE35chVT+BO2ouJ99/QtkIiYiwt4RlG5ihq1L3F+N8PMT1ZQvRkHFWt2WyZjtbulTy
 LQziiUarCFA3VB3gMO4sI7DM1JZkl87lOVv7VVgIQ6dmw5vGEsW6M6bDfuuQwX5ae7XeUCn6Cpg
 aDOBRTwjwhIONByjbnw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d56e39 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=qf4gfuq51q0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=XCssrilYV6wRj-C0hOMA:9
 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: eeEJaV10Cg12Re5O8XtcinqNCmF6MH0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

This patch series implements live guest migration support for KVM guests
with s390 AP (Adjunct Processor) devices passed through via the VFIO
mediated device framework.

Background
----------

The vfio-ap device driver differs from typical VFIO device drivers in that
it does not virtualize a physical device. Instead, it manages AP
configuration metadata identifying the AP adapters, domains, and control
domains to which a guest will be granted access. These AP resources are 
configured by assigning them to a vfio-ap mediated device via its sysfs
assignment interfaces. When the fd for the VFIO device is opened by 
userspace, the vfio_ap device driver sets the guest's AP configuration
from the metadata stored with the mediated device. As such, the AP devices
are not accessed directly through the vfio_ap driver, so the driver has no
internal device state to migrate. It's sole purpose during migration is to
ensure that the AP configurations of the source and destination guests are
compatible.

Implementation Approach
-----------------------

This series implements the VFIO migration protocol using the STOP_COPY
migration flow. The key aspects are:

1. Hardware Information Capture (Patches 1-2)
   - Store AP queue hardware characteristics at probe time
   - Provide access to queue objects for validation

2. Migration Infrastructure (Patches 3-5)
   - Define migration data structures
   - Initialize/release migration data on device open/close

3. State Machine Implementation (Patches 6-13)
   - Implement required VFIO migration callbacks
   - Handle state transitions: STOP → STOP_COPY → STOP (source)
                               STOP → RESUMING → STOP (destination)
   - Use file streams for AP configuration data transfer

4. Validation and Callbacks (Patches 14-15)
   - Implement migration state and data size callbacks
   - Required for VFIO_DEVICE_FEATURE_MIGRATION support

5. Documentation (Patch 16)
   - Add live guest migration chapter to vfio-ap.rst

Compatibility Validation
------------------------

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
------------------------

This implementation does not prevent configuration changes during
migration. Configuration stability is an orchestration-layer
responsibility, consistent with other VFIO device types. The driver's
role is to validate configurations and provide clear diagnostics when
incompatibilities are detected, enabling orchestration tools to implement
appropriate policies.

Change log v1 to v2
-------------------

- Removed patches that attempted to block configuration changes during
  migration due to inherent race conditions and incomplete protection
- Simplified approach focuses on validation and error reporting
- Reduced series from 18 to 16 patches
- Rewrote the description in the cover letter to better describe the
  patch series, remove confusing comments as well as references to
  function provided by the patches that were removed.

Anthony Krowiak (16):
  s390/vfio-ap: Store queue hardware info when probed
  s390/vfio-ap: Provide access to queue objects and related info
  s390/vfio-ap: Data structures for facilitating vfio device migration
  s390/vfio-ap: Initialize/release vfio device migration data
  s390-vfio-ap: Callback to set vfio device mig state during guest
    migration
  s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
  s390/vfio-ap: File ops called to save the vfio device migration state
  s390/vfio-ap: Transition device migration state from STOP to RESUMING
  s390/vfio-ap: File ops called to resume the vfio device migration
  s390/vfio-ap: Transition device migration state from RESUMING to STOP
  s390/vfio-ap: Transition device migration state from STOP_COPY to STOP
  s390/vfio-ap: Transition device migration state from STOP to RUNNING
    and vice versa
  s390-vfio-ap: Callback to get the current vfio device migration state
  s390/vfio-ap: Callback to get the size of data to be migrated during
    guest migration
  s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
  s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

 Documentation/arch/s390/vfio-ap.rst     |  325 +++++--
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1095 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |   66 +-
 drivers/s390/crypto/vfio_ap_private.h   |   10 +
 6 files changed, 1395 insertions(+), 107 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

-- 
2.52.0

