Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6140488DB2;
	Thu, 27 Aug 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845995; cv=none; b=CbldQ4s3TsbUMLf9rgByzFLGOewLJry3RWiKoVh/pD5D0oWCaQtr+iEgZIICZSXUwSkfeD+Lb1zU/0SXMToyT/c/5Svftl9eeP00AMazynsUQYUbAvbMrB1XWCVE7O+/Gg5Ozlw2xaLkZz7mJTQOclQWeYu/b04fzeSM4kSuyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845995; c=relaxed/simple;
	bh=svRQoDZTHOQZAY7ksz2hU8CjBEPxLR/MYMehJpai+yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKRukhr0WDOLcVP7CW/S3/+09My9Divv1nl29zXYkm4GpjXpryRGnPDrX7VLajfV4p4RIGkiSy9CnPSO/Fuv3u+Zb5jGDs23iCXNDUS+BxICWtdHm8KPxMy4JfxHtMWdz90+1TKi25YFaWvl85kuIFltpev9/FLEE9TDSHXiSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bULX+sit; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bULX+sit"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF53pd3355188;
	Thu, 27 Aug 2026 15:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pLskao
	U3QyaQzM7ln7YJvJsObejI+oH/J91RhKN7L4o=; b=bULX+sitrOSKcDvxEdnfXS
	3qK4kM6WuRNukK26g4DwzgezdAWqS4DUUHEcohSa/+LevOHcPDBDaNIsdFDboEE5
	WVVeEZy3WOFq9gVhDQZtz8TTl3vcwqBBdAuQSy6GImD/T3GC6P8R/0Q9tpolh7v1
	dOJZvpouQ1wCEt7NZEGsckNNEzBKDsRmXmr7E6nTerByJLycgHCkuY/yiMaWpYPW
	2D4RFth04gmswX26078vro15PRPnm9DtCVEFFezCRhRzi5bYodIXsAGH1xSeMdf9
	LKBq5pkmYTpJeUpqnrn5oLzIzyZI1POVH5wFrh9WFIbX6bZJmNZ5ZyySBKqw0rzg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g56f3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfqrl006107;
	Thu, 27 Aug 2026 15:53:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrqtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr5Zw36635080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A4D020043;
	Thu, 27 Aug 2026 15:53:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8729020040;
	Thu, 27 Aug 2026 15:53:04 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:04 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:54 +0200
Subject: [PATCH v6 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-14-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=svRQoDZTHOQZAY7ksz2hU8CjBEPxLR/MYMehJpai+yo=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoNf9q5e2c8rZ7pxtdEew0Wu3bZXr/6devycX9wxP
 6PGDI1JHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAExkfSXD/7CYurfu0eq/WleH
 Fz8ueru6sW2LRx5D0sk+pRsZDzzmMjMyNJ3ct5x53r9XT0RutPBd3tnE3+MQ5Hmw6Bdb1F1+lX/
 reQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 84yXRCL8slpRPGmGIPPJEN3SLVbElFJE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX0XhSPykcDHu8
 wi2DqLm1QnWnRrqc68cpMvPNOaKtYA1ye7x/CWY817OUIvTyBYnf5/6u/kBploSPDPBoiWSjL2D
 hmXagCiFqb56ES8PVf2AEozfDZtBpSM=
X-Proofpoint-GUID: _OsVldKtMjvoXXaW13lw24jMifb1xHVe
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a905d66 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=b1Ck5HAT0Q-BmxMTSzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX5FUPZ4mjHV+i
 uNX+zu3ysxTNTVJkHmMUY2FAV4839Al0h2gPMprdjXl77iFXX8d91PI1jO7PjqxSiuQPtf2ykZX
 3tRZqtLnP5z+mRX2IpIl5UU5jf+jRFiIEO/ZACw2owMc1T+GvYEhuJOnKsgSxuuyzYl6GiYJ+gn
 9LqdbzH1uq8Q82fTmBQ4OAYRF6Hrcl3rci1sI4wh86tmZk465derjaZ13penyHaaBAkcwAo1zYI
 DRE/LHl3V+RBSANG6YoCYrJChI/m2OFsHIWicA/Li422Jz9ymn+Gao6zmLhLhjhx4/l/uw9uF63
 LRCMLarSNvK4FQGxTwOYvZ3wN5t/b1rROOfmXDznos9w9cAQiYgyficsd5k2gv5oMlc3BT0yB56
 BtPAzl+0D4fxDYe+eoO/Kfe1S6iAvYsidYEy9YVgTdaXK2vJQ1JQi1u7ozOP5BgYSWaXI3C6dUz
 jpkm8/8/6zonwk5Xw4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

To handle vSIE configurations with an ssca we need to pin and unpin
multiple consecutive guest-2 pages in guest-1. As these might not be
consecutive in guest-1 it is necessary to iterate over all pages and
store guest and host addresses for later use.

Since the new methods use the existing {,un}pin_guest_page() helpers,
they are moved up unchanged in the file to avoid having to resort to
forward declarations later on.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index cdce4b3b2525..d52c3a42aa27 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
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
@@ -251,6 +256,46 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
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
+ */
+static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_pages,
+			   struct kvm_address_pair *addr, unsigned int *nr_pages_pinned)
+{
+	int rc = 0, i;
+	hpa_t hpa;
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
+	*nr_pages_pinned = i;
+	return rc;
+
+err:
+	unpin_guest_pages(kvm, addr, i);
+	*nr_pages_pinned = 0;
+	return rc;
+}
+
 /* copy the updated intervention request bits into the shadow scb */
 static void update_intervention_requests(struct vsie_page *vsie_page)
 {

-- 
2.55.0

