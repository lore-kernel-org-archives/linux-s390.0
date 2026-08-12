Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AC45FFA7;
	Wed, 12 Aug 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542776; cv=none; b=a9wwx5HdyJaBCGfE0KEt24CxQKYMAcoMYGZO9Yvsw7366JNvYWzSpAygqoiK2XCCSoIV+weOEL3uZIQLH+0suBzkMWrqw7U2bjkXN9x7aFGNbwFPuniF9x86OweYdpwu8laFw5gryUzM9/7TSLvEYAk6TYioHJMWGbQwR0l1boU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542776; c=relaxed/simple;
	bh=xX3iDrFclUF872/x0LHXNAjS5x2907JR2tGDAg97cI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMyag7JmVvLMprMZ08zLKy+AGysQS8zIX/8uf5hl3ivnwFV7cs0kucWnySTvSfGm2E8lRnsdFa61BqsLqLpb5sCbN4FfViNo7w2/Yndpk2fRyk6fBiz0VmlISci6fxAqd535aX2yncmJZYSfaMSWDgCe8HcN63CpJOy+YKOWwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pax/paVx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pax/paVx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3hGU3214443;
	Wed, 12 Aug 2026 13:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QDXpu+
	q0XJ3M76/GpYIyb0jPCz1Qu0ZJvjWOXw+tEB4=; b=pax/paVxH9GZQQmPC2YM8W
	oeEwj3FpoiiiCes+gCn7gR2STJ2Wy48Nz6rxAwJpeguQKU+5eyev0KqYOh6HsgtC
	c6EKmxbVXA9w84BRJPSlgI8xr3AMl3doT6VKBiJkyIwESXCkoRFV84yDhmTN4dJc
	e3JAmxkj5FfWwCU9LSbUB1BrxpEMHTED2iNiubOWmZ+RusYh+YZ5R/2aCKYAdf1Y
	HLji7xzI+A6H2k81rkBIy514R3r6xLPEix1acbUWe80p2SB4RzOw5QelIX9NpTJj
	6RA2Umr+K2lCYFKRdhYFY6WIerujHlBIj+xiQPOGBQnzdD4FrJUIbMmSWlmKbalA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31wqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfb6A009807;
	Wed, 12 Aug 2026 13:52:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6dmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqe5S45547918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0BDA20040;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37772004B;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:44 +0200
Subject: [PATCH v4 15/20] KVM: s390: vsie: Guard against invalid CPU
 address
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-15-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=xX3iDrFclUF872/x0LHXNAjS5x2907JR2tGDAg97cI8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYuFD5duL+76KVEqej2WaWeDrMzGJGGj18HT7X8sU
 zQsmMrWUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwESashgZOveFcFbH9BVNtc71
 2v+wa8dUo317A1WnG+44ZSl/q/20CyPDRKfvGXw7laY8bfi6w/TbqgTf7r/L2aVYledEnS1RKRT
 iAwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7aac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=YOA8uwR83rpBMXObnZwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RIIetEW0HS5FIAiCgaN0w5LxSffGcyyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX3RR8MlLyHoOK
 AMnaBgwZbDejOLRVU+2MSsUPka/qiXuELwOjhnWbM8fl1KwuHBlpgm9Il5EZ7csHbljkPR3dCJg
 QvK/xbgMrpU3ZvHdneRsX8+h2elcQo4yxngk0OolPXNWQl+EYUIhuu0dgOWAhg1sXTRzHd5DPJX
 OsyoXcJj+wdpidcLFUUTaTGCzMntp25BS2poKYoPtdZkQezdThVFSbWPCDQUJLWpJacF0XKZ49R
 3de46bbtBvbmR88e0gV1S7upge/4hgTmkhYNj26Wr0RHlffUl987sXNAa9tRZH4MNYk+jP+fJ4W
 WefkV7yfY0g8+WnHAGDqHoZV++ISe/lbr4n5YzMx8xJ4c/UOqU859F4sV9ZsnLd2lMMM88Bn/fi
 HTIpTkEfBCWesra257w6zQQ4hpr3cTBKbmEBFU6RwtIjNKX93viXsP3wfBJ/cdDEsyCrp2hF0UK
 xoji2e2hkz708Sx9Bdw==
X-Proofpoint-ORIG-GUID: RIIetEW0HS5FIAiCgaN0w5LxSffGcyyJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX01/NOnOh34J4
 hSk7YukAF9ApP6P09exm8zhsXwDv1a9QYInTgq4g0JnuNkpzaPmwmG5XQrzoluYRG5OeTpYVEgC
 QaEo71ytSsFxQFdBmgy/Oo2l24ufbb8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Inject a specification interrupt if the CPU address is above 255.

It would be possible to implement a finer check here to guard against
CPU addresses over 63 when a BSCA is used. But this minimal check is
sufficient to guard against out-of-bounds accesses.

The architecture allows CPU addresses up to 255 for ESCA configurations,
so this check ensures compliance with architectural limits.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 2fd349e52bd6..154772278d0a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -2169,6 +2169,11 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	scb_o = (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
 
+	if (scb_o->icpua >= KVM_S390_MAX_VSIE_VCPUS) {
+		rc = kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out_unpin;
+	}
+
 	if (!use_ssca(vcpu->kvm, scb_o)) {
 		/* get the vsie_page with pinned scb_o */
 		vsie_page = get_vsie_page(vcpu, scb_addr);

-- 
2.55.0

