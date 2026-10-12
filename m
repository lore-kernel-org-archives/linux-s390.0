Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE973E49C3;
	Mon, 12 Oct 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805377; cv=none; b=ZlvSvxC3k1Sa/j9yZfx4pjlXw31US+Wurwudd4/aNLmmRorgpDDNrVN4gSoYpWun0wh9CQ8ImPg++kdzBXem5JzxBwznu/9PdJL2TNCGLZIZZP/E1WCiUymEfC2Opve+V4dUKpc7j65tpEukzfk7ikU5rGPu2MIMQ8jFw7bNKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805377; c=relaxed/simple;
	bh=EdtIl+qUknndku8F3mCbwsv8zL5weCbbI62mjlkQ4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THSJ2wRX8nSn9RQatcbuM6kgB82H+B82F8NHBdj34lTXHLhRYPQ09cLGVZ2bjIXhjhHeE9uWbvHHbKoBQHIfAObigva4DMrprA4+uuXj6D5h9aOI6kRw3SX35cA0Dlxiw5j3DP6gHk4gnbWfIVQNmLVRdZxjwrrU4ZE7qg1azj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnYIQD+1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnYIQD+1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iVDr2750349;
	Mon, 12 Oct 2026 11:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gdknihAnQBoJ4jFy0
	yO5qXnb2ZylW7iU3mVkMeSxtG0=; b=QnYIQD+1BU1MwaQEuLPWKxiM/+A3WAP0l
	SfL42tKWBEiJKOpdFBExFc9c9hCOfNAdvHiHSQELPdpwXsNfAEEefaxyvUR6juqG
	H5DCNkL8Ye2Wt3AQ5i2x4oie7o8hg4rXo3ItGbXfCjFcfhIquGSt/ot56NxW794j
	ZFUy5TEpGWL5ySGZNs9KGxYUgokv0nynDBUBMlwNqWiJpR6CYBBw4Adr+rCjNeJi
	TfUGfxSu2WSv3uOWpphxa3NCIDA2T8dlU78D3UOVAXwOKgtu0K6xU4r/MMt49q6l
	RyhiW2jFQgPWQ/Smx7jml88JiacwAaNl3si2kAJYEBcevFlver0eg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv08bd1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K6Gf1013658;
	Mon, 12 Oct 2026 11:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cycpvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CBgn7v44368252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:42:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D489320040;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA0692004B;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/4] s390/percpu: Drop unused output register from arch_this_cpu_add()
Date: Mon, 12 Oct 2026 13:42:47 +0200
Message-ID: <20261012114249.2898572-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012114249.2898572-1-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXwe1sPUz3lHUs
 xYblI83S67mRB+bn4pp3JHzglSzA0Ds2Hys5BPeLqfK7SmfGQxpUgshWz+ZJXqQjIme3+eOUK93
 yToE1N4WZchz3SNJxQpV0PF7uIngWpPXEGZWmBuGTHi3wq0eSap9l25OQ3SIvMnFUSw+RQfjD4m
 o1kgsbYPQlFDK+Xk0YC5xhIyLlo68eUuoGbYyND1S1Gkk76KsCnBDD+JFS5L53Xx9Oq3hQj2Tne
 Rja9iW1Me587uCR5mJ741NyeKMNi634n6Tx4DKvIwrcer2ksOXvIpEEEluUo6wwBlA5yoKQav/F
 WvBGKm+eN5NlLD1Gx3n7RB2gAzYrvXwDMb1RBv9s4X4jKR4EhI3gZJgRtCAAicp8Ryq15OiEHWp
 olJA7/4vNSTr7/M8kjewpYZ9+ByPdbDRPeXLDIB8w31gHYrN7olM9E27ikYhdyz9yakx2+KbPIA
 UyKjkKsJFckd5q2SXXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXyhuTzGqmt1LX
 06QluzVO89GPl+TI8eOm/Y3qaKj8uCsBQIa7AA90e00+i9+WlRu/yL9LIhtwC/KBh4QuxIEb9UJ
 REn8fucsjPNxycRJLs9tAqM1p41gkhM=
X-Proofpoint-ORIG-GUID: z3tIrPPqGTXpCaQqhf-DxKVQxpDuDrbl
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accc7be cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HZORN2dfYEM7eqIYgV4A:9
X-Proofpoint-GUID: z3tIrPPqGTXpCaQqhf-DxKVQxpDuDrbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120044

The laa/laag instructions return the old memory content, but
arch_this_cpu_add() does not need it. Instead of allocating a dedicated
output register old__ just to discard the returned value, change the
val__ constraint from "d" to "+&d" so it is used as input/output
register.

This reduces register pressure.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index dfab41b43b8b..fd0a3a9951ce 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -188,7 +188,7 @@ do {										\
 	typedef typeof(pcp) pcp_op_T__;						\
 	union register_pair rp__;						\
 	pcp_op_T__ val__ = (val);						\
-	pcp_op_T__ old__, *ptr__;						\
+	pcp_op_T__ *ptr__;							\
 										\
 	ptr__ = PERCPU_PTR(&(pcp));						\
 	if (__builtin_constant_p(val__) &&					\
@@ -209,12 +209,12 @@ do {										\
 		asm_inline volatile(						\
 			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
 				     "%[pair__]","%N[pair__]")			\
-			op1 "   %[old__],%[val__],0(%N[pair__])\n"		\
+			op1 "   %[val__],%[val__],0(%N[pair__])\n"		\
 			__PCPU_END("%[lcreg]")					\
-			: [old__] "=&d" (old__), [pair__] "=&a" (rp__.pair),	\
+			: [val__] "+&d" (val__), [pair__] "=&a" (rp__.pair),	\
 			  "+m" (*ptr__),					\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
-			: [val__] "d" (val__), [ptr__] "a" (ptr__),		\
+			: [ptr__] "a" (ptr__),					\
 			  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 			  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
-- 
2.53.0

