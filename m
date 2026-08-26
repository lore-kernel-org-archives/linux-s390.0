Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9044E640;
	Wed, 26 Aug 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756733; cv=none; b=qy9hypHOOKTcTISWWo9s5eYDlV37gmGY4l6qih43S7y+CTXFw/NNNgb3NnXsduBd4vJbctgEmqAdPmHBK98I0Gfx4zsj/XoGZTDO8VHstNNNMuW6Oi3Gr4g5sCjV6CJhyE1+rveV+ePB56xgGaXPg4pOMuC7hW1gFSsrAWrQQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756733; c=relaxed/simple;
	bh=uMKkzgCrfyiqr3VSqElkWWe1FsgefZSzdcBe6PtYVDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UshqyYjnWfGWBoJxmEcepbYdiIeoBGW20ODT1xCef8CP9Wtqu1olxrT1ADWEIQhfClAy8GTqt5zzrhG5GAtSBpXUlCGJj9qNimqgAMEjQI5V+TPX5mrBHfFT0fhSWdcNIdCk1nELGX1inEgOF9HMmhriKdgCbTVRr+LBHOwYBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QUuTBWsn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QUuTBWsn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1eTK070380;
	Wed, 26 Aug 2026 15:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2knsal
	ncta4c+JGMpd2N+cJJmQ+aBNO9mG0GFjHwoTc=; b=QUuTBWsnbXLtCpnBYWVyKr
	cjIGAOXc1WgcTpUBA+tv2kPAs1VYJ9heB9dFsqbSLckD4ozdMh8+IZsJI97wQtQI
	5UXoIAuDyA3ifpzeoSoZ7avj8e/WH+IFGvVXH8OL/dHb6nyJYkzo+MtBYX2UthKT
	xu6U49xkHAwXxiKSYFMoklnEPeZ0Vh4AVXy6iE9NYav9sZnJfFsHU3LwyDc3C4HQ
	Nl2Y13eRf80DchLzXtwW6yBCLCbefGpjyLfxUvg8VrzPkkOpgDrCV8RP69T3NMgi
	BAqdNs/UHWrph/RH21Hg6VIUrd1cto0MDePjrrmWwZxIgUiDNxUXiG56JWrd66ow
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxf4fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuLSY017944;
	Wed, 26 Aug 2026 15:05:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2k8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5Joe46530918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1DF520040;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31372004B;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:16 +0200
Subject: [PATCH v5 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-14-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
 bh=uMKkzgCrfyiqr3VSqElkWWe1FsgefZSzdcBe6PtYVDU=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKuLU+Pql70T5H6Tprq7OEdp9umDko9q5hxd7D6LJ
 yrn7FznjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZy4ynDP+NXmnJdWWtdEhpr
 4zkD9IpidWr22ft/Pf8mTuiE5rsAfYb/ldaFPm7sUbWc8x79v1u6cmldq+R9r8nrhY6Lb5ut6aT
 BCQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX+47BpdmrB6Vp
 MS8Y1q+3fu3WrZes7SttCrmoG2TLKRIz3YxPIoquqQp5tkwCNhgICAk0yE0doevJHPC+cwaaKXG
 V4sx8O3a5+OXSvzkqc3EuPxCbqwnsZE=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8f00b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=b1Ck5HAT0Q-BmxMTSzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UnYQWCfjyxFSkbP3Y3Fl_6V_lqgvc5z_
X-Proofpoint-GUID: 4BN5fJSV1B9QVHZ5NqZHmNjA1O8svTgK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX2aHcSY9H+5Lf
 CQnOI0SjZGmo+NG4XW1X7696uTflfaBBZsEiOTfx+IpNwe4MRsiOnMvww71zudS7zdXMqAj8nb5
 HnoFXZk/GIR7VZ+t4Ry3ajKL668MFtH/cA+//tZ1dUjRIPl8L/JjARi6xioQcOgwInwJ1UyOCnC
 HASDV8X52uhwjv23ObyTN5qwyOWOELnQchjNRkxdnQx2uOVweCTX2m0Kw37TD5D43hymJ4LHnDJ
 S3fsSfqGt4yrN4jNl5tAHCWDgFTyggdSarozG7I5TcrGfWgdbGzouUQjP3P0tn0seYUHVgqZj2i
 3fVR0i01qQL10gBN0zphWd8bjMe/MPU7hzEdpgwIFzNE+kAyzC1dWSJsJBDrvZmaLFlWUVe5xn6
 rcsacGH5NznInEER1YBGS0/nWJCqyzX+yzIt8ye1HZdeVqQrowud0goBqlioUFVOZdqIK8TBfmW
 1b6m3wS1XIUkWtj3TiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260125

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
index 24af48af89cd..f7a7170e3112 100644
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

