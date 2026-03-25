Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF03264C4;
	Wed, 25 Mar 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472521; cv=none; b=NUkr6JC0xbAADCuZ4JJ+HO9+KJuY7clXcg9bi+tFeqL18RT+lBBjoMZqlU1LbK9ZJ9YSPpWW8M1o+ZbW6d08XAWvWU9NmRzhJzhP6bML8toHL2E4I8gDYC3uF3neJzHfk/pfgSCSL/BE0bRmx8Bvm7L4DxxZakWL8IL1jgppRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472521; c=relaxed/simple;
	bh=JidwgDqF7MRldWu+qcD2yCE7UnI4/UOAAq6awwqIOoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2ClCGIRKpZ88W0WSKqTf3BgKYKrSVuw57vYIHJ6rSZXD6/AEqr7hMotTC6sdJLKLLi5S+t6vy5MrapXOQAGHb4H3STu5BtTtGVJ/6pj8YIDuFa3Mpr9qWnZ15roO0qtkMrDHz+diYPwmEY+tdsNI40leYDiJRrf110J2+LXHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d7s6csBa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d7s6csBa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PGd1TQ3000322;
	Wed, 25 Mar 2026 21:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Bny60BAxUJInLAND0f7QqXf5lbeB2oMvyzI9y3XDO
	38=; b=d7s6csBaPXXT3BEJhA7GzVb7RGGF1Cd6+dcpoAhWjNfs0mF4XzLL4Ln9h
	ad91e2a+WbDdYcDhtMKWyYsiyC1tQJM5H7TsxYJgaXTCQedZBXSgwSnM0L3Mh5gf
	qGNpwbMnJJ+VpqJhpNaZmfuQQAI6NY7coBal+bZSMjWELrYFTPepi/qP2Zc9qotB
	L3yttj6aoO6ysHo8Ow9bwYF/lbM89O2a/wRRSVq1D3nPlcbXjALyv4rqbFggteUI
	AG+wy1M6ZtGszoMnb83B01EL1O3XGCrOiECta2HpKxYrVHORwmY+ZA2duWwx964Y
	MqjPGP/bwfAaLVtc36+LSowK26ktQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky09fdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJ2PgN009118;
	Wed, 25 Mar 2026 21:01:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnr7qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1pHm28443272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 722A05805D;
	Wed, 25 Mar 2026 21:01:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE9658056;
	Wed, 25 Mar 2026 21:01:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 00/23] s390/vfio-ap: Implement live guest migration of guests using AP devices
Date: Wed, 25 Mar 2026 17:00:47 -0400
Message-ID: <20260325210149.888028-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfXyrVX5xVahmdE
 5EWeEsXmdMQ6YtwVS2GAlbfcjcsEhsdwN9T13mhQ6RoZposCFn3QVCC9+HvKCvq3Tv0lguYawsK
 YxMBZkofuNdVi3wrSdjAkxPCffRCW94B8mc6a4v0OjCNB0ubATByjPgNuBiHQ6gf2S1SPd+wFRk
 JfHHEIY2xQ+c2DGM8da+dTOkC+AOCrU95rGoQohIgqt8Ln669BU0fdPOxBSO5GYh77JDYwRon6S
 1wd7wbw//mlut0s4RUivE2Qiy/k09yWqyXwgIuawOfTLDQ9r8LSkAbusevyXzexA9uRwzy9w2J/
 cuVz/q7bBNL6p7+BfMRtcx4RfW2fQTMskpkJMVGs7/B6gJhgXwRncuYfN+BjJEUAPXekUoPuZRn
 ue4ZnLwJVsyVx3CSYGkwCXu+KOVFgaFTiB/YRAjDYQuyQoeXtVK3ukgYlOP8B/LCN00gPjdDgDm
 l10G/psrgzRAcALhcXg==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c44d41 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=5dm_hwIQ-uxai2U3UpIA:9
X-Proofpoint-ORIG-GUID: WMfCdzg-uJ7nr_xRfLb9FLZE5D557dTY
X-Proofpoint-GUID: WMfCdzg-uJ7nr_xRfLb9FLZE5D557dTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

This patch series implements live guest migration of a guest to which AP
devices have been passed through. To better comprehend this design, one has
to understand that VFIO AP mediated device is not used to provide userspace
with direct access to a device as is the case with other devices that use
the VFIO framework to pass them through to a guest. The sole purpose of the
VFIO AP mediated device is to manage an AP configuration for a guest. An AP
configuration is comprised of the AP adapter IDs (APID), AP queue 
indexes (APQI) and domain numbers of the control domains to which a guest
will be granted access. Once the VFIO AP mediated device is attached to a
guest, its AP configuration is set by the vfio_ap device driver. Once set,
all access to the AP devices is handled by the s390 Interpretive Execution
facility; in other words, the vfio_ap device driver plays no role in
providing direct access to the AP devices in the guest's AP configuration.

The only role that the vfio_ap device driver plays in the migration
process is to verify that the AP configuration for the source guest is
compatible with the AP configuration of the destination guest.
Incompatibility will result in a live guest migration failure.
In order to be compatible, the following requirements must be met:

1. The destination guest will be started with the same QEMU command line
   as the source guest, so the mediated device supplying the AP
   configuration on both guests must have the same name (UUID).

2. The AP configuration assigned via the VFIO AP mediated device on both
   guests must be compatible. As such, each AP configuration must meet
   the following requirements:

   * Both guests must have the same number of APQNs

   * Each APQN assigned to the source guest must also be assigned to the 
     destination guest

   * Each APQN assigned to both guests must reference an AP queue with the
     same hardware capabilities
     
Note: There is a forthcoming consumer of this series which will be a QEMU 
      patch series is entitled: 
      'hw/vfio/ap: Implement live guest migration of guests using AP 
      devices'

This design also adds a use case for enabling and disabling 
migration of guests to which AP devices have been passed through. To
facilitate this, a new read/write sysfs 'migratable' attribute is added to
the mediated device. This attribute specifies whether the vfio device is
migratable (1) or not (0). When the value of this attribute is changed, the
vfio_ap device driver will signal an eventfd to userspace. It is up to
userspace to respond to the change by enabling or disabling migration of
the guest to which the mediated device is attached. The operation will be
rejected with a 'Device or resource busy' message if a migration is in
progress.

Userspace must also have a means for retrieving the value of the sysfs
'migratable' attribute when the guest is started to initialize whether it
can be migrated. For this, The VFIO_DEVICE_GET_INFO ioctl is used. The 
struct vfio_device_info object passed to the ioctl will be extended with a
capability specifying the vfio device attributes. One of the attributes 
will contain the value of the mediated device's 'migratable' attribute.

Anthony Krowiak (23):
  s390/vfio-ap: Store queue hardware info when probed
  s390/vfio-ap: Provide access to queue objects and related info
  s390/vfio-ap: Add header file for xfer of vfio device caps to
    userspace
  MAINTAINERS: Add new header file for the S390 VFIO AP DRIVER
    maintainers
  s390/vfio-ap: A sysfs 'migratable' attribute to enable/disable
    migration of guest
  s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
  s390/vfio-ap: Signal event to enable/disable live guest migration
  s390/vfio-ap: Return value of sysfs migratable attribute from
    VFIO_DEVICE_GET_INFO ioctl
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
  s390/vfio-ap: Provide API to query whether migration is in progress
  s390/vfio-ap: Disallow blocking migration in progress
  s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

 Documentation/arch/s390/vfio-ap.rst     |  339 +++++--
 MAINTAINERS                             |    1 +
 drivers/s390/crypto/Makefile            |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
 drivers/s390/crypto/vfio_ap_migration.c | 1131 +++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  263 +++++-
 drivers/s390/crypto/vfio_ap_private.h   |   20 +
 include/uapi/linux/vfio.h               |    2 +
 include/uapi/linux/vfio_ap.h            |   34 +
 9 files changed, 1685 insertions(+), 111 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c
 create mode 100644 include/uapi/linux/vfio_ap.h

-- 
2.52.0

