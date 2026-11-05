Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878863;
	b=phlaKSjocDbeVIhQUcpJEZRfDnsBWubDIssF5hpPmtajMdpDBsXypmVtnqC/jadMGhH3
	 rvsC9CCnSMpemB/GIdWZKNk8rBpQo42aFwEWZcVig/cPyakCsukKcBB3vw/psUwcd5vy9
	 rVNMv+zm1E+fpR/kFDooqhkrznN0EacNGtl5dY3Em5eth2upl1AlEoo3JKRrFHBmXmMO7
	 D9epftVHpVRjrLi2jFn600RaVQh9LG5IFjdXYubKBDUBdsqPPG4v6RWEYIGCWu0BjsirA
	 SIyq07ZTai+OwKf7Nu+6utT57Fs/d/hFCAgL9nNFOE6tJZqNrxACDypv7vS/xQd6pvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878863;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=APCybssPVDEk08dxo9yYemACe7ZseVauIwXpk4cGm1k=;
	b=T5KMhABQsN/LhlFayAOLzSlwJD/CQjjgf/cgcoUmlbruj0Y6D3SfK3/rWTXVEDm4dzSD
	 JVx+doPtzrWBt4kV/QGrJKkhx9/4sHEW/3VUlhJ4KcVKESgpOMrYUnar/065fnlxLPTYl
	 lPo4ipPfns9Cra8bH+MG4z/lXGJGH32+WaB8/6dHanIdfJRki836ZtiA6ESn9QtX6VucG
	 aM+2rq3sULKHmUNrtbwdxgongg6ps5i/jVFHrf272hh5TTumkEZAYHyOxtvGOFI29RbSC
	 UKEMUzPSVCyrR90oPot/CWzwSiPXINZv55Lc1z4HwOkNgFAGK1uATa1ZjoDHvjksNKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZsPJKRVJ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A31606A326;
	Thu,  5 Nov 2026 11:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A31606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZsPJKRVJ
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEKit2060001;
	Thu, 5 Nov 2026 11:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=APCybssPVDEk08dxo9yYemACe7ZseV
	auIwXpk4cGm1k=; b=ZsPJKRVJ/YwC57J9TIMRO0cK8XskuadtVmTVgYPP2LSAXI
	w0RTUXzDMqsz9U5Vd261SjK7VnWkef0ygkQgSGuFk68dQrAKjMY2bEPQM2JWBFDm
	VAltUAtLj2aEDcZ0jiCJ5GEpmeTMBrh71xHTYBUElgzf4qW4ZO5UB2gt17wrnRJQ
	iUvlAU+XlR8VGQJxyLU10606XCB6kNG7bV4+rxD2Lbo/mXuwT/JQTedC5xyzgzeg
	XI9N/sdz1qEG4ZrIZzNGjveMuJY3/Ic2PaBAAv9iWmO9SjRJYVHOJUDunKAOCshP
	kYWaWfSVB5S8myE4MjmxdaDEwa9Uei2EGvC3z+9Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdhfkm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 11:41:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4xw4271729;
	Thu, 5 Nov 2026 11:41:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5g77y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 11:41:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5BevOD30737000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 11:40:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4653B20043;
	Thu,  5 Nov 2026 11:40:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26A9020040;
	Thu,  5 Nov 2026 11:40:57 +0000 (GMT)
Received: from localhost (unknown [9.111.35.118])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 11:40:57 +0000 (GMT)
Date: Thu, 5 Nov 2026 12:40:56 +0100
From: Andreas Grapentin <gra@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add assembler-level include guard to
 insn-common-asm.h
Message-ID: <auxq_7KszQp0JXGE@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
 <9b3348d9-7510-48e4-8be8-31efabbf152c-agordeev@linux.ibm.com>
 <20261104084033.8132-D-seiden@linux.ibm.com>
 <auxlzfQe32jZHc_4@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auxlzfQe32jZHc_4@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FwUkmL8A8fpsVpBFwJcQ78jtKBCcAtTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfXw8Q3L2b5dAqN
 lZB8goHQZmBv04yNBU9fpboWdljlqffibyfudCl6TFHRXV9C/scQGji/eIMuyB8S0D2plSIuVEJ
 fS7h1A2Xt3MTupbvrRthp6RMbJaeo4hDQT+CogLdghDeZ8xI7vYTD2b9+IDBZ4nJj5zEGgaum3g
 pXEfcO9vfHTszLaHO+Pfejp34567sf/eRx6+PEWaJ+wgSx72/9w1WD85NPTM+1dkhGXMghF+PIj
 d6A8WjujwawK6GSn3J3EWpxyD5wxagNdZKu+pDSarUtWqJqhUJghHEF0OGEgXspxK/jl2sr01+u
 K+oELai4A7+tQ0jSnaBUlYPzTrkOfcqSFhnglcZs7eYRIJzEzzRTsTrwN4okp8a401PVbGtLwJY
 psdKDJXXy91Ek4yGPk1N/m9epqsa5vaB28OyivbNeMeRlAohGdXZl3ku5cTOPGAMidX0x0xlSwE
 3/WAFOZAXKHcL1j0AEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX4UGaKWya6aTf
 qa28qUaWjaaI3vLku9ha9/AcyzaUwDn6jnm90WcJfbzQlbadi0aPcHe5AK5JXM+i6BJGXxubSP0
 bQAYLkTjYkQ6XwO3WmGrwm8KTnf8BRo=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec6b4d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=U-2YEEF98ZwNu8pyFNsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FwUkmL8A8fpsVpBFwJcQ78jtKBCcAtTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050044

On Nov 05 26, Andreas Grapentin wrote:
> The same should also work if we wrap the asm(.include...) in another
> header.

Something like this (compile tested):

diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index eeb0a233d5c7..f1167aa2ab45 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -15,7 +15,7 @@
 #include <linux/kmsan.h>
 #include <asm/asm-extable.h>

-asm(".include \"asm/insn-common-asm.h\"\n");
+#include <asm/insn-common-asm-emit.h>
 asm(".include \"asm/fpu-insn-asm.h\"\n");

 /*
diff --git a/arch/s390/include/asm/insn-common-asm-emit.h b/arch/s390/include/asm/insn-common-asm-emit.h
new file mode 100644
index 000000000000..26a31e8439bf
--- /dev/null
+++ b/arch/s390/include/asm/insn-common-asm-emit.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_S390_INSN_COMMON_ASM_EMIT_H
+#define __ASM_S390_INSN_COMMON_ASM_EMIT_H
+
+asm(".include \"asm/insn-common-asm.h\"\n");
+
+#endif /* __ASM_S390_INSN_COMMON_ASM_EMIT_H */
