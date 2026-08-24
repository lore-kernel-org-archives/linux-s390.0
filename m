Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65A43305A;
	Mon, 24 Aug 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579943; cv=none; b=JimEMA0fvYZdnxx6vA/ktGItJRBlkMxvFcyzGXiVtadI9HfjmxCz5z0wCVTa0cYZsfCzKdld+leBcdCGxBeRuRjqCmTUbY9X1dgv++jtE1THJJFq5a3QmPHWk07phQyqQe1xkzgIJpbF4BsHZhi/zJjNuovPGGPrc1Pv4W93Vyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579943; c=relaxed/simple;
	bh=eT21lP0xl9gav0o+aAgg9jcZASzAhAQ329T5YHSka8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKysWZm9E3NgSKB/ljYl7dcI+mFSIxRpZ5JZwy9VM+jiO5EIsa7iwzb9vn5QgjtJkUsV8Lx/+J/vUNpfNVukVYk2uqxupg5JQQk4c9lwLyi88IQpax+5oB4FlAs7yEgqYz+nWh+hm+xse3ZgocwG/Vf8csOmpzojMCyxfTqFbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vph6eiMO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vph6eiMO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1rSj1846176;
	Mon, 24 Aug 2026 13:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+Cpbp2Ru++Is2gjoiR3U1su1jgewmh+MPCDEj/IG1
	cQ=; b=Vph6eiMO0BGWeBfUqIVzkjMHsDCrUejJo9IujBQBFPEcT6qJLr1YsavZx
	YgxqslyYLXKYIa/e26jE2t82sUqSfj6ZvUv0JIv43Bt1QhNetBlitVl/2n+33jDt
	NBsABNrCSyd4q9yPi/Y3u2eFRSf3y6cl3SkfiUFr9mQ6WSWFGLDn2Py0wHpFkvWR
	TgpyWSWyyvEmbVvuwp5u/zVFG7vX26uulV5s9Vsx4kwGMitr4L5/fJvdfVZwKltT
	5VRm6Eq7/wSsEJ2Ih6HZvoWfeVyA7wTh+1sOAekePCVCuDRVOO1SLHzg8lAM6FMv
	evR+1PmDAwUe+160Tj9SP/HdQUoEA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hhxfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:58:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODuLMU017220;
	Mon, 24 Aug 2026 13:58:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jp8xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:58:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODwrDQ61735320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:58:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25CDE5804E;
	Mon, 24 Aug 2026 13:58:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 670C958054;
	Mon, 24 Aug 2026 13:58:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:58:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH 0/4] Fix pre-existing bugs in vfio_ap device driver
Date: Mon, 24 Aug 2026 09:58:46 -0400
Message-ID: <20260824135850.503728-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX+m2ybL/wLr/5
 2cwK7I10dYujmsngUWbXceQPJ7z2RrkEErpet8/m2VoUYDpuC8CjtHOCGUnhWToDJT7Zk8vwJ12
 CSiDcEER44VIM/PQU3uPfsQQjBoI4cQ=
X-Proofpoint-GUID: 2vrmrPSa9M8hhI21qQy1-tp6qf47Pq1t
X-Proofpoint-ORIG-GUID: 2vrmrPSa9M8hhI21qQy1-tp6qf47Pq1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX9g7jTtEmCLou
 pPJeHWANU/FX2+1bAdreDTqK7OPD8hAsrBjNfRxVLXOXxA62PxOAKylU7+icWzKRkR3y3wdkJe0
 iPUSKN3IbHAF/nx9iTYOawcLE6rzTvMLBKqI8zgd2JJTl0BHmJ2Wz3vsUQ60SsHNv/Le1SKtFy2
 7+CuIO4dUT85tNhiHz/t15Q5xi5Ouso1C+VXqysmjOw/j5NLtPeorCsjAsHkTM8Ua9Jbw9jZVOR
 rI1CF0MRxGhrMv1NeoGPuHVSvRz+5Jdhb6jy8F6XV2i0Xjt29Q6tXCrI59b7ri2lbBMUHjIALOM
 RkmfiuMXk+11ZompmJBefqh77E/loMbtWyMZlY1QmUUUy77zCf9c7ftUKkXjWAhTXinaYn/p2yV
 QNYKjRdAPTnzI3oHWYP5aNqAWREt0Jh2QQGlx8Jiak4C135fzdn/lunafZnGFd9e/bePfu5Za6M
 M+IhrOn5fGvR0vTKk/A==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c4e1f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=fuWVWdFGajcpH1A5QwgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

This series is based on the 'next' branch in the 
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
source tree.

Anthony Krowiak (4):
  s390/vfio-ap: Fix leak of pinned NIB and registered NISC in
    vfio_ap_irq_enable()
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()

 drivers/s390/crypto/vfio_ap_ops.c | 36 +++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

-- 
2.53.0

