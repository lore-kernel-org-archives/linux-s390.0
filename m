Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2AE3290B8;
	Mon,  1 Jun 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336038; cv=none; b=hZ1NdhepCoZK8PMaZAvZ5pvLQNByvXS/cflziuu8l2J+RwKnjgaDERrh0r9NAPhyPz+EDI5g8c8hp3iahPodUdZ8opJGwHmIQ02M6w1OlmzNmorcJVd6UH5qpT9LsPy2E3Dv3xBmrNRHr4GbAHQRh8dmJMU+M1BRWGntKM86zeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336038; c=relaxed/simple;
	bh=phafkXkPal7edQRE+4hr3mKklDGfz5zr/ybrDpBlOUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My3dJ4NyEK6BeNE3D4jdZG8+smI8PIo2JMeDM6UtfBxT0R9nsOGLlX4OKu2SktMmBWXJ0lnWDjSqzujMtb51L/+FsT8MN6ZIjbTY9K1WXfIKfEMonQHcWSUou7zr9tiCzhl/m5y1Lnbiz3oisDqFZhVGK0jDoQ3RA5HPM5pOqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jzt8GE2H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jzt8GE2H"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Ee1aM1360394;
	Mon, 1 Jun 2026 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ubH1qkuwQxMGssjzN
	QTwbfYf5FFyJ+BISqvcGLhv9sQ=; b=Jzt8GE2HzczZ0MudhcEMsSoO9AJkr7Eee
	SRQwBzMGMCbAe7/zaZyDa1q4CZk94qD0ruGxbibossTFR3D7JBTdrL9fLlERxxDI
	xArVki2ihkAB6ucMM4iRT9NbEW9gOJGl2JgHO4/51omPP/YVs8DRDz34hWyWP4ll
	YtItPgR77tlYmHTHiVcu3vBPXKVMPIYa60bmDDkWimOCdceD9mfb/F0mMp7wOtFO
	tnVb7XW6qBigOBcsGn2QSboKpWRQSz9BKnKK0lCD2B7aIn84mXMVjaZXeIUu9GTo
	A45khgUCc6Qq+W9s3IlRwNpb/eY44c+XFhZHuKao1XKl8rGL6gKmw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd427sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Hd6S4017576;
	Mon, 1 Jun 2026 17:46:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jydbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651Hkmql24379654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED38920040;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D77820043;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
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
Subject: [PATCH v5 4/6] rust: helpers: Add memchr wrapper for string operations
Date: Mon,  1 Jun 2026 19:46:23 +0200
Message-ID: <20260601174625.2910233-5-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601174625.2910233-1-japo@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfX7aM5zSbzJk7r
 10kLoNOBcZgVXGGVBtGWKjwMUStFvEhP3SkZIB7YVeD4Gl16lIHLUTzqPWJKC8M1nGj46+L4guE
 SDKf5MibzsM8zQwYcRPIt/4CNTwxe0EKMSS/bYutMSiFWT+z85wAhNo/xwhjvk/PS65AnB5RLr4
 /QcwAJ6ve+Aj54n7qnpj7/J+Ue5LRd/ABVjLieh/E1vrcvSg7Huk7s/xlu/BQL0/Cq8+s0OiQOP
 1IfEYslPgEHVoa1w9W4eK5K8lvKPMLQsEknpoi6wIF65gkDzGP6PpQYR0sfKJswW3EdHe4r9S3c
 qAqmbh51zZuv/RZsRSDw2vXEOYkgfFfUcmjoQZxUvM8Vi5rJ1Kk2ERAHUSW+kWQusBvqF1V++GG
 RN/iBGWqLtoMavX9l2bdbQkfqpyFK0/Yo6FrpWwbXmiDJwTFdzm8tKBp2i0kkP1I3WjI19lmwJf
 1hpsiHZ8i2rKRP5z9Bg==
X-Proofpoint-GUID: k48lJb7CljLPFBJhcvVl881Kl2R8FCFm
X-Proofpoint-ORIG-GUID: GHw6Rg5ACLDvhyGfPNgywl6s17nSxyaS
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1dc58d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=0QoH9A0xUf0yihFjRsoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

Add a dedicated string helper file with a memchr wrapper that uses the
kernel's instrumented memchr() function to ensure KASAN and FORTIFY_SOURCE
protections are preserved for Rust code.

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://lore.kernel.org/rust-for-linux/CANiq72mXAZc0sNM7ShX8VDVs_7zJddawP-e=wt+ERr1YUCcWUw@mail.gmail.com/
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
index 000000000000..d04340dc9139
--- /dev/null
+++ b/rust/helpers/string.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/string.h>
+
+void *rust_helper_memchr(const void *s, int c, size_t n)
+{
+	return memchr(s, c, n);
+}
\ No newline at end of file
-- 
2.53.0

