Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE61B87C0;
	Thu,  9 Jul 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610132; cv=none; b=AMhUwoUoz/cY21rFjyvxTs+IA5Qu8+Z1XO8Mu8O9IGAY3f6A6bmPiWAX2CNZODliLUOyegKOMzvN9bJ5Fsc6BHgsmaZI5uAn2U1nMBZzpj/8CYycRT57UWhE4n0xaiU/33ZKTJJKspy2FCRvWcMM40A+N6HYmY17UXSfWzAvSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610132; c=relaxed/simple;
	bh=bnOrft0/N+eg2mVsCr2SFChRVKCecATxzyPnmxAGYjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOJM5bWlUkEQKtr4vsk+ESj0BjucE7K+td6dPsmoPXMW2P3G/x6oQKgSloTGs+IO/4OqhfjbQkcKBQD5jXIZeEa3qgskM45FHJagMiGOpBZY69OA6nGP1cRe7YN26mp2lrD0oOy+NlnR1n5TZuhF8dO6cQenDqI5mPpgjFlniek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fjuINBgm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fjuINBgm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIgld2914806;
	Thu, 9 Jul 2026 15:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7V4tu5
	CVl9+SYfG4ovXDeFYyjUFzwLWngPl1yiNNqB8=; b=fjuINBgmFTp1fqaGMmhfB5
	1pjhWmd51q+ReV0wHP/5+4wZtTtt3XQR773NkaxswpUFvFxExwNuBv0Yy7zkFWCw
	8In34RfuC71Eayy2RTZykojf+HdGvQ6ESCQu0ZoLr7DhXnNi5SJweovNZkHu+2RM
	LccmcxvDvSf1U27rP/cGVsVB07Shnr/KdkWqteRk3J5BTt1ix6Yw7/R7LToiAwdb
	sSJFItdbaMIl6iJKMv0WnnCjzK3oSwBwRAx/WLeKftDb/zURTCqmBO7N0B0fkbAQ
	X7JuXrFkkkk+axvWT6Tp9hhyM7JwnOKjzQYLNuRg+XI7UXgITwHGxKV9+bNn2Bow
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur22vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EnoMs029157;
	Thu, 9 Jul 2026 15:15:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkdpdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFLTn46793018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD682004F;
	Thu,  9 Jul 2026 15:15:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C5B2004B;
	Thu,  9 Jul 2026 15:15:20 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:03 +0200
Subject: [PATCH 03/21] KVM: s390: vsie: Convert shift to phys_to_pfn()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-3-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=818;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=bnOrft0/N+eg2mVsCr2SFChRVKCecATxzyPnmxAGYjk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5m4nkh8u6HLnCUsmrrtUJfzhN0pOVu00lKeB+1Z8
 SKNQ2VDRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABNJ2Mnwz+b49tnR3E8my5y7
 yhvqKP9JPf1wyCHmbm41vsU/p/uFNzP80+lS961+0Okx7eXviSp3JV5LlnxXnSP57n74Y3m7S/x
 3eQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX9MbZQRS+ZDU5
 S+y44x+Y5O4wUDSB1lRbrLMGQyB7wGlcmD9oyIAL1UIZ72w9lork4FCG0HCzLw7/ex2litk3OnV
 /uFcDsw4xWEhrkMnR4Jf2i8KDu0nb3U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXxhM4qkaBvUgl
 C4QuxS7T/R/eWBgFXJIDE2jq+EMc2akiyftuxcg3HIZYy62uFIftZAAgY4tQOU3ZXOR+cR12IWD
 k2oT4vxkjks2a/wVZSMUBAcAiWbawniG+epKnotxHvBtydsEz1nmPqUzRGPipHnzQ3oS/v642C5
 gy85GLUBGeWIn56dwQNug7zJooR8vpetU6+KCKwgYVHysaHt697SKgCE/Y/fBNtxWtg9zfgUrZg
 5OzsFI6i2awJRrDOjywjh3mwIAN2Iw6+40Fm0o8kLSbCuAvfkNP7HbOLcda1okELQN33LG6cH9N
 KYacsecpEc75ycF1sD6yV4msT9TvHabWfd3Sk3yc2GkmdR4+4/DygRWJ5cqwjaKd5SsXqzBobKb
 /84v6mdZzoydzeGqxEjT2rYvC0AVpXpzH1E/RC+KCUYROJwz8NHgw3HXWGtT+l35CPc0XQJUvjU
 /Yac5Xj2snWbxP2uElA==
X-Proofpoint-GUID: je3RCj5EUzWnx9Gq-ubhb6LrPu7vos8K
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fbb0f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=TjNmkj8DtC1qGl0FwqUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: je3RCj5EUzWnx9Gq-ubhb6LrPu7vos8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Make the code slightly more readable.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 3e956c7faa4b..937f9c99bc00 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -701,7 +701,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
 /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
 static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 {
-	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
+	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
 	/* mark the page always as dirty for migration */
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }

-- 
2.55.0

