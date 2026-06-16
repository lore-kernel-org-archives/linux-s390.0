Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0E47AF67;
	Tue, 16 Jun 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628684; cv=none; b=Sba3NdVOr5FVpSHUNye2AJGpwWZI45169Op6sKX48uRjpu/DJwwp+uPTxeM/75LxdEbBdtpQ1Lo6CMfdg/Rg4/N2CwuBeeSWl33/p5PxxExoMt5unojTx6j9ghv1iLR2mpiZwsViESkNs+InO7C01aROiNYpBXkG5xUssSpRCQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628684; c=relaxed/simple;
	bh=oPjOyf3Hgbx6tuk6sQAUVHzo31rRBbp8eiOdKXU7eDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw4Nwk+73xD1rXF7WhgtUqT2YQi5k4ZPyDK34hJH/lRxizF23rRRWWcIUSiQW/Zwi2jajObJqkfogWPefdhZwgBvGPTT3mqEQK3lQ5xrcGuFFy6Ihxvw1OsQ4MUzzd4D8yBRm64ZL2BxPMA84Zpz8Ze5MS78vQeFNXuN7G3hc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bm1hEsnb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bm1hEsnb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFmPV11969377;
	Tue, 16 Jun 2026 16:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eXfq10rdjq2dwJz74
	2ligmWaaqJDzL3+tscnHm/Avgo=; b=bm1hEsnbjHiaS3Ad/SuFVHe5DhRhg8j87
	TE/8XrOLNd2ay7/FqV39OORiOcF/mOyK4DJcFUxqSR+RgfPaKifCJaySPNU4RnSz
	NnaRY3YWXjEZBKHMb1HXnzWzjUwYO0j6BfbBUoHEPDyY7hDFuCn1Cr4K45rJmZ5h
	xlKs33UWXOm24x0ZPOqZNgvfFgJeXv3WRgz64tt8ZGA6TBwk2tp5ZQpOHxSYkFKu
	u4I9CG+9EvGlV/acYEtFH2qdhYN/YX4GvASbeY2G4oRzm8+uZiCpFbY5RpEvGPq3
	chGmhIh5SqcwK2afkXG1KNDCnd+fXCN7MQMluHMZgVmb9lZZgRZLg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23npwq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GGnbTp010323;
	Tue, 16 Jun 2026 16:51:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h4bsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GGpGsd30278238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 16:51:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C495120040;
	Tue, 16 Jun 2026 16:51:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC84520043;
	Tue, 16 Jun 2026 16:51:15 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.66.4])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 16:51:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v3 4/4] KVM: s390: Fix code typo in gmap_protect_asce_top_level()
Date: Tue, 16 Jun 2026 18:51:10 +0200
Message-ID: <20260616165110.360921-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616165110.360921-1-imbrenda@linux.ibm.com>
References: <20260616165110.360921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a317f09 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9Lu97PCYw38bWmK0XoMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX3VGOGkdMtok2
 TvXXkfQ4UDa4S/OpMJye+G2+9+1WYmuBsHhMm6qRO/YM1hFcIJhwlEQEfDe1Ioi7cbBrUMqFfTy
 csk2RPrlUuRhowIXbR3UgTsxdNo4IRLgvgtXlU13E76mHw5dATW743dCctd7dMrix0j4nWSx2mE
 4us49/O6PrJVoVYHkg2Br6UCFBFxtLp5Zygu9pApHvZn5D6zT1rEHNe4mhdBCdNfNS4DSLOGN0j
 4tweXq0PNM4h4yooKz6023rqqmoFEXJw2n44cErGiDBpLcVY9zau3di2PlHMBmoLA2Yz7dEXWQx
 Oj3zuZeZIgCpcJHgFTKAB+fybHQSMpihpcUreQF2ZIrLkAKzSvW8/xxLXH+kXjXG9pd6DIi9sKB
 0czXwQEWryxZsuq6P20JT05d7ablNdGr7OTF/J35j9LdJbAI9xWXoUomHMu2BWI366kkqd+WooA
 hOTzI4fNUqNahSmiKQg==
X-Proofpoint-GUID: 4ZGFgbzs5V5Ygy8Kdzz9M5Mg7qDj1scy
X-Proofpoint-ORIG-GUID: 4ZGFgbzs5V5Ygy8Kdzz9M5Mg7qDj1scy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX1WZsvwJUXHs+
 Z8jQTV9iMgkd2g2PLG75kvg+FsZwmeZfRH1MQay+hxnL5XFLmKM8E3cY/jzl55rNA7hOrZy9SUQ
 ZPoezufIeQzjvP4dAs9LTo9EcdfqZx8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160173

The correct length to pass to kvm_s390_get_guest_pages() is asce.tl + 1,
not asce.dt + 1. It was a typo, which, due to fortuitous circumstances,
did not cause bugs. It should nonetheless be fixed.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3192f610f696..e6e786811db8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
+	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
 	if (rc > 0)
 		rc = -EFAULT;
 	if (!rc)
-- 
2.54.0

