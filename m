Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188E26B099;
	Thu, 13 Feb 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459405; cv=none; b=KY5o4T/KvbM1p/hA3t7i+zN4IffpWeBzS57tBaCu0qkiFP8gGce7Aeq6WXiwX27FkRnf4gA7pNNoJiEnK7w1BKW2Yq9058SqSSEKAToFN8/y567p7K2f7JpDgQCcegGUrd6y/bCLIM7z4gyj19viYMq//fJvPI4NUVDgI+5F1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459405; c=relaxed/simple;
	bh=oNWaztRC9HOHQeQo0SIxqA8XfmleriZq7neNIntuQaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttNsFBQ2jz7bPEMFevaza++vzMI8XMCwYv2pdHNGRaDF5TG1SiRXwEBlM3evOOYvwehVVHyiePJidIY6t2YY6ZzjBylcA31FXclu4rqEfHM12M6KSUKKmByq5sHlP/SMX6k/BiBr+HxFMhtQKawrAJ7T7+/wj1RR83/HhU26bT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XeZ0X3gn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XeZ0X3gn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DD9qPa001101;
	Thu, 13 Feb 2025 15:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Nx35n43omz2S0j8VNoQwyCAaNPUmYf
	sQNdk9Bkd5gKY=; b=XeZ0X3gn2QPulkRaUnJnBrZkQCpid10B09iYKl/e0gO/kT
	//uKE5UAuTKSEP6MpOZ0JdUGipgK1ZUvEMuvWebRA/T+txqkwpRpgd3e/mERuzOV
	sTH4tx95ucF8RRUBdSHmZBzFILZmimHORQY4r5e0s5ywFtpubF3j6E7p2899L44t
	gJp0lXNmSQyzZDSgGMmYNUgRsjJmg+TY2iqbi0hP53UsYLmRgHBgKlDwiRE93loC
	MVTpmfmpL6YTYxFoNtCmnQZBwe5O87KEryJgTjYj8XJb99HSZWdoMXYOldec0Ab/
	+GGu3zbsk1gom+joIynUxJ82kKE3zCJbLhV91Teg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44saj8jrrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 15:09:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DBb4oe000914;
	Thu, 13 Feb 2025 15:09:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknesrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 15:09:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DF9a3C33095958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:09:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD09E2004D;
	Thu, 13 Feb 2025 15:09:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A95542004B;
	Thu, 13 Feb 2025 15:09:36 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Feb 2025 15:09:36 +0000 (GMT)
Date: Thu, 13 Feb 2025 16:09:34 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc
 at boot for arm64
Message-ID: <20250213150934.12012-C-hca@linux.ibm.com>
References: <20250210142647.083ff456@gandalf.local.home>
 <20250213125302.12012-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213125302.12012-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S5kam7uZ1aI1nPU6jix8C8BRLexLvoRE
X-Proofpoint-ORIG-GUID: S5kam7uZ1aI1nPU6jix8C8BRLexLvoRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502130112

On Thu, Feb 13, 2025 at 01:53:02PM +0100, Heiko Carstens wrote:
> On Mon, Feb 10, 2025 at 02:26:47PM -0500, Steven Rostedt wrote:
> > For the s390 folks. I cross compiled a s390 and looked at the mcount_loc
> > section, and I have no idea how to implement this for that. I wrote a elf
> > parser to dump sections based symbols:
> > 
> >   https://rostedt.org/code/dump_elf_sym.c
> > 
> > And ran it on the s390 vmlinux:
> > 
> >  $ ./dump_elf_sym vmlinux __start_mcount_loc __stop_mcount_loc
> >  1801620: .. .. .. .. .. .. .. ..   00 00 00 00 00 11 70 20  ......... .....p 
> >  1801630: 00 00 00 00 00 11 70 90   00 00 00 00 00 11 70 a0  ......p.. .....p.
> >  1801640: 00 00 00 00 00 11 71 10   00 00 00 00 00 11 71 20  ......q.. .....q 
> >  1801650: 00 00 00 00 00 11 71 90   00 00 00 00 01 7c 70 00  ......q.. ....|p.
> >  1801660: 00 00 00 00 01 7c 70 20   00 00 00 00 01 7c 70 40  .....|p . ....|p@
> >  1801670: 00 00 00 00 01 7c 70 60   00 00 00 00 01 7c 70 70  .....|p`. ....|pp
> >  1801680: 00 00 00 00 01 7c 70 98   00 00 00 00 01 7c 70 c0  .....|p.. ....|p.
> >  1801690: 00 00 00 00 01 7c 70 d0   00 00 00 00 01 7c 71 68  .....|p.. ....|qh
> > [..]
> > 
> > It looks like addresses in that section...
> 
> Those are the addresses of the mcount locations. After looking at
> sorttable.c it really looks like that for s390 we can simply select
> HAVE_BUILDTIME_MCOUNT_SORT without any further changes.
> 
> I just tested it with different compiler options (fentry vs hotpatch),
> including selecting FTRACE_SORT_STARTUP_TEST, and as expected everything
> works.
> 
> I'm going to give it some more testing in our CI - but if nothing breaks a
> patch which selects HAVE_BUILDTIME_MCOUNT_SORT for s390 will go upstream
> with the next merge window.

Something like this:

From 0759d6b961946b7e5cfb19971d56f5493204301c Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 13 Feb 2025 13:57:33 +0100
Subject: [PATCH] s390: Sort mcount locations at build time

For s390 the mcount_loc section of the kernel image contains the addresses
of the mcount locations. All addresses will be adjusted with the same
offset by the decompressor before the kernel is started.

Therefore select HAVE_BUILDTIME_MCOUNT_SORT so that the entries of this
section are sorted at build time. Given that the same offset is applied to
all entries the section will be sorted in any case.

Note that this was not possible before commit 778666df60f0 ("s390: compile
relocatable kernel without -fPIE"). Since this commit all R_390_64 absolute
relocations are handled in a special way: only the address of the to be
changed location is put into a special section. For all those locations the
same offset is applied as described above.

Without that change it would have been necessary to also adjust the addend
of all relocations which correspond to the mcount_loc section, when sorting
the mcount_loc section.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/r/20250210142647.083ff456@gandalf.local.home/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                 | 1 +
 arch/s390/configs/debug_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9c9ec08d78c7..acaa1d1c12b2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -185,6 +185,7 @@ config S390
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index d6beec5292a0..a2b0444b7d6b 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -887,6 +887,7 @@ CONFIG_USER_EVENTS=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_FTRACE_STARTUP_TEST=y
 # CONFIG_EVENT_TRACE_STARTUP_TEST is not set
+CONFIG_FTRACE_SORT_STARTUP_TEST=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_SAMPLE_FTRACE_DIRECT=m
-- 
2.45.2
