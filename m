Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B743C455C;
	Tue, 11 Aug 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464888; cv=none; b=GOfFlRwbT9PQBHrNFWlXdna8kdEYzitToPxIBrbCo8Alc06yl9PGWF59iSYgVOEi1c5P1n9eBcbw+VJ8OUhMDyK7a4wmvdabPtSCVdrk08OGO0/R/FMjK7ak5hyhOSoS1qT8+kNVcoheMT0GExhzXs6F7lRg3cTNT4e6kEOMe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464888; c=relaxed/simple;
	bh=HdAbxf3/6CAE72nAg7s66s3DoxDSgPEPFZ2O8imvz8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snOCz0phPyHvvIwK/mBLGobPh50h1tp1bH8tl3rDYsWdI3Ss+hjiJCXMfWeNXqoyucd/+GQNDVFUBSQlsYQUDxQR/eX+kUzn8hoo82XBtG4GZNfTfQI37Glb5kYVVqibotob1DP28WcdS2eFwdrcuSSeIhSPaY4ler537tI7ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CMTJJdIw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMTJJdIw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX0812865450;
	Tue, 11 Aug 2026 16:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BLJ5WE
	uVLSSq6ZfpJZIBjP/KE737NkyKJt2NQXIFHKs=; b=CMTJJdIwZ7CsNJy+lqCtFl
	cObJHbxRIQwoV0QO6nBQJR76i6Kj6hr4hutkir9OvNq4IIE9j+TUNNeW1LivqyhF
	32X86epN7raNrHWMARzBIf/rrl9RhSLrK06cfMtf2jofwa1+AF/7vbyn68qRk4OW
	3B0OSESFAow27L3AdgrXaVMn2RXkaeCiWzlN83VDU9SXRM4fpC+8bQftfxbwfDdo
	x9xsrcUOH6UgIbkFH0qZnLfMU9FDVs3MtC57K0y4tbZecPMdtZeqjp4ueVjjoR4s
	cwGGW7sFNADnw8wN3QNvXEz8PTg+uf9AeigAYd8hgu3vknGmaGivuNNlDKLwTU2A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjywv70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:14:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BGBHYv005514;
	Tue, 11 Aug 2026 16:14:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1mdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:14:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BGEetu53477764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 16:14:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 059D220040;
	Tue, 11 Aug 2026 16:14:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D02412004B;
	Tue, 11 Aug 2026 16:14:39 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 16:14:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Tue, 11 Aug 2026 18:14:21 +0200
Subject: [PATCH v2 1/2] s390: uv: Fix loop condition in uv_find_secrets
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-uv_secrets_fix-v2-1-64444968ec55@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzNCBTYWx0ZWRfX3ap5QyftyWUC
 C7r8zm6jokn7AHUAvByYzIhaBkMj5vxsNXrYElX78/GZ57KbQr9IHCD0/NaF5axl36nfYGPz2ce
 L9fyLOsLLpAVPBzJAF40nBq/FTz7vFXhQlt3oxql6ethYENzUJIGbOc1CqK3axfoom6Wfo2Jtb8
 UQ1Rixfj8ba6Q5lscPu0o051fkJlC9R40rDejKfF5+IywUG8/Wfar2fykHGPd/K/9UFAHTlhXVT
 HRU942e+PFgZGIF2E1yv7DOi0TZxp3FMzQqKMrQmwpoQ9dsrQkAQ7cWGA8h1bo89xqrglsY3nE4
 LfUjap1hXTpuN30VSjWrjPe0jnb28exAA3nzQDdvXeRTVl68HpBVPb51ynvagsY+10+OIBt7tjX
 1uu0grg1STGxvSgS9SaLJcFjI7Mfqddvm5xUxcFSga0tUNSLSHRD59Vx7QHQeltMFouL++7TXKv
 0EKWvmMqIO2pgKv/SxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzNCBTYWx0ZWRfX58yOmKYiyJvL
 HAlp2UlcCj1v3zVHvWSV7YOAgVszY9EL57etGiDPKoC4jHJR7VFm041E/1u323peAvXUz/8itEo
 UxjagQQdanhNdSLmbnAzSOxe0VN8af8=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b4a75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=oTDM0dCkufzkdTJShNUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H2Gh_TxqxeZ96jfHsYo5P8x7mXffaw1N
X-Proofpoint-ORIG-GUID: H2Gh_TxqxeZ96jfHsYo5P8x7mXffaw1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110134

Nothing modified `start_idx` between the assignment and the comparison,
so the condition was always false and the do/while ran exactly once
even when the UV returned UVC_RC_MORE_DATA. Systems with more than
85 UV secrets got -ENOENT for any secret past the first page.

Fix this by setting the start index at the beginning of the loop not at
the end. First test if there are more secrets left by comparing
start_idx with list->next_secret_idx, and then set the start index to the
next secret index.

Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index a284f98d9716..d970b15ef126 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -781,11 +781,14 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 		   struct uv_secret_list *list,
 		   struct uv_secret_list_item_hdr *secret)
 {
-	u16 start_idx = 0;
+	u16 start_idx;
 	u16 list_rc;
 	int ret;
 
+	list->next_secret_idx = 0;
+
 	do {
+		start_idx = list->next_secret_idx;
 		uv_list_secrets(list, start_idx, &list_rc, NULL);
 		if (list_rc != UVC_RC_EXECUTED && list_rc != UVC_RC_MORE_DATA) {
 			if (list_rc == UVC_RC_INV_CMD)
@@ -796,7 +799,6 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 		ret = find_secret_in_page(secret_id, list, secret);
 		if (ret == 0)
 			return ret;
-		start_idx = list->next_secret_idx;
 	} while (list_rc == UVC_RC_MORE_DATA && start_idx < list->next_secret_idx);
 
 	return -ENOENT;

-- 
2.53.0

