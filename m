Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88954457BD;
	Tue, 11 Aug 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455440; cv=none; b=nQ2sPnoLC7NTix0KK9KyVmc0523uXrF/ghysq2+qA6rZ6NnG/eKsSjor+/NhG8vLUp1wnLZOytB9zCNbukGDoMtlIv7jiahzkvWPEZ+CbP+xMkLmgv0ITUqsH3j0ASzUDTOq4bSoaxnz/MbZB91lWc94E5qRD/esYofK2/B/XBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455440; c=relaxed/simple;
	bh=eOsmPna9+ADsFikWgI5X+yaAnXPw2tvdhhEXAPwvae8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adHJn4LDlfe8aqtgkvQrZmm9a8C2xaPdyICpBlXlJrEY3bmIGRFET9/f0uEYWwwfcVvjYtSA9gD+Bzg9w7gjOfb/mou9lhlsQqLzaEOSKolS7reOEnROLC5ThMyAFisfOv/lvK4TL8Fn19G7Nrs/CqA0V6nPxVAhVU94pjFHoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EGVDj1hi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EGVDj1hi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWVKp537676;
	Tue, 11 Aug 2026 13:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UT8DH3
	IBq9zJdfsr60XQz1jVCGWbppXj6s+D9mciduo=; b=EGVDj1hitpDzeJ7QzQatbD
	/sqiL3b8SJrn5W8VLZ0WSggQ2lWEDKq+1T+UZ+aK5nnjffNyCEJGMBquXBq1yxI4
	7KJlCJ+2vAXjSFYxSbdxIHVCd/rnUS/apqSfo4af/JRPJudVYQ2R7m+Mj/tITxCL
	nCiGJUNfLUCvzmFTe8Pbu+tBIZgLKXIncj8c9sKmHqJmIGdskH9pLpVZNzhMyUmr
	MhUpG4JQsB4qIzhGQrtyFWkWXd0daH+yGV2JiObWpa8AAHOu0D60Ay95u5C/ydRX
	bPV8YlzfYQCybw+Bp8DN4+lvvGJEfaO9WwUqaEIJN7PMFsk/RR/RnawmYs6JIHmg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9n5mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQKGj025616;
	Tue, 11 Aug 2026 13:36:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0vb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaakK26476910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A47142004B;
	Tue, 11 Aug 2026 13:36:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E8E420040;
	Tue, 11 Aug 2026 13:36:36 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:35 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:27 +0200
Subject: [PATCH v3 12/20] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-12-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=eOsmPna9+ADsFikWgI5X+yaAnXPw2tvdhhEXAPwvae8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlHJ2enxB6Zly0x7Zsz6X+vvjWPTuZi5YvxaN8enP
 f0xT6C0o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgInY+zL8s14lohyk9Dfv0DyN
 9aXbdcrUz6lIdW7q7fLQdxBKFma0ZPjvpWRZyBE55+WdL2URnKktXLvucUz5v7L5NMuECeYv7u/
 gBgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX5w342DLXInAZ
 XQMX/IxjjSta48JaLVtc3ruidklrJxCrshKTPjFP9+37IJoncIa8ZOZOZPko3VJAYeWf6v05N7G
 It1N1yup+ss7yXeLQjB+nht9ir+7LIuU+/c+85KVhxTjtRg7Foysgrl3m3VIDsueUMKY7ruXiTP
 ZHYDfBX0TnV9X1/m1J69f3/2YFcZWkLdq+3QH0P5rgngreYUAvBCyX4ilJUFdKxxMWUhfDMw2ay
 XOB0nUMy/n7qTMF6UdwtGGYKWU4UERzRvDGlukWQHKvuocGJudVnGRQS3DCz6Jm/C+1NxYnC4cX
 rBtZvURXxcYqzqTrgFKTLLAnTn35o6XtxNKxouu0DEqr/xknwIjHoKFk94Eqw65hY+XPiEasNx6
 s+TGe+79+m0uKPsyAuKnWNW3iACrxVlnpM9Qeughu4DT4wUNV6U2A6kZaEn6h+jArpzFmQRfIvl
 U7RgUKPqec/6EhIg1ag==
X-Proofpoint-ORIG-GUID: 7_9qr4-6xU-aHNB4VNp2kWd-zQBNME3R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX9cTaK6VDM6JU
 6YuvvuQndwJNfpKQxWrN3VJzbwj4DbQMQgVfWg0332zzLxLyVFVyBjpWFNCOoxTa41QbbATXg1c
 3asQMmku2kfNNKr+TCHL7CwWZW/KdwQ=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b2569 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=b1Ck5HAT0Q-BmxMTSzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7_9qr4-6xU-aHNB4VNp2kWd-zQBNME3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

To handle vSIE configurations with an ssca we need to pin and unpin
multiple consecutive guest-2 pages in guest-1. As these might not be
consecutive in guest-1 it is necessary to iterate over all pages and
store guest and host addresses for later use.

Since the new methods use the existing {,un}pin_guest_page() helpers,
they are moved up unchanged in the file to avoid having to resort to
forward declarations later on.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f4d35e0c8c1..0bbb65300a85 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+struct kvm_address_pair {
+	gpa_t gpa;
+	hpa_t hpa;
+};
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -249,6 +254,46 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
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
+/*
+ * pin nr_pages consecutive guest pages
+ *
+ * Returns number of pages pinned or -EFAULT.
+ */
+static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_pages,
+			   struct kvm_address_pair *addr)
+{
+	hpa_t hpa;
+	int i, rc;
+
+	gpa = gpa & PAGE_MASK;
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

