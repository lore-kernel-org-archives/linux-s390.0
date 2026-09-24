Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20D36EAAE;
	Thu, 24 Sep 2026 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226192; cv=none; b=KjANQ5AeGkAXSb5PqPcChiqoKkaorGtS9fO2RznVRtd6rSU/zGabh+1HORkDck6YVgcIk4hFS92elBRzI44Y6GB/fBf8tNGVoDYmSv6aHJ74P1ScNMtK3egrg3MewtAlwIuXYsDZC6buU9kYXF49isF5eXE6Sprek8eN/7oZzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226192; c=relaxed/simple;
	bh=73ZlyzTOwzjD4wf1mAXpiIHbcfkZnOxq/eVWjUFftqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6tjX3ih2KUChjSYwMmfvnxGmrij+oaIOMXDyjuHtV5JtMHbAGnJljAyxFM+26AaEpTZ04Vxj8H2ysCbwK5CxOhf9tASh+uQFbHdnkQHxiePK+p4AcUmzmb6eexrHnNuD2VKNnnsU/kr+lWsKPQ+dYKyb/4H4IA346InOj5/iQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gQ08j1FM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gQ08j1FM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2aTrv977372;
	Thu, 24 Sep 2026 05:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+9JTNbPjMO1tN5oHiZjp5WEGe1rV
	cKEtW2ZTrvtx1h8=; b=gQ08j1FM6F56ptMSFmr7CcxoLZ9cICKL3+GbfMrwV0mT
	c3JkDJh3/0oBDBf9a6x7eAIJzQHVHeXb+dPirtwLm40uhZvVv+k1bWHQI41KQKYS
	CFSvpLwH/xwvkhrrdG8kZ7RqkWdEoTQoAVFg1xufHeynglu9bZv1Jb0SVZARuRlZ
	TD3+92twbYQJRN8FjVFiSsYfFmh5U/Q+wZH82XJOJ92NEczJ8GH7ID9K2OPd82Lx
	nPaC3E2Ky8rEaR/3Szg/9ayPAs5LgdKfG1VWvtvLHqw0EkfPbEwjfMBIJyBYHobQ
	318sONwNyHJIaJMmhWExsTmo3YnnPG23fuDHjNMzww==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvefax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:03:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2ZeUa005650;
	Thu, 24 Sep 2026 05:03:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7e8ch8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:03:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O534Km39256442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 05:03:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C253B2004B;
	Thu, 24 Sep 2026 05:03:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 917EE20040;
	Thu, 24 Sep 2026 05:03:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 05:03:04 +0000 (GMT)
From: Nihar Panda <niharp@linux.ibm.com>
To: linux-s390@vger.kernel.org, vneethv@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        hca@linux.ibm.com, wintera@linux.ibm.com, bblock@linux.ibm.com,
        nagamani@linux.ibm.com
Subject: [PATCH v2 0/1] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware activates.
Date: Thu, 24 Sep 2026 07:01:35 +0200
Message-ID: <20260924050217.2583852-1-niharp@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 46bs4uEdn3PrOk0ns0CoiSwNZf4GvMHR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfXwxg8awGNBj4X
 0J+DXX/cdXtgTYUnkWmPWtDwBNlAWuV0Xv8u/H4Cm/nv4xSzP8kZE69TrWcjZrKGsSdgcUkzN0Q
 XmUuR0qvsUBI2jWmjdDZP1TMjpQTp+Q=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab4af0d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1RjKuTH46G08LcsVwEQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 46bs4uEdn3PrOk0ns0CoiSwNZf4GvMHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfXzORMzyrKri+J
 ERhYl7IHxWN/keSb5pKRRpXc83LcWAEwQhNv5JG2hGzoly4QcMOqntSvc2yaccFYaTbT5RrZ7sz
 8G8KvqRRYg3pdOvs5Ii2TBbqmo6/IIHk4AOxmewMcWJ7l3htLepQvdYTkQh3Mej+9lFPG5mmotC
 fsn5rphDfsxpEzm3hLHIfztX45qrCEGXfbHu+sNIw2NRmrIMKcY5Ux8M2R7NsCD+T8AS+RGlJB7
 U+zo17oYlxa40vyKsQe5O567375qiRK+RzwKFso5psDnM+CktLwmVYqova1LtgJIL7TT/CLBuhJ
 ls+R8Gm7JhEY7KhBJLra643FiKaB8UFTBOv/v2nJbGSs8xEjKJyt9b58UUkpxbFUQ0zjjpaUQib
 zCSQVl7ko0A62xWfU2qP5BYMwKTAR+oe45ATSnPw7H/Jr2w8MdRJz5RzZb40u5DZesbl9IytrW8
 6xLmwGsPkUyZ5AhGGiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240020

Data Race Fix: 
Moved the execution of cio_update_schib() and qdio_set_state() 
under ccwdev_lock.
This prevents a data race on the shared sch->schib structure and ensures 
qdio_set_state() does not overwrite a STOPPED/ERR state when called 
locklessly (as identified by Sashiko AI).

Timeout Optimization: 
Converted the timeout polling loop from a while to a do..while loop. 
This fixes a preemption bug where a thread interruption could trigger 
a false ETIMEDOUT failure before the loop body could execute even once.

Nihar Panda (1):
  s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware
    activates.

 arch/s390/include/asm/scsw.h |  4 +--
 drivers/s390/cio/qdio_main.c | 59 +++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.53.0

