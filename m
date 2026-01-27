Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5D35FF40;
	Tue, 27 Jan 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527204; cv=none; b=AgsXRFbf4S4nwGhOPJCLVCWZXcxuJ4D8vtanrb0KugY3EDqyH1DAsI7cxCrBG71IsZ66tXJafRXV03Eu7OM0S0DZf7IQydDlNryNfxTefc1Zf61kx7bDTRoSLX7PVI5NQ56LQAuqSrLHwjaDDBFueOOssvmUIVuOB6jnYxnq8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527204; c=relaxed/simple;
	bh=rOcR+5F/C3Nq8e90YbOxlbMijoGlvSAnkfOY289Jreo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9CyFrSPJE94/MKZrpaafO8abn4PJeTAlVIfR+k6XJJCXPt3M3yyECO6RlbESHlKJahDFqUlWGQ5KjzFu887Bf8SNJkF49b0BVcpcvzbpaeZQzOA+iIUQolsvNfE0HT4u8R9DRC2k4dtMKO9X7/Xev1zC0NVjcAR6H5CzRJ/Ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nBc0Gw8v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nBc0Gw8v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7HbWs014420;
	Tue, 27 Jan 2026 15:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QIzG3yERWAD0X6BiE
	CosJMQQHT3hd/5vCOzAO3f76gI=; b=nBc0Gw8vAlJ1QibcDWBzTPCMxoFMlZJnc
	EZldc8qlM06wayxuknypttfW6rr2nfwyt29pVWiB4H8SKMQLUwdfpKnriSS3X6Zz
	uADQUx+nKegv54fD/6KTvzDEcVd3buXmdb6MOl2hHm5nKLI3dy2US8/wXIvA07tQ
	X4E1bFhX5l/8SLuOG0kiBAkqoLdoBh3u0H21d3DPr263GAupnuLMOD43hA4MgEkA
	nYReUFdDEx8nVfScbNG4f9Q5jPQU4bPBtLJl4NmcYsyl27YwwEigerhzeNqVRtmU
	sZyFk9KMrGgTeiHw6dVGF+nc1JQ7tWqtDQ4E8IbueHRvHWIOTEJFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFJber008249;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE3Pmn019666;
	Tue, 27 Jan 2026 15:19:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn153y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJWOG61866368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E32C20043;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A5A42004B;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
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
Subject: [PATCH v4 03/12] s390/vdso: Keep function symbols in vDSO
Date: Tue, 27 Jan 2026 16:19:16 +0100
Message-ID: <20260127151926.2805123-4-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: TOYoFOrvGBo3XdukcZDhpQGLAq2TyU_B
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978d78a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=jnAA27LldM3NCp0g0JkA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 4puAM-DtEJJ45pjh5iMT5mNi_AO2fhtR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX5KKO9kgPsI5c
 uYa3XNUhw2ynyRt8TgveCWbQXdfcaDKTtkeexwdG+TwTcnOy5tNP12F9nktkVxb+guzFHpxesik
 rpfO11Vp/ZjnMHVl0vFd39GCeX5sZJUw0eqCDfsmxHSRxDcrUNnnJJs9X6jak3Fr0xH60Y4cqj4
 CWjTskvlmDmOAK1V035XdgQ9UU2E5lRVZEUo9WbqKsA5NdfbLaNjMNjh+1u5q3SH6O5Opow6Juk
 ni5fEwpIanz8KSJ43nrUWb42nQrOwEpnwbw58doPvSvlfXqJHUTdh/QaSzwtyq5MW0bY79Dofan
 eibkawwNWUORaaStNEiSOWO/MoVUPYf9SjpoCKoXvEghKIFHurGPeS3NOcKDIvaEz9BrFCzVSXf
 IA93X5MdJiNx51Pae7x9J4O8Br7JJhY7/REoc+E7lMR1nV49hGIWTzC/wyx4owq+XUs9CoOx8su
 1a+o2EoHciMdXBJ3VtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

Keep all function symbols in the vDSO .symtab for stack trace purposes.
This enables a stack tracer, such as perf, to lookup these function
symbols in addition to those already exported in vDSO .dynsym.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Use objcopy flag "-g" instead of "-S" with the cumbersome filter
      "-w -K "__arch_*" -K "__cvdso_*" -K "__s390_vdso_*" to keep the
      function symbols, as Josh did in "x86/vdso: Enable sframe
      generation in VDSO":
      https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/
    - Reword commit message.
    
    Note that unlike Josh I did not squash this into the subsequent patch
    "s390/vdso: Enable SFrame generation in vDSO", as this change is
    unrelated to enabling the use of SFrame.  perf report/script do also
    benefit from this change when using perf record --call-graph dwarf.
    
    Note that this change does not cause the vDSO build-id to change.
    perf record may therefore not dump an updated copy of the vDSO to
    ~/.debug/[vdso]/<build-id>/vdso, so that perf report/script may
    use a stale copy without .symtab.  Resolve by deleting ~/.debug/.

 arch/s390/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index 2fa12d4ac106..3a8bde5716f4 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -50,7 +50,7 @@ $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(obj-cvdso) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
-$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: OBJCOPYFLAGS := -g
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-- 
2.51.0

