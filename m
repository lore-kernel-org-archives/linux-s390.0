Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B943E488;
	Wed, 12 Aug 2026 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542768; cv=none; b=CECvbH3nj7N/0XDA8c9v54WS6vs7+/T2r5M5xT6+RVOkI51kEM4KRo55MfxKbwN2ApA82x/0J2tTXn9QWdvrpnNtKLw1VIZk/nXZ5e8GjX7Hxp2PLcmJpKfr7Co6sV4m59IqEq2Y4xsVdt2bRlTZ0t3TDdJUqeL0/DrgX/Aj2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542768; c=relaxed/simple;
	bh=TYqDij8RnxtHYkFY6YcY7D2IVRG/EgjULHK9pQrR48A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeDb++rq5n4jH3BPwnUXFk2BKpmgMXMfyR939D04scWupI/dX7gNTaYB/8VuXa/o6VybAfCHVW4wy36Vz472UbrOZuGAYe4JPX8h6OGqA2LU9dQj9aj46rnv9i+3fJQ3RJ3nDu9zzTFVryqXw/khyZAKpttiqwm3oxwvRkRiDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=da9Md2up; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="da9Md2up"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3X6L3214182;
	Wed, 12 Aug 2026 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K0ZFAn
	jektefDvrBZXKYU15GW42B98XDt2+RpFOmdWw=; b=da9Md2upgY5vOC8lg1RBZl
	LpJhoNySlaWd9wYNhUWkt0q0nLxd1ndEL44bHINv7c81DPg4kng6kDDEUNL/u5je
	kBho5hMiARhqgmk9sFSa75XkSwvbiTsTlg4lnq11IKsk2ujUvEDt8b1FSxwjImBb
	ES7hfvrTPrIo2iM61PgcKc+zP+5MwdSutbiMoH/zB7+hpEj0aHfpqhzE0h0quNEc
	JF0JXKdVXuQG2Z/9RCLnzLHSss1HTeMET1qK1KV34WboVHMMRtKBcKE94Sq79G2H
	+yn/uukwSUSgX4gosz06NbJUwM8Vha8ezzLCM8fgso097Zr3sl2Cqgut1xJ6cZKQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31wqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfc56009914;
	Wed, 12 Aug 2026 13:52:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6dma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqcBK31326474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DA4620043;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 412F42004D;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:37 +0200
Subject: [PATCH v4 08/20] KVM: s390: vsie: Create helpers to alloc and free
 vsie_pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-8-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=TYqDij8RnxtHYkFY6YcY7D2IVRG/EgjULHK9pQrR48A=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYvPieQlr9ZfJqFvfEnubdWhrrVbX22cpdj1y/3On
 h16zEw+HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAExkYS7DX8GfMzdYl2Uerpq7
 9XuKlO8sUwvT5zoefCdWM6p9O5yt3sDwP0gi4Itvwol3UnlfrxRezfGQeLfkhJOdadnVLCY5CZ5
 qNgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7aab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-UiXzxHpo5ppJV-mmbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZzsIdqlu4zhmS5MEN_XHr_vby9LcIZ5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfXwBmH/B/ig1g5
 3/yl5A+jluZPVk+R9PZVCFXs5dZPVNH8q+S6fBLZcZnblsTrFS+nLpSlFEnq1zDXTvj1rdGG24B
 8kMOpFMyQaLpIzBfAAGyIZGdfRBEZ7NorzgfgCESl99UnC4lE35QpEK9jJcUiyup2Z5Sc1rM4Qe
 gCk+ix667uywjc0J2KwjK7CrkGBY7vker6/cGIjcaIgSabpiTBU1iqVpvg8R9tk4g4uFUFLH6au
 tyvY1zcXT2iFgQXya7pbMm4lrYyzJKnZ/aI7Xr2taclE/WcYGoI94GY2xAYjkJwZ7gK9WTpg9Ja
 5scRCDrodOr7HbQ2rsa1TwtIDaOJsxdQ/Clapc1B3iLG7hX5Y0zINEkYqZtfI3wNhY3PjTUCABY
 br3mHnwQRmnGJjZ2X7/Yz6LbSJj9YvtOUwG1gd99g2gXqLXQMzOTXPo3taer9/hlxhHCZcnVfWR
 Ybx9NRh42VOWOUjtx5A==
X-Proofpoint-ORIG-GUID: ZzsIdqlu4zhmS5MEN_XHr_vby9LcIZ5f
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX+SSKFpxOdKmB
 Jjpl8nRsbhdw6+gnZW8MXDcIM7esg5aJEU0Zi5Uxmv3XCq29iYD5DU8hV/Q3vHqndX577Y+Ml+w
 j0YpOMmnNNPkPpaiPbQb/DRlfoVlf4U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Encapsulate allocation of struct vsie_page and free into its own methods
to allow this from multiple code paths.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c935a375f57c..805d28f0e705 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1503,6 +1503,24 @@ static void put_vsie_page(struct vsie_page *vsie_page)
 	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
 }
 
+static void free_vsie_page(struct vsie_page *vsie_page)
+{
+	free_page((unsigned long)vsie_page);
+}
+
+static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
+{
+	struct vsie_page *vsie_page;
+
+	vsie_page = (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+	if (!vsie_page)
+		return vsie_page;
+
+	/* Mark it as invalid until it resides in the tree. */
+	vsie_page->scb_gpa = ULONG_MAX;
+	return vsie_page;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1538,7 +1556,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		vsie_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+		vsie_page = alloc_vsie_page(kvm);
 		if (!vsie_page) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
@@ -1558,9 +1576,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> 9);
+		/* Mark it as invalid until it resides in the tree. */
+		vsie_page->scb_gpa = ULONG_MAX;
 	}
-	/* Mark it as invalid until it resides in the tree. */
-	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page)) {
@@ -1663,7 +1681,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> 9);
-		free_page((unsigned long)vsie_page);
+		free_vsie_page(vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);

-- 
2.55.0

