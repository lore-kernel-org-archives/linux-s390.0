Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A930DD00;
	Mon, 21 Sep 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001040; cv=none; b=u+ARHtsZoFqDwfdnGE4aQhDk5dty80pk6NsK0mivZ2vspqI+4S5lxLEQtP2XuFknXXgD5I6VMrABJfGXykCsKenIdm6X1cC54hforNMOCQXxx5KS46leY9Dpb6aS++TYUjAygTzILT+0/AIeLFahQ5cOPStvrnuB03y1il3kfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001040; c=relaxed/simple;
	bh=V8gbEazb6tXFaEzTBxWKVf4YbJOr4fwO/mW+6t9MkSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqMlPm37eosSod2BWYcAuC2MSr4k8YOvhG6u1L4uKxVO/wzLA989K0YvMe2Cj3soHTX8pqlm46tbPfeZxxHWSmjxGNo8HH8NFWyuHHRYha6OrWszRnXsL2QEbx0GBf6yzabzfEXbaKwR6SwX61BD48horM3Zp1p3JoVPE0cK/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pAbu8pvG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pAbu8pvG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LE5i3I4059771;
	Mon, 21 Sep 2026 14:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sozkM+f+xSRL1Pi/gT4ex4aHcAMoHAh3vWphV/6pu
	/U=; b=pAbu8pvGIafHGdrccKiAdInbjnKEMC+brFrUp0dnZi9MvikxVMqP+RIKo
	SNW5EynY93CFi9S/pb2VWq/OQgzJvWPANolnCSgIgC07XfBj7lqUXMXa9sPVau3M
	xklNPLWYwHlhasvtzNnECiiK7V1artx7EfsG5R4A64c7kc7BKH6++zYeIBalNl2s
	sbWihKWursJLo3lgajMhu4/74ULYT3I+93clsPjljZVgfHBHr2K8ARTTKtL8d4HS
	9k85x2jT3ItEM2oW+MC3q0cZTm9Y273O9Jr0FrElm0RZWnCYqpWAEtWtoJErpss9
	Jd0ccbL5AAIc2geu8TSHgtP699TaA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1h2uw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 14:30:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEInEP2318985;
	Mon, 21 Sep 2026 14:30:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy5ec4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 14:30:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LEUXKr49873166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 14:30:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B71D62004D;
	Mon, 21 Sep 2026 14:30:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C6302004B;
	Mon, 21 Sep 2026 14:30:33 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 14:30:33 +0000 (GMT)
From: M Nikhil <nikh1092@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: M Nikhil <nikh1092@linux.ibm.com>
Subject: [PATCH v12 0/2] zfcp: Use DMA streaming API to map I/O
Date: Mon, 21 Sep 2026 16:30:28 +0200
Message-ID: <20260921143030.356432-1-nikh1092@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kYI4OgL9kIQR2M3caCQNiEUjvZNIKYDh
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab13f8e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Wd4ccqAm3J3WqkYLFQkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfXy6dSqopNsHAN
 3my4uEPVo7ptZaQoXz74/D8r8qo9sxXYKGbBRrHTfvZRpZSMt5nn69a9LapfAO+Y0bE5rfasov0
 YPW8kNn+YRxrnm3t0R4wg1JlILH9xP4=
X-Proofpoint-GUID: kYI4OgL9kIQR2M3caCQNiEUjvZNIKYDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX3UprpACad9jq
 sUCv+jIQ32UnNd68zHZ50pIC4t8H/P6nX+T2tfWrxsquGiN4ZZCzN0mAGh3bXl2l/46Ik3h7Yb0
 hQi2e3WxYOPQDsmtWTkIFRizPV2R9X3zoDNDdbWTGPbjkRbwZg22tGFByYcJOfC6a13pdSly3e+
 aWJrkXIComXVIuUpyZB+EC2SHRJAziTLWzyin1QmXLL9Q5L0/xQS3N+mHWFOsHyGNkdjdeGWprM
 yzyGZK3ArOGHS4te7XICsm/S4+VNkfJxlxIL7q5hF7qYnKoAeI0OD677rX/ZsYvjsZiz7XKaJOu
 OKwdUklWEJaQMT1FudIRjwBhe4zAh+se2aW9g/bgqOrtIRnGNpRqlz3g2CWIJxhQEpFcQzRxbj7
 tVQbCZzF07q2jYQyyQWvfxK4W5zxbzxq3gZncnRaJ4rCVCG/fykHN/8Hgm2sL/FzUaaYnKFAdQI
 xOuIdmgYtmPydcYBU9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210205

In the existing zFCP driver, virtual addresses are translated directly
into bus (physical addresses) for DMA operations on all I/O buffers
passing from zFCP driver to the device.

Need for using DMA-API in zFCP driver:

In a Secure Execution environment, the host must ensure that device DMA
accesses are restricted to non-guest-private, page-sized memory blocks.
This prevents I/O failures that can occur when a device attempts to
access guest-private memory. Therefore, guest memory pages must be
prepared by the hypervisor before they become accessible to an I/O
device.

To support this requirement, the host Linux kernel must be reliably
informed whenever a memory region becomes eligible for device DMA access
and when that access must be revoked. This information must be
maintained correctly at least at page size granularity. To satisfy these
requirements, all I/O buffers used by the zFCP driver should be mapped
through the DMA API.

DMA API Integration in zFCP:

The zFCP driver is updated to use the DMA streaming API's to map all the
I/O buffers which will be passed to the device.
All zFCP I/O buffers (QTCB, SRB, CT/ELS and SCSI I/O) are represented as
scatter-gather lists and mapped through DMA API using dma_map_sgtable().
Once the DMA transfer is complete, the corresponding mappings are
released using dma_unmap_sgtable().

By routing all device-visible memory through the DMA mapping layer, the
driver ensures that:
1. DMA access is properly authorized before use.
2. DMA is revoked after use.
3. Secure Execution memory restrictions are honored.

Changes on the github can be found at:
https://github.ibm.com/M-Nikhil/linux/commits/zfcp_dma_api_implementation_io_path_version12

M Nikhil (2):
  zfcp: Replace sg-list with sg_table in zfcp_fsf_ct_els structure
  zfcp: Use DMA streaming API to map I/O

 drivers/s390/scsi/zfcp_aux.c  |  16 +++
 drivers/s390/scsi/zfcp_dbf.c  |  16 +--
 drivers/s390/scsi/zfcp_def.h  |   4 +
 drivers/s390/scsi/zfcp_ext.h  |  10 +-
 drivers/s390/scsi/zfcp_fc.c   |  36 +++--
 drivers/s390/scsi/zfcp_fsf.c  | 260 ++++++++++++++++++++++++++++------
 drivers/s390/scsi/zfcp_fsf.h  |   9 +-
 drivers/s390/scsi/zfcp_qdio.c |  37 +++--
 drivers/s390/scsi/zfcp_qdio.h |  27 ++--
 9 files changed, 321 insertions(+), 94 deletions(-)

-- 
2.53.0

