Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030A2F49EC;
	Thu, 13 Nov 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046484; cv=none; b=G9136sQW+PeQFJKk7nMV9KkbbcpCs5mnlIfkJ49Gi9LuKBOdeoTJfAn5bOK5+LCruMwJivgk48BAOuGM+KKQ3ODxzT0n04iqGrWkVKVSrFYSa8oP3N1SlcgtORnNE98roMep+x8c1ezW/fUrI2MHKvZLYHaPXul7Bm/Sj5wD5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046484; c=relaxed/simple;
	bh=HU+/8S22KGEQXl6s5SisIzNo3tRB59olHyGCBrFWZO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWnVfBt7qvrvNcKHA9GWEtcpMSIMKMgswTkrK6s6Ea0h/b1sLYNK6petiLIDnNQXc/LMwtQWpytHRtIf5iW0N29w8E1KLbxAByPKdXkOiZlZLsxsmirKngNfIVKX3bx0wHGlEirvjGEVMUL2877xTRSTraXLs+mE0b6Zh7Q17/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bJyqRrBr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bJyqRrBr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD53S7P007136;
	Thu, 13 Nov 2025 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=djGPZVdmxeCXzwKny
	TboFO3KXicwD+P7YDurUTjoaAQ=; b=bJyqRrBrfOpFE+YXxjrFO5m6BEGdRRziu
	zewJysRgYavWOtHmMGUuecM3p3qMybhPTGG9+wUDnaPka2sSGD/PYI4oVNkeMYEd
	UsmRvpvmhb7NW3OshBWbZJSO8UxUgddMz5R5u8IAx46NaWD3C1TLzXqUM+4bnJuZ
	Vxmjsfom7oTzf4X4rUw0HrT+X5cDSczKfujwXZ7QsW5yim8qmh4/vnfuNiqTn2j/
	yI8cHXTbVouQnIpHnRejKLGFfHWIfVEu43UpxNsKTyeftYwiJLMH87VdttCHdIi2
	bOIbTHuCOrr4kBw5ypqLHR4xpKMeJBnYroOn9DgNkxpn9kku5ZEjQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx6xh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADDRTfc008239;
	Thu, 13 Nov 2025 15:07:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n6dw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7WKm18415980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 160C220040;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0B920043;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/8] s390/syscalls: Add pt_regs parameter to SYSCALL_DEFINE0() syscall wrapper
Date: Thu, 13 Nov 2025 16:07:25 +0100
Message-ID: <20251113150731.2697279-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113150731.2697279-1-hca@linux.ibm.com>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jpomK04ugSPxU2roHLU2x5bKZB0QgOzW
X-Proofpoint-ORIG-GUID: jpomK04ugSPxU2roHLU2x5bKZB0QgOzW
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=6915f438 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=94QMi1Fs8O4gAvJbfwkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX7Jfm+9C3bAba
 zkyh9pdAt7C91GWK0HSpVswnw8PxeeDxZXXQJ16glH+VLfbxvuJektdi+hy6FB7B50rC6vVoQpU
 PxRehV+EBiSGpRZcSS3wt6xg7NyUZsYpYs9cSLWUiKs1Bs9zUuNArkUr0Tpu3FPsNbGSIeOt3Qv
 QFdxGWLAPxTHx3UKh2IdY9wxxBXlbtBB0xHijid3u1nVWVo/FC8nN6yQz2xpr4TjFlyFCS7OFxk
 D+IWyxDtibSYanPTLzCZB6nWaq+B9VK3YIkXqelrC20UXxChlZoMYEn5thVs+8RXsEnJRPtYgQI
 Zsj9xsveZ4UiPdS/azrliLGrZ15QYiPFqojvsz6PUHEYo2rvz8StItqHHFnL3vwtQxUnEAI/zcj
 y/rXJ9mDSr03/Kqzif8wT0l1KVA44w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
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

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

