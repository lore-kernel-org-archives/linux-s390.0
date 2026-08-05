Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE584438FE8;
	Wed,  5 Aug 2026 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927914; cv=none; b=kCL1w6icAuQW9Bw09SMPeJoZEgckd4v1QJ4lTxiBRevSoRt9a7txFCdIfaDrfBvUkvNiIKl01kzqpYC/DmfXrgmg4aDal0cMcbYHGLykViih0u19SqQ6J5c8pBKptA+UvsKjao+XClLwdxdfZSL4aPThFV7zLQEGHiFGaBNxxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927914; c=relaxed/simple;
	bh=ntXSsdPZqK/hM+GB1fLr7GVZjqTsBU0WRMD/e6spe80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgiP3NB3cCJJSEczPma2E+a0BHVOVARuyUisX6v+BblTW13+Klymehpn27elmiMmEuftjC2hUYN7pNZ9zn0X14m7ntK7EAeOzYczWkCL5v9WBAL7116IX1M/KI+8O8xmBgcv1IFO1Hi3iYpafamHr9nBPO5X8OEhfTisWy8fJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ib3k3jXq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ib3k3jXq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m4Gm3438632;
	Wed, 5 Aug 2026 11:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bDziJAW/mYvzeE28M
	kir1Lpy5F4FkDCmaX6n32l/A0k=; b=ib3k3jXqnSZeu6vzk/rCXEOAd2npEKa7N
	9t9b40r8o6vxvuBIM6rKX0mjkXTDi7EDcg1OQsMRxKK7BnMDxyUD28VY6m+gbIwV
	roNrId6AxMDFd1UBJuVxWLO4B+AdYeX7txsHICPt9w3yivFhuKm53ZjShdZ+CNYe
	7F+izuKb/ya77xrtiG10EzhVy7hUVDDHiaS2baNr3RXotL0gf+L7+zUt+h4QaWqB
	Yhi6LNBOJbLyw9p7MVDUGpn1sLPJgjL+QhgtZI1U6STRSywZgnfWc623crjO9iUX
	26pN368EiTfL2QMzudS2xXPXke7WU3GviRKKm1Kkj4nf33VI+CYtw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eut4vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfU5v006268;
	Wed, 5 Aug 2026 11:05:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k66py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B57hp30016058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F66D5821A;
	Wed,  5 Aug 2026 11:05:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EAE058215;
	Wed,  5 Aug 2026 11:05:05 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:05 +0000 (GMT)
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
Subject: [PATCH v3 4/8] KVM: s390: Fix memory leak in guest debug handling
Date: Wed,  5 Aug 2026 13:04:51 +0200
Message-ID: <20260805110455.7200-5-borntraeger@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: c9WQe5hri7v98v7LDp8cdvw9M_E2n7R1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX5+p8gGoUWa8H
 yzR1836SOI5vwR2pZ/VaiZEWeoXwbErnOF+c+vBo6wby7ZRmYQNIRxmAGGOSgfuOAtoxcc/psAD
 YPIp4s+nvCwA8S/gjZDwKvD8zhPZKQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX3BcGk1SD5hn+
 jsZfkFJhVqrFSn8eIls2/z8qPHrWpNMYCyyPw34I3p2Hlblu0c3zuRRydh63WLJ7EnVvo+sDtLQ
 U4dA8+7wU9z/oa9pvcM3XYWIJz+RzT5W54iSTWwOV4FGLkT2YDN9iVLhL32Rh2e56fjCSXibzvH
 ttvZLeOr0XqMQwEl0ItjLV9RMm+wtENEj9G5qbviuKKeG4KTzblUj2LtKl/i2dOjM0gYLlVJxKz
 Whtyl98IVDIo5SZMScW/HzngS0P0+EloJBQA/A0bz3HQ3oecqfR/lsD80qzu4IOX3xM3+J9j1je
 gz2Aqw47vSxRP1U/P+4/zgMh+h8R8QU3yrnpGsXsT/qTIFSlxZriiiARHp4SICO2eMQNYSsGASF
 9v79Pti5dE138QMUXp7znaFyLB1BaPEtETASIp3Y3YsV2YR+NUhUpcETkk4yNF0clzybzahxRJI
 T/J0d+irlYPDqBdRmCA==
X-Proofpoint-GUID: c9WQe5hri7v98v7LDp8cdvw9M_E2n7R1
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a7318e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EuSpeD5rqQqXJFU2zEEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

bp_data is freed only for the error case by kfree(bp_data).
Every successful KVM_SET_GUEST_DEBUG will leak bp_data.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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

