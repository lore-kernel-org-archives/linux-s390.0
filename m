Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F948663D;
	Thu, 27 Aug 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845988; cv=none; b=KxQtVg9085Lyxgfj7ZGVdPkE2R7O3X7k+rE6Gr/kqK8Jq3g7HY3WKweiFZcRNzTQqz5X2uMWiKX8XjyknHztxDZtVgpbcwoXxKswD7g77hgRfP093NLe/FTgl5Wrn+Gpv77Fr468XIA+Q+rTGLPkPbeFmau3cfg9skduiuwiJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845988; c=relaxed/simple;
	bh=V4HbsfI2pYUPkmn8tlci7EFaFet7C5Gz2K4iT2PASkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8rJlJvvAzaqMMZCJmDPKNtzgRmjszkHIBQvoqjpWz34iXZPv4UIJY7AZUoYv2FjYZof61OFZfKTFT7fciy+XV1DcllwWtqms/iJlXXzFeXs0SPXm8me+vLycEEBZih07iQWTioDx1ouvnFaBsMC1wsKI6lO4RnFlLoLqNxMVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JN11DS/8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JN11DS/8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5EE52224824;
	Thu, 27 Aug 2026 15:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EawxfB
	yVCxZV8wl4WZ3USXO4DBROisUO9TVRaXdLcTM=; b=JN11DS/8e3tkXWAXY5HPBU
	LcriGZ4pcHYcE2z+hP8LllrxV9n+t8Kulm1lU0nccTuyDSN9EJ4NPlowTKR3mQX7
	XXFN7T8PhegB0Uth3U67yJj4pXOafK3UvUiRqulMkBwxnM18q2YI+CITk5YVj61N
	GZQ4M4M10dlLLGIRq9jksFHMwVL/Rj6pRH2MUGowp29pHtcHy51VB52FQcQwrfbl
	231eBaUEyecMoyi98Q8qmzHN4mxdo9GDxRPB8U37ytHtoryTq4qRA7JM2VjzSg54
	aNBJZzWnwZMCnznJKdLSNgKaX2u4Mh17wRodbTMZCYQAlzGyVNlztK1Jd+HWwVwg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ex8sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfkwD008875;
	Thu, 27 Aug 2026 15:53:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsygm98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:52:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFqtN243581700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:52:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BC4E2004F;
	Thu, 27 Aug 2026 15:52:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85AB82004E;
	Thu, 27 Aug 2026 15:52:54 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:52:54 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:42 +0200
Subject: [PATCH v6 02/21] KVM: s390: vsie: Move SCAO validation into a
 function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-2-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2755;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=V4HbsfI2pYUPkmn8tlci7EFaFet7C5Gz2K4iT2PASkk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoO2mkXNz61j07ooLZozXcz/Xk1jWpa+GSvbfaf0p
 dFWC3k7SlkYxLgYZMUUWarFrfOq+lqXzjloeQ1mDisTyBAGLk4BmIjrdoZ/qlv2l8Rev2g8YXKr
 0LuuI/ZCmhdv37Txi1wy2VjEgrl+FsM/zfM/w64cX7tDRVeqp/kBy4mG+9knXnRXrO/52d0xT+o
 0LwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a905d5f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXwHuvTrX95mct
 SCJEiqfQzFuwLmLW5SqMqml952uSjEO4QtraBVT0vHCDzfD3COx+aqV67PgUuhncbUrr4tyrBrf
 66jZLlcgn/Ho/gDc9hFRIYF75wqhk2E=
X-Proofpoint-GUID: YgJRCGYhZHnxfibkvpGI0l-_uLPLFa-q
X-Proofpoint-ORIG-GUID: IaOb82xlfDIKSSYOzwOwz-ycarrS0E2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX1WPdYWAGXxg5
 VS5lxVi0zldFgNDAt0LIFFvx9qqVdPHqJfWl0MKI+vkE9UJY4DVEV2Xr6QQld2ePQMnFX7L7Ku0
 +5cYCD46AfxiRetkdoKREFkMZwezKaP34i2ISzG1OjH1vAmahxRKgDVggw64LUA9E6ike3PS0g5
 oC//TiTJyZ2sv/eDQ0tDTMRP4hRn0I3U+Y0hJVyCRpupYidKexmRgetOoFbkct4RgQVr15A5fnv
 NdzCgOjfzbUutUl+gbYf+pwhkP4w8ERsM6njqX+HbfxqrI8E4pRia2kQx/ULIJ1iiFImPm/2mIK
 7Ga6qxZjKFvM32X05bExV61XCdRfBoh3UmRWOeGQ57EqrjVOXVQ+/fyaoZc4GW8tqSvgGyDnCcK
 DIXrHkT+frVXR0UzToS1ixZI7NODxXftrHSxeDl1po9s9uoV+zWXDk3HBCfYmY+mXPBKEmQuFXu
 S0MO7PzPu8QKvTJXg0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

Improve readability as well as allow re-use in coming patches.

In particular add the logic to be able to check the validity of BSCA and
ESCA origin addresses.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 61096ee991c8..04cb38aad33c 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
+{
+	return (scb->ecb2 & ECB2_ESCA);
+}
+
 static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_block *scb)
 {
 	unsigned long vsie_sca = READ_ONCE(scb->scaol) & ~0xfUL;
@@ -97,6 +102,25 @@ static int set_validity_icpt(struct kvm_s390_sie_block *scb,
 	return 1;
 }
 
+/* The sca header must not cross pages etc. */
+static int validate_scao(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb, gpa_t gpa)
+{
+	int offset;
+
+	if (gpa < 2 * PAGE_SIZE)
+		return set_validity_icpt(scb, 0x0038U);
+	if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
+		return set_validity_icpt(scb, 0x0011U);
+
+	if (sie_uses_esca(scb))
+		offset = offsetof(struct esca_block, cpu[0]) - 1;
+	else
+		offset = offsetof(struct bsca_block, cpu[0]) - 1;
+	if ((gpa & PAGE_MASK) != ((gpa + offset) & PAGE_MASK))
+		return set_validity_icpt(scb, 0x003bU);
+	return 0;
+}
+
 /* mark the prefix as unmapped, this will block the VSIE */
 static void prefix_unmapped(struct vsie_page *vsie_page)
 {
@@ -788,20 +812,14 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = read_scao(vcpu->kvm, scb_o);
 	if (gpa) {
-		if (gpa < 2 * PAGE_SIZE)
-			rc = set_validity_icpt(scb_s, 0x0038U);
-		else if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
-			rc = set_validity_icpt(scb_s, 0x0011U);
-		else if ((gpa & PAGE_MASK) !=
-			 ((gpa + offsetof(struct bsca_block, cpu[0]) - 1) & PAGE_MASK))
-			rc = set_validity_icpt(scb_s, 0x003bU);
-		if (!rc) {
-			rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-			if (rc)
-				rc = set_validity_icpt(scb_s, 0x0034U);
-		}
+		rc = validate_scao(vcpu, scb_s, gpa);
 		if (rc)
 			goto unpin;
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc) {
+			rc = set_validity_icpt(scb_s, 0x0034U);
+			goto unpin;
+		}
 		vsie_page->sca_gpa = gpa;
 		write_scao(scb_s, hpa);
 	}

-- 
2.55.0

