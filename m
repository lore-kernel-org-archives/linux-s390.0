Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926892C21E8;
	Tue,  9 Jun 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011484; cv=none; b=DPHNaaPWYiKSuBpivr328fmpgLDr5dyci8ynEdKthEOjv4nLMDPUDHrBhPcx3W3IGE9R+Zup+Q3z0lrpOKpMhK2x6UZi1jxwZ8irh4elypKUmL0uAhWs00aGvE065Jci9SEfLF028w49WDsDCAEhsW1qJ9kvdsIYAyIbpxtMOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011484; c=relaxed/simple;
	bh=3C1TlY2FuZCbwee48bG1jh+kPBxHaApTldZilo2eaOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWiN661/r3tuqXaZghJdINs+rhppPqDmOinX25t/ZWWyOH4XvPrGzdVp+6jJXowMMVH0fxe6f1E1YdNhYnPrl84IvHScByq+DOBu77X9YRRtCw5EFolHWj/rLFQu24Zbb+1qtOKGdUMABJlA6Ayj0f3l6jbedIXvIf8RW8tYT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bDgjnHru; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bDgjnHru"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CGcTK3088318;
	Tue, 9 Jun 2026 13:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fZ7tLm
	7WGJwtG1rB2sRuAdN+kok0VuZ1lt8q0Pu/dS0=; b=bDgjnHru6izja6t5f0mMc7
	TXqN3mXtv3yAjpKhiBJ1aiCfldROCkrgtI4070TR1XyR2yFVcg69GGDOUos+3uG2
	NGB//NO1f9JGEsWNvXjO1+M+6e7bNBEvVJYCGB5fIWkguJl+h2AFG07GmnKnvMO0
	TNzrXG9fXzmuCi2+AG0VmazzU1nXrk0+fWApTvYIAlD+TbgcVaz6QE4+aZcsWnwv
	vLa4ZCgcIKMTPtgHz4h6WcPbEhag98nUaIS01JjMfHYEsPmfn6ItYrtASzjIvBEX
	3B6hnJ9yh5VWmthYhHvKDIcsN+SnSg7OXeQkdl2TgtaC1ACfrtqjY1AEKtVT16Lg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhvakq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DJhtG032075;
	Tue, 9 Jun 2026 13:24:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych221d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DOSWV46465466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:24:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99E920043;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D9720065;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 09 Jun 2026 15:24:23 +0200
Subject: [PATCH v2 3/5] s390: Enable TIF_POLLING_NRFLAG
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-idledriver-v2-3-21c2f581d11f@linux.ibm.com>
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
In-Reply-To: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX3UzhwJnACj29
 EYRs/SV5i990MUcbHgldWhH2wK01iZghSrnBdKOSkmD4AKYl/8u2uvq4tcRjruZOmFcu7QdrFoB
 ahtGvkXayApj3i1dNbHNn1la2+C2i/0w7LNML4VCnsYOMhFM2E0dp27/HG9DUoy9JmT0n6FLU2T
 JoZNhvkWjDOmrF6liD40zj/UuBbMGvD0x/JAO+pd9544hL1zRDJoVYqqmUo9kj0fG/KQA1/bSvg
 PUH5RAzAiaW4HLzJoowllov1EFtrD5aPbYkZINm9KYM4mPam0uQEGP5Fyh/iat8FqTrAU4eMvSc
 lLr4MX5oYR2oaD3WKLdjA+fw6FXDADx6mVyFGoBn+ASS6n0UvOqnYU1FdOiZhTvgAT8QZP9JQkB
 3DV/QhVc6dx8kfBbMPxS+kT9FQ9JwPxx0/xbUyzW3N1+mW8r48ZgS/MntyZlay9SoNOzpUt4Cz8
 7UG1sFD7XiI6pC7+4/A==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a281411 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=c5jR2BqudvT-Uhvel0MA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: fNnvSyF-r2vVKhReQpHoZXN9pBW07E0Z
X-Proofpoint-GUID: fNnvSyF-r2vVKhReQpHoZXN9pBW07E0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090124

Enable TIF_POLLING_NRFLAG to support idle polling state in the
upcoming cpuidle driver.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 6a548a819400..2554cef3a6a5 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -61,6 +61,7 @@ void arch_setup_new_exec(void);
  */
 #define HAVE_TIF_NEED_RESCHED_LAZY
 #define HAVE_TIF_RESTORE_SIGMASK
+#define HAVE_TIF_POLLING_NRFLAG
 
 #include <asm-generic/thread_info_tif.h>
 

-- 
2.54.0

