Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC74746D4;
	Tue,  4 Aug 2026 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860687; cv=none; b=g6DtUfVSKI+WXwfoLzONe29fVwRLI4hxPkycY6BizYRrjGcMrJojNKxl8SzRcqyA+Gna7FfRbNhibFTlTcCQlrfPTbzV5wY3UMymZWPE85oMHc2GykibtlspJLJrf3pqqxbyPErZScZTiqIfjJb5TPWXM+g0eK+4w82THVjTRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860687; c=relaxed/simple;
	bh=rKE+mpi9CGnthaRHfXWMhjkPWo35/V7FfCf5DC1lnQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY0OL/enIkftqrkBWw2N7nmX13jazy6xHipycGSZWQvtK3xTeD2QabqmeN/hIephy6dabuNwfZ22mmcDEtUXCBc0Bp60LbyN0TWN2W/pZDWHBSutu1nM416JYpc5Ik9JFxzbSjX10SeGCKRGsDH3byY23cKOYU/pqe9FAM8mHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C3iH0vl8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C3iH0vl8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlhtX1193453;
	Tue, 4 Aug 2026 16:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ysyVaxYZ+V2h7SU3y
	Yt7XC3lWDRhF8p1Wt7YYnRLUtI=; b=C3iH0vl8SKqYBfAlzTOz4tfJdlQm/1SuA
	Luplya4ZhX5Qa1SnXeBWyLMhc0h5N4c2bv5XyjfheEC7AGsaZduaf8WFVisbnhVx
	ymP1iAjIQzpke0Ghye7RjOJJ8Ix1TXvpHpUmwr9CDj0AEMU3u4CuqHeJxFXbh962
	iOXmPKRenoK1g+/f/pcVo+ldjpeYORXIzZw39tf65sOAViX0YsIfOtw3mOKdPmit
	bP4qfLJWkK3dM0DIPANleEIpnzNZWQJSrEMZYS9kimngiqQ6ZRt/5UsW7FV3XWMM
	ZcsVq2ABl/qkOKksVmnh4nnLL4KLoXmLCXGcIhM+lq/AHa0hh9qrA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g6gjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBGSs010883;
	Tue, 4 Aug 2026 16:24:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k2qnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOfps32047708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD0A58059;
	Tue,  4 Aug 2026 16:24:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4495158058;
	Tue,  4 Aug 2026 16:24:39 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:39 +0000 (GMT)
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
Subject: [PATCH v2 1/7] KVM: s390: Remove user triggerable WARN_ON
Date: Tue,  4 Aug 2026 18:24:29 +0200
Message-ID: <20260804162435.28617-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804162435.28617-1-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX8a9n8tGvQheT
 FEAVKFY5PSrSFtrQQL56PodiCx30uYXyQD1IVjKR5J8+k8Iq49yBuaiIDl/GEhjuDBbbWYMKdKw
 nEBlB4y9hWuhgzJw2sCZZWK5dpoR4D3rI+sem/WWl5N334DVJgUEoyzuUxalAosjoYA7J5c5sJp
 sNBXxHWdEs7aG2+USV5osUjb48M+Awky9MW3oSQ+UoFKQxyjLrRH9P/MfUqV78fkOv9odc2VIcx
 61VaUFCJbbcf7IOEOnnjgwnh5pPAEslujf3b7K8/W1gof9IW+DFVX2TlcxJJtEM75kNG6FVGNZb
 CeHAceJQN4RAEmvVZsfymnLtj+9doSV7HmemZ6BoA7MJ8pHuXzYVADZsnwCeTvWyobkrZldvpoK
 3uy2JAPCqWowq9boe0CGUA6tjX+LLShdQMI3K9fQQjL2yUkNDweJr5Od0We6U8rIdSr4Vb8qJiP
 v3yBtX+53V/QwrvfXOg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a72124b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-vZO4XS2Tn_gDkGoK2UA:9
X-Proofpoint-GUID: sJB70Ce22wMaBwyKzNWpwovatRnVpTHY
X-Proofpoint-ORIG-GUID: sJB70Ce22wMaBwyKzNWpwovatRnVpTHY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXyhMkOvKFe+r0
 hOxwJ4HZTv2dogkSPPAZIy1zlSRjaLB2S+X/EYzqLlApzya/xoYs9mOKhnNHBKFEzd4aC7lreen
 zVXN2b1ufUcyitzY40DqO4vTl5pFgRQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040131

pin_map_page() fails legitimately whenever the userspace mapping behind
the adapter route has gone away, e.g. when the VMM unmaps that memory.
As this can happen without a kernel programming error, remove the
WARN_ON.

Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
Cc: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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

