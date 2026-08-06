Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1C3909A5;
	Thu,  6 Aug 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042953; cv=none; b=UnWi92wIZZFgDhRsMtz3RZwc7z4nY8hmhdbpnsJ7z1AkjH9c1BJsJQ4Ljjt++2FMv50LG0gXMirR974T+iZiI3Y1oWyksTTtFgtKVj82YOHR7siTNh/avFzEMUR1u7EbQZpusEFizDtosdMwFOqRqs3ceEwejXMRWEaR0dzxiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042953; c=relaxed/simple;
	bh=4Kev0XaI1kTAHCQKkEAg41q+xTKf5IrU5vvZTWj8yLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llRuUrhRZOuuMlWE9fTNjxHHbOt3noOtRx0fV4nT1yZALqwwWpa0MAR5p680A1cj33GIjpjbrd3Z9u5rrcUEwQWcmJ0mOUgxuNVd0gzril+i/v7uOZ7z06Dhmhu4pNVUhxDQ35XyssiPwSxH19pngXgZZsAkJoCXTbzFBjLzuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MBk+YB3s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MBk+YB3s"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHYd73420314;
	Thu, 6 Aug 2026 19:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pQQllZ3R9DOuagSuE8kOTeebZWTn+UeKjsWEZ08hV
	5Q=; b=MBk+YB3sqpLpnt8Lbx6J/WH38t0PF0v8kAs3F8lfqoAE29N+YQ4OqSWAS
	cipWxuQUps7xsT+/2VwKcxh4aU7MZaelrITKNrs6O+XcZTOs4Yt93ZtUZB/TitQk
	NzsS1gqlV/01e/nbfhZQa+a+HWntV/L5snweAx+cCjaK2sEmy8snFg9O/toN55wt
	pN+sKr7jR/HSffCGIsO/bQz0SGAIAl6R4I2v9WGuyUn2xbpRFW8nsrwCu80LGWqz
	zQOqLGyGvZSTYiZ6nU3y6srdw3nM5Jp5le96cAHy9SSvOKhpxMRt87+gBW21Cd/S
	fu1SXO0JgqOpCNkoMH+xmIz0/1bxQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyrb3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:02:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676IuGMD028337;
	Thu, 6 Aug 2026 19:02:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwcnuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:02:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676J2PFt45875482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 19:02:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6702820043;
	Thu,  6 Aug 2026 19:02:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECD3E20040;
	Thu,  6 Aug 2026 19:02:24 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.90.112])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 19:02:24 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] s390/cpacf: Unpoison query results
Date: Thu,  6 Aug 2026 21:02:07 +0200
Message-ID: <20260806190223.3292580-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a74da46 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rrDz3YSv9LhRwPo8zLoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NyBTYWx0ZWRfX3NSGEfJPLoSe
 lC77Y7La5nfmlMINVK7FKF6RcaRNA/korijEf1bVGaWIB5qqMImjjlPnH44XwE8OBlTJMlb8y3o
 q4f9wE8qrRbYjNHfwVnmMBqFC8M/djk=
X-Proofpoint-ORIG-GUID: E87Vxk-x9EnJEI4Tv790Q5pXLvb5rJoI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NyBTYWx0ZWRfXxYcEdefoA399
 1H/npJNQMhMKypPC8supdGea1+2r+hTsinDckhrfmoyj4awbJSgjjNL3bqBvzMcjrJcwcp0snT3
 zfTj4t+ydBuA30V4GTjAfTqJ2YchyqH14tjz0g7Hk6Q0l5iEKMQPJxwRntrzd6PikSGlTzXpoct
 cB9QIrZmcci+6RCQ4/k9d1d3HQJowHfjDTjShtAJuOr0Fj8gHzut/zLIQsCg1QcR059HfBSqi0Q
 LMz7UBjTdnYdGPvDXMSe1+L/qYrEuMIahtSz15B/xgiy2/Gj27z/HOOLs3s9Kccku+Juo55OTW4
 Cdbd7dJrWk51KArCstouzhKs1fCJGOoZmqBkYxBo6rIn1+U0wMc9/s65WrhnZ9g+gX5lmB0fy53
 WeEX454rFL6eu/3OXqPqZh+zY92fK01lXxfnwpnqiF0+F9mdSLxvi5jXbm+SdX9SzkdNfDilIJS
 H5v41hKxa0PK+NumP0Q==
X-Proofpoint-GUID: E87Vxk-x9EnJEI4Tv790Q5pXLvb5rJoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060147

Stop KMSAN from complaining about query results being uninitialized.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index a83683169d98d..d4128d3fd5138 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -301,6 +301,7 @@ static __always_inline void __cpacf_query(unsigned int opcode,
 					  cpacf_mask_t *mask)
 {
 	__cpacf_query_insn(opcode, mask, CPACF_FC_QUERY);
+	kmsan_unpoison_memory(mask, sizeof(*mask));
 }
 
 static __always_inline int __cpacf_check_opcode(unsigned int opcode)
@@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned int opcode,
 static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t *qai)
 {
 	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
+	kmsan_unpoison_memory(qai, sizeof(*qai));
 }
 
 /**
-- 
2.55.0

