Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C52DF155;
	Fri, 27 Mar 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625054; cv=none; b=I7soQWLSyY52/wXxR4tgqAckVZfMbzm+TR9xZ+HUdLaRFj6gZ97Ay0B8xUATQqFD4kZappmhelifj6DOMZvQLFyps3V7LRQ0jNgGKHcdidhXcDECTCioPONKSz+OmmSOODAI+optDjvb+wBfpvq8yfVuLJQcLGVe8dHciYuuzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625054; c=relaxed/simple;
	bh=xvUaGwlVY+iOjt1wzRp+igCKr0n7tNN5RXAB2xJ0RiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czTdHLmbOmmIMVRZT9yJhQirNC1aEb+OKpb1CwWevSgLJi3sCjkOFSTappMLavwsKzkCTpjkYkxfpsADFNe7KhuILUPQO1HTz3YJ3EIio3oZUFgHgzkKYJCQiSWzogDJx0IkYKOU3sP51c/ML5IhyNYTZkK7/031qbZ4tWe/MwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B9yz5gcN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B9yz5gcN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R44T403340564;
	Fri, 27 Mar 2026 15:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9aN/pClNt63vB8GA7
	4mqlBllV9uPgcEZfo5d+SWe8YE=; b=B9yz5gcNh1T1g1cyujEkSDbj7WQ07Z5v5
	ItML+x5P+ZVCJTshKQ6GiHCKgEGjrAOJLPL5WrIHLO/Mxh2DPWZqS97Pc1ojuSzn
	pQTRfrewmIAFljmihmag5jBsP89wPKXxe3D4j+dEOjXRwrGJfC3xvJLAsEFA5EmV
	mNowGHP1xHx5FbLchlRbLwSsizZwEpOYxAG4feZE+5KK8KQC4EFW/qt3AuqN/Ysl
	QgUKZND1iXW9brpCce2+rpxcfef5s+xCsZNvkF/wTtJyVPRzotpYB/3uDA6F6TC8
	tC6FRejIW71rWylYy68qly63u80t3GuWjkRLZQyCXvd8HQdgUvMkA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0hk25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RBHiwD026900;
	Fri, 27 Mar 2026 15:24:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m7wsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO3af50921844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6276D2004D;
	Fri, 27 Mar 2026 15:24:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676CC2004B;
	Fri, 27 Mar 2026 15:24:02 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:02 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 07/10] KVM: s390: vsie: Fix refcount overflow for shadow gmaps
Date: Fri, 27 Mar 2026 16:23:53 +0100
Message-ID: <20260327152356.250625-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX/DIPBjx+J7jd
 o/WYZWjy5hzhix4TAq8FloA+jQjx1vDAp+UIpwFEcMyIrp0k15vsJwcjZbh8NIXTQwQ+Q/5HmP/
 f6ZbteHyoeyMYfE+3Nu1OV1m7Q4Esq6d/DJsCfs2eKrjwpsRJDlRR5qP0CDvTaxcDipjeH9xTir
 Zb6KSTI6cC8Ie+Cp3Lk1t/fSB2GzrzHb2sdwmLma4+vxjiACjls67dufTgFCNUwP7AXUJDzVFR9
 3Ihsb74D583GByA/pqcYwaDsi+TZ0UWBOHTylYk85EP0dX0m5fu5Sb/aqz5kNvzfeJ1NyYx7qR/
 0AEpM4IUg8JbgWUGNRaHiw318sDzSRiLK3q768cfseGLAneLs9Ru7dsCQfWxlvmXElipapwpi6y
 ixUiKUzd09la4Q8boeA0B0x990ER1ER2aCrzOlOC4F1eqbqRij49AB/YH3kvZ3qFh1awFpXEqk5
 /wvOA2/PnGYKMGOAaXQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c6a11a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lZqwt92h48PHW-tHXBoA:9
X-Proofpoint-ORIG-GUID: uTETOFFUgbK0qN-VFchaWMqAc8OWZhYK
X-Proofpoint-GUID: uTETOFFUgbK0qN-VFchaWMqAc8OWZhYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

In most cases gmap_put() was not called when it should have.

Add the missing gmap_put() in vsie_run().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0330829b4046..72895dddc39a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1328,7 +1328,7 @@ static void unregister_shadow_scb(struct kvm_vcpu *vcpu)
 static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct gmap *sg;
+	struct gmap *sg = NULL;
 	int rc = 0;
 
 	while (1) {
@@ -1368,6 +1368,8 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			sg = gmap_put(sg);
 		cond_resched();
 	}
+	if (sg)
+		sg = gmap_put(sg);
 
 	if (rc == -EFAULT) {
 		/*
-- 
2.53.0

