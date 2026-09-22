Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51425B0BE
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059401; cv=none; b=DsQsYMyRKlKIGOf3QJppYEbnNcP43zI3Hvn7318HakRstd5LqvTMM6g64DqjPcir7ZNDVRzIQ1Omod4YiKxNdSu0A06iy4cbVP5ep0eUbZM/Q+3sBBizZ0SbG6PeeRwGnp6lupVhqhY/rtEfqzrHhfRgsLkMMa9NfsIm3gJFMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059401; c=relaxed/simple;
	bh=Xn0ipRuey+QHaD+hRWucbGGNGAJQi43MqYYc7iKU1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkDQ/GHSEz27e6+h9244rZn0dThIp/w3Ix1lSqOJJMgxZo71/Ng9VhKR7+xjRNAWqe9PKCy9fw6Y6negpKMlt5TV3LbL1hTyvfVRBjj+iIWlGX15Wfy1n7GUDvP1uJkXagM7pJd2GlEeBvNAW+KQl5Eawi89Hwc9DAoP9cS83HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OkfVTuy5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OkfVTuy5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05eLP2980370
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YLLKQ0qDfE0cXQHdH
	fYqGvFGLhG9S+oZrcRmGh9u4o4=; b=OkfVTuy5DFLXsA5HZl0qHb9AwkfR4S9NC
	0eW+aDWNP6G7u+a8O2PMbOebe2iEGfb1jnn7N2yvthRswkiqhHQyI3zA1nUCnoyX
	/CRBvKTlYMH6i6p/xXddDK3Asi+8GszCn9RciuGzrr1Tj4fdxv5b+AbIuc6IpJwp
	j4mEDWC7zuezgcSIa+dlNPMRAqxUZonW7Wa1CShq/GMkwombypDfPVCJ+gev8mBe
	zS0SNPFnfJLLgdtYQ5HxbmJ6yTF/mnYh0LBONB4piY3heJoexp4DEyCXtcYLxCH2
	xZSz56NLOuk8aQ9AqWV7qDhkBHx8QXYZSkp0OoqThDIpMSM77LGvQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv43ff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5eele2085634
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq8t8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M6h4wx40239522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 06:43:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1902D20040;
	Tue, 22 Sep 2026 06:43:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7B0D2004D;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v6 4/5] s390/sclp_ocf: Fix computation of length of GDS values
Date: Tue, 22 Sep 2026 08:43:02 +0200
Message-ID: <20260922064303.524293-5-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922064303.524293-1-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y9CPVxt5BUzkJjLJSuyqXayvO4tOPkGv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX+hT2OLWzEGYk
 5BWmRQ3h9zAgRani1QAqUFiElheynkk7qIRe2BOJompzgDKt+AYaJWxkY5Z3d0m0B6anykmxVY7
 14fEeX6Ewm9nOMozrQQaEcMJ3tl5j/s=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2237d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3p12VsNbHHCjkpGzt3EA:9
X-Proofpoint-GUID: Y9CPVxt5BUzkJjLJSuyqXayvO4tOPkGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfXzW6xocxWrOfi
 I10O4jUlc+SulZ28DitAff6lYuWPtWXNfZWHnN4N3AmcS7zwrq/oq6wM4f87d+ZKMLYgeYZgP7D
 GElbz+CB+H82Y5CuSHHTB7PwAod3Tfp+ZkSeOq6/fFgY/x0XHQRfkxIsF6Gjv3JPzIDzUhWV/Ag
 SOBzv6/Zi2hwsHKw0cdVt8cs6XeExmi+w8BwyHjRuPRA8uHkX/POt0bfWGITTFru8A/Nq+sScRa
 KzywbmEgwsS9tDJgiPjWj8MSF93mWy9Y+FRmsEFIEBz9bCjK4BsB+4zlCAVs/BVemWJMdiUirEy
 ly4jd5Ly9Cdaqhcm4wq1eFqeySdmiP564snG5snddpNN3ZeKb9awBYIIucKrsdKK/HGi4YrC7Iw
 h/acLFrfX39nYvTHF3ZR/jJaQCcyrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609220093

Fix length calculation for HMC-network and CPC names in OCF event data
by excluding the GDS subvector header size. This prevents a potential
invalid read access beyond the available GDS name data.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 7eb9d5bec552 ("[S390] get CPC image name")
---
 drivers/s390/char/sclp_ocf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ocf.c b/drivers/s390/char/sclp_ocf.c
index 35f3a4a08b12..cee4bfa4a48a 100644
--- a/drivers/s390/char/sclp_ocf.c
+++ b/drivers/s390/char/sclp_ocf.c
@@ -66,13 +66,13 @@ static void sclp_ocf_handler(struct evbuf_header *evbuf)
 	/* Copy network name and cpc name. */
 	spin_lock(&sclp_ocf_lock);
 	if (netid) {
-		size = min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length);
+		size = min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length - sizeof(*netid));
 		memcpy(hmc_network, netid + 1, size);
 		EBCASC(hmc_network, size);
 		hmc_network[size] = 0;
 	}
 	if (cpc) {
-		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length);
+		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length - sizeof(*cpc));
 		memset(cpc_name, 0, OCF_LENGTH_CPC_NAME);
 		memcpy(cpc_name, cpc + 1, size);
 	}
-- 
2.53.0

