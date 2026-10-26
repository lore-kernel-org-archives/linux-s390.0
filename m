Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016217;
	b=MuHA8gLn3Lf0tzWHTh3gFdsirhHhIIo5UhrPjvikDyxFPGBd9IKIM+maVObhnfvJLN/l
	 quTQYW8Giq6ZuJZldATEPNByzjAqSxOn94aVmjWWOvaKMJDInWl1Rk62N4tRTOg1B6UDb
	 2G9r9Mag6Y8LW6qdp/HdiQklrFp2KFGYujFkaMi0nwunmhXtlNzok+MxhkjmyFqaeri0p
	 8LRDVpJcrReubZca2Xt18czqiyBgBVL89jitaXkABV+aePafWnPymp97HbvYO18X/07IM
	 SdO2gl6F58M6Q7dv6pMADYKOVmy2QX1S+lBAlTLBWwz4VCNcmx2i4CwdKmtgYyFkMNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016217;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eIqpiz3jZ8IJHMiwAlYB08dyURhjLVlqMwUA3h6t0n0=;
	b=fxNGFbMiAryf35gfcDkF7fT3qHnvri1ploDpinqJfyQ3PK0Hrj2FoxSK59YHGz03FZgx
	 3/v3nC4r4/c3cMMt9E8e3vqTJrOYobrlWNqLfNx0fSlHQOodPbk0afpdJyW0ORycrznkQ
	 u3S1CngLVWqNYd5ow1rtEDHvhT9pVcPlqXG+iaE48Y9MF1jjur2xWM8UwoCbx8rC8q5Ka
	 NYDfnBfWn35gYeTtnJkQXILrTlDRRipGq4uCQShQ0Vr7arO7Uh35Snh8wNRCdYl0IosOb
	 zbkEwvfBlIwJGeKraBikejz8W671Sp9vl68wJQN5k54LA6NOLZ1QDTv0+S+34fh4HUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j9TWrnaq;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5B606A323;
	Mon, 26 Oct 2026 12:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB5B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j9TWrnaq
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBECBx1707054;
	Mon, 26 Oct 2026 12:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eIqpiz3jZ8IJHMiwA
	lYB08dyURhjLVlqMwUA3h6t0n0=; b=j9TWrnaq+DuzvJz63mO7t1UfjpCJpuW1U
	AraId+ruprHAzUtcXdA3jEJl6H+3nskSZVMv9f4WxGn2iCVKmU5ImuTkOouYBnNt
	qEXKcKwowWmJ/vhD4mZIQw76PQ1/De21Cfy7fCiLrffnki7PNXD7C86BrLY/8Ju5
	3OkhHXglwbDna5/yTTIrWuuLmPqWaidt3hs4dCMcaEBB/nfywJ7zcItvv9lTIVMO
	kNEN9uxqB3vCJxSG6TieQ2TS8tizdoy0VvskIRS0zAhwydH2UpNZbtzNG5wNMDCo
	yLI+WXwhBU2JR6EEeFCZ285D3LldgnLmByS1Z0mdHpeAP8dHDLv7A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsspt0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB4tdt1270401;
	Mon, 26 Oct 2026 12:03:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gngq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QC3UQP44564756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:03:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B992004D;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E482004E;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/4] s390/bpf: Serialize text patching with text_mutex
Date: Mon, 26 Oct 2026 13:03:28 +0100
Message-ID: <20261026120329.1792436-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026120329.1792436-1-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX9GmiO2SnQeTk
 EovYrtSnigP51AhS2MkirsDLtVzYrg3egHaszBENyrA4u7t4c9G2IlPtXBCsecF+Skn9JgISh7N
 mQlRhoeXG1nWEn3NYTLHVzVRLV5cdOBA9a9uK9SA1FVokhyjyw5spmVXQTQXNoieQyIKVoyZoCe
 4cL3jBssuYWuzdMqBoye1s9N7kJhPLsCsn8l66BRBWkvrW03ADoch43HhJfwAEu67eu5gvFVT34
 lmHREdEJ1zqCQrHl5alh+C12RT9yHBmTD2Y0KQheIX2+8VDbvYLcYad5QUMwI7rtAGaj6fBBpoR
 dpsE1CF8MhyNGklQ77l3QJic5dJqDvRUvSfYdBms1DfM8Eyc1a8V/8/g6JWqBxzkjp9GntALElr
 qmvzN5fQnKZPtvlBtklpppTJzq0nh8p9l8PoHM7tZnBTHf6XqJxuMgIShLo29RajuJI1Q82sPtU
 cv1jtAvNTsiaEVQ23yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX2W4pd8n1uPWr
 4OydEzjKKzpqvtjPlvX5YMue6ugyMjuGCnOtHZ3KzKfdoMRG3/mY8d4N52qJXu0FYgCCzteJ63n
 mC47S/wOw+mSAxkjNKai//ZmHD9hHKA=
X-Proofpoint-ORIG-GUID: zvhoZxljQnRc5a_SzmG4JeEu7gXqUSuj
X-Proofpoint-GUID: zvhoZxljQnRc5a_SzmG4JeEu7gXqUSuj
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6adf4197 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FuFlwj96ZHc2psSyFL8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260046

Acquire text_mutex in bpf_arch_text_poke(). This way s390 uses text_mutex
like most other architectures.

This is a prereq for removing the spinlock in __s390_kernel_write().

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

