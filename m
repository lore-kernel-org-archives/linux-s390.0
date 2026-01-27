Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BB35F8DC;
	Tue, 27 Jan 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527203; cv=none; b=ag6qjDQAjvGx/qJ0QE67YVWH2zfYaOhGusZm+bRhabB7yBDoJh63B69b+jZVVre82Z2Ned01hySuy9GVNfMRVfJUmXiMPZTlgPRYnlgfEVn+NvNDpDLXssPD8Fb9KjaVAJ7qh1PnlwTa0UO2DHDYWwG8FdROjz6EWfhErBkbLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527203; c=relaxed/simple;
	bh=n4UqXtWKP9aM7+of2a9zTKNpugsdsHjeuZZ9Y6vQt1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNpTACnt3jLKTdf3JLQL1+UnWLpX8n08paMoPYTEVcDvLgJFZbtUU1NNGqojx5HjHcq5V7PdWYWryufEsitnHk5ifiX9vI27RO1KSEMsyHmXiG3kJEu45iMvfSHDiFQnaClIswddg7B7uom6Zs3zg5r/L3GCXqVUNVgNqYL0HxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d9wYm5H1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d9wYm5H1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8JYWi021655;
	Tue, 27 Jan 2026 15:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YwkCBIDx+CdwD1PaP
	1iGkMwFtK6nggvYnNMUdWID+FY=; b=d9wYm5H1bnAJo4F6vo4IW5OyLc2T+n2XR
	6/SYNP55taYa5OBXkHAaWwXsci9/7jA04Z0bGhyogvMX6+TI361cmZKlmqxQeYHT
	qRongjx2vma9aVcPmx6kqKxzQzeGwyhAe9i/ShSzlf9J60UtPpLDxjB6kJFZQUNs
	mYdhlOQCUmIcqaGnA66oS+4mJAdlNaU4QNYcPy3erbupNuHbPmNP6iQbfDBAq1JC
	iykkiClHGu68AA1UKENGBHquOmGGYA/31QewyjCHfDfTvQCu7FmcpkZxyWwiQW6S
	el3IbRe3gbHDK5xHsTbqfsUFXT7Fqj1UN63i1S9lyO1f2W/9KL9qg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x5hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFFtfW006394;
	Tue, 27 Jan 2026 15:19:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x5he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REptfE017960;
	Tue, 27 Jan 2026 15:19:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41rvge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJWFD61866366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25DB920040;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0D3D20043;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v4 02/12] s390/vdso: Avoid emitting DWARF CFI for non-vDSO
Date: Tue, 27 Jan 2026 16:19:15 +0100
Message-ID: <20260127151926.2805123-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h_nc00dc0Tt1Wj7AikvB-Ktd9HCsR19H
X-Proofpoint-ORIG-GUID: bzr1sWWmmNhoHfzG0j-EJXNVzzOZJstn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX/AlT+89Tcx18
 BVzYUI9JvLp7ubq0wMfau7ye6qk5kfujksQjXfZ62SLH1DZGSRHzlGKq2pTzQLHqMZXMPQXyWdG
 WxGvWz7v9QuwibLseupLQ3WaTlDWmYfOpys6xSwJk/QTfIuNARABklgDmAHRk4wfE5nVCQSzCkb
 0LJfKUaP7WHGBVEk94DbLl6YjB7bSTrweKcUsP1uhbLdJJ2NiXQtr8LfEd45jivTTLMyI8fbYnZ
 KMu7nmTa//l8fXLbKhLko+SWLgFy6ch9/52IDx43nIx627n+37ATAeNtu16MLjRmp13lxb/zkS2
 TGD4biolxS+8dg10/uWFxxiRGq2TNSmqVA0fnlfIzp3ZVELqCSo5QQYDEQbRTdT/3S4w3x+Gnhj
 qxI3pzqmAO+7MftRMP9xebKN6H+krbo8ywnT+aax4/9zLSHQrECQ7jYRF7xW2bquakePb9xxv4r
 tuHvjMl903EjNhMgQYQ==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978d78a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=BeDKgDnIR9-QKG0Pbi4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

This replicates Josh's x86 commit TODO ("x86/asm: Avoid emitting DWARF
CFI for non-VDSO") for s390.  It also aligns asm/dwarf.h to x86
asm/dwarf2.h.

It was decided years ago that .cfi_* annotations aren't maintainable in
the kernel.  For the kernel proper, ensure the CFI_* macros don't do
anything.

On the other hand the vDSO library *does* use them, so user space can
unwind through it.

Make sure these macros only work for vDSO.  They aren't actually being
used outside of vDSO anyway, so there's no functional change.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Link to latest x86 patch:
    https://lore.kernel.org/all/20250425024022.477374378@goodmis.org/

 arch/s390/include/asm/dwarf.h | 45 ++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index df9f467910f7..6bcf37256feb 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -6,6 +6,18 @@
 #warning "asm/dwarf.h should be only included in pure assembly files"
 #endif
 
+.macro nocfi args:vararg
+.endm
+
+#ifdef BUILD_VDSO
+
+	/*
+	 * For the vDSO, emit both runtime unwind information and debug
+	 * symbols for the .dbg file.
+	 */
+
+	.cfi_sections .eh_frame, .debug_frame
+
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
 #define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
@@ -16,23 +28,24 @@
 #ifdef CONFIG_AS_CFI_VAL_OFFSET
 #define CFI_VAL_OFFSET		.cfi_val_offset
 #else
-#define CFI_VAL_OFFSET		#
+#define CFI_VAL_OFFSET		nocfi
 #endif
 
-#ifndef BUILD_VDSO
-	/*
-	 * Emit CFI data in .debug_frame sections and not in .eh_frame
-	 * sections.  The .eh_frame CFI is used for runtime unwind
-	 * information that is not being used.  Hence, vmlinux.lds.S
-	 * can discard the .eh_frame sections.
-	 */
-	.cfi_sections .debug_frame
-#else
-	/*
-	 * For vDSO, emit CFI data in both, .eh_frame and .debug_frame
-	 * sections.
-	 */
-	.cfi_sections .eh_frame, .debug_frame
-#endif
+#else /* !BUILD_VDSO */
+
+/*
+ * On s390, these macros aren't used outside vDSO.  As well they shouldn't be:
+ * they're fragile and very difficult to maintain.
+ */
+
+#define CFI_STARTPROC		nocfi
+#define CFI_ENDPROC		nocfi
+#define CFI_DEF_CFA_OFFSET	nocfi
+#define CFI_ADJUST_CFA_OFFSET	nocfi
+#define CFI_RESTORE		nocfi
+#define CFI_REL_OFFSET		nocfi
+#define CFI_VAL_OFFSET		nocfi
+
+#endif /* !BUILD_VDSO */
 
 #endif	/* _ASM_S390_DWARF_H */
-- 
2.51.0

