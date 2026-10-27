Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111438;
	b=PsIgSMv2r4Cf9F9/Sf59ojftv2haYKK5umPfq43OHuDTlwxgGjkvRIbxgzNWeCDSv87y
	 oho3NDlHid5dYisINyaJQcdPG83uha/W3JQucLCcGpHuCm0Dnma609BHe2VBqINLhXtrh
	 6WShLj1g+ydaHP4FKYhza+F1yT1ZLeRsC5bbOrL1xpOG7KIeTcjle5l714+1wqOe6FqVs
	 2hOTy5tmn9j8uTnKXs6Pb+zpgIxGsBFBNK/TRfMe0vMYmHqFHOwhbX+ZOMtXKV8MxXDIq
	 p3uzeD3NmktxQK/zxosiRqZ9OlzvfZd9uSex1DlsgrM5v9l49y8RUd8nd15Orq8qWOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SDYSuYmbkZNxw1a6NZQZLDzPgq6u052uZcaAl+47ce0=;
	b=qlobiD4gO1TLZIGfHvAmfawNtFsy/gcMwvkAsmoTOH8pg+vQo+82ECylD3YPAp5UH5NU
	 zhntRLQ5m8CFyiK9vaahKXKOZbwKy2UVkgjHLQolg3VvpnZusDR/yg6WSrkSKgC6/mwo2
	 H0/5pKkb3YyxiHNGYbuSb5JvfodBY+hE6j1KOgDwJv29h2197sYpmWyizNNj7D6V8GZ7x
	 whb4AgKUWCVqAdSnfCLriSq1yImvCJ1a8F5xIRAl1T2A3LHHICNqqgIdVeBc/NehpEKP3
	 cJvtaQk+ynksQBE3j9fgAki1/gIRf5untMk6Fv0i7+p6ddKhBFCAbGcAc3509ZtSiBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RAW76Pk+;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A74606A31A;
	Tue, 27 Oct 2026 14:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A74606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RAW76Pk+
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEER02695743;
	Tue, 27 Oct 2026 14:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SDYSuYmbkZNxw1a6N
	ZQZLDzPgq6u052uZcaAl+47ce0=; b=RAW76Pk+dSaWN/PraZuB38nsWsTu3qrUS
	vzhR5dKBDBRqHxwUsw8/Er+Q5+UjDsQYiywOJn0b5i3AV6/ruwnGntSZhnpVPCRF
	WzrBmiYPGb8UDJG6h5W+neSrJoVV2aRJ4eI7XORkG2g2Pvs4hqlHUV/tO2LvlxZk
	ne0KW8R3KJztWJaDG4VKFpUpNQ2tTEtC34PbPRPBYWze2Di4AqWXljaKJwlu471N
	uQpu+CvlXqLKgO/Pck8pnNf2AfnWKnPxH8K/r9Q3KI4K1+gOh0ekWZqgu059OiU0
	griBnKiDFJDjTK2co/Y3mu19D5hRanZRvM7x4Qubl1WQ2yomq50nQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavfga8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RE5IE5050387;
	Tue, 27 Oct 2026 14:30:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvk9am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUVLD34537806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 470592004D;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 176082004F;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 01/10] s390/jump_label: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:21 +0100
Message-ID: <20261027143030.3154657-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae0b58b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=mGn3vSmrZvqK9RYfsYoA:9
X-Proofpoint-GUID: mTgO3byzaCFNZg4K2s7op554enpd8AYc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXzdE55qzihhjP
 chf8WCJra114BjVkr04VRZAQuo7GI3EB/w4GgSby8yit5IK7QRaOXSRR5Mzpx1w/b1Yh6gDqg7e
 wCcez5lwbZ8RBDWBYG1+bWji7w3gn10=
X-Proofpoint-ORIG-GUID: mTgO3byzaCFNZg4K2s7op554enpd8AYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX9dQGF1JlB2qs
 dttWlEDK1vL+zxZE1NIZYlyDJjb/Wk0ubRoTjv2PFkEtAEdZmiSdDBB+hlNzHG40L6RBZ30mSRi
 SZih38Z/4aeJlULCgw6+fy97OsHWtQ/VM6fOsRTq7Bgs2rtn50xh6aBiQVi6v7ir1PVLYFzRps7
 45OeZRxxKzlsv5/5ZL2mOrrmaPVbKVQCKSE1I1ER4MmNxf778epdP32vILdgdayL0tjgsN5B1rj
 lCW0TZ3xfQGdMvU+NDLnoeqqG7GGl+IKmM/BTbqkV45J90mEE7RcO2HSMpsevBt0+ptzhuRggUd
 rtEOfofX2gRE0TCzIy/r2cD0+K580FCwSZJvBUbCoofI4bqMZwmvlKrmRA4Ewd+g+RHFIx/yUHb
 46NvaTMCeLw2vt1k2y4y5Jp4kdfsHPYLIa7ZkpgMD80zEBcyXcNMOYBCWIimAm2JVh2R19/hcKG
 Wwwd9PrsP56OQ9IAKoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

Acquire text_mutex around the verify-then-patch sequence in
jump_label_transform(). This way s390 uses text_mutex like other
architectures and does not need to rely on other implicit semantics
(e.g. no kprobe can be set on a jump label).

This is part of larger series where at the end s390_kernel_write()
requires that callers hold text_mutex for serialization.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/jump_label.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index e808bb8bc0da..548141eaa20b 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2011
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/jump_label.h>
 #include <linux/module.h>
@@ -57,6 +58,7 @@ static void jump_label_transform(struct jump_entry *entry,
 		jump_label_make_branch(entry, &old);
 		jump_label_make_nop(entry, &new);
 	}
+	guard(mutex)(&text_mutex);
 	if (memcmp(code, &old, sizeof(old)))
 		jump_label_bug(entry, &old, &new);
 	s390_kernel_write(code, &new, sizeof(new));
-- 
2.53.0

