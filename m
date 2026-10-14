Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73847F3D6;
	Wed, 14 Oct 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978618; cv=none; b=ketG6IQlI4rioZ7gmDgcBYN3K2FuLoHCpS7UnTxLYt9RypYNEKMfB1XthI4sSQkhoPFyCuPZsdreZaMUxNrdpdLfoy8eMtLGVuiFX1sXPPdn25ime48v6/BYUwERxZ44hFJ1TZGGBxVL49wUrS0xiONusXCszhvxKcltQc0jFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978618; c=relaxed/simple;
	bh=KRMiirGqPExLNjUiwOOvq5jW3jHQqUSMdK0sC33+L2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZxF1kSlyrxae5+V0sWblupXGTjUf5JkS6fM0hIG3QlM454NB3/7uEhN1e9iEMTOkMNoKaaDoK5VKtL5bOckmylAhbcwUid6LPz6Fg7ZarK9ikk4tmW5h7qNAg+2fOkInoN/YZ3qXaJc7utg35/lxxmrMaJu2jH0HzbPELKBGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sy4MQUHc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sy4MQUHc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DMgvEM2017268;
	Wed, 14 Oct 2026 11:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=x8PS802cU6ZGMgoHQFflaZCE94j/izX71TzjS6zXL
	Ws=; b=sy4MQUHcStJCGaidT7/mIChw4GgMsocgsUohYKl9S5WjJD9cUlgQZm+KT
	7vhDqPC2FgZE01zi9N0Q6T73dCcJ9Nl4f9Tx5MGuKJP9yHp8YkM4NdujqJHOJb57
	sTguwZ0Uzwwzqcue6NdHQ+hjkHS6nRkJbt/q7CJAjiXaFulzdvk+0inUIlkeXWz6
	JA5nANHHwpNIEYeRNLSjy6cniwlxwIOzwzeEIihYpHh3f2w6oFRQe8f7LpvBrnUM
	+lzdNF5lwRLMBrgyw9/vosV8AZ31K+1V7tfypw0xGitc3IOtVcxBOLMD2uQ7X3vs
	MWWnnevDvbF6DvLOGDD5N7B3kmuAw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugm364-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 11:50:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8jMHZ2585762;
	Wed, 14 Oct 2026 11:50:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg2cwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 11:50:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EBo6x514549382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 11:50:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47B420043;
	Wed, 14 Oct 2026 11:50:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E43220040;
	Wed, 14 Oct 2026 11:50:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 11:50:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390: Select ARCH_MEMORY_ORDER_TSO
Date: Wed, 14 Oct 2026 13:50:06 +0200
Message-ID: <20261014115006.537790-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acf6c73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VKxXeIzvFiKux1AIBa8A:9
X-Proofpoint-GUID: 1xR7OU9AOMm7Xw5yWdZ9-zotVT1jWLb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NiBTYWx0ZWRfXxHwN9ExA0ddE
 DiACD0nbK966vHikUMYF5B9VFq5rmjKLWe8sIsGNcjRlPVmAcfd7nfD6tQqHUaVSvM8vv5LeZvM
 5juqzFJhCGg33PlvpobrxBGc+69+LUx6G62eVHl5ZgLSqIQgjuYEhPvVkam339X3rlN1btjkLgz
 QzqgbGWlEiWSZrAzXeHA4qk/++qGI1+xteQHToQDrJrlqsipTgUsKf23vdLLaZyg7mMBD+1Z1hZ
 MccvoO1Z95j5gIuKpI6sHQHD1VNoVlUHvljytOvwhC5+zLhrfGc+EB/JK681aT1i49dVKItzv2R
 49Kjf6aOgvDBMlFJaaT9h4pQ8/AGCex1MGOqfcwTJMZ0yMZv9YFTZ5WNht2k7gXh86D4Z6KRcvr
 0eKn3pVLohg+kQBbEDNi+lfKcrntyuveU9ikmwqSmfeozMZSJGovqyHXhh8spTvejur947PbfU0
 fGe9vorjaGqmadqcUug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NiBTYWx0ZWRfX5AD6tkDp4g6U
 xCSzTaJSwax4Y2ZfIXeNqC2OzCznr3bWpy9S3bN89FwZbu24y1aC84/n9waWyQJpoHAtfKHh+gN
 AHHenQZPf8IWMpAyrr1LH4Kzw7EDFFw=
X-Proofpoint-ORIG-GUID: 1xR7OU9AOMm7Xw5yWdZ9-zotVT1jWLb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140046

s390 is a Total Store Order (TSO) architecture. Therefore select
ARCH_MEMORY_ORDER_TSO which was introduced with [1]. As of now this has
only a small effect on futex_robust_unlock(), but that might change in
the future.

[1] commit 6149fc36c09b ("uaccess: Provide unsafe_atomic_store_release_user()")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..ebdf9c8049af 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -145,6 +145,7 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_BH
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
+	select ARCH_MEMORY_ORDER_TSO
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
-- 
2.53.0

