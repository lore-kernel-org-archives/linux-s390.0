Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BA384CEB;
	Mon,  6 Jul 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327995; cv=none; b=GpMYJGhwZETTvvJWZjq5Jw7FV+SxOCsaTN6oMv0ll0IVbdSxU4xDUAdt/pAolzZU9B3hzyXiOIMwZLbZLp0Tjoq/0irK06z7hKae90QL2qVzB9hHZNujLsycK8zKbS27cLqzj+wjjsdBdvaxUiXeCnpIeMWNtAZ0/T/39bNlxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327995; c=relaxed/simple;
	bh=CdRBGytXIXa1zx9eXOvGAuzKgsrn2BprzimKUV3/4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHgxs7sE5u8tMbSJFb08eds+LR5OOaeNBlOzw6kmt7uBqNq3RRQ8UvLpntJFyP8CLsMHfHNwWWFVZ6my89U0BRpBdadcRgReGaCAQOb+ET0xvQEiGmyf28ss1DQg+3KQS/bT3Qt3VVniGd/Y9PzpU0P88dkefDLXIo8sdOp5PPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ab5CpB1u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ab5CpB1u"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MInRI2251392;
	Mon, 6 Jul 2026 08:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eGPgAnjtKT6ftTAM6
	aOkUfJetBSRY7Y8hfEs8FIUvWE=; b=ab5CpB1uvGHrtrsgkue6ad3Kr/jFMfJuz
	e0kt1cH9i9tlNBlwqOVMWOORdenSRe1chuGS6WuC7JpGxIRZYuVYqLRdjURkZQX/
	uu7cNyXLI8SHAS62zL1qx9CivJ1vNz2b68bIj/EfDcpgNGxRGsDIlaMsTEVDjYs2
	Cr3IFfCrCGgaqcsWSvyCA7f9SXHUGz1k9eTbWYA5n1QN9yJ7+ZrA1pUpNnAk+MSW
	jwVG1nuVg5HQnxonYG+DQhxu0AMr/lgSomeWlvQPFoqW5AIRhRyKi94FtyQDp+P5
	yzTeIApo0kIxzJtzMKQtWL5dVhlo6++B4gkyJzvDeOTkZnZGngumA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8p5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nfLN022566;
	Mon, 6 Jul 2026 08:52:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4qdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qWf643647426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62D2820040;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08AB820043;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 06/27] arm64: Use proper include variant
Date: Mon,  6 Jul 2026 10:52:06 +0200
Message-ID: <20260706085229.979525-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b6cd7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=d3WjOe2bLlXSZPWdUOEA:9
X-Proofpoint-GUID: 29Y3TXUkrKEMUOyPWEyFpnOb2WPuAQqi
X-Proofpoint-ORIG-GUID: 29Y3TXUkrKEMUOyPWEyFpnOb2WPuAQqi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX9lYKTlmWEIOz
 mv9ZDtQKpn0Sb/EEjnzQIBMFjJwyD+4O33+xK6/Dk1vk77I1sorgu10sJ5tjq+4CEXP6LTsr9oR
 DTz5nsCwtdVogf/PaUk+q+WCbWi7YrA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX3pfaaJrrzLVS
 iZQlWxO1Mv13FPgH4GnJYXGRqcwbE27xm5ICjBIZKxvNoxE3RFcIVGmXAH68KKgBJwJnhyEI9w3
 BViAhRivBpHw79J/4LL6ylFXMEyUI2be2MJ4cyhucyNgbXQhbPZ7vP7Y9Xg1TQfyD8hOKXGqjNt
 FdaVLPjYaxZXb4YfX5uh3BXbAiCpVsImcqsT4v8/3D6ikVFtHD3fBMLsZeYR10FAjFgDIlD0ITI
 sjsIcWFA95Bg5qfY+5hOG5v3FhKoTSM+CpmsYQSfv7DStVVos+yt+MYbvn0ig6j4XXNtl5vLpWN
 Erib4TMwyi3xLgnkv3C/4kqkqZE6ALn3+8gmb/TBXnVxAS7hblo8oB26EJ+NfO2i+Rm4/GYY9NO
 /4HZym7E5SwKbvckvkBNsccDUnzEiI/FURbD30ssPHmj8S4m2f40yHYDq0TdBlQm57/2KJ1TH5W
 5SksJaOlEG9bbE6RLqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Use <> for including the sysreg header as it is not discoverable from
the current directory.

Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system register definitions")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7aa08d59d494..4bfdac9401bd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -173,7 +173,7 @@
  * come from here. The header relies on the definition of sys_reg()
  * earlier in this file.
  */
-#include "asm/sysreg-defs.h"
+#include <asm/sysreg-defs.h>
 
 /*
  * System registers, organised loosely by encoding but grouped together
-- 
2.53.0

