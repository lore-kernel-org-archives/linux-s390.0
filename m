Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176593D9027;
	Mon,  8 Jun 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942523; cv=none; b=bNHnXee4hDNbZ7Hap7ijAdz17ZSQdN1mHOSsdyC5gt9AwZFEf9j2jwPNuC6CjCzQhmgO9c1d2+WopMz9Ty3zpuGeJW5NEUbUikDFUZA1dyJcInMQon0Yae79geE8degcGXkY8NEa6ZCILZJ+LfkA9M/r7ccW/EOm5SbiEEyH3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942523; c=relaxed/simple;
	bh=z5aDbCkruTXiuZUIzSSdNkuEKChf6FJQ7I6csuaXjyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2ydUXSJGhvvKTDt0HfjTyrH15/7MKkRJwtWqQNsNdkonb3dlBtx073sbHSM86l3IwinfgJtK6iXxHPdah9aafGhfsOwMt/8R2vqkPugEdwU0s45JDn8hSDbGnr9/VICsffwERecU50IjlP92QZ83RCoKG9xgTpXAYTr0XsCnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b/Qi19Dx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b/Qi19Dx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6589dX9t2494942;
	Mon, 8 Jun 2026 18:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tdPNMk18ImxNBGKmf
	2uPkiF94pNknNIhO/Gpdrcft8E=; b=b/Qi19DxnOuPJZWD2D4d0VoLZOK4BnEoP
	eVPtXYe7XI6QAySHXZJ+Du2Yir3MAb85WMruiL67yhUivKbmxhliSof1n3g9iR9I
	UHD1QG0hRiyEGsyqIkEOD0p9mH9VRPQHd4bFa+t7vEnEySTsTqDf8MdiS9BWtJke
	T1AqDfAUMojbm3oiHP5gYo8CL4CuWb1kU6IbGta7hjrxkTBkmelMcLxFHA+eE804
	AMa5egdFDXzyHTmy6dqwTa3dr0O21pvWh0c0kj+oUJfmmS0PgZs9LAWOY6MId2lc
	l3PhBcaynXDJiV10LvfoS61LhZ+kc7h0VMBwGznQxZRMsEs0z1J2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6srgxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658I4dcC020169;
	Mon, 8 Jun 2026 18:15:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vxngh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEvfD50528534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D69DE20040;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84A642004E;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v6 4/6] rust: helpers: Add memchr wrapper for string operations
Date: Mon,  8 Jun 2026 20:14:49 +0200
Message-ID: <20260608181451.3734956-5-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608181451.3734956-1-japo@linux.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KgDHuFQWEO2b7jqeHFl5EHnbGbKMNcyv
X-Proofpoint-GUID: 1aIC8G-_gv_EdTTuBMIHZB_S_R0gn0mO
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2706a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=0OX8x8mQKUGR4pMsIeoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfX72ZFz/lDI8Uz
 FW1UV0gC4jCyowrnujxMHlYQRL2r/gi6JxqbL0Jq3YxmAO8IaE4QRM0+1jiWsu5OKwg2xJ9+aRx
 mXZRD6eacVxZrMZq3ubLvwufmZ6dIQ6nWunmordD71Nz7fZCAYkzTUS6wdkxuH5vW9KzkZiNQoX
 jY8T50BXVWmgMaaxuImiRTuzr7EibZ1puqi0oyHmEta0wYw4I33+eiG1pS5puMM/6P1uukdXWCt
 bjDdokwnPpXpnAKbfOGIbQKlBCyalesWHMuBZNrQZY4iOlnKXgCOFNBPB0fnBB6Lg81oPBMGcV6
 XWMcnnHv4LGcM3KVeV/hKg5k+Seu8hbC60ZcjvW4oj8PL8Yp05nnAun9rZm0H1lhdaF3q+sZsqS
 Sfj2BS0Hrvf6p9FLeQQ4O2WfdHkAY2mqCNlAk1q0f57crnljN9004xjsS46E3vw2DclGy0mULJf
 dfV6nVDrJJD7rQJIIIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080170

Add a dedicated string helper file with a memchr wrapper that uses the
kernel's instrumented memchr() function to ensure KASAN and FORTIFY_SOURCE
protections are preserved for Rust code.

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://lore.kernel.org/rust-for-linux/CANiq72mXAZc0sNM7ShX8VDVs_7zJddawP-e=wt+ERr1YUCcWUw@mail.gmail.com/
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 rust/helpers/helpers.c | 1 +
 rust/helpers/string.c  | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 rust/helpers/string.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..592b9bdb4e4a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -88,6 +88,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "string.c"
 #include "sync.c"
 #include "task.c"
 #include "time.c"
diff --git a/rust/helpers/string.c b/rust/helpers/string.c
new file mode 100644
index 000000000000..8ef30eb07a15
--- /dev/null
+++ b/rust/helpers/string.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/string.h>
+
+__rust_helper void *rust_helper_memchr(const void *s, int c, size_t n)
+{
+	return memchr(s, c, n);
+}
-- 
2.53.0

