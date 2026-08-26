Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2B44C518;
	Wed, 26 Aug 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756730; cv=none; b=L9NC1egLMPSdfiwluFyrnm6D4EyeJ6CnirKSen76jNa8NtREow6LSSZshCIAiwm31BbwB3BlkabIHMv4ultuHJDO/9i/m5lmTdOyjMphGaxTo3L/emDML/FhrthRkrAekza6swsNAgiuUoZFT6FppQUT+p01UQ2JTnVYnKM7C0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756730; c=relaxed/simple;
	bh=WXdzEC+4jLkDKkNWzny2N+q6m8l2y1LX6up/MX0WdqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVeZCy/9ViSW+nwqBwE++CWt6FoUKA8fh3VgmLo1MZdTAMmjyf3yNFAhdWvd9SGLbKdQ/jtHEBkPNdRh9A4xbl1YBCVCckynEYQaO/vAMpKvazwS9NqYlstCK7KbA3m7cdDyDC1DphKE3oGAbjX+nM3frcXcHHYWpPu8Midv4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y2mIv3IV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y2mIv3IV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1gk84099748;
	Wed, 26 Aug 2026 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l0RZOm
	d8B9mUabe2qw4ylUOI8AgEKlhSrtHq4gStO3c=; b=Y2mIv3IVKsYa8whnGkZKqJ
	adg3NVbs/6LiwcOeccCN2xoW40SOmWQBH8+X/I5Q6zCwcQXmnjFQssMqwUybAcdj
	0G5/O7kEI+2fALykWIWOzq8S0EboFOj3mWRx8qwZ5i0GGsE6X8zb7jptRc4SN0Gd
	ow04Bvb783DjCVKW4chnTxnRMij4O623BAlOp/34WlCLnkJ7Z8bxlAhgF7nAn6YQ
	/kEBEL2iWKwONDN+vI3z/59p1IhvVS6SHmUDQD3l8w6B/y518eiFJxzF9jsTdHMT
	e+2WPqt+rBfFP9fJ02vypJRSCHQdmdyRAv95eY7pRkK2IJIgasvdIKKEpIkndZ4w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyhkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHvV017169;
	Wed, 26 Aug 2026 15:05:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qat07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5Jkn44761524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DCBC20040;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00BAB20043;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:13 +0200
Subject: [PATCH v5 11/21] KVM: s390: vsie: Add helper reset_vsie_page() and
 unshadow_intercept()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-11-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=WXdzEC+4jLkDKkNWzny2N+q6m8l2y1LX6up/MX0WdqE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKsTdi+a+/ZCdQ0DW0v9rYtfprat9K85rjU5+9z/1
 zwy62o3dZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRCWmMDEdyFPZtz1sc8n9C
 ZiDD5NJtcaKP9i5rueNenH/jjOCblwGMDIfy+DUrLim9nBse9SmnhFfxnYDf6QMn1ikH8ZuEnkh
 dzwYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX7nrBb26Fy0ea
 9zFnnA7kCEbrNaXG/6Mrploy3ELDh50X4w7TWltfggQ+91AF5/SFNHhXSQqQJiuAl9foePzttH4
 Xf49xoQeqHMxG4maG8y9Qfq4/vbv9v8=
X-Proofpoint-GUID: z0vBKWcD68I1kjVMIGQMIEbnEDuBUkrq
X-Proofpoint-ORIG-GUID: SS9Wy-k-4FPhVwFOtMnvunnV-7a_6IMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX/zHP6J4JTPgV
 D1cB3vdgoIOLakkJbM4OuEG1CuMMae4IhPlurnePq+GQWd+v3gHN7YAiRSlDx+t4U145OL7QThu
 6yw+ZYtK5uJt12Kj4vW79tlmoBkZImpHZPDcEnhahgdB7D90rUMPV1tJyW6zZBAogO63Wjt+ErQ
 ELkXa/+0mmnOMzXmpXATzVVZvjYRq1qt4GReO107MsEzrRFN0lF7hpONZTmTumE9903a+v4NEiW
 ahrhKL9dSsF3Zjx5NX4Zx30GL5gE9JbCsy8QjIkOYRhmrzpavvBjFYVYH7/erNRKfSQgRCvhjFO
 k61RIfr9aRAXhlJNqFS3I44AgynCM5ZbHexYfp4r8Mlk4TzzkGZSTMPZFKxXKDl+YgxAyjAsvxI
 xylqno0gaPYsz2YIt0BjqMVvT72RIfzpCA52hAg+J4EJrVRj5qY3n7n0GyREv65I1Gj7TU9MEMB
 Wb160XL5FJ7uB7niQlA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f00b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=BT4YM3xfTWJAqdQ5kpwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Extract helper method from existing code to reuse in new code.

reset_vsie_page() clears and releases gmap related to vsie_page.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5e41dd151f8e..5c4f13777178 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -1530,6 +1530,16 @@ static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
 	return vsie_page;
 }
 
+/* Reset shadow state after a vsie_page has been (re)initialised for a new SCB. */
+static void reset_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
+	release_gmap_shadow_safe(kvm, vsie_page);
+	prefix_unmapped(vsie_page);
+	vsie_page->fault_addr = 0;
+	vsie_page->scb_s.ihcpu = 0xffffU;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1595,11 +1605,8 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	vsie_page->scb_gpa = addr;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
-	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	release_gmap_shadow_safe(kvm, vsie_page);
-	prefix_unmapped(vsie_page);
-	vsie_page->fault_addr = 0;
-	vsie_page->scb_s.ihcpu = 0xffffU;
+	reset_vsie_page(kvm, vsie_page);
+
 	return vsie_page;
 }
 

-- 
2.55.0

