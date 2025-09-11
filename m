Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5863451BE;
	Thu, 11 Sep 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602639; cv=none; b=YyzGdFkwaZdeJYsh/n83SUQ1V3kjxO97MoxN1tvBBh7RrsdL97a1WYxpYXa2oVC9Lbn0a3gbK1QmvXzbinqh6LjmvAr5+MEDY+2Er8XCEfbtW5zv6uin4qaVZXivsCQItoonLBLP2+Xu+zsvRa11twwhbMuqHYdSUaKyTM86MZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602639; c=relaxed/simple;
	bh=nuUixDWHzXlSRF6SGQOXJrNKnjPnOA0pJzhu+2XeG7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkvGp+PztlEMDO75ohyMHsBMKFYIQy9MpHzY7EJ9AztNhtXia1M2QCzj0WJKrn8KZCrxNKdGk0Zkt7lmZtVyL0CilYp4cAcS5K/85/xcjbtiZp8CpQ2KOyy55NMju2SsqmUvEPKgYvehdap8unuwQQYHi5cyV1gmzVTiXHuAbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fw5gs5hL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fw5gs5hL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBeGAk009402;
	Thu, 11 Sep 2025 14:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MAtZA5hl/c34uXdQAh7SPzJG+/4x9c
	Dfa5783pZG3Fs=; b=fw5gs5hLoAYfkpf4SDE1XrW/it219AYlXtOyLf71WSiwM9
	UAvxAj5wZIXJuPzMWt/YYagCBnzck6U+G9r9rSsKXrXEom/3cqix+mbBrBK8vszU
	7Qk9s/UhCqV+0OOMcSAaMRqbKwMkfHBXbSrDpgwVjoCGd/Y4S0jWAa8b7wFL7muT
	BDH9pUahoy0iUCBKrVFNAusj8JSZd+YbdVtHVgI9+suD7FsKmz1crfIiINYZJWH8
	wwi6RbBCzz4gDKAGt4OOghsNyXpG+GQ1JFYpqFJYxAXZIU1KUtsB/VVENK549KaU
	HFrZ3WqmK+SECi4HsHPsyE6VE2I18yGOAO0RPUgg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffne6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:57:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDIEwo007965;
	Thu, 11 Sep 2025 14:57:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pxbke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:57:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BEv2N946793084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:57:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1858720043;
	Thu, 11 Sep 2025 14:57:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5A320040;
	Thu, 11 Sep 2025 14:57:01 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 14:57:01 +0000 (GMT)
Date: Thu, 11 Sep 2025 16:56:59 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
Message-ID: <20250911145659.8894Dea-hca@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911013243.GA292340@ax162>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7pxY6FnKke9qpM1WTK9cKy0oyboCv-8v
X-Proofpoint-GUID: 7pxY6FnKke9qpM1WTK9cKy0oyboCv-8v
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c2e348 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=mDV3o1hIAAAA:8 a=Twlkf-z8AAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=B-tQutbZQLmHDA95ir0A:9 a=CjuIK1q_8ugA:10
 a=ppDDjHLidN0A:10 a=yTjAz9eSMYQA:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfXwjYRAYta6tab
 7ieBhpuuaCIwsw1dfDxy6ZXIg0Va9rWiXz6ecrHrVTUWrnK0O48mZdzjJtR6zO/sQdhxsHCDfRL
 xnP/MIT+QbhwEFcg/zJIHflsti77YHh3XWbySOjPiLpZ1mpumuohjBMD4lWyPXP9ZNDQWXEqg7L
 1Xf68euINx0q/TTsPQAmzhqthUL1cjnZ1mG/978y4HKIuCbpiMVbBukQQcTmBifVEMfozSUw6d6
 MyxPpJXM8hPomGiI4BnMNYaiNCZIPYMVwDgXWxLFSTyyIW35AB7Fwj7pzwA+u8yEGUvdQJGvqZe
 CIYtYvE1VRl7OY02HHZ5cpGdTxOMPhS/bwHpJY/6a9mUEHeqAy/WAV2xPrE95Hsh0i2o1MCYsn1
 e/SRKl+v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Wed, Sep 10, 2025 at 06:32:43PM -0700, Nathan Chancellor wrote:
> > + *
> > + * Optional: only supported since GCC >= 13.1, clang >= 12.0
> > + *
> > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-assume-statement-attribute
> > + * clang: https://clang.llvm.org/docs/AttributeReference.html#assume
> 
> Looking at this link sent me down a bit of a rabbit hole :) Prior to
> Clang 19.1.0 [2], assume was an OpenMP attribute, which has completely
> different semantics and errors out when used in the way the series does:
> 
>   In file included from kernel/bounds.c:13:
>   In file included from include/linux/log2.h:12:
>   In file included from include/linux/bitops.h:67:
>   arch/s390/include/asm/bitops.h:173:12: error: expected string literal as argument of '__assume__' attribute
>     173 |                 __assume(bit <= 64);
>         |                          ^
> 
> Unfortunately, I think __assume will need to be handled in the compiler
> specific headers :/
> 
> [1]: https://clang.llvm.org/docs/AttributeReference.html#id13
> [2]: https://github.com/llvm/llvm-project/commit/c44fa3e8a9a44c2e9a575768a3c185354b9f6c17

Thank you for having look. This is quite surprising. So after looking into the
various header files it might be acceptable to add this to compiler_types.h,
since there seem to be a few similar constructs.

Maybe something like this(?):

From d9d67807e6854666507e55d9ac0c7b4ec659aa99 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 10 Sep 2025 14:18:07 +0200
Subject: [PATCH] compiler_types: Add __assume macro

Make the statement attribute "assume" with a new __assume macro available.

This allows compilers to generate better code, however code which makes use
of __assume must be written as if the compiler ignores the hint. Otherwise
this may lead to subtle bugs if code is compiled with compilers which do
not support the attribute.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 include/linux/compiler_types.h | 20 ++++++++++++++++++++
 init/Kconfig                   | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 16755431fc11..38a52a792e48 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -329,6 +329,26 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/*
+ * Beware: Code which makes use of __assume must be written as if the compiler
+ * ignores the hint. Otherwise this may lead to subtle bugs if code is compiled
+ * with compilers which do not support the attribute.
+ * Using this attribute requires careful analysis, since in some cases it may
+ * generate worse code (see clang documentation).
+ *
+ * Optional: only supported since gcc >= 13
+ * Optional: only supported since clang >= 19
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-assume-statement-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#id13
+ *
+ */
+#ifdef CONFIG_CC_HAS_ASSUME
+# define __assume(expr)			__attribute__((__assume__(expr)))
+#else
+# define __assume(expr)
+#endif
+
 /*
  * Optional: only supported since gcc >= 15
  * Optional: only supported since clang >= 18
diff --git a/init/Kconfig b/init/Kconfig
index e3eb63eadc87..5882c5e74047 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -112,6 +112,16 @@ config TOOLS_SUPPORT_RELR
 config CC_HAS_ASM_INLINE
 	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
 
+config CC_HAS_ASSUME
+	bool
+	# clang needs to be at least 19.1.0 since the meaning of the assume
+	# attribute changed:
+	# https://github.com/llvm/llvm-project/commit/c44fa3e8a9a44c2e9a575768a3c185354b9f6c17
+	default y if CC_IS_CLANG && CLANG_VERSION >= 190100
+	# supported since gcc 13.1.0
+	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106654
+	default y if CC_IS_GCC && GCC_VERSION >= 130100
+
 config CC_HAS_NO_PROFILE_FN_ATTR
 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
 
-- 
2.48.1
