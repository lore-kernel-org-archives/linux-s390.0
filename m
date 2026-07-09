Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC937FF62;
	Thu,  9 Jul 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610138; cv=none; b=OU99P078mGHlCpf+FUFY0kq37CQCN+pDhkFil8wbcErG/Ko6Pvcp1PptJtAk8PaFYj0AWwd2+0T+d/vf4nrVjsx3EUX3DxjKxMq4GsI7qkna23JMAUboSOz/pyYljPFMKpd0cTTr8TYaYqg1mFD/J/Y1M1PNN4iw4i2UUQ6FTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610138; c=relaxed/simple;
	bh=GWeerAd/nMwe6A0tj0kHPNyVo9fBeOhtajHO8NfbmLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myHfmoW2mYRua3FU37tMoRa3nJ4Y2vTj+kmEJU4T1nBlmV19fGt4p/SAcv2Eo5zqVp1Pe4hTGaGgbJ51F6BeIq+XFYPthvUhW8CoywgPfQsDD2Qh2ciPwkX2uy6TWZAd/UPCZyld+1MDuP6Q0kDTuO5B4Tj4CsOfpCTdmwZXYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dxi2aHQX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dxi2aHQX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIEbU2171251;
	Thu, 9 Jul 2026 15:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zkPFd0
	MEHdo8tMONiORtFKBtw2vhzFkVQs078hudwg4=; b=Dxi2aHQXILiDia8pyHoUFq
	nefQNUs7e5q4/yMD5lvX2bPMPFp5Xn3oEwYf4FQFqdhsiHK097PwTYEFr8uZFP2V
	L59BDV6TP4/Yu1XDz//kV4kCgS/GhL3uv3HKGjq4w/txZUR6hus6GEst3Xoov5Qe
	DFlsKSqrjTMEUQvpvD26JBOd2Ed9t7wOGnlFqurHarcgk7LZfK3YEywW43YkuVac
	3jnTXcoM208ZJ9/XUetLnsVCQvE6eU+yF8GxVfKRt/o5618n9DrlFlO9fffCejnU
	eSgunSSl4jE/z+vBJiI7svzB5I2WkjlxQDGbjKmc3jd3JGwTCuMQEz7wxpQVYYDA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw52bvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EnaxV028343;
	Thu, 9 Jul 2026 15:15:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdwcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFSpC49348910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEFB92004B;
	Thu,  9 Jul 2026 15:15:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F80320043;
	Thu,  9 Jul 2026 15:15:28 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:28 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:14 +0200
Subject: [PATCH 14/21] KVM: s390: vsie: Add helper to release gmap shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-14-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=GWeerAd/nMwe6A0tj0kHPNyVo9fBeOhtajHO8NfbmLo=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1lXcMZsvbRo5YvG0hLVBOeXnervzXY1m+rdTJjyt
 7om/+v8jlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZyyJ/hv5/mVb0ZHvf6bQ62
 R95s+3dcV97tSZZDlc8s578VXreO3mJkuHV709Xfqd3RvI2ODwTuhXa0aXSHtSoJWmRpS7LLbtn
 FCQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cwrk_rVxJS306uKj8BiNLJLlaaXkoV-D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX3w7KPpzBFsKw
 xPlECefwnZ4tkz1oaeWiRW2cGhcjWQyAGYEDw4QUFCIjvPr9X6fhkQ10YE19n6q2Y43e6BPmQsH
 /Ou2SDkRGNcHA0Uwy2trKWMB0NwC8UkOMY0rOCb2eJhN3nez4/ivc9e9kZ5xNpnwBv4Ao8Z2XNv
 SXsYYvnSH6sO1S7GL+xI2YJmBHMAz5pNu0miSkuMY0+23fTIKmYx03nXctyFIlevtsoJ/Jcedqr
 fWoVmwNh0hihHsOT+FNPKlbjoyTNJqHQoAivl4jAYEVZdgFENFJRfWFPg2lk+qBVpbX6QRcbTVs
 CS7rN+2i7NVvKAGSx7jKwMxnwpnBG4A+GicSy4q/N04NH2B78WPgaVj+OUJPihundpwrziOmoct
 +tc27/VAvm1ApCEthbAYfAppuG/PFC6gyKFlcsC/WDitA0zw1Ib/PAYv4W7bZPmbDlbSya/b7LX
 ZGVZn4nVjJZJ+fbIeWQ==
X-Proofpoint-ORIG-GUID: cwrk_rVxJS306uKj8BiNLJLlaaXkoV-D
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4fbb15 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=520cwpyMf__qVmlIlYMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX50xwEVY6dXHQ
 xgYFqf9DeEk51JWkM+Db1haHCP7LlHBe14Mp9LWVvAnSp0Go0tbn9aBrX/9Ni76Ke3388XWBSxQ
 1iq+P2Kqg8UgJWbHAZsL/SfOJoS7rNg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page.
Will be called from multiple places in upcoming patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 644b37582b5c..874ed2a55347 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -170,6 +170,15 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	}
 }
 
+static void release_gmap_shadow_safe(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	if (vsie_page->gmap_cache.gmap) {
+		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
+			if (vsie_page->gmap_cache.gmap)
+				release_gmap_shadow(vsie_page);
+	}
+}
+
 static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	union ctlreg0 cr0;
@@ -1623,11 +1632,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	if (vsie_page->gmap_cache.gmap) {
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
-	}
+	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;

-- 
2.55.0

