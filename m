Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77F3FB06C;
	Fri, 29 May 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066700; cv=none; b=rAEZv25g709JPRQyLjhijI1gBuB80beeZRoRJGVeQCZAFqVk1oJyktyBpmp72VEgTERE9ulSuzO1R1lm130Rf2M06LYVFipd6Z+njFUMZ+kYdEpHYiXR2nHhmRFN+wDveSLb0H8fb53vmq1B7lURBLaqOOIyxrWDpi6gLqGFNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066700; c=relaxed/simple;
	bh=IzaHGNo+wI02TY1vL/z8Q0HtpWru8igkQzbYsUb+gmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBGMi/aSSJrv5lwQAQN3CPVo5aOTvDapblj1p0YznpZcyOvcZwHNiNBeJ77QClrNIF1zqzfEIMdoC6+Ttk166/xTagari30r3wQsstsXxngo8W+hfUwEsHJ3KDUO3PDdKlGAm7UNnVyVlMf/uzg2LHh/ywMeg8a0vgSRj+xRjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OX2caTQK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OX2caTQK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TETswi1467859;
	Fri, 29 May 2026 14:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gLV57L2cE79gIsPyQ
	15hh3VU7Mp3tzfLpiwC7VM+Z8I=; b=OX2caTQKb/QG/dxBcYHdP1SXwore7yhs7
	PT5G0UpdA+l3pVDrD1MJNjAchPxKuJDsz4n20ulZJAcQvYOjaX5foKdK9AXBH7TI
	uDWg7Oj+izGiwgpQyBSxlFdFwvBFXDuLeQMb4O801xRRoMlpP9mMpQc6wova8vDN
	S2332tIc0Z+6wchEb42xexnoKPBfKoY1RO/9TqrrJEsOCsgu6f+QVvjAAIr6w7j8
	LhUx8Ai7b8iY9964v6f/NBC2XPD0KkCWC1mATimZR6lK4flYuJJzxMuSb33C7DHt
	G7w3/14qDJU3FjaBDyy3jXSrPzGLh1WTayUmTemUu3L/6I0tqxS6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886jjpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:58:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs79a000697;
	Fri, 29 May 2026 14:57:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrby52g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEvt9q22151690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:57:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9678A20043;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F5C2004B;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] rust: helpers: Use __builtin_memchr directly on s390
Date: Fri, 29 May 2026 16:57:50 +0200
Message-ID: <20260529145752.1209016-5-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529145752.1209016-1-japo@linux.ibm.com>
References: <20260529145752.1209016-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vV_9jLwsdk_Yi6R_FsAr5d08pjEHK2l3
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19a979 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=IDKdOGsrxnk7c9Cu3JMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfX6/uoqH9kLBPN
 F24UiH0lwfmVDTGHpoxjSBNEjDXVhwpxTENliL7UbyoKkuOFnaV7G6E4BjdZ6Q0oa0zs3N7S87B
 MQWqJm3fGFa6qNu7gSTTx88v0gwXIii0foLYKxhm/zLer9pKDSUNMqk+Ym1/KkyOr30aJmRRXxl
 /NxcKkecBwuGWe/rBh0l+2Tt1zbz67EDh2mcCLdZ5UsT7puaz+i7Jhm0jRFRgGjSlbLxn2YybIk
 4h9hqU1R569RhdOVVqr/FhwgjlI4NyLFEWevhoYtGkefy/LMO99yhfJF0byaTuDUsTowSzQp3Qu
 LZ2VXNCvZRoKc2E/5nshiiPi8dg/OI/Doii3/fBS+fBQNdcX3bhJ5vq9JVkHJraq2KDnX7puvHr
 JXynzrdXCUljpfKvesNjgLe9ZHVaFmFRiDZbC1335NhNAAYetoex4cKaW9LK6dU0oYcKuMKtsJx
 OjxoJuwAI/bX8GUof4Q==
X-Proofpoint-ORIG-GUID: Bm-_96bkl9LvOTzOMAlamic2RTseClsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290146

The __underlying_memchr macro from include/linux/fortify-string.h
is not being expanded correctly during Rust helpers compilation on
s390x architecture, causing a build failure:

  rust/helpers/uaccess.c:40:16: error: implicit declaration of
  function '__underlying_memchr'

The macro is defined as __builtin_memchr, so use the builtin
directly instead of relying on the macro expansion.

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 rust/helpers/uaccess.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index d9625b9ee046..d4107426003e 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0

 #include <linux/uaccess.h>
+#include <linux/string.h>

 __rust_helper unsigned long
 rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -27,3 +28,9 @@ unsigned long rust_helper__copy_to_user(void __user *to, const void *from, unsig
 	return _inline_copy_to_user(to, from, n);
 }
 #endif
+
+__rust_helper
+void *rust_helper_memchr(const void *s, int c, size_t n)
+{
+	return __builtin_memchr(s, c, n);
+}
--
2.53.0

