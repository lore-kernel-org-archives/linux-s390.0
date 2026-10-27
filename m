Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111437;
	b=dgCyhEt2vPnpMXTId0jOaDqhy4xCEBZ7F7B2X2bL4nigq2RJrCKtQDnHiE5mKwfOTM4S
	 3AW5mLv59uwRoFQr1PLaLdFdsuTCX0BSDIJ6YlQF5NbnTJ7SeyhE98RxybvS+F3C7KkNd
	 ILthvorgWmeS6mn7v3vnd/CFxQyF26RgpPFM0BAodVfNdpK8D/nzI/gchzM/x1dJu9Tjv
	 ++Z87/k5ub0sE6YZSEX8mq3QjlLe+Op6XeAYCnImkDut1C/MC5eFFaWo8L6q5UiQyvOnV
	 UVb5TGCcyssebXoZcU+TdZw5zTVSrgeFZuPX/6uhtS4c1/dePoOcm89FePsiFCmsJug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3YPCSgPl+L+PiEH9CmXplC1scfg3eWJpQIejljdLxgc=;
	b=os7gGdEt/6mEWKMkVuLiO50BCGfJEj+Rfrg8y1NgFXhsI5UBzqsqRth60M/uqPdxDl3X
	 4M2fzrHvbdnPByBUnuO5y7iCcum57yeru7Liv9S3zVdb3HOUEHc3bHR5l3w1xq/RM7LKV
	 KYX+xmkteUtQm7UGBw+bH9av7RKs9Kg7AoJ6I2r+wmdk6c4HKL4P0069R1FXFhHfZ24ut
	 gHiD/rQJqE56dHZdzGB5MYcdVZ6c2P+JUUQcktYN7OAUq683aV72qO+/cAy34Ham0q/RB
	 5Lm+VP1Fn84oU5wzfHm5ZWAIdTXSXIWOGBzotCuUMuEB53QyudWpms+cDTvtN0JMgDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WTvtlHQJ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C625606A321;
	Tue, 27 Oct 2026 14:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C625606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WTvtlHQJ
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEHTS1518777;
	Tue, 27 Oct 2026 14:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3YPCSgPl+L+PiEH9C
	mXplC1scfg3eWJpQIejljdLxgc=; b=WTvtlHQJPR5c8MTmB5knGeL8wE4g9sRSI
	gfMj9PH+pXIgCM7mCMX4WoAL6yNcrBJFPZRxfob2DcMwyMyObhh8W3kZyJ9IZ0Aq
	DHWfU30hcH+FI4AbtIiGd+69uCZWSoR8rayb4Oa2S3iE5SD6CFXrVytl6xAqPLl8
	hZpMBZgrKqBRVQKrTdpl6ltARYjVVl5gZBEIMGJrdKBZUjfBqDEnJPKo5iaLQhJf
	ijV/edodjlZYuYdsbcJx9FX7KVuJPyyZlDdW8M6hUOcMCu1NmeqyZhGzPyla3O1l
	dCfX07d5QBTP79fP/IeUh1EirKxARhr132CKUerOnwf//9kktojkQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fysgg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoM9r098140;
	Tue, 27 Oct 2026 14:30:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1rcx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUVsG34537810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 940742004D;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F312004E;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 03/10] s390/bpf: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:23 +0100
Message-ID: <20261027143030.3154657-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0b58c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=QtMx0ssUDtz2akRNsVYA:9
X-Proofpoint-ORIG-GUID: KVS_SyLRqyiA-lqmPD8vi3WzPDZcE411
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX9ggedMEb3PPF
 w+Bv2mZvCUfd/edFcrnWGMXaMWyxiuTjMRFCT1jMUlHh2xGvSs5h8GnNtGr1bE2hPqa8HusMSeT
 /L1VPHpXhQjxvuFd5/ZNR06Yrf4vsNnH/4Axsil/aN/cDeI9FSoCDOTGxBd1v9wQ6pbUg2ciauZ
 eMSM9tehoyyRaSzQ4gNwKXuapRCPighPpbJePL14HEBWDAMnDoIkyrZRxSD1+3hL3u/MzAlpnKC
 lkVc6597Ri8S8I6ra+7qODQEbrMxl7IBJwrMBjNyNun+jHUibYMkwOnst0ts+Yr621ysl053gw6
 fN+hNupH+i3UmzehvGxZyDREDLRxqx8+mcoBV08mb2Ewf7i8CD9Et+DYG4ZV7rpI2s0Rl45ZY+C
 m62jugRhZcs5WK8IKPtM/W+dGAXc6yR6QGEe59weoGG3C01IFsHUoh24C6yUi5Skld7cx3Zz7hF
 R+Iy0c4sdamJ2SyJg8w==
X-Proofpoint-GUID: KVS_SyLRqyiA-lqmPD8vi3WzPDZcE411
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX3EI5kTq5qJg9
 rrW3KL0EaMSZ7qxhR0JZcvDXJhqFK/EB8C2A4Jn7T5GFqghselb9ynblWLxtzNvCGA/1iY0Ld4Z
 0LQQ0tUkipvGv2//Tpvw1yEYBinGdK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

Acquire text_mutex in bpf_arch_text_poke(). This way s390 uses text_mutex
like most other architectures.

This is part of larger series where at the end s390_kernel_write()
requires that callers hold text_mutex for serialization.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 51db92c3329d..b8ff1ca2f598 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/bpf.h>
 #include <linux/cfi.h>
+#include <linux/memory.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <asm/cacheflush.h>
@@ -2446,9 +2447,9 @@ bool bpf_jit_supports_far_kfunc_call(void)
 	return true;
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
-		       enum bpf_text_poke_type new_t, void *old_addr,
-		       void *new_addr)
+static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+				enum bpf_text_poke_type new_t, void *old_addr,
+				void *new_addr)
 {
 	struct bpf_plt expected_plt, current_plt, new_plt, *plt;
 	struct {
@@ -2458,6 +2459,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	char *ret;
 	int err;
 
+	guard(mutex)(&text_mutex);
+
 	/* Verify the branch to be patched. */
 	err = copy_from_kernel_nofault(&insn, ip, sizeof(insn));
 	if (err < 0)
@@ -2491,10 +2494,20 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	/* Adjust the mask of the branch. */
 	insn.opc = 0xc004 | (new_addr ? 0xf0 : 0);
 	s390_kernel_write((char *)ip + 1, (char *)&insn.opc + 1, 1);
+	return 0;
+}
 
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
+{
+	int err;
+
+	err = __bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
+	if (err)
+		return err;
 	/* Make the new code visible to the other CPUs. */
 	text_poke_sync_lock();
-
 	return 0;
 }
 
-- 
2.53.0

