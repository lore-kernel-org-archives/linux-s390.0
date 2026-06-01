Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F23E0224;
	Mon,  1 Jun 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336031; cv=none; b=S0pERpbualcbmuUr4umTmbtFcuseu/cwcHaexGNp02kF2Ya2Y5B/0LkqDjbRRqZzlL2xiuHT62PbGw74eIMRnu0V+40qvtsTx/YH00FAWn6aVN4APaIEp2cNtyiuo3xRdsL+Khl7lAV9TqDVNGsFZadWPQ+oBEfD+OX3bpLyM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336031; c=relaxed/simple;
	bh=s6g8kcj/uO9XZk83H3M5Nr5VLLmjQgkp2xoyTvCv50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+V5JGNCdnWxnomo64RUEzR0M0uy5HAgg4c/ZqvNzw58yR1/dTpgLBtxFENo3Uw9TQoKSMJ81Op+Ms/Oi1meWmtmLuJMExhxNOvPjBhu27/HP4vWL+gdzABzAaTxT/j3s+pi9ARJwMmdNpJsAGWM8z/QFMphkLdSPjc0+rYdyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZGLC+FS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZGLC+FS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651GVxbE3708195;
	Mon, 1 Jun 2026 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GQ7gNmv1F+aGOr69G
	f7a+NCP5ld0x97wIY/UegH7zUs=; b=iZGLC+FSfpmJIgyMPXzI6Pp5WlBEoe1sL
	dCjxRVPi1q7wuLkVQCMz63vmuqDQExhNeUtKkEYAHpIpbDDu4pV3XDYzs5jEhHzH
	5xM2xu4O3JDRxSD0ihbHBGfA8RXzglETROaghGr5oAY3o8F7HCFJRDv8+eWE5lRr
	l36j2PCFkRDwv8jdJTo3V5ajWrVmU7G1ueAsYT6xPQd05Jxv0DjP5M26rjRJL3or
	HlbrAH1xR0ITZNw6mHj9MQLdbBZ0+uYMhvOkx54ywGNDoQWZ1LiAv+zhspDpyYCj
	lN7RhwuFaJHY2OZBHcnboBEZ2ycvX2sydi0ElPI2oe1JVe+Gn0bMQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae1w2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Hd6eg025109;
	Mon, 1 Jun 2026 17:46:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvqh3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651HkmPY16777588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43FF320040;
	Mon,  1 Jun 2026 17:46:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A3B2004B;
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
Subject: [PATCH v5 5/6] s390/cmpxchg: Fix KASAN stack-out-of-bounds in atomic helpers
Date: Mon,  1 Jun 2026 19:46:24 +0200
Message-ID: <20260601174625.2910233-6-japo@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1dc58d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_2yia0w1AAAA:8
 a=VnNF1IyMAAAA:8 a=9-FPAKYo-0jGICd3_CYA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-GUID: oNAhO7AWIvZOwQFELP72dO1agTvTfy22
X-Proofpoint-ORIG-GUID: fWKlbdpq1bhD_RTRhLNI_UAvrFaMebOK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfX+Db5X3yvueAF
 VOwr+LpEUjkBC4ifMriIHAt0ZX+//F7BU5afrLWQZr4l0FRtJMZKDih6um9tPJBfX4louWajzRh
 u7o4vIaREmxQp2vjFBqtkeuhx/VaNjeVEAPAC74CREcfwC5v0ddFILxWtygK5Ud17n0NZS+zDkF
 0UpSYXSvrMETQW9ROsSVJuPSbCUiOVg7ojJUz2mHYzo7Wuj/JVQ9xH+6vYb7rAs6biOLywB0hMh
 sCF6LfclpT+CWiAHG4Rf1WzB4ato5+R2zjUpr075PmQq2t2NCWs3mLzv0XZ+SVM4fdt6AFsmsjc
 KSGG95noDJG7ce2eUMQRANi1kwfPyeXt2Jm8RvzkpYDy+ZSsLKZb8qKDtXn9ed183+8nHaHLaqH
 AWSTM5cDauI+XKGpA+J3HAeTMMuON5KcemyBxk/CLUDqBiGojfBN+iUKhM/SFCueFleOtaS1avw
 BrDvWmPkNp4kgg8oI9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

The __arch_cmpxchg1, __arch_cmpxchg2, __arch_xchg1, and __arch_xchg2
functions emulate 1-byte and 2-byte atomic operations using 4-byte
cmpxchg instructions, since s390 lacks native 1/2-byte cmpxchg support.

When KASAN is enabled, the READ_ONCE() operations in these functions
trigger stack-out-of-bounds warnings because they perform 4-byte reads
when only 1 or 2 bytes should be accessed.

Mark these functions as __no_sanitize_or_inline to prevent KASAN
instrumentation while maintaining correct functionality.

This resolves the following KASAN error during rust_atomics KUnit tests:

  BUG: KASAN: stack-out-of-bounds in rust_helper_atomic_i8_xchg+0xb2/0xc0
  Read of size 4 at addr 001bff7ffdbefcf0 by task kunit_try_catch/142

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://lore.kernel.org/rust-for-linux/CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com/
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DITFTAVVHTNQ.380OHUHGTOI6M@garyguo.net/
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 arch/s390/include/asm/cmpxchg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 008357996262..e6ac55cf3c17 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -35,7 +35,7 @@ static __always_inline u64 __csg_asm(u64 ptr, u64 old, u64 new)
 	return old;
 }
 
-static inline u8 __arch_cmpxchg1(u64 ptr, u8 old, u8 new)
+static __no_sanitize_or_inline u8 __arch_cmpxchg1(u64 ptr, u8 old, u8 new)
 {
 	union {
 		u8 b[4];
@@ -58,7 +58,7 @@ static inline u8 __arch_cmpxchg1(u64 ptr, u8 old, u8 new)
 	return old;
 }
 
-static inline u16 __arch_cmpxchg2(u64 ptr, u16 old, u16 new)
+static __no_sanitize_or_inline u16 __arch_cmpxchg2(u64 ptr, u16 old, u16 new)
 {
 	union {
 		u16 b[2];
@@ -173,7 +173,7 @@ static __always_inline u64 __arch_cmpxchg(u64 ptr, u64 old, u64 new, int size)
 
 void __xchg_called_with_bad_pointer(void);
 
-static inline u8 __arch_xchg1(u64 ptr, u8 x)
+static __no_sanitize_or_inline u8 __arch_xchg1(u64 ptr, u8 x)
 {
 	int shift = (3 ^ (ptr & 3)) << 3;
 	u32 mask, old, new;
@@ -188,7 +188,7 @@ static inline u8 __arch_xchg1(u64 ptr, u8 x)
 	return old >> shift;
 }
 
-static inline u16 __arch_xchg2(u64 ptr, u16 x)
+static __no_sanitize_or_inline u16 __arch_xchg2(u64 ptr, u16 x)
 {
 	int shift = (2 ^ (ptr & 2)) << 3;
 	u32 mask, old, new;
-- 
2.53.0

