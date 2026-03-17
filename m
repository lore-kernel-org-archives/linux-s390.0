Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A53254BB;
	Tue, 17 Mar 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777295; cv=none; b=Z4aA2lEbde3lmT7AgsQbV8n7sAMSWDxpW6Rvdbf4tBFebCfUZmPjFJU1Gut8r+U2RO0Zex0YfOHGLeLQz1LG0ZqqVYUIkGVbA++F8Uee3yKCtBJBu+lCIWSDaamXbaiMgVp8y8Dt/U2G3O88ZO/sGNKZ83Zwbm9guRABZzBzogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777295; c=relaxed/simple;
	bh=0RMy2yUPZpOjljYRzamsROmIJDxTeFTzmlSYHsO3eT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMyDAiUM2qFCc20QktwZrtwmiD3M1ty1TRJNtEdwf/fEcQplkMzXJT8cAPsuQtS+/67FYLxjr1YfJ1oTp1hF//R/lbbpuokrgGjwAWORC4XAT5dikrH1PSFfex/5KfXUpwDEsUmpAABDunl/gci9ZhjeBTnVPe/EtAi9xl+Ho2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k1KufDiO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k1KufDiO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HJdoIh1093922;
	Tue, 17 Mar 2026 19:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=32nSjMS4mBotDKtzK
	bPQQzWFpThr7pHDokgqeJVMKUU=; b=k1KufDiOdDBFSsXr67NT63OKvEeCk2zHX
	pgLMhoIsbaE7MZ3M9eJ70ir5yIS2nABfdxGIX0gtd1/U/DC4VIETT3HBw9Y53qQH
	c4PWq0Jr5wd+rzVfRcNVSkz0cvqIM42UMR5ez1xdCEk3BJy5uEx5a3RWO1j+Dx4B
	N4oUh/e9P7mKW7tg37sZTJJRlAtQtIRkFwD8ymvtoXRiwWLvEMJbPKCIpEb2Xj+h
	SigGwKvf09mVQSvhDnVtXd2SwpcvZdaBsdWRl5tkjF09HEMbE+8RaJjvtjqAIFx5
	SB3BTK1ds2oq/aftRBwc3p8h3pKYhyD/oR2NB4NcQJIZYgz1XFqYQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64ppuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HJeAQQ032327;
	Tue, 17 Mar 2026 19:54:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jtmuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJsbAg41222422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7031F2004B;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F1C2004E;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/9] s390/percpu: Provide arch_raw_cpu_ptr()
Date: Tue, 17 Mar 2026 20:54:28 +0100
Message-ID: <20260317195436.2276810-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317195436.2276810-1-hca@linux.ibm.com>
References: <20260317195436.2276810-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2hvIDpO1c6rE5bkxyU_-GqliHc0Y1w3r
X-Proofpoint-GUID: 2hvIDpO1c6rE5bkxyU_-GqliHc0Y1w3r
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b9b182 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=FJXwAgvRweZ6vCOBEk0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX/Zsq4GwBEgW3
 EKKLxHKMHhXk3tqxvrZEQKg9J6aoIClmI1TK92WtOMIEjohRb0txBRyMSI5eLfJwltk7hfKTKoM
 Q20T1CLwP+VG9HKR11vzW47wE+Ki+wnrxsb6xbh202u8GdGqk3UdiyAPMklD+KccYczhySJFLYz
 U2jjJWpHXuGQBbUcAW0I1xUDCwLEzKpx19l8xIW3bsPkfWYX6Q4jbYQlJzHeazQCnx8w+pMNODd
 uAxGIeAD6qfJ2VWKq4uLezzDlgElaRcRzMhsS/hXqttc+ZS2yE5okX6lDWtqwqGkBCrvBHKnr+o
 ScsvlmS72lHIVCr91/yby/on260bmPLppWBbs5TML5N/v4p0B/mDmyS0o8LktLBGVS48ufEu8yG
 CdVPO9z1DGlZvCo1TSPwqkjhPXaKwmHLo6zJ7sksAaELWwZ83kYS0uyq7fv9PZfhTKjzNaj6qWE
 Yo7B1H0vsJ9MQJY7yiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170174

Provide an s390 specific arch_raw_cpu_ptr() implementation which avoids the
detour over get_lowcore() to get the lowcore pointer. The inline assembly
is implemented with an alternative so that relocated lowcore (percpu offset
is at a different address) is handled correctly.

This turns code like this

  102f78:       a7 39 00 00             lghi    %r3,0
  102f7c:       e3 20 33 b8 00 08       ag      %r2,952(%r3)

which adds the percpu offset to register r2 with a single instruction

  102f7c:       e3 20 33 b8 00 08       ag      %r2,952(%r0)

and also avoids the need of a base register, thus reducing register
pressure.

With defconfig bloat-o-meter -t provides this result:

add/remove: 12/26 grow/shrink: 183/3391 up/down: 14880/-41950 (-27070)

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 5899f57f17d1..b18a96f3a334 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -12,6 +12,24 @@
  */
 #define __my_cpu_offset get_lowcore()->percpu_offset
 
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	unsigned long lc_percpu, tcp_ptr__;				\
+									\
+	tcp_ptr__ = (__force unsigned long)(_ptr);			\
+	lc_percpu = offsetof(struct lowcore, percpu_offset);		\
+	asm_inline volatile(						\
+	ALTERNATIVE("ag		%[__ptr__],%[offzero](%%r0)\n",		\
+		    "ag		%[__ptr__],%[offalt](%%r0)\n",		\
+		    ALT_FEATURE(MFEATURE_LOWCORE))			\
+	: [__ptr__] "+d" (tcp_ptr__)					\
+	: [offzero] "i" (lc_percpu),					\
+	  [offalt] "i" (lc_percpu + LOWCORE_ALT_ADDRESS),		\
+	  "m" (((struct lowcore *)0)->percpu_offset)			\
+	: "cc");							\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
+})
+
 /*
  * We use a compare-and-swap loop since that uses less cpu cycles than
  * disabling and enabling interrupts like the generic variant would do.
-- 
2.51.0

