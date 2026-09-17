Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971164DEC22;
	Thu, 17 Sep 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672976; cv=none; b=ScO3/QhpdKz1xvuaYxxUKkbPsupikxVOCT3sr69VTrhACAUDHOcez+yuNE1GWVMNzJi0lJXHxZLn5CiHkvtc6uX15divTwtH/V3mJnrgz2qBUcxUgz1AHP6VRvjfxpwPz6XQCS3+oT2fEiIc6N/mfBUhx9hWYHqkn2efxBIbi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672976; c=relaxed/simple;
	bh=ETfxXUjrRH4J/di1U8Xgg8F4wjJw+tcsn5O1uG+VX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiFaCh6atgnTUs4F61X6jvZTjLfhZ2eO/vf9Dkf0iLK6T1KN6FNqUooZ0sO28V7YgD6BQX1Lbi5L7LbEHS6TkF8AoFSHG0GQ/G5hZA9XbDBEEyTHni/jqtSfq+hwgotrtQc9+Myuybag5S9eYx81+IwlVeJtjmYYUWtw8whpPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dAPsSqqF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dAPsSqqF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVWlb3143323;
	Thu, 17 Sep 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hCQN16gxRDgP67dcL
	modHocT/4BhIAkQwOZ2klcPTOE=; b=dAPsSqqF37MaGJkeOlR6bzRae28DWnt9B
	UQk4qiABBA8oPhqO+oiepyD8JGpdLn22h+wLENarlI1PhPepLY1cAYl6Q0fKQjEx
	iIc2Yxwgb88TYWXgYV5rzcGqtHdqHVI8NRy54IoVZD+xWIgs+ddqWf02WkaL3Lcz
	4oaXdy5MSEFewp5z+3sgbw5ImtUZJy2Ca+ZY9920E8bSN8SXg15/OhyNU1cym8TR
	kSBJQsiwjjvWAy5YG/M816YC7/s5BEC2xW2lcTZjztVmTkIY25/LCtAYMOGn9hNR
	9ZLTNVHr6GKknvafNTtYUeDk33Rwz2XLhea4RSzepwlNf1cSxgHyA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx844d3d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH93oC3510145;
	Thu, 17 Sep 2026 19:22:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa3w6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMb5e46661890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B422C20040;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 849932004B;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 01/12] s390/percpu: Fix comment typo
Date: Thu, 17 Sep 2026 21:22:26 +0200
Message-ID: <20260917192237.638324-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917192237.638324-1-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX8GHBRyZBZLsR
 xfby9IiJqkI0fIPYYtDu3swJTbzZfgMcgjSrbTN4wjsC1ZOWQsK0HGUx1alk11P+VdIESgeqlEw
 xAuyFCz+rsesqQCtChuULjEpV0bbYrYIuSt8H1fdwV91OjprSNqIY3Xhoe7wIVX8SqrFwt8E6F+
 oCzIUQ9ZO7wGbkqjKqrCzMGh/0JzARr2qJeMEu2DiuWmombgaX1C83ygvBsaL7QYvR0/7MXlm26
 dH9ZcA54NHFHdNBtfKai9qT/1atL3RpfhTYCym/FhvfmLzgXH46HVU+yFnUjMHVceTaLDsuoYOn
 /AOmxWehGS74TXcurL2ERLck1wrkmcqGP5WWkv8tGfPbaDcwiXd/VlT+VNaWQ1HEA2fUTu2Ik1I
 jn5VUAwZPS9gH9HCMlI29sDvUmpvhlYY3Ayphqki8OT/9uyjnqwcmU6btMopw2KUxzvuiCuZz1+
 9yBBvO2hE8FxlLujRyA==
X-Proofpoint-ORIG-GUID: Ydqo8iEA713tMntoaDq8WSN_G6qdUNP7
X-Proofpoint-GUID: Ydqo8iEA713tMntoaDq8WSN_G6qdUNP7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX439o7aWuBCxj
 XZiL3oZWGa57t7ns41jbmE+FLJd0a3g0iT7P52OaSJaAaFkp5iWD0sWvz7HuDoyQxAH9ekvjolk
 IMgbrUVWb/Ql9/X7rYeKO0xejJ+kU1g=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac3e02 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=I_7Bz9khIIb0WmrdVP8A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170272

This is all preempt_disable() / preempt_enable() pairs and not
preempt_disable() / preempt_disable() pairs.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index feb58acf87d6..31012abe8292 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -63,7 +63,7 @@
 /*
  * Macros to be used for percpu code section based on atomic instructions.
  *
- * Avoid the need to use preempt_disable() / preempt_disable() pairs and the
+ * Avoid the need to use preempt_disable() / preempt_enable() pairs and the
  * conditional preempt_schedule_notrace() function calls which come with
  * this. The idea is that this_cpu operations based on atomic instructions are
  * guarded with mviy instructions:
-- 
2.53.0

