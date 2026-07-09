Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486237F01F;
	Thu,  9 Jul 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610137; cv=none; b=P/Vg6TMXKQlGnQELcE18jWKO90MntIrklm9L26u3mpxESND2RtNKXTaizF9fl74pWYzGftSu9aXUZFNGf0/ceVl1OjukxI9Ac/mhd7BkOuKe/u++VEhA9oZ6xPL04yigAxY5/+DFPiAi57hYKqRb5j8+3AUMFwxGAid1N+ue948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610137; c=relaxed/simple;
	bh=2kFBlScm/KXAElklQlr6z/Ls+xa0YBG4I3WZdtm06wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2diedo9SXk+n587I78P1SH97S214qoT8vmqGwX2kHrIF0+KESXh3KA276ynFgxhKDSxcqAWFNKVWJK0Xei86Hp4K8TVua5AyRhtcP+F4j4wl/WnrByjv2jGkyxo4CdVh/WXyCBUhWI7MC9Kvcnc0qJMQ3KUNQWN/+nxf3eZe/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SqjGfVBU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SqjGfVBU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIrTc2915272;
	Thu, 9 Jul 2026 15:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sgHpjf
	lKlRnjwJPv7TRRK2i0gceoCBteeGa3EiSBKbc=; b=SqjGfVBUqcVkbYauXYe+rK
	fqxYU1JDx5bRzfRirupXS0aMYKLsIL5tPT9xLdSJ3/yghAjmP95neiXyDOs15by6
	2T6Uc6rVkWlTesws+Hna8QDxph3F7Auk4wgcFtg515OFB7aT7k9MrjMxKH/rtk2N
	cWxGDa0d9CH+VBtJQHRc6QKuDyNrJw36xzl1mh5RTIveY49BSxV6ruOnQ2uD7PJD
	G9NKQvxzXefNVcNEy71lMjzQJHconIFnhen7Tprg2CcLDoWSlbFn9PH783EEzxAh
	oxQF+0p/HavZHGXqFw2wiogkTo9xep3dJxl73Pm3ojs5Yb2YCrPpsU1mYH71SJUg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur22vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4ek6012247;
	Thu, 9 Jul 2026 15:15:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ydc22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFSeS48169450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F56920040;
	Thu,  9 Jul 2026 15:15:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 837BA20043;
	Thu,  9 Jul 2026 15:15:27 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:27 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:13 +0200
Subject: [PATCH 13/21] KVM: s390: vsie: Add helper to pin multiple guest
 pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-13-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=2kFBlScm/KXAElklQlr6z/Ls+xa0YBG4I3WZdtm06wA=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1kedS1bmfr1V2TDPWOmktZ0yZZTJ/crru4RTfril
 8X4wou1o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIk4zmNkeBCRN1UiT8/DrOTC
 nLc71vyf+O/6xdS7E2Uypcp/rBTu8WRkmBS9LGLvXPUVhqppke0zOHc6KP+0XNCflndZ5DZ35+K
 lDAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX9EqRkZ6inVB3
 8PecASPSdKFDtzkcOdIYpfvrVYF4fHKAQgH2PLTD4oBSJT5V8uH7wSh55Mz3RYVrbzWCbin6LGI
 etq3Ect/eacYsUeJPpsUkup5Zd9uk3Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX7dZh3+yFgrzz
 n8ruOB5XYjbNfGKItRQHmqOe8pp1lK5CU6TdczCk3BapcP556x2sLb/D91XDs21art+nlUDpSeA
 ZWr7Bo0Ahgfe8ezgNtQxQRq1HHA9FCKcBCyOYLWfGka+1CwEosEUz4A1S+jaMxiI5FEDCSMUsD8
 k+9OaAGaFXncVkXCxmF/hf/m/lzbptzd6cmErVBbzfQUj8/UZvgxUtPvyj2sa8BF7NHqypUSuDF
 CMefaubDJjCHnMKrAQRYrbvzAeCG6elMgLH3v170v4USZ4iFzSpR0IBzG8kESiQJVOv92A0yzK3
 yEqoBuwuIGT3EYcmBdqyLe5LALZwCTOoJscZlRwUe0tThMhStsXAVqX6NR8MK0Os82uMXJNH/jH
 hAjKiG+JMPuE9cF/EvhyR/PveBlCRlZ9xKgaH7JNVMI0jybGNELnHVpbqLoO71YUJCtsK99ATQ4
 CxBRmbhnlZTwL3FInAA==
X-Proofpoint-GUID: ZRNUFufs_1cHl95hCNLCx_xxuoYH9NPL
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fbb14 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Ik1NvB_GfErtmppR53IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZRNUFufs_1cHl95hCNLCx_xxuoYH9NPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

In the main patch of this set we need to pin and unpin multiple
consecutive guest-2 pages in guest-1. As these might not be consecutive
in guest-1 it is necessary to iterate over all pages and store guest and
host addresses for later use.

As the new methods to use the existing {,un}pin_guest_page() methods
these are moved up unchanged in the file to prevent to have to resort to
forward declarations later on.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 1734215ae73a..644b37582b5c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -71,6 +71,11 @@ struct vsie_page {
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 
+struct kvm_address_pair {
+	gpa_t gpa;
+	hpa_t hpa;
+};
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -240,6 +245,40 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }
 
+/* unpin multiple guest pages pinned with pin_guest_pages() */
+static void unpin_guest_pages(struct kvm *kvm, struct kvm_address_pair *addr, unsigned int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		unpin_guest_page(kvm, addr[i].gpa, addr[i].hpa);
+		addr[i].gpa = 0;
+		addr[i].hpa = 0;
+	}
+}
+
+/* pin nr_pages consecutive guest pages */
+static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_pages,
+			   struct kvm_address_pair *addr)
+{
+	hpa_t hpa;
+	int i, rc;
+
+	/* the guest pages may not be mapped continuously, so pin each page */
+	for (i = 0; i < nr_pages; i++) {
+		rc = pin_guest_page(kvm, gpa + PAGE_SIZE * i, &hpa);
+		if (rc)
+			goto err;
+		addr[i].gpa = gpa + PAGE_SIZE * i;
+		addr[i].hpa = hpa;
+	}
+	return i;
+
+err:
+	unpin_guest_pages(kvm, addr, i);
+	return -EFAULT;
+}
+
 /* copy the updated intervention request bits into the shadow scb */
 static void update_intervention_requests(struct vsie_page *vsie_page)
 {

-- 
2.55.0

