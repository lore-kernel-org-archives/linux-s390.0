Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676912DD9F;
	Thu, 28 Mar 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640532; cv=none; b=BBsklcpzttJVqfDhUTSJtQkJVe3tdVZuJDNdRSykixzFEQCLdXIaTX/sXREu0/G8kbpcWBF1TWG6aN30FzzUI+yYgVOjm+Ucm+8AjY9eIgpQPTZJ3Q3mMyymyC5pIkupGdnsDBHcZdWGbmMTzIl1oJRjI/CARurFBXjPGlLlZ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640532; c=relaxed/simple;
	bh=gQ+kk0SQBBP3eOv3P5/aVEbuzc4SIcGDP0vMIvNg6lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoeahSSZhhrSHkAR9zlGQViuj0nhSDjgSs7xgEMHZYzqapSZXd0+V/XvksY31gLcUvd+HkBtxUvMHhctG//ooIb8N7AF1atHD1tVM9zvRd6rqHYKYgHMr0rEtfO6Dwl4XIgdnoIfQTmf68r1r8jOT8+rm19vEzpFPwo1wNPtp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NM5700hM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NM5700hM"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SFaaX9030045;
	Thu, 28 Mar 2024 15:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+twlGnF486xP3reYJjt5jvhY61DjcP5gxAZnmCwp3pQ=;
 b=NM5700hMTwbkQ0QAC9ph7e1FyWCBiFbpOMIgFauWwLmPmlrQP7jerJurE9C51iyE/d+e
 t4yMuv9BQJsPS5HDu4dZoUiFNiEti0E6DZR7y2JswCujQ1ThOIYkRGe7aM4kgO6GVyle
 EdncqAY3PVo8ghgethGMujz5MLb0afgr8VVpW6exZUPtDldPrBlvEW5E8T5hTb11Xfkf
 dEDtYweWhErva3jQvdnj0exv2GFgAcsPcAiEGbQDPfRv8jeUI2POWIQzdr+Cnwpd4WPG
 OxbxwB2ckbcOuQtZBnoCNvfTYrjTd8X/C65TeidSaASs0Payw67Ykm0qXzSorlqixvKD Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5as083yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:42:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SFg7If007590;
	Thu, 28 Mar 2024 15:42:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5as083yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:42:07 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SCbT0B016592;
	Thu, 28 Mar 2024 15:42:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29duenmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:42:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SFg1N58847684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 15:42:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F8C2004B;
	Thu, 28 Mar 2024 15:42:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77AC620040;
	Thu, 28 Mar 2024 15:42:00 +0000 (GMT)
Received: from dilbert5.fritz.box (unknown [9.171.12.209])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 15:42:00 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH net 0/1] s390/ism: Fix splice for SMC-D
Date: Thu, 28 Mar 2024 16:41:43 +0100
Message-ID: <20240328154144.272275-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -MarECeU7iisMw_8gZ5unuERBbbbB4K1
X-Proofpoint-ORIG-GUID: 7DmgMPNWLmNtiwEXLZL711pGj8_Cy0b4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=997 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403280108

Hi all,

due to a change in the DMA API - to no longer provide compound
pages with dma_alloc_coherent - splice broke for the SMC-D protocol.
Here, I'm proposing a fix for that.

I'm aware that this is a rather coarse fix attempt and a proper
solution would be to rework the	SMC-D protocol to drop the requirement
for compound pages. That work might take some more time.

Meanwhile, I'd like to probe if this change in how DMA buffers for ISM
devices get allocated is acceptable as an interim solution.

With this change applied on top of current master, our test-cases for
SMC-D splice complete successfully again.

Gerd Bayer (1):
  s390/ism: fix receive message buffer allocation

 drivers/s390/net/ism_drv.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

-- 
2.44.0

