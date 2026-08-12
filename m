Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C309351C10;
	Wed, 12 Aug 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542775; cv=none; b=MIsxV0wNpyVQY3F1WzgDcEqJiKGurvKXmkOvFAmvPBzrKii7r6zaA10iX6mcPRBl/XIVD4xJNWj2M7yVYjIV8IdIzZ+VgNHuuewaMyzlrW92Ns9lHFaAolSVlNuCSTUoxSc6mRBL4SPjYegERRpnmauJFg91cruEa0K5M/IK3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542775; c=relaxed/simple;
	bh=zFlvFhJo0w8aIcH6d/q8P9tVuV29ivMk/qP02lNmuqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8zqKMQ+oZGm6tUjVLVknzbAMTol3f6i2FB2OMKx9Cba0hOZUWYmISX4H4wzo0vH2mdPZbzQbj3U9w1pvs0HOYICaydFPajh2dndBUyAzIH628Bjca296wipaRMfXJC3yp1lLzrwIFJ+FljS45L9ONr0mOIXs5AUUEfTczeZvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I/TnpWBj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I/TnpWBj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB43nO3259075;
	Wed, 12 Aug 2026 13:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tArsbE
	y9oPE91ysuET1RJRFC82eHoUMexFHZXnLmQBA=; b=I/TnpWBjZlNZ7yXJmlWZfH
	fQA6h5XuAC2Som2K5Lxcc9P0A/vvt+/olWA7z3SKBuCFtiZuGFBEKbB5KEYhGacX
	KK7uYNSHFNJd7s4REsuEq9+IXIpCQfOLl+TOKVtdvQ5h0y8LSdbBoR1ZysSaXFfX
	hbnOK6KOUw8M5cdJ6nyxWR4b6RN62EujNYLZLIyCv6r3fuMeI3eQQOY3FD/XJXkC
	RTOK6/CKosQY7Pqo6BILzonhyN7GKZL5xycRVEf54aSov3KqSUvNwcW0K79VHaJu
	8JAALxxydb4hTiTmW4qN8Uuv/dYPP0IxXT3O3I8X8Jg5G6kRRogmo4HU3tgFEOwQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9jpc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDpQHY003085;
	Wed, 12 Aug 2026 13:52:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ge4dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqdNA34406728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4887E2004B;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6ED20043;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:41 +0200
Subject: [PATCH v4 12/20] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-12-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=zFlvFhJo0w8aIcH6d/q8P9tVuV29ivMk/qP02lNmuqw=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYu/mXeU7HIt+rxMbveB58pyR1ZpJofIMrfsd7TUF
 4t6GDivo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIlsesDwm/3QuvMWBywWlHKz
 Pvu7LSqIQbjoqds5+9U3jm+9uCf4YAsjw9LwAC9285OvbtY9+3BJW3B30GITzh09fzJ8PxXLhB/
 dxQEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xWnS10OK_-hOb0kQxXQ3ATEcW6zR83vE
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c7aac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=b1Ck5HAT0Q-BmxMTSzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfXwtQUYovYGfzZ
 chVut3a58zmbpgdFTM9TDUnisu1qS64zSaJhE+2fxC/UPmv7Qu2e7K0b3fdmnkcl691kF4vHWOZ
 VVoBkCFCtt4CBZosE14C5PLoeqz5AxDA3suRG/E4Y1P4ecxYibLTd0Rh+WSmz/yEuRYr7+Eyaqp
 zgoQboremsl5O9xPksOxyv8eR62kWZ9HdeocO5IAjpDmRW0uYJQ9v9w4panllNOOV33a5BnV85T
 K7ao/AAtfs91UpyTFrk4S+fU0JHIJX+wbg8hIFGAUWI/6wUb8asO+YIxQ5oGGCBHu4EeqK2kpVN
 Bcj6bE8OKFzYDtS5ISLpcLFR6y88lJV4s6PquwbIR4DxHRUPoS6op+Fwmo1UPZCqBllRx5vhdEL
 c8XgT/tQ2zZA3W6PlhvnkauBz5EglZSlOC5LYjtWQgxP5tq5ulzXpckp0kyoqPGgxhD81Mha9WR
 x3zY8XP0fFHsElF2oBQ==
X-Proofpoint-ORIG-GUID: xWnS10OK_-hOb0kQxXQ3ATEcW6zR83vE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfXy17BcaNHEiXu
 eaxPaB2cK/oyoC+fAYSqI5QdcI6eVnHNWK7xxBk2QPOcK3ZAgUcsI5NBwXVKm3tdosv0YmESxNn
 /b5qz1CkUC3pVAFm90NTXh6H/nEJiLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

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
index 490c29b369cd..442e7997ee51 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -72,6 +72,11 @@ struct vsie_page {
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 
+struct kvm_address_pair {
+	gpa_t gpa;
+	hpa_t hpa;
+};
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -250,6 +255,46 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
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

