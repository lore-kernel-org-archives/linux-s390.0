Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E831E846;
	Tue, 19 May 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203573; cv=none; b=AOc2mAwpwBbG2jSFoO9gRACcf537hKQtd5cO3r/YbR+OBG3T1sDFGLwxPeh/32IiFWUj45q/Z8pBWymBZRAFQzLHAGVWTIn7rVa/TdygGX4liv2NPY4RF1R3/9KTOfQmMGvm/uR/ntOvreXtSX8fXJfktPrNsJKyuZUlpNSAhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203573; c=relaxed/simple;
	bh=rSsUhmRk1T4KmL0Xs0s66E1ODoRrF1MQgNpA5nUuYjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR01GCz2FBSiaHE1kXh3iLNSnDzK6mFKWrPe5ltv70tRPjSHE22VMoJO79pB9Tyf1tM1Uqqr3pilbNMNGCyckRjxjN1/0/rprmMf8AVQFOswwNnJZfdyvfXntbkeQhcpuJNZzFXfU1gepFhVbcyN1Y8YyCAqrswV/v6oFGO2lQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IeHC177C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IeHC177C"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J7P6cE3605721;
	Tue, 19 May 2026 15:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Kk32Fc2nYKGVpKhLP
	afzmCRMMiatjxD09qo2Q8kAwhE=; b=IeHC177CQz3452s0jaGCskbQTNxtIwsia
	My5bfE4o2sd5MmS/3NbdA2UBZSn1YMB3ohoTyWyfMwOg15BcdXF1nq4CiP3fDlX0
	OfNBfzdS+w9QUywPSaCswBDyLQOgGo4ohaOLCDrmRa8q7QHcp2Ln9LZ3QTy/NOuw
	3HBymKEy9CNW/OgbRx+wj8Ag85hU0wN5X6YbeKs9IJzZc0fRFOHCZm0R+APA5xTC
	sp8MQZI/q7fYPZCYrunXTjNBhR6Id0cGNPpVpHnzkb3Zj9Yd7bMqnCXh627ltJp6
	WoGmfydnhlSSR+1+O/72pO30takX2UZUZY32B5Bl8Nl6XQ2Nu/+GA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw4y0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JF95iZ012254;
	Tue, 19 May 2026 15:12:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq3dn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JFCULJ24052086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:12:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1982E20043;
	Tue, 19 May 2026 15:12:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49492004D;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
Date: Tue, 19 May 2026 17:12:13 +0200
Message-ID: <20260519151215.1611802-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519151215.1611802-1-japo@linux.ibm.com>
References: <20260519151215.1611802-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MCBTYWx0ZWRfXytWYfVrkCnry
 xivG86VmcVyUvkVrPqaLgHP/XU/gsCNlxcU6Va3C2pibonKZBUq0ZRW3RHs9pie5jwsSJuTeAQr
 WB8t7aL6SPfO0V2sfVrueMVhDTnpOTN8eWC1JEfLL3PYz2TOSeuOXMMxPdVJCX5yIQ2fsQ/Kyat
 jCSiVQS4cOar7ZkogheMAM4HvAgYbZJhzJCz4ldUevgKJ3SLIRsNMzMjP3DY2jz/wbYROO9lbFI
 nl+YYB5KHPQh4L+BpTLtn2U8gnEQi7wMN1KgXP9aWNPGYkTqInzIf+bwGpKiH9Vh5pIf9cdjP1S
 /sl7kb8d94748oum6WF0y/NrvkKTq+zGmvCqEbLFHSrBFOJXCv7iR/HnZo8miLs+jC2XwGPvZ24
 2SQabmSpgUZK4HkORsKHgPP6UW4owio9gG3qedrc/szv28zCqkkItZCbmhRplHtNgLYoBTR7HPd
 iqWrZqK2d0axs7qqavg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0c7de3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=_2yia0w1AAAA:8
 a=VnNF1IyMAAAA:8 a=Ulcv6RcHQRQKaI22KjAA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-ORIG-GUID: AHXIwi_-ZpLBP3JAYv8kVvFojGM_EUm-
X-Proofpoint-GUID: ZMJ5eqwORWFam1IMHE40mf1ajHp3G113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190150

Bindgen attempts to generate Rust layouts for a number of s390 structs
that are packed but contain, or transitively contain, aligned fields.
Rust rejects such layouts with E0588 ("packed type cannot transitively
contain a #[repr(align)] type").

Add the affected s390 types to the opaque type list so bindgen emits
opaque blob types instead of full representations. This matches existing
workarounds for x86 types such as alt_instr and x86_msi_data.

References: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com/
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 rust/bindgen_parameters | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 6f02d9720ad2..8402b0c93545 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -14,6 +14,13 @@
 --opaque-type alt_instr
 --opaque-type x86_msi_data
 --opaque-type x86_msi_addr_lo
+# s390-only: same packed/align issue as above (E0588).
+--opaque-type lowcore
+--opaque-type tod_clock
+--opaque-type tpi_info
+--opaque-type uv_cb.*
+--opaque-type uv_secret.*
+--opaque-type zpci_fib
 
 # If SMP is disabled, `arch_spinlock_t` is defined as a ZST which triggers a Rust
 # warning. We don't need to peek into it anyway.
-- 
2.51.0

