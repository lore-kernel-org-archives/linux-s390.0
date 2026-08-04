Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46273AE1B9;
	Tue,  4 Aug 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845216; cv=none; b=iXVTMFV//jlCvLAGqSeA/CWaV7q4/0wgbfy6m9SchvEULcjUqtyZclQNTJA3mX0PSCU258g5wd7/GFlwki9aeO5Nt6DCt+5wSMv/GBGErNf/vlJ4Tl9ayjZcuJJVsPq1kxpCuZvDth7TjiFKMloLd38t2NPGdcgspuI8O8PzxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845216; c=relaxed/simple;
	bh=5WjLMNdJHCvLB5Cmbe27if+LnF2PGWwIxN6RPgcC6P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6SpIxej2B1P2pDg6JDEb4gFAOV3aQRz+k4CQ38w3nckrp9grzLMBNJ4kOlCEJpaNO7uacYOhAhm2OyZAVu0NEmU5Hwl3cQSdMU5OF+kK4zol57TqPahwX6JU0v1HuURUdFL34c5Cx2oN0t8uHAAmfVuGORpLgJ8GYmnh4oSYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rbnbsPBn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rbnbsPBn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HqlG383260;
	Tue, 4 Aug 2026 12:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xmNZ9TW12wMT4rHjH
	P+iTsaG4htWSdCV7GbCqhnu9YU=; b=rbnbsPBn7VT9fZJxFwEioqhxcf9JxIWVK
	KuIXs7gzXj7rRoFKijWikd6DIAIX+7/kO/2xKhzx0X+BfMWZD0ejbswteE7drFRk
	ivh9wEXwSUs5+2E/a1CPRjfoLsqmDpZHRTTlNSV8GUBobKawZTvilWR45dPYXxVZ
	DgCODLXih+SILWY3c/xGQapOJxo49T2AZTLMlWTRWQL79a0540rgirhpIulRwSAZ
	TalfN3Sd9kVxBkIGoMlT0IU8iyp93Chw0f+QTSHi9+8/nAhczK8cdkKJ03+aac4w
	cO7Z0Pa03XHkDmTmtTn5ez+sW1McNkWyjWDmD2Q7XZqh5p03UmdYg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eun8du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BuEkn030751;
	Tue, 4 Aug 2026 12:06:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k1tqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674C6gqm6292384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:06:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 997C95805F;
	Tue,  4 Aug 2026 12:06:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C865805E;
	Tue,  4 Aug 2026 12:06:40 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 12:06:40 +0000 (GMT)
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
Subject: [PATCH 3/3] KVM: s390: memory leak in guest debug handling
Date: Tue,  4 Aug 2026 14:06:31 +0200
Message-ID: <20260804120631.736919-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804120631.736919-1-borntraeger@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TH1UukU18Ksc_wJVYsRA6Fqs6oP4wITX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX2NJf9RP2J048
 JxoZ+u3Jn1jWZtt7GG+D7Ke8KZwhuwF4CafE+j0UY0sNo4nwzkXYUjYt8SZp5tA/fEAH08vdXa8
 /jWDi9oOdzoKz7XXCSTN8TrmP7EOrIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX3kholCxciZJ1
 oXP43QnTQhSa/Q9hc4+YKw8VVdVI6DXqouHuAsz7u4cY6TFBVkfRORAFU3/9VyA0ljugrdj5mfx
 a/YyF27Rn7s0n/VCdLbhOORUHpBxHw3Xemc1Ltj49wEUo19uBrN7pzVy/9VzPlwHd3UkUp4+U8y
 Mt5G6Amm2cKR8gBS8lvCaN2LBXZg2EjFQF+XLV0Kdqk9aAFxqJis04kStsPKyjIbCaF26P5Ekdd
 fifkoFb81oDCZ5nigC6HXxGsF79CWVR4sw9NIDG5x9SwcBca9Vwx/8ggNNLf8c+4bl4Ixqg4IZo
 pRSXRtuWysa15QcjNzM2mR6Gj2uxz7q2ePCjBlTrIbyPA9Dr3OjOooFdIxp2eYN/3UTdbEPDa0u
 ajHrs4ihMhfngaCcwCpLZ2g7tYVNKqDZXrZ8J8B1IqMjM/M6HQ1jzSQFA900nT+Qagsj14579h4
 p2ISQB11FFDhrbNpv/A==
X-Proofpoint-GUID: TH1UukU18Ksc_wJVYsRA6Fqs6oP4wITX
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a71d5d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EuSpeD5rqQqXJFU2zEEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040094

bp_data is freed only for the error case by kfree(bp_data).
Every successful KVM_SET_GUEST_DEBUG will leak bp_data.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 69835e1d4f20..4c02dbebb2eb 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -267,6 +267,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 	vcpu->arch.guestdbg.hw_bp_info = bp_info;
 	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
 	vcpu->arch.guestdbg.hw_wp_info = wp_info;
+	kfree(bp_data);
 	return 0;
 error:
 	kfree(bp_data);
-- 
2.53.0

