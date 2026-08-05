Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D22430312;
	Wed,  5 Aug 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927907; cv=none; b=IrAUOoXlh181bXEA1QZ8/U47wyFPTnQrt2DGUqENErLuQOn9ib3sHrxQwhFm4n3NFo9rbUZUt474X73AYatPPJoAlSUDn1Ukqsl1Bc1INEaGvsNsZv4S7fZOcfrJuzFbvJiPNOcwHrI6njgfpAc8sd3fhMnt4br4EXHoaUV9ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927907; c=relaxed/simple;
	bh=tMjyiE9i+m1yk7/6OdRzQtBf80/YXyVeGUoP2VS1Pto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJWjntTuYjLFnsp1lLWDmYTXwkVbgB18qkk7wY20PP8q6O7HUM0vETExjC6jL2tM45BTl0SmAI4A1dJ1IGHM4QtubiYtOrQilbunlZjB4effeNu4fLSyVmyZXqdYCIpO4mq4F0DiozogSQG58Y00DtCsJBdOeEZigROwahnXL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UpMvWIFZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UpMvWIFZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ldHK3288595;
	Wed, 5 Aug 2026 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BdV1EEgZTdS28cIdH
	TdG/ugUikT1YS4Lf6lmOP0HUgo=; b=UpMvWIFZvpskcXTXOxcCB3pPma15j05Nz
	mMgjIBrTak63jEU/bRJ2R8ybf3ajAdtnxKfLTlsgSn3pkLtV0+MzPmbM9+y2MrnN
	FaES1erFg5+GWTJ5QuHttrG/rBvBJA3+Rs0Lq41hFSGA2yh9Zmbe8qIA+mv8VJAH
	K0sJim/GAse4+OeFL+VmJSJAl7SdIT7XHyx3D9uIaaEJqQ+od1ONxFJxNllbLaY2
	4DkWqb/8Yq+CFXkHOpRKxf76blDyjkY9sPoI8TDCF2eZtS/2g+vXQ/GjyPM4YeF5
	XHRZ3ROPPtWF67gAF28A7lXcIvfH8XB6kZjdc1tziHRB10YGFL7Ww==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htexv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuJOG003253;
	Wed, 5 Aug 2026 11:05:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6act-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B50a422610502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0AB858219;
	Wed,  5 Aug 2026 11:05:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D037558216;
	Wed,  5 Aug 2026 11:04:58 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:04:58 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v3 1/8] KVM: s390: Remove user triggerable WARN_ON
Date: Wed,  5 Aug 2026 13:04:48 +0200
Message-ID: <20260805110455.7200-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805110455.7200-1-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX90OoFZALQDUV
 6bLJX1x47Frz/YHITXUhwxgwwwug3lqnLk0MPCfXM2zdDGtueRkY4b1qKe3G+nCSBREZS6vAkL5
 kjVUxS6WyXmSfSfCW25mLLU5DBiqWnw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7318de cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=-vZO4XS2Tn_gDkGoK2UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXzd/bxr7eNjVq
 qRQg4+yQHwALWBy4PpmNwtF/KcOAOPnQ93Zx63Qq+M5vWBIOYg8E46uGt4coF71paG0aVH2sJyb
 w6mOibm0oMPQlHw35ER13fpAPgZSa7MHzEP0hOcbuAz5D+9wUXw5/vbzy9hKg5KK5JoYy0gDy+k
 K4XnK0qm0bMwHxrar1S3iDRhcbU9x9jmcHDSWJoSt2EWOAs8VDV5yhEjK4d2EYpkKDy8tENviG3
 8TR4xueSfetlhqmAaWnLYMPWehqB8LqrbWZMH0r5yed5f7xFohtZKPvJle9j2WSFhCfTi/kPt04
 Tao6hooqCgrig93ZJEefo7IyjAQXO2jeozh+N2nDr7KgUP1FMxibEHvt/CS5c8Y2jw8z9l11VUF
 5S0Q1+OLiHuzzlna+R7bCRFWKvHucMMmgOhSITHFYvjnAwfX1u5gMK9jKdrsfhJEUwAMp/xRMu8
 GY636DxwTW0vYAGeqQQ==
X-Proofpoint-ORIG-GUID: vQsvFb8SBHNlVBGIq8zdMkR_54UYJjRN
X-Proofpoint-GUID: vQsvFb8SBHNlVBGIq8zdMkR_54UYJjRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

pin_map_page() fails legitimately whenever the userspace mapping behind
the adapter route has gone away, e.g. when the VMM unmaps that memory.
As this can happen without a kernel programming error, remove the
WARN_ON.

Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
Cc: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8f24bcd1a6d3..23f0e0821474 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3013,7 +3013,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 	if (!summary_info) {
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
-		if (WARN_ON_ONCE(!summary_page))
+		if (!summary_page)
 			return -1;
 		idx = srcu_read_lock(&kvm->srcu);
 		map = page_address(summary_page);
-- 
2.53.0

