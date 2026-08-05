Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD94314A0;
	Wed,  5 Aug 2026 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927908; cv=none; b=C13lPT0GLiRt5ViVreHfgsf3nDfvzQZHinskn/P/klrVjiezH2xz+Bi0WJsCE6A16G6hHnzQAUQQzDjnIT8gtBtn9IQnwc95mGXF0KF6lhM4iOj8maAGM8ATCcVW12jJcc/ngWi8Co1CoqoUSmMxyjK0AMZDz0RDS3pT4FwWiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927908; c=relaxed/simple;
	bh=HjVXw7YRkIku3qpATO7j8kBdhD2U5WOT3ALsPPwaVaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx+dlgWg2279ZAY3YdOmPkaRrXke2WADm86rd7TrCzRGGl+AQtrmKkhYygmRxN33zhNxZvsmFg1xf19M87Hu/WDhadB8p0zB8FykeMOip+vRuB/xyJSPH0fn0bXwnNgYRIPxfFcEiSFMT1kPoA4Pp2ybLgXOWGItFz2aBbmxKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HkFJbvr7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HkFJbvr7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lcMJ3387320;
	Wed, 5 Aug 2026 11:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hQqGGc2kR2LEN8JQY
	1xf8L6ThKERxbI84VbEYhXl/W8=; b=HkFJbvr7ov4p1LqmBFOGCu55Urp8A5iuq
	fJ45sJASwlUoWzZ+A7Ajxd5ernL/okt0hyFmvEld6j451FIq74/7qkhsIyRbUKWM
	Drqb88l90JUf03vKnQWSiWGV6Z0/37zJRCUdAJqLQ7NGq/jz6CJUWbVa/J3pgp/8
	3SUlXCYJAzqMXqZi5KbuaSp6f1cuaKpC8e4yh5dy03s1CF3hMojRmdPB817AIIH7
	8VdOCah6xaKIRmZEssIGswZCa/YEpAoTkmCPprc/jrjWwFGnFypEICQ/EO7pa5hR
	1oAZs972yaFAabDMuUrfJCRZ+yft05p44Ys47H8YrbW0WDwJnutUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52nrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuIMJ011203;
	Wed, 5 Aug 2026 11:05:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe4qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B53cg16253638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C0C58215;
	Wed,  5 Aug 2026 11:05:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D80C58216;
	Wed,  5 Aug 2026 11:05:01 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:00 +0000 (GMT)
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
Subject: [PATCH v3 2/8] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Wed,  5 Aug 2026 13:04:49 +0200
Message-ID: <20260805110455.7200-3-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX7JwaqADTt0Iy
 B8YoyKqKAv2f3CRDR+TTVBPEOqaiytjqM2gm3Rp2ZELmmQCwM4ogG2HoxbT6ozJvvEYCH3itXN6
 CVTrFJ8aluR8oMDOZObC15VoxP06D68=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX8dYTk0lwVeKI
 upDbCfJZXaD9Dt8gSHTDesFp+L/RGyW+Us190ZakBVEElZJnnzE+EJ6nQ+G4DDsxHpGZlTZBAYE
 k4FH/K5XO/AHOIncetRWCEVPE5y4l7BhG59fZyyNVvb6V0CX/hYOAXjMZ8uvpcBY72TNPy+Fab6
 WNoLSxKD8RpUYCkwd/E1zDOavhDnDAiypVjb8AXWJ6I/YN/FXkGmVA65WYsaKBSfT8O/KDue7yI
 LrcZ8kMUdpMCUBbnZJqdzzLxlzATlLvmS/PI5dy9unq+YR00nKWEKYnATWi1hvFniNfZmxWGL/T
 kIx7cnm+XFr34SIKxd1VVsRLp7L5YNJ1yj2MKIHUnJUmR2qlW4RIs0yQG3S90Q9+C3+BXwlC7rd
 SMbrFbYnxlOQaR6IvEoTsc82ZtpVaGh0RZDuzzQ/Uf2VtwziBqDWRUHSkkWsH4g3ELNY/CptJuh
 9Nb66dR/ToKwe3lfSbg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7318e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=D2ETlDs0240gq-PhJq4A:9
X-Proofpoint-ORIG-GUID: j_JMIHROIQH6DTUlALW2RjyaYlsXv4hB
X-Proofpoint-GUID: j_JMIHROIQH6DTUlALW2RjyaYlsXv4hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

__kvm_inject_pfault_token() only sets .type and .u.ext.ext_params2 of
the on-stack struct kvm_s390_irq but the full ext substructure is copied
into the cpu local variable on inject. ext_params and pad contain stale
stack values.

Interrupt delivery only uses ext_params2, so nothing leaks to the guest,
but a host user can use the migration ioctls to get to the data.

Fix by zero-initializing the irq struct.
Do the same for the inti data structure.

Fixes: 383d0b050106 ("KVM: s390: handle pending local interrupts via bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4a38de3d6758..c47c3a930db7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4473,8 +4473,8 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clo
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				     unsigned long token)
 {
-	struct kvm_s390_interrupt inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt inti = {};
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_interrupt_info *inti_mem = NULL;
 	int ret = 0;
 
-- 
2.53.0

