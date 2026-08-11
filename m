Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D139659A;
	Tue, 11 Aug 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464889; cv=none; b=APDdN0IthShuec8q7H9GVgH8oFdTuD0o5ghoVuKvxH3euwynJjZqmzRxVQJevkNPrh8JSXAKFoU1YK2wAIAvqkH3kuv+2LNT3KqrwxwAtYnnfXp4tuftvFE9923FRgMX21rwTAdZKt5SP3ZzeWM1EI0E6AxBGJ+/J1uLXV1YJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464889; c=relaxed/simple;
	bh=UYrgxX2oGrH9EZ9//XdjA74c4x64vZkMNk82mX+FVJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1dP+n0joQbrRLkcILg/oj+JakJQb5f6cTCjbBYJAHJD4/ef2zS0/tQydc7bKc9IdqklpyOVDo5HR6Dc9T+MC3B1Q69N+ofDfHCmu2r2wYr7t26JZ3FBbcYQUf2hD9vDUuqxrkpccFD++wxOeR2CuK71vsmjc4BX6MvV/cPJ0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tT9DEQsS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tT9DEQsS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXANr451276;
	Tue, 11 Aug 2026 16:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5owEyd
	dO7KZ3OucGwXctpsCjDjvE+myJwsfdveK0VCc=; b=tT9DEQsSvBd3zpWUYztRXU
	sSpd6RkDO28AyN0P1oH3nIkutB/KkTehwufV9ZB16kabAy7XAczTJ7izIUPBXXgy
	qiLTzxaUmBcPv5aaQtdkdMNqSYkP+ONB9MX+YBX0l7gxmJfpRdfmdU0bGEWHYYPe
	RPJJi1ghxawxuYLKjSoCJTJdEQqf/eXvetZovUQgq+IkKIwa2w5Y989/nTA9x5FI
	jj7a/XyuS6zNmEcuLZnLuN/w7JKkYfKJOR0MRx/CmReGAU4LPZCwuzINiALaVy3F
	7jQAXVwQX+u6AxarTaVBeWHt3zKVU3QaOzCBIFVfsriUJMTGAJi4T1vvGYPrZ/Aw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2w7y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:14:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BGBGRe002902;
	Tue, 11 Aug 2026 16:14:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1fjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:14:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BGEebw53477766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 16:14:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32BC520040;
	Tue, 11 Aug 2026 16:14:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0941920043;
	Tue, 11 Aug 2026 16:14:40 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 16:14:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Tue, 11 Aug 2026 18:14:22 +0200
Subject: [PATCH v2 2/2] s390: uv: Prevent potential out-of-bounds read
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-uv_secrets_fix-v2-2-64444968ec55@linux.ibm.com>
References: <20260811-uv_secrets_fix-v2-0-64444968ec55@linux.ibm.com>
In-Reply-To: <20260811-uv_secrets_fix-v2-0-64444968ec55@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b4a74 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Tnx3wSNbBr_IL-7bfWUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wu_SdOwoWvbEnW9JDG0oiEFSfAGv5_X1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzNCBTYWx0ZWRfX0u4nJGqPA/0e
 c7x1HOsCoVdkZ3oEg8rxgSbJLowQK0aBFFWD/c1jt9ShaOF4z7hZsuTeWyrcd37ppAoRW6tD85V
 Y4uYH4iSAtqAPdZhSRrVd00bvtoh/sUC3QYhM1XGAbQFbQMXKsX4A1a8meF0PApwR4kJ4DB90tN
 wpmjpUdE1E4kb3u0cRbVQRgCJLl3D3wuflZ0KZjfCDWXpXEk1Wh2La/CrLpGPkS2Gp26IeK62Ye
 GKtQ1wi/+P2MOhCO1LKjg+2Os9rpMLEw2fLgqsGFlkMiafGA4sWUeqJnQeh67aU0DXra/02kyKg
 FAo1oewcgGqIRGNqpRyV02nOls8tkWLkFe3edNR8Hk7eKL6nU84Eogf6Mt52+2sGU5H5pc16SP/
 nCA6tpgO+eF7Q17DbQdrWfQ8cfDpPZ+N7/cy/jiqpAedhbVbTqMxVDFcRpwzzQ24JKIkexIEQjw
 axvUwzG8ZDSdTjmVx5g==
X-Proofpoint-ORIG-GUID: wu_SdOwoWvbEnW9JDG0oiEFSfAGv5_X1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzNCBTYWx0ZWRfX3m9qC3xoXObE
 kFtqLn401VL50RCn5YDm0PdnYpD713ghMtQfV5CKYVZ9cWM3VxJDUo6fSyX4WwaVkzG0AMdP5qD
 10mjWkr+T8npJOtaWYilBILCwQHGGIo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110134

When the system has more than 85 secrets, the uv_secret_list struct array
only holds up to 85 items per page, resulting in an out of bounds read
if the targeted secret is in the next page or not stored at all.

Fix this by looping only over number of stored secrets which is the per
sub-list count of stored secrets and not the overall count.

Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index d970b15ef126..e70acad09cd5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -760,7 +760,7 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 {
 	u16 i;
 
-	for (i = 0; i < list->total_num_secrets; i++) {
+	for (i = 0; i < list->num_secr_stored; i++) {
 		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) == 0) {
 			*secret = list->secrets[i].hdr;
 			return 0;

-- 
2.53.0

