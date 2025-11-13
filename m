Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741632F60A7;
	Thu, 13 Nov 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046487; cv=none; b=oX5mQ7yqdvfEizV/1+CLz9rMBKiW4gC34Kbu1kJGpbr9i1rmiiN2mKYJXSaB+p3YUIsATZIK9TQ+rJOmgJxq4XxAi+48vLx+RrLRkDSCGQI0MYO4Gnk5dZ2TvrfMqvh/W06BdENXtTl0jOq8okaKTjMQqjCaj4HTC2ZCfAby2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046487; c=relaxed/simple;
	bh=vz5dv3ftTX6v1bq67WW5xNCXji9BueveUNJ+pubEUlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POLAX8uIVnMdKz139D8NzCOyPhtiWFCB2zS1D4gVJF2xtzsP1LUt/bIY2XTnn8HwMHLF62H7xx3t0A3esD1Opfm94BJJIJ52CwjyqYvj7jmsOHcGguIIMZ52hSiEQc04s8nfg2DtLax6hl3TBJewWRlkB9RnDLNVsUypRNyAckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TiJbJlER; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TiJbJlER"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7fk9F006823;
	Thu, 13 Nov 2025 15:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oCj3VDVUCyCKpcVOZ
	+m69bknEU9MwLqeSxqZsvCw3Hg=; b=TiJbJlERR7mkkS6/bygAqkaK40c25ciLq
	Ivlh8vc0r4LOyMacC1R5zQGUAlyuCslwm/Zown8kNz9V9l50xH3xR1Nlo30lBaq9
	wHwuEVqQXcysTqUyEyW2cUyEQQreGf7l4SyHSgNFdBWUqRb4OxsrmWrkDOTfGHio
	LiQy4LMPaFd6ZSdH8aHZLu5Ex8oTVHKniMGW9Jpkyx/9oDqBRHidyPi1vvTOq+8K
	0NTDDf99gSj46GMQp+1OckTyU7heuvH/RkS2sqbnzcAqKmcqLD5eMxHS0X6CH6Vl
	dNJTmAATSi0Wxz8dkVPuR6c8W9ayW3AlQQQy6B7lXJElXLPtqVvcA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjfffb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCZjRl008218;
	Thu, 13 Nov 2025 15:07:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n6dw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7WTA19202312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D920020043;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A53842004B;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
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
Subject: [PATCH 6/8] s390/uapi: Remove 31 bit support from uapi header files
Date: Thu, 13 Nov 2025 16:07:28 +0100
Message-ID: <20251113150731.2697279-7-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6915f43a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Ifr4xurfjaCKlH7Lw5MA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX/1CqrLerHMmW
 LhR4ELZ4jAYbdcFC8B5XXcTy3c+Btuq0Zlb7Y/Nsbme6s5l+d9VOYf+EXoE3Ffc+h35Pwwk/p1h
 Mk4/CBChb0LQ26Lt6wO6V8XVFixhHdCtuHaCfL7kYV/AKNSyIALH1zZJIT49txq4PqxN+9O7E63
 R/lkjkaEtWbDECzEP0cFW6GDMa9pK9QJXYOVbJ+mKBL4GLwsWhCi31WD1oPmaWLERtbkieg5fOv
 j0/fFcfzZC/PB3Xl9f4JBraLYx66z4A3CchEL7l25qXiVdWYnI17RnWm7LvRohFkeJgJGAIZ62B
 DPGFK8bz43ATQ9HQ4cyn0T5NsM2P1xnDvaeX+pC5swMa2VN/l32jHNi621NRLi3RddEfucZZlOB
 HkCnHpeYBMp3FyqCqmUbTK9TxboYHA==
X-Proofpoint-GUID: N_WA2rD0-vIhFfN3ZEKshswJI1H14SRg
X-Proofpoint-ORIG-GUID: N_WA2rD0-vIhFfN3ZEKshswJI1H14SRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

Since the kernel does not support running 31 bit / compat binaries
anymore, remove also the corresponding 31 bit support from uapi header
files.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/uapi/asm/bitsperlong.h |   4 -
 arch/s390/include/uapi/asm/ipcbuf.h      |   3 -
 arch/s390/include/uapi/asm/posix_types.h |  13 ---
 arch/s390/include/uapi/asm/ptrace.h      | 124 -----------------------
 arch/s390/include/uapi/asm/sigcontext.h  |  15 ---
 arch/s390/include/uapi/asm/stat.h        |  70 -------------
 arch/s390/include/uapi/asm/unistd.h      |   4 -
 7 files changed, 233 deletions(-)

diff --git a/arch/s390/include/uapi/asm/bitsperlong.h b/arch/s390/include/uapi/asm/bitsperlong.h
index cceaf47b021a..7af27a985f25 100644
--- a/arch/s390/include/uapi/asm/bitsperlong.h
+++ b/arch/s390/include/uapi/asm/bitsperlong.h
@@ -2,11 +2,7 @@
 #ifndef __ASM_S390_BITSPERLONG_H
 #define __ASM_S390_BITSPERLONG_H
 
-#ifndef __s390x__
-#define __BITS_PER_LONG 32
-#else
 #define __BITS_PER_LONG 64
-#endif
 
 #include <asm-generic/bitsperlong.h>
 
diff --git a/arch/s390/include/uapi/asm/ipcbuf.h b/arch/s390/include/uapi/asm/ipcbuf.h
index 1030cd186899..9277e76d6d72 100644
--- a/arch/s390/include/uapi/asm/ipcbuf.h
+++ b/arch/s390/include/uapi/asm/ipcbuf.h
@@ -24,9 +24,6 @@ struct ipc64_perm
 	__kernel_mode_t		mode;
 	unsigned short		__pad1;
 	unsigned short		seq;
-#ifndef __s390x__
-	unsigned short		__pad2;
-#endif /* ! __s390x__ */
 	unsigned long		__unused1;
 	unsigned long		__unused2;
 };
diff --git a/arch/s390/include/uapi/asm/posix_types.h b/arch/s390/include/uapi/asm/posix_types.h
index 1913613e71b6..ad5ab940d192 100644
--- a/arch/s390/include/uapi/asm/posix_types.h
+++ b/arch/s390/include/uapi/asm/posix_types.h
@@ -26,17 +26,6 @@ typedef unsigned short __kernel_old_gid_t;
 #define __kernel_old_uid_t __kernel_old_uid_t
 #endif
 
-#ifndef __s390x__
-
-typedef unsigned long   __kernel_ino_t;
-typedef unsigned short  __kernel_mode_t;
-typedef unsigned short  __kernel_ipc_pid_t;
-typedef unsigned short  __kernel_uid_t;
-typedef unsigned short  __kernel_gid_t;
-typedef int             __kernel_ptrdiff_t;
-
-#else /* __s390x__ */
-
 typedef unsigned int    __kernel_ino_t;
 typedef unsigned int    __kernel_mode_t;
 typedef int             __kernel_ipc_pid_t;
@@ -45,8 +34,6 @@ typedef unsigned int    __kernel_gid_t;
 typedef long            __kernel_ptrdiff_t;
 typedef unsigned long   __kernel_sigset_t;      /* at least 32 bits */
 
-#endif /* __s390x__ */
-
 #define __kernel_ino_t  __kernel_ino_t
 #define __kernel_mode_t __kernel_mode_t
 #define __kernel_ipc_pid_t __kernel_ipc_pid_t
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index ea202072f1ad..ea29ba470e5a 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -14,94 +14,6 @@
  * Offsets in the user_regs_struct. They are used for the ptrace
  * system call and in entry.S
  */
-#ifndef __s390x__
-
-#define PT_PSWMASK  0x00
-#define PT_PSWADDR  0x04
-#define PT_GPR0     0x08
-#define PT_GPR1     0x0C
-#define PT_GPR2     0x10
-#define PT_GPR3     0x14
-#define PT_GPR4     0x18
-#define PT_GPR5     0x1C
-#define PT_GPR6     0x20
-#define PT_GPR7     0x24
-#define PT_GPR8     0x28
-#define PT_GPR9     0x2C
-#define PT_GPR10    0x30
-#define PT_GPR11    0x34
-#define PT_GPR12    0x38
-#define PT_GPR13    0x3C
-#define PT_GPR14    0x40
-#define PT_GPR15    0x44
-#define PT_ACR0     0x48
-#define PT_ACR1     0x4C
-#define PT_ACR2     0x50
-#define PT_ACR3     0x54
-#define PT_ACR4	    0x58
-#define PT_ACR5	    0x5C
-#define PT_ACR6	    0x60
-#define PT_ACR7	    0x64
-#define PT_ACR8	    0x68
-#define PT_ACR9	    0x6C
-#define PT_ACR10    0x70
-#define PT_ACR11    0x74
-#define PT_ACR12    0x78
-#define PT_ACR13    0x7C
-#define PT_ACR14    0x80
-#define PT_ACR15    0x84
-#define PT_ORIGGPR2 0x88
-#define PT_FPC	    0x90
-/*
- * A nasty fact of life that the ptrace api
- * only supports passing of longs.
- */
-#define PT_FPR0_HI  0x98
-#define PT_FPR0_LO  0x9C
-#define PT_FPR1_HI  0xA0
-#define PT_FPR1_LO  0xA4
-#define PT_FPR2_HI  0xA8
-#define PT_FPR2_LO  0xAC
-#define PT_FPR3_HI  0xB0
-#define PT_FPR3_LO  0xB4
-#define PT_FPR4_HI  0xB8
-#define PT_FPR4_LO  0xBC
-#define PT_FPR5_HI  0xC0
-#define PT_FPR5_LO  0xC4
-#define PT_FPR6_HI  0xC8
-#define PT_FPR6_LO  0xCC
-#define PT_FPR7_HI  0xD0
-#define PT_FPR7_LO  0xD4
-#define PT_FPR8_HI  0xD8
-#define PT_FPR8_LO  0XDC
-#define PT_FPR9_HI  0xE0
-#define PT_FPR9_LO  0xE4
-#define PT_FPR10_HI 0xE8
-#define PT_FPR10_LO 0xEC
-#define PT_FPR11_HI 0xF0
-#define PT_FPR11_LO 0xF4
-#define PT_FPR12_HI 0xF8
-#define PT_FPR12_LO 0xFC
-#define PT_FPR13_HI 0x100
-#define PT_FPR13_LO 0x104
-#define PT_FPR14_HI 0x108
-#define PT_FPR14_LO 0x10C
-#define PT_FPR15_HI 0x110
-#define PT_FPR15_LO 0x114
-#define PT_CR_9	    0x118
-#define PT_CR_10    0x11C
-#define PT_CR_11    0x120
-#define PT_IEEE_IP  0x13C
-#define PT_LASTOFF  PT_IEEE_IP
-#define PT_ENDREGS  0x140-1
-
-#define GPR_SIZE	4
-#define CR_SIZE		4
-
-#define STACK_FRAME_OVERHEAD	96	/* size of minimum stack frame */
-
-#else /* __s390x__ */
-
 #define PT_PSWMASK  0x00
 #define PT_PSWADDR  0x08
 #define PT_GPR0     0x10
@@ -166,38 +78,6 @@
 
 #define STACK_FRAME_OVERHEAD	160	 /* size of minimum stack frame */
 
-#endif /* __s390x__ */
-
-#ifndef __s390x__
-
-#define PSW_MASK_PER		_AC(0x40000000, UL)
-#define PSW_MASK_DAT		_AC(0x04000000, UL)
-#define PSW_MASK_IO		_AC(0x02000000, UL)
-#define PSW_MASK_EXT		_AC(0x01000000, UL)
-#define PSW_MASK_KEY		_AC(0x00F00000, UL)
-#define PSW_MASK_BASE		_AC(0x00080000, UL)	/* always one */
-#define PSW_MASK_MCHECK		_AC(0x00040000, UL)
-#define PSW_MASK_WAIT		_AC(0x00020000, UL)
-#define PSW_MASK_PSTATE		_AC(0x00010000, UL)
-#define PSW_MASK_ASC		_AC(0x0000C000, UL)
-#define PSW_MASK_CC		_AC(0x00003000, UL)
-#define PSW_MASK_PM		_AC(0x00000F00, UL)
-#define PSW_MASK_RI		_AC(0x00000000, UL)
-#define PSW_MASK_EA		_AC(0x00000000, UL)
-#define PSW_MASK_BA		_AC(0x00000000, UL)
-
-#define PSW_MASK_USER		_AC(0x0000FF00, UL)
-
-#define PSW_ADDR_AMODE		_AC(0x80000000, UL)
-#define PSW_ADDR_INSN		_AC(0x7FFFFFFF, UL)
-
-#define PSW_ASC_PRIMARY		_AC(0x00000000, UL)
-#define PSW_ASC_ACCREG		_AC(0x00004000, UL)
-#define PSW_ASC_SECONDARY	_AC(0x00008000, UL)
-#define PSW_ASC_HOME		_AC(0x0000C000, UL)
-
-#else /* __s390x__ */
-
 #define PSW_MASK_PER		_AC(0x4000000000000000, UL)
 #define PSW_MASK_DAT		_AC(0x0400000000000000, UL)
 #define PSW_MASK_IO		_AC(0x0200000000000000, UL)
@@ -224,8 +104,6 @@
 #define PSW_ASC_SECONDARY	_AC(0x0000800000000000, UL)
 #define PSW_ASC_HOME		_AC(0x0000C00000000000, UL)
 
-#endif /* __s390x__ */
-
 #define NUM_GPRS	16
 #define NUM_FPRS	16
 #define NUM_CRS		16
@@ -308,9 +186,7 @@ typedef struct {
 #define PER_EM_MASK 0xE8000000UL
 
 typedef struct {
-#ifdef __s390x__
 	unsigned		       : 32;
-#endif /* __s390x__ */
 	unsigned em_branching	       : 1;
 	unsigned em_instruction_fetch  : 1;
 	/*
diff --git a/arch/s390/include/uapi/asm/sigcontext.h b/arch/s390/include/uapi/asm/sigcontext.h
index 8b35033334c4..7c90b30c50fd 100644
--- a/arch/s390/include/uapi/asm/sigcontext.h
+++ b/arch/s390/include/uapi/asm/sigcontext.h
@@ -17,24 +17,12 @@
 #define __NUM_VXRS_LOW		16
 #define __NUM_VXRS_HIGH		16
 
-#ifndef __s390x__
-
-/* Has to be at least _NSIG_WORDS from asm/signal.h */
-#define _SIGCONTEXT_NSIG	64
-#define _SIGCONTEXT_NSIG_BPW	32
-/* Size of stack frame allocated when calling signal handler. */
-#define __SIGNAL_FRAMESIZE	96
-
-#else /* __s390x__ */
-
 /* Has to be at least _NSIG_WORDS from asm/signal.h */
 #define _SIGCONTEXT_NSIG	64
 #define _SIGCONTEXT_NSIG_BPW	64 
 /* Size of stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	160
 
-#endif /* __s390x__ */
-
 #define _SIGCONTEXT_NSIG_WORDS	(_SIGCONTEXT_NSIG / _SIGCONTEXT_NSIG_BPW)
 #define _SIGMASK_COPY_SIZE	(sizeof(unsigned long)*_SIGCONTEXT_NSIG_WORDS)
 
@@ -66,9 +54,6 @@ typedef struct
 
 typedef struct
 {
-#ifndef __s390x__
-	unsigned long gprs_high[__NUM_GPRS];
-#endif
 	unsigned long long vxrs_low[__NUM_VXRS_LOW];
 	__vector128 vxrs_high[__NUM_VXRS_HIGH];
 	unsigned char __reserved[128];
diff --git a/arch/s390/include/uapi/asm/stat.h b/arch/s390/include/uapi/asm/stat.h
index ac253d23606b..21599298c2f5 100644
--- a/arch/s390/include/uapi/asm/stat.h
+++ b/arch/s390/include/uapi/asm/stat.h
@@ -8,74 +8,6 @@
 #ifndef _S390_STAT_H
 #define _S390_STAT_H
 
-#ifndef __s390x__
-struct __old_kernel_stat {
-        unsigned short st_dev;
-        unsigned short st_ino;
-        unsigned short st_mode;
-        unsigned short st_nlink;
-        unsigned short st_uid;
-        unsigned short st_gid;
-        unsigned short st_rdev;
-        unsigned long  st_size;
-        unsigned long  st_atime;
-        unsigned long  st_mtime;
-        unsigned long  st_ctime;
-};
-
-struct stat {
-        unsigned short st_dev;
-        unsigned short __pad1;
-        unsigned long  st_ino;
-        unsigned short st_mode;
-        unsigned short st_nlink;
-        unsigned short st_uid;
-        unsigned short st_gid;
-        unsigned short st_rdev;
-        unsigned short __pad2;
-        unsigned long  st_size;
-        unsigned long  st_blksize;
-        unsigned long  st_blocks;
-        unsigned long  st_atime;
-        unsigned long  st_atime_nsec;
-        unsigned long  st_mtime;
-        unsigned long  st_mtime_nsec;
-        unsigned long  st_ctime;
-        unsigned long  st_ctime_nsec;
-        unsigned long  __unused4;
-        unsigned long  __unused5;
-};
-
-/* This matches struct stat64 in glibc2.1, hence the absolutely
- * insane amounts of padding around dev_t's.
- */
-struct stat64 {
-        unsigned long long	st_dev;
-        unsigned int    __pad1;
-#define STAT64_HAS_BROKEN_ST_INO        1
-        unsigned long   __st_ino;
-        unsigned int    st_mode;
-        unsigned int    st_nlink;
-        unsigned long   st_uid;
-        unsigned long   st_gid;
-        unsigned long long	st_rdev;
-        unsigned int    __pad3;
-        long long	st_size;
-        unsigned long   st_blksize;
-        unsigned char   __pad4[4];
-        unsigned long   __pad5;     /* future possible st_blocks high bits */
-        unsigned long   st_blocks;  /* Number 512-byte blocks allocated. */
-        unsigned long   st_atime;
-        unsigned long   st_atime_nsec;
-        unsigned long   st_mtime;
-        unsigned long   st_mtime_nsec;
-        unsigned long   st_ctime;
-        unsigned long   st_ctime_nsec;  /* will be high 32 bits of ctime someday */
-        unsigned long long	st_ino;
-};
-
-#else /* __s390x__ */
-
 struct stat {
         unsigned long  st_dev;
         unsigned long  st_ino;
@@ -97,8 +29,6 @@ struct stat {
         unsigned long  __unused[3];
 };
 
-#endif /* __s390x__ */
-
 #define STAT_HAVE_NSEC 1
 
 #endif
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index 01b5fe8b9db6..b0c5afe19db2 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -8,10 +8,6 @@
 #ifndef _UAPI_ASM_S390_UNISTD_H_
 #define _UAPI_ASM_S390_UNISTD_H_
 
-#ifdef __s390x__
 #include <asm/unistd_64.h>
-#else
-#include <asm/unistd_32.h>
-#endif
 
 #endif /* _UAPI_ASM_S390_UNISTD_H_ */
-- 
2.48.1

