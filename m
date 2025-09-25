Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECF2FFFBE;
	Thu, 25 Sep 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815244; cv=none; b=XpaLYR//+qJBg6OW6Pu6iSRHmbjakX7ZS6wkPOHnZfA3JV8f4Mpdt5pFOztEzpDDsE4Uun+EJiByPmLns8PWTdxZu37iIfWerWLMhH9Idze8Ddpi9JNcfd7ujVaV3/ugZg632vkf2g+2LmO9OPYVTnv2cbWfBhQtnZeRFKHBpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815244; c=relaxed/simple;
	bh=bd+uMg5CaeWo8Ubscw80715wocX436eQRMwazxCTxvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/m9XX4SfamMpkKwhG/xpGxDMwhc9gGDpLgJnocBccrDSyJwrU3o0HAYqgwPfJF8q3Rh17SNY9OJ7yfaO6/vx75hdOChEI6n9Cx3iLuGr3od1IW56Y5boI68LpaBGyBbWRsjzusbDqR16VSL4yu0hOl7CTyLdFSza20aMCcf9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AkmpsCVO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AkmpsCVO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P6XCxM013794;
	Thu, 25 Sep 2025 15:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9uwFreGYvHrCa/01Rf9omYlVpFNBnvnNcetyGvFaQ
	Ek=; b=AkmpsCVOlrqQkvEYmp0NpR+EzDGSwXaWe4QNZdZsDSnW1kQCogQgY0LCS
	VtmWWKrlLxxxg2NVEhfNYOCcm9WmGE2zDqnJfJx4g/mxHm4vtdWuqhnLxaj9hvIT
	8mO+RJWIygFohefBZd/lESwxJnF40rGvUeiXhc50tMTmVifx38D6uymT9fjU+J4R
	VWBFGRA+24Ixt4PP3f0HzZQtUYcJOeFjW4/OpnTV5TyxU+zEI6uvWIbc6FdR3arI
	RYURjbxaJIeQpexmIL+iJnGlpSMcUlfTP5PJ69/TaQdOMRf/Ivr+8qNDbdTFa/gY
	de3oPkeIrb5vukPWpoavtTXKgnbow==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkp1y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:47:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PDYOJ8019709;
	Thu, 25 Sep 2025 15:47:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83kem2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:47:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PFl9YY35062060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 15:47:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0929820043;
	Thu, 25 Sep 2025 15:47:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0A620040;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id AE35FE1645; Thu, 25 Sep 2025 17:47:08 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH 0/2] s390/dasd: fix buffer alignment validation
Date: Thu, 25 Sep 2025 17:47:06 +0200
Message-ID: <20250925154708.644575-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d56408 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=u30P7ByRb8RLwmXF1lgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX3S+HmAU29qcq
 OZdP/i8jLS0tRoe4lT1rctnTRHtc8UVbt7HmxJMXqow49hrD+sD6sZpRVzRWxzsOqIJzm/+UBwJ
 FUT50OcYLEy8CtMq+7WYlQAylNOB/ySVkzs9kaTSRb7HbKgD2/nbXJfgcdfkFohQeKPuWKxdSl7
 dAjYW25YJXzdEhcZyRAUfC6Zz4DRg2xNAFbEe0B4FsQmHb9WQxSWmLKFAqNJ2Fos+vHq6FvFr2l
 3xnkeBDnpu5fFwnucgR+eBoysh59ivsuLIakc/YFnCjtPB6CtFxM9G3JuLpKGiKkxs/dGj6nJJg
 FUmvYpE3umdhAGW0u+mbinLiaDU9IV5wKiXv2qMOAfshN2wPw1cysOxzLJLmmUwUmHRSdm7zV/p
 OXYaOv2p
X-Proofpoint-ORIG-GUID: TCC8j2qGdgoVILbczv1VaQv2x_FSJor4
X-Proofpoint-GUID: TCC8j2qGdgoVILbczv1VaQv2x_FSJor4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010

Hi Jens,

please apply the following two patches that fix buffer alignment
handling in the DASD driver.
The first patch corrects the error mapping for misaligned requests,
and the second enforces proper alignment validation in the block layer.


Jaehoon Kim (2):
  s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request
  s390/dasd: enforce dma_alignment to ensure proper buffer validation

 drivers/s390/block/dasd.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.48.1

