Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F20F38655A;
	Thu, 24 Sep 2026 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230173; cv=none; b=KQ4gPBmmlvdJI8+dBr96hLm0DSUyNb00KP3KD93tv3yPQKAbsiPYVhEzFEH5zD6Ux4a2Vva/rjKdY5ESYyb3rPY7z47MOe0TRvcyLtPFZ+0WqQKv6TauDIxIPLjSJmBHLt9/RtOtCV3gPMCHjj4N3jSrAodD9Q8T3ORVsT1uags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230173; c=relaxed/simple;
	bh=C1eFHGohaRJAuesZuYFhK3HbNemkoqfNclU6qRNG0LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qb6vNZow2XAu01RjLk2C6ei5XEMwAaHMp3oWMbu0ikvRQqmhkXQC4cTsVK+OGbSgScOxgYbJueBkg4HjHAfwOVK6ygkT1u09+aI6YjckKD9pWFvApF8FiteFxufUMfXRja6NW/ZvLyd3UfEO4uR24ACjtuqPeDqAz4uAnXeq4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nrxl2hta; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nrxl2hta"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bLBX1333868;
	Thu, 24 Sep 2026 06:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IwNXKrbo9s8sRFHyG2axCTLokErDaAuf9tqQlt2QG
	YM=; b=nrxl2htazTiFm/jvfOr4LIMORLK9YyQSBO0P1OAcaGlXlSFqbSzIuLmna
	TpYI3ccTvE7ycXPar1F5sajQmljMtDadiYkJZ6x3spHDkPJhew1N6/p3nDStuEbx
	WdJQ6t1cLtBNxtfWLinoXzu7CXkl7wsqawO6mwlwa4021QtwfckVif6Pp1G0huZM
	q79ZkzErZ/XMg4sPOq5Qm6EftiJZano7q9MYCrJRnU515d5fTye6d9SQfbkFL1Ac
	SRDkGm2GyXrizLRYaeIR50H2DacUZ/j1enq2Ddg5xyUU+rjkj8JWB8WB7zZJ2siQ
	ZjdSIFySVoTeEn7XqRyfYfPIAqtWQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsf9fe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 06:09:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5ll601497500;
	Thu, 24 Sep 2026 06:09:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8v854-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 06:09:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O69PNm41353718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 06:09:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C189F20043;
	Thu, 24 Sep 2026 06:09:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6AB420040;
	Thu, 24 Sep 2026 06:09:25 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 06:09:25 +0000 (GMT)
From: M Nikhil <nikh1092@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: M Nikhil <nikh1092@linux.ibm.com>
Subject: [PATCH v12 0/2] zfcp: Use DMA streaming API to map I/O
Date: Thu, 24 Sep 2026 08:09:21 +0200
Message-ID: <20260924060923.3076902-1-nikh1092@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4be9a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Wd4ccqAm3J3WqkYLFQkA:9
X-Proofpoint-ORIG-GUID: cZFDZGpSs-Fe4j-mkGirFJpPIhgqhdTQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX6xIp6hxMsZMU
 Q2kA9v5C97uyrLCiDvLDEjSe9X+O8GdvXaclpR1wSa0msq0AVfZtsV0DP5e86eNZYz0TDruwSUU
 lWDE2PLog40kwwk0kXz1Ow4lQgtnMU+SwdCSIW5BZSiDUy9tR/2FdFL7JUsQMtYGlkNmtVG7wcC
 VnOP6TOBcbrx8bsO3lnDrI4k7QNzNmcHcMZCnE817rwPJqG+yGayonwBmR8iWL99R8w0Kx/bGSq
 UhS44apMjV85ZIxWSiVnBNSzXtafi/UgaAOraI1ad4YeWD/z9FFL8y7jOO4g7iN9NEw0tmNMjtM
 hAiX1govY0zPYbsFWkS/w/qG+oIVi4FOBiXLWuuDL3rTef69pwEZDi4WkmqfXHecy82OvS7c29w
 /LsP6MmZFIwHNEMS1ZUJbS8f1mdKmfPmcKlqQfmil+Z1RZp5e6EmRw8DYS32+b2JqpHEf5kqOoa
 OVk0LPfpKsxLlE3kGNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX98D3E6pCmenY
 Xu6KUXyXQGCq4VdZR63oSMTrx4vVFLmOv9bTHFqLgoPFmiyv1sZG4rsnK2sl4h+cqsvVTSUc85+
 WxrKfQh0+xYF1g1TvPkZ7SuNXdyaaXo=
X-Proofpoint-GUID: cZFDZGpSs-Fe4j-mkGirFJpPIhgqhdTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240026

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

