Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011383D45E6;
	Mon,  8 Jun 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942593; cv=none; b=iyY1PMAfCaj73GIDRH0WJq14p6OajlT6uuK39cWapY1l3YvaeHG5XUufLcZGafHzeOSdvLp8pE7P0OqQEns3YIDhs/x7wVy4Yr6zw1PAdLz+3mfNqoVIGGl/WGcEZ/hQw1SmC3Fn9iPI83C7Ma3jIGtX9eYOsU2yNr1m80qErxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942593; c=relaxed/simple;
	bh=N/5vqbnuG5A+AUDy826NEl00ECRgNaqNXW4fu1PiegY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPLo6sp+ePDlMYg0pphbZMCVNF09JTrOnVgleRrscDACQaf0Qc8a1Hg/EzNEYvgsH3/kmZ6wTHdV9gU0SJPpFUwN0yyILCWYTRKW90cJZKPXYLk7PD/XVB0FdwnVe38lthi67/KSx5/w4yz1HUNOD0SYbjXhpUpWb9xC1jaiyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NIZBAktc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NIZBAktc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6589xjj43804276;
	Mon, 8 Jun 2026 18:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=12TTVlDLRFRGHxgvl
	+8cBIsCTcACPNHnn18WCSFs7s8=; b=NIZBAktcWNotrIkV6mhOn81gsjJDtrsZi
	t+97eowOF3XK9qpKfygGUKD0wZC4eXQ1IQL9EwN1FfsfIPxdBMlD4xQZePQZxRWH
	Iw3U1axrPF+wDM4Ej5UjAEz/3a+zAJGmKBJ4OFnwVSNJEDz3JCeuLPp7hhn+/sS9
	pccZ30v94pjoaO0cu5tAoB8R4LWTIP93uUHJHa7muiG2Gfxb5xYtgktNtDrbuKO8
	S1p8wc3J117s4RMVI7FuwfC62SmjCV1lt4wSnscZ3096f9jp36s+wtsg/AhHvB+D
	u/Fv7KGEm9kSb1FEOfgl+D/VDUU7298xr9xH6dwZJz6V5gUIxcwtQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye0nc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:16:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HnnER023332;
	Mon, 8 Jun 2026 18:16:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpxqn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:16:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEwpb61342100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D74220040;
	Mon,  8 Jun 2026 18:14:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBD9820043;
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
Subject: [PATCH v6 5/6] s390/cmpxchg: Fix KASAN stack-out-of-bounds in atomic helpers
Date: Mon,  8 Jun 2026 20:14:50 +0200
Message-ID: <20260608181451.3734956-6-japo@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfX8oF/U6Di/uxR
 Oo2ALV5t1EEu76auHCGntiNt78R6WHHo9RTpialaa1gYGu3gKLJt8+QjQM//2Jmj8Jtr3/F6orp
 ymdMYspbtv1KUWzqjuA2O8zwJ5gaOND0kGwHwUu3HHp/sFWrVG9QL4TwC5sKV+wt14ZENl35HR/
 7/VqG2VVchmxK7e689XIbpwfNnisow05l2lkDnSS5+XhfYP2BDwuGfagw3R2iuZltBir2pqAp8d
 3KucK6wN+/NCyula6TvoZsk7SLUPPQKbYIxNF/6ZRHPpcO7CwcWJCqUVrElyyMJQ3O8IaWroo6p
 JOqGd0CNZtU5/ELVlZQ1qZNm5ufWLJcpeInBCjTk77ZfC/tZAaLc0mOK6B08lA9jzJLqoAUF/kn
 4QSLFW9FSBZuNrkaJVxqawxia+X07PjN0XfKJ5ggcCVdM09xiuypjAeOw+Qev7/nx3QOYyYO9Sq
 Zy/yKdGtF6kqq+WG/VA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2706f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_2yia0w1AAAA:8
 a=VnNF1IyMAAAA:8 a=9-FPAKYo-0jGICd3_CYA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-GUID: 0kHwyCX0npoqF-48K12MvQwNNZTxIskr
X-Proofpoint-ORIG-GUID: ZGmTGmcKN0XVTr5DXbQw_hQpJB_V4vc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080170

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
Acked-by: Heiko Carstens <hca@linux.ibm.com>
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

