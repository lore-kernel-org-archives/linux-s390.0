Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED83346B0;
	Mon, 10 Nov 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800890; cv=none; b=s3l7WglmDvtfQDIvhsEo7nx5E3o7Pc5EtCMOQLyrpg4K/mjWNghfDogegfxkKGO0HNLc3o8tN+aELJpCZpvOX4tfP/7V9puRf15qMioUA04tBAGUpMYgbWFsSeQg0JBHIRg46ZNj9Zdmfz3hU00DO7ilaa/ZjMdiHBrQUj+DmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800890; c=relaxed/simple;
	bh=4cohGBnTv5L71kebtOVXskhvOpWXOfUSUbTILjy4wh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCKj0/6xK9gSc9HEBVo+n5ZD0wIfo4NnrYV8CXaerYF+pgulAUlpBV6cM2QrzlOLtJCk2Ergadldkiai8QjApy9+5sUPUmDeTre/XwQSKmtK/0MinVJJAcrkV0/Anzmv6w7OcUNO7S99wIsoomxiyhWkRVn7detKYxsd4sr0m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eznv1Yzb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eznv1Yzb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAI5sB2003484;
	Mon, 10 Nov 2025 18:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zjIEHIEte+NV57tzj
	Q3eo8hha9ypj6/6pwLlcJ1Xwm8=; b=Eznv1YzbhTipaWY/ChquIgXCmMBicp+nU
	FkjJYxT3eHwV4ysmBy2L4bCE5e3FUDXbECiLHLw0Z0vmnwX3PgwK6jA+84sB+cCD
	4uax4IsUXk9f/T+qWbdESmjee5aOTNRulFiyrIPICklm8vIv+bxT4OkDb0ah8JXX
	vH88y8wY4tpKKF8JZEDP9B12sQgx4SMPDMhilnig2fJi0IM6qHJVH8XpeFNAgHby
	8qUYJKRAkf0aDn4VaEy/+35/UkQjRKDoPXAcDlRsmzhAcCVNoScrkBwAyqcedO16
	1zK+dm1vD2u63t/bPPedIm/bQC0WPlKUWOHa5TBXUE9BVbpAaOAvA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwrpwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGeTFQ011600;
	Mon, 10 Nov 2025 18:54:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw16u89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsfml11600348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F59120040;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3994120043;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 3/8] s390/syscalls: Add pt_regs parameter to SYSCALL_DEFINE0() syscall wrapper
Date: Mon, 10 Nov 2025 19:54:35 +0100
Message-ID: <20251110185440.2667511-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wfuTdCa3vX1rlxan3GFH4_keKs8yBUK1
X-Proofpoint-ORIG-GUID: wfuTdCa3vX1rlxan3GFH4_keKs8yBUK1
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=691234f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=94QMi1Fs8O4gAvJbfwkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX0Mc2D3+Y4dUk
 a2Lytl3VRqmdrXBgxaruWUQIpZds1F0lcWZoPGKpifLGVKFshR1eeytOQycMAJ05wpvNWx0KnFV
 AccdNEVyTaCqeV0yDq3vnhLGJWxZDI20gSl+XHgOq1WXBJFS6FHaVP/+pWaybH9rmWOJHAFxM+v
 Tu3Gmhxg+wuSgS6NnT8TiPuTv1f066h8uWLRE8azIxDY/x+UFHg+0C9IUsKbM5qmOMczfMZfHMJ
 j6dh/6oWI3qXU05z/tFlMstoxKXZCHa0XlQIi0Kb5oBUvBaBEo8OTXIhEGDeUjSuJG/gJe6Xa+U
 yEm0VQCwUZltmNTI8FwTu46dN1ARRsn/RLqOgELyi7EUzB/BThuKTrAnwLS8fFIgAGfCRBgFP5T
 g3V2QQMjTqm51oGy9JG7Dlkszf2Hsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

All system call wrappers should match the sys_call_ptr_t type. This is not
the case for system calls without parameters. Add the missing pt_regs
parameter there too.

Note: this is currently not a problem, since the parameter is unused.
However it prevents to create a correctly typed system call table in
C. With the current assembler implementation this works because of
missing type checking.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/syscall_wrapper.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 35c1d1b860d8..bf1ff5e9242d 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -38,22 +38,22 @@
  * named __s390x_sys_*()
  */
 #define COMPAT_SYSCALL_DEFINE0(sname)					\
-	long __s390_compat_sys_##sname(void);				\
+	long __s390_compat_sys_##sname(struct pt_regs *__unused);	\
 	ALLOW_ERROR_INJECTION(__s390_compat_sys_##sname, ERRNO);	\
-	long __s390_compat_sys_##sname(void)
+	long __s390_compat_sys_##sname(struct pt_regs *__unused)
 
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	long __s390_sys_##sname(void);					\
+	long __s390_sys_##sname(struct pt_regs *__unused);		\
 	ALLOW_ERROR_INJECTION(__s390_sys_##sname, ERRNO);		\
-	long __s390x_sys_##sname(void);					\
+	long __s390x_sys_##sname(struct pt_regs *__unused);		\
 	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
 	static inline long __do_sys_##sname(void);			\
-	long __s390_sys_##sname(void)					\
+	long __s390_sys_##sname(struct pt_regs *__unused)		\
 	{								\
 		return __do_sys_##sname();				\
 	}								\
-	long __s390x_sys_##sname(void)					\
+	long __s390x_sys_##sname(struct pt_regs *__unused)		\
 	{								\
 		return __do_sys_##sname();				\
 	}								\
@@ -104,10 +104,10 @@
 
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	long __s390x_sys_##sname(void);					\
+	long __s390x_sys_##sname(struct pt_regs *__unused);		\
 	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
 	static inline long __do_sys_##sname(void);			\
-	long __s390x_sys_##sname(void)					\
+	long __s390x_sys_##sname(struct pt_regs *__unused)		\
 	{								\
 		return __do_sys_##sname();				\
 	}								\
-- 
2.48.1

