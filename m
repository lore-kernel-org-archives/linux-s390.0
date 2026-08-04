Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50508476698;
	Tue,  4 Aug 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860689; cv=none; b=h4PXcrn55JZiAkqAKlERl/dEAXrZQn1q0FqOuo6ow1xTbiBvH91aBidMBzDAD7aOtfWwDGX3JQ+6URcXvL39Oi3mtpbng1iFMRPizOK785fxs1chD6URZlX0kepD2TTjnr61ma8SCAm1sCIUPHLuMK/DyFcTacitwsE2vOALbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860689; c=relaxed/simple;
	bh=HjVXw7YRkIku3qpATO7j8kBdhD2U5WOT3ALsPPwaVaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVjWuYfjDDC3FWVCMhypEKAlNCSkDSXYI/gGvOR/58XXyJN93hbQzzlZKQiaMUBWuxAieYdMyiFeDhSLTZZHeZymvJxgKg+T8WDdk7lhOJnAlbWauls5jaJO2IXeU8zRVOrWb4wsyLj6I1FI4ee/tSABBAwRqj6oBc1iOHrzkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TrME5QMW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TrME5QMW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Flrv41286566;
	Tue, 4 Aug 2026 16:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hQqGGc2kR2LEN8JQY
	1xf8L6ThKERxbI84VbEYhXl/W8=; b=TrME5QMWZgBIHtzh+299RRhulBV7xRCpb
	LYA7qegS4uT+a17o2NQvyxtTGeurH/m1sfZUiRiMVrjhKL+vyfYqg6kosLnvi2wd
	JAw2FxQKCr8WwV4pC26C49Uaab2rmbGKkURAPE91vkA0jALLr0vmJTk5KIlIZNHM
	m1svAFIEn4rRUre0Ouxz0aaDi7W+J0/Mg/y8j8L+pNoW1db1ou4Le0FK36rlDSG7
	+jUaagMkAzBIad1cb3bM1VuMtdHEzVYStfwnBtiTMWxFhPPGdX1c94KdsGCJ5QpL
	WRD2tLmz7h2MPULL3EbjI8KusEGUyk8FLrhaq3fhIbnXrqK4aulPA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4xth3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBG28004520;
	Tue, 4 Aug 2026 16:24:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyjfv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOix716122516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2128C5805B;
	Tue,  4 Aug 2026 16:24:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80A658058;
	Tue,  4 Aug 2026 16:24:41 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:41 +0000 (GMT)
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
Subject: [PATCH v2 2/7] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Tue,  4 Aug 2026 18:24:30 +0200
Message-ID: <20260804162435.28617-3-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX8qxU1HqJQDbI
 Z0DigJeG3yL9SlcrJPKzac9Nz6gFr+iXvvxwHjotF8Mokh5yfJux+KJrLpvnNiCnTK4+M6+pnHX
 ncK1u7Q+FO3vvaXUd6qIHCovzNEpo2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXwEkOFDmrlEib
 tSXQZ2xUuKm4bVz7jK97ZlUcArwO+JKPMCDvqBGKlin7MFdxf/5EcEQx5pRqaawzX9/ESBhQ3Ju
 xaI++KLpFDbVBOoBZ+bDFYlr2FSBi9+lZEsiLkAlipQ0l0Cv5M4EeSCYxRcX0SVsC67H92o09MR
 ODs5ZeoPDKn16/oVq4nOHJg7UreigBfa/pAjpjfjo0vAh5SgcTEmHP5hOTKEDaOlc+gs6OuJR3N
 YH4oFQYCSc3A21LnLXUULEvwEsUzmDeZUboK05qOPEErjzTvIQhallrD604lTWh+KcBVfq8ynBv
 zL02Cfo5Wlkl0HpR1NhURohPyMZc0jx8zLGZv0VGi5MaGzK3y56T6+AIJqarHcj4EqviwHitvTU
 qgdLaiendyhQB2BqoY/aOdZnu6SFDbzDa8jPBQo6e3Ge5oapOSuE/3rTM3WoVXUOVul5Pg6Us4e
 1N9tMcAO+N8adhqaosQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a72124e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=D2ETlDs0240gq-PhJq4A:9
X-Proofpoint-ORIG-GUID: 5Q0Ljva9ooCN086WhqgLlE_43JK_lmRX
X-Proofpoint-GUID: 5Q0Ljva9ooCN086WhqgLlE_43JK_lmRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040131

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

