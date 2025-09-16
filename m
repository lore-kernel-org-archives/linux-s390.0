Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5A311C22;
	Tue, 16 Sep 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030495; cv=none; b=ikv5FwXicm6EeRoOf8Iy++XA8STrjgpF/+V7PMVe3x8P8gptlx58c1LZLnb6wUCZIMdbXU80Kos6Phq04o78idvxsz/RaJzNP41aVvNBSqSiRB+H8a7FnGjtbW4NoKt82uHIlo6ptbI0KRiIKyQs5WEjm9HvzINiRntHSxfToM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030495; c=relaxed/simple;
	bh=a+56aum91H7TC6NjgT2qGSwt0mf5qEDaJLI+TNpSFuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g71ukwnVpra94Wm3DtdSPmZjLOZAkUm9FsrqKRVCiiftoCmn8pTNl3beSbna8IejQpudFA/YdexXz3MBcKhwR7EyPVASEqII51uBu8ZpNZ70wjwlrLz5D1kFyx+e0HrefT+W6mQR5KthFOhrkn96RU/WQd+nxxUkPc3S5ks6SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A7HnP3kS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A7HnP3kS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G5fxJu003218;
	Tue, 16 Sep 2025 13:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qgg+JZ+RGKz7+EiWK
	WifKsLu8WghMf0jUnupi9hkrus=; b=A7HnP3kSRBNDBIJwN4pcS7+GDSE7nsN6w
	Xcs/DheYjuCYJXT82+JPivloKIpYz0MHeIuHbOMyojwECBbe7VMqFHiIxI6U3Gp3
	WoMblUtBknoaGkJc9HbIsVHtDikK80L8K1aaYjaLc4c7UE13RuYQtp98lO3Kp+5D
	ESOJSJOCHJtlznG0yike2B+lGZ9rrgUHO6X3PrDnUxSFaFyq3fmM/MxqIBE3fvcF
	+MEM+Ny0h0W/YNc67S1oZzmJIb25a/oSYuWDMfTo2ZDnrB4HdkxJVeTWmwmsNktW
	0/F/0X1F7Jetn+YFUycn+qB2VfWG8gjVQs8js4nSPtdL/G7iQgLIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494y1x8kgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GDeIsQ001761;
	Tue, 16 Sep 2025 13:48:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494y1x8kgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAuUd6027268;
	Tue, 16 Sep 2025 13:48:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495men41mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDm4hd62325098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:48:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 050C820040;
	Tue, 16 Sep 2025 13:48:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C57D12004E;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 2/4] compiler_types: Add __assume macro
Date: Tue, 16 Sep 2025 15:48:01 +0200
Message-ID: <20250916134803.874580-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916134803.874580-1-hca@linux.ibm.com>
References: <20250916134803.874580-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMCBTYWx0ZWRfXzIVDI/K1dnhu
 9YK+M7lMnsHcwG8qXY/bnKEehEYxtVzZCGwzNEefndVly05GQTT4CjLFL246TxUbbYyNvRXzPzI
 fpsjeozYOUJsh7r5VQZpaD/iGgjqH6+esi/4aAgJ1nowpSnHySkm3LXxnSRURGejZ3X76bDKW5C
 3EwWRD0f2u61bTpYNRJa7WxLP2Ejs1CgLqf8SsLWgX5ArK/68YDEFbn+yKbVx6ifYeLoCe+e3Mf
 C7mOqwH9CsPClX29xf5a52nnyNyzLd/XNkmJH5NhXdzk5mXw/wysG82wl/ThsXvT3v9uiUt/twJ
 gYHILeQWOo+mCQpF6/RS3S7jWJ4rqFp4Xh6TfW6Tgr+VCqwB/DZgZU+715zbqti0TbolEliS3oi
 dcage9LS
X-Proofpoint-ORIG-GUID: gFGOrD1Th7obFOwU-THP8epixAo_zwHH
X-Authority-Analysis: v=2.4 cv=euPfzppX c=1 sm=1 tr=0 ts=68c96a9a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=mDV3o1hIAAAA:8 a=Twlkf-z8AAAA:8 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=MHpFcgiKDtP6AC432MUA:9 a=ppDDjHLidN0A:10 a=yTjAz9eSMYQA:10
 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-GUID: Dje0A4EMYP8Trpvu3o_DqOOxUIosxKRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130010

Make the statement attribute "assume" with a new __assume macro available.

The assume attribute is used to indicate that a certain condition is
assumed to be true. Compilers may or may not use this indication to
generate optimized code. If this condition is violated at runtime, the
behavior is undefined.

Note that the clang documentation states that optimizers may react
differently to this attribute, and this may even have a negative
performance impact. Therefore this attribute should be used with care.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 include/linux/compiler_types.h | 23 +++++++++++++++++++++++
 init/Kconfig                   | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a910f9fa5341..41c16fb8eb40 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -329,6 +329,29 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/*
+ * The assume attribute is used to indicate that a certain condition is
+ * assumed to be true. If this condition is violated at runtime, the behavior
+ * is undefined. Compilers may or may not use this indication to generate
+ * optimized code.
+ *
+ * Note that the clang documentation states that optimizers may react
+ * differently to this attribute, and this may even have a negative
+ * performance impact. Therefore this attribute should be used with care.
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
index 59ae2b967195..935eff59af97 100644
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

