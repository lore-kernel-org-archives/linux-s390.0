Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871735AC09
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331021; cv=none; b=PMXmkO0qMlq7GfGmGs6m8GFwyc0y1hWg26D0Syc+i2UZUNQiTI2fijU9yq1nUnywE5PF7zc1AytVAZtlSpav5GfN6sTGdyMZHOZXGHwmCZI0PShMlLuJy3+Y2aCz+oB0isCxILsv3Xfq8F/6Ulp5bkOntXzrw7QBPFNps15DJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331021; c=relaxed/simple;
	bh=+gkOl6Jma5OdYt9EGfZHA5frhFKAnc1cMPLw/iRwn1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyDMw+6IN/wGdpVYOeLAfIT1crTh2WJdFEQ+5vNgqcyosdpPbqsxQ+YIxU2GUuk25WWTL6GLvoeVUEiJhrpOB1StIZDII/8kV2y3/YJuIA2NvciRvR+G7uHsIBT7kpxI9Tx72UfckYiqmTVa72cEDuQNpp6gl7O7RArwSL088pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mo/y7MlK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mo/y7MlK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IWDF3783634;
	Mon, 6 Jul 2026 09:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7HeIz0x3Vg4GqOBlZ
	v/iGgOTB+uhuxBJfASbtqqOY7o=; b=Mo/y7MlK3ftsK6zGF3hJaXfQW/ZvqdMZc
	BZZQmXaLJH/r0hsd+5Xt6yap4dhGlrnYr9Fn4zJ3T6/g4eHk0xPQv0FYrYK+/U+a
	qvBjyrGH4XGejpeqbgiZfgJamCUScDnYoN/tVg2MLj5CsBEV9rywxcAdwfGYp1B/
	h7dpIZwCRhyhrBAUT4nG0HmlJdyUdkO6uL6eKxSP9agkb5tK8SWY4yPF5QNHYFnK
	e1P61cZgcTJTJCYwMpvXTEDzlsTuWl8ZzJvMnOQAXVO5qJ7JkUucZkPok2VZP/i0
	DCU7Ysdb/ydNGbNHQF3p+QORslJ74wxTy4yomWMuFNwEMsllNVJfw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4gqwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669YZMX028286;
	Mon, 6 Jul 2026 09:43:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjw0gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6669hGGu47579436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 09:43:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44EDF2004B;
	Mon,  6 Jul 2026 09:43:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BC6F2004E;
	Mon,  6 Jul 2026 09:43:16 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.193.81])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 09:43:16 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v10 01/21] target/s390x: Fix wrong address handling in address loops
Date: Mon,  6 Jul 2026 11:42:54 +0200
Message-ID: <20260706094317.17032-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fuiIidox9XsdAgzYv4AU52_fsPoW-On4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX07qE+6LXgCwA
 ZRoFCZmh92uxAJ1yuoaoNvvzrm7BCRHbwOXjis9DqCMCxj97K5ya6LzwTdsIYrKmEA69uzIyOwW
 Wo0anBQ8eqhfkZ0hzUISN3txqcWTOLTFehg9rTt8zS5L/ncFjpFNVSeRpUPdDe6iPXK98OVsjse
 2VulMpYvM+HOehpWJ5ir+Fu+yajZUizfnPULnUlZFlLsZCI+B6akMN4EME+6i5Neck1JZ4uGOiN
 kfG4ZOmTJMqU3QKkf+gGXmxjPovLCtqv74WAuwcD/rF68SAFpjnjH30Cy185ktFpWOvf0VKizEK
 4jXhn9bzz1cGEthlSZ3JOy0fWhLEWI87GJotg6ktZ49CAD2+CbIQteIJTsKBC6/3PvAJbwdNEWj
 rJ6xshf3daDAyiYY/aK5Wra5v+QX0MeuZFA8cDUD1FRxLha6ZO+502jvb05Mtu9m8BSGdq3aQIz
 s2yfGD7GSNO+8L0ONdQ==
X-Proofpoint-ORIG-GUID: fuiIidox9XsdAgzYv4AU52_fsPoW-On4
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b78b9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=JcvBkDReJmzHsdK6FyIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX8Gp57f53L0GX
 1kf+podd9GbON6A0DacQqe0h7zdhaarh/8+/BTP+D8q5Q/76vNcG0uPpFJ0PixqSluHtDgFOtIa
 TJgDK/QUsaQxFwS0GTNXIWHmaDEJcCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094

The loop increments addr by the element stride (+= 4) before calling
wrap_address, but then overwrites the loop addr with the wrapped
value. On the next iteration the stride is applied to the wrapped
address of the previous element, not to the original unwrapped
address. This results in every element after the first is read from a
wrong (wrapped) address.

Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index ae392bce0e..8fe0a22219 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -126,8 +126,7 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
@@ -137,8 +136,7 @@ static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        cpu_stq_mmu(env, addr, a[i], oi, ra);
+        cpu_stq_mmu(env, wrap_address(env, addr), a[i], oi, ra);
     }
 }
 
@@ -148,8 +146,7 @@ static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
@@ -159,8 +156,7 @@ static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 1) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldb_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldb_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
-- 
2.43.0

