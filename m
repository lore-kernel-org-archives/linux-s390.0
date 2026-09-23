Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7399455624
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149216; cv=none; b=VyvN245pMSMrzEfdRrn1PIUWMok9q5iL+IVw0ORGcnMbpG3X8lcnnEeaCh/WwvHGyoB/LkimjAa+8BtW3Yxz6sZaQCvAghlb4gJ1ALzV/7zxPFC4cSHkXIfjyCfBReussQMYV32WY2Rjovikg/eS6Ns+R8y6xYyLCNkopkjo3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149216; c=relaxed/simple;
	bh=Xn0ipRuey+QHaD+hRWucbGGNGAJQi43MqYYc7iKU1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVTEG9mHCpWHIHuUU8/3+QVMxIeL6y5DiOijTSQ5RRohUtVhzEOz4XehNnLl0o0YTQfx82AhJzwiI7ESnWCLiVBZfmC2PlNa8VdNSI7EzFYj5D9rWB/zSEnJTkpCPaZ0qlmHWcpE0Mkq4UJd1jnV05f1nSRvyIeRj3+zY/vWBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dsH6frm0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dsH6frm0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N77sOQ2565609
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YLLKQ0qDfE0cXQHdH
	fYqGvFGLhG9S+oZrcRmGh9u4o4=; b=dsH6frm0ZjShxGKsIP2nKO6NvzNP6vbO9
	wSaN1dCX7os+S7uzWO7RpUUXbjsVAJYTQm8jzqSb2Lq//I79uEy73cf1Qkh0nGOu
	NoqcXWSEUA5Rdi+9uoCFvewAMlYFcBGON6laGOhhtB/dXOLcG1J7y4FdGlB0+oM9
	654pU004HT86iRseTH+88JIj2q/dnBjCL5QrjGX2wIM0FizmxZ4Nxkt8hlJ6XOOa
	HATKJprpUGd6F4vIgSWYGpLrBEnEzqOSFiFRAILAWfkJuiS1xHBsQ5WJzfvRuECQ
	WPq75u4JU7byXLEagUcCMTUGTlF/MkJPE/q9NC2Prfr1G51AJjeOw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hgcp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N7HU1p839894
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyd24x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N7e7j252429236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88A6420040;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C54A2004E;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v7 4/5] s390/sclp_ocf: Fix computation of length of GDS values
Date: Wed, 23 Sep 2026 09:40:05 +0200
Message-ID: <20260923074006.3962077-5-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074006.3962077-1-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rke7EYe1PEjecvcv68Xhj3yaUpKL_rQQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX8Xf4Ob4USMwd
 zySTCWLOR2qoGQafI9uOI4tj+hXzs+kIRsX4W3tmrcqz44zF0dHtAurSB067pvwZOkuEAFVAEvv
 fVK7+pJoMCybnoNO4MPWNxSJaqeblodZKKNnEK3YojF/MWm6lHwEVVXGfssWZ0fjaxXf5YdVWtU
 XnHk6EskM5wgLISjwwFTKe76EDo5NB6pCHDXgfJ6hZx6jj5ahFbTNp3bW6e3PFfxhg005BJ+9Mg
 wsdeOLVPikPqwTwoRA8fAUvTNAon6F7EpY4vi5J0r9ttOvkv5LWHMpj4WZOVXyGnO21ZnNtUOpW
 l+4kEWNft7uiXuDJVU6KVuH/sGqONPDqDeZC7pRuEJMsig9lB4kWXg0X5ytmiGZCE7BruvP8kxo
 J9a6Gb0h3YIM5BtOnyrBYMYOVY7K7mU3q8XDHd8EFPG8a31s2WCIXcLdVbwEnpB9mtCR9C18tir
 4vyX5n7H3iqz3MoY1qw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3825d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3p12VsNbHHCjkpGzt3EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX7WLUnRHZXh1Q
 apixparLLcYzrtVrA84BLye1FxmbS+A7se25VKHWY+p7MtCkwdu228PGNjTQ+C8NgIc8Wf1hN6V
 PTyKUl4JIyymq6LJeCqsOT2GSPStRIM=
X-Proofpoint-GUID: Rke7EYe1PEjecvcv68Xhj3yaUpKL_rQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230030

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

