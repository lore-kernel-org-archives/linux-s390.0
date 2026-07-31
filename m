Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA321FDE31;
	Fri, 31 Jul 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502912; cv=none; b=W/zRpkHM25USHm/inKOhXhu8V80azEHG0z+k8XmEvgi7AmUkDFHcNjNuVllnzLUjnv6FtgrMvVXpoh715ZLKrn+5c+RYR0FloVoauSWPldpLXTpgU//bxpjhbM/rdu6+jAAiT3s3lVPxJHbm/mnSf1HKnvXq76O3zYJWEuWO4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502912; c=relaxed/simple;
	bh=rGUq/bbmBOybJjU+Ue7l7Uyfv2XCqwBWhe6A32dvtIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1u7wDBSaZa7EZrr3goFnbNvTqeOVvCGq7nidgvYZciBVfuy1ZoY4AeQmQUPWA72zIiWsAPve6ZyzR5ek/AUB033rWa4zyvYd14Txacn0I480FjNMBQLhlN4hAF66baZUabnofwmrwn1eUFPebGkW0FstJYrQO4mxhrthvzqJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/yt3TIX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/yt3TIX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlcvW4072623;
	Fri, 31 Jul 2026 13:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a8o63o8zb7q/KcknA
	rEgZd6tgJdqLJy5aq5FS+Lux1A=; b=R/yt3TIXyeVBpFz9d5VJH1FM2YeLsiAKk
	qt8V1pgf4bM+AKXHaB4Pi6jMuYEXGH1WrmsiN08ehXp7Z4ErTdai/JhmtEM4xlYV
	XupnnpiXjPCA8ABuf5ctBGmMG/5Tb6xBqczRz0HDzS34PZprsIdVISxy5CVKdTy9
	eEBeYOYDevZi/9LjoxRSsRodpMob657l2YgJZ4Gi/X1KzbzUWH79Fs6ixaQz01py
	nfbxyee0HgEdYhlXKUEC5RLwHsfBVZIe7Rz/uybYvs9dwYcsQQcu/IcCM+aJpuTc
	ANFHpm9uQ8UD1XW8N+XY9LGhUitzNHpZW3vHrb7ZmDGAUQ8ny2OIQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw1d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuJh3012652;
	Fri, 31 Jul 2026 13:01:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkfxxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1fvw35651888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BDCA20040;
	Fri, 31 Jul 2026 13:01:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A977B2004B;
	Fri, 31 Jul 2026 13:01:40 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 02/14] KVM: s390: Do not free SCA if it was not allocated
Date: Fri, 31 Jul 2026 15:01:26 +0200
Message-ID: <20260731130138.173983-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TZnnwUKX2DdPEuiK5jN0HBbJByhZBgFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX0Yk4B6NiYypI
 o8hW1kLcceAeqPHVqMCozcMMlQnM1nvOj0XUPzp1j+l9iRlti6PCfjPQgVPYi3I67oCFm+9hb7n
 IvZmgDpTHESRKU7UtqvULGmVyPPpVrErq/VM/t8m4XV1NDpKtDA6OwZb+rkTvfkSnxfqeKq7BUo
 ptGFmo01/A9xCvBVeQewJ2krY54hSROKFJNdvQQcFtkN4QfMWfqdxOm7E0SiIUm7LdME36U2HZ3
 +/zV5EjpoOMgBXwN+wROxB72UMj+GDg/FZQAzRlWM51M/sb7X1thG1//jCCR9kxqz44Yg5Rsxuq
 qdbmGFJgh2+/nURP10ZivABtPIqNWjcRUtJOr3zcDV66IitblktHARQmVX6hkfs+yAUwQ3Jood2
 2pgMdCC1uBQTOoKsy1ixDqKFNDvH2zHD0FQlUHESf/HMvcZf2qrnuP0y1Iq/OcYrlhuhSTJDj24
 iJ6lyeKNjUzbPPvcoHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX4avdRwgxBrHY
 JK6/z32LNVc0sXNVPagpvgIrj/NyloYrMfyvvUpbw4MrRIEcQbdgKS709tlfMbxTV3bFGQjkivA
 JFphIQoG6ji8K/plc564Dsin5WAo/rI=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9cbd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=M5uM2SGDJJfKum1V:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3jiQNkuJ7WxZ42At8I0A:9
X-Proofpoint-GUID: TZnnwUKX2DdPEuiK5jN0HBbJByhZBgFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

If VM creation fails early in kvm_arch_init_vm(), the cleanup code
tries to free up the SCA, even though the address is 0. Due to using
free_pages_exact(), only the first page is skipped, accidentally
freeing pages 1, 2, and 3.

Fix by checking whether the pointer is NULL before attempting to free
the SCA in sca_dispose().

Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f86b4b0b356f..1b3290a5ad1a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3247,7 +3247,8 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 
 static void sca_dispose(struct kvm *kvm)
 {
-	free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
+	if (kvm->arch.sca)
+		free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
 	kvm->arch.sca = NULL;
 }
 
-- 
2.55.0

