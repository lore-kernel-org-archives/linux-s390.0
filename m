Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7182F2E
	for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816498; cv=none; b=cZUEHT65pPH3h6+wNRKxcQMl1m0Bo4oIZcvVD5GXjUCxnUa76MxuFK49khQeDRYu5owHNY/HVRtleHyQAV8NuD5ASBkGwovzTXvShXS+N28yiUSpJzYgt37I7KwtDmH2DhtU+TKlHMxocx4fSk8gtYyOvl5CqGSt48thHWQh4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816498; c=relaxed/simple;
	bh=lWpGkuJhT4zANDJJv1k9X1BgdY9xfZpJScoeTXcc7Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfSbR4yXbSL2Ex1O3LvxcFg2JCyb+sh91M1YZhtYDXf6g98RgWE9Xzl17N30RIH/iYz6HAHWIPND7nnmr5EYA27y2dRJeKj+QPrJnneslBiZVuORBJf9ls9ngmYxlYzOpEy/Y4YsQKb4feAVPw1wk/Tm0hPuCNYoUDXKI/3AkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nsQWIDpy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nsQWIDpy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JGU1tA027830;
	Wed, 19 Jun 2024 17:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=3+fcjI1bwEzAwswNsU0tzLNFIby
	LRCXzAdhyFm5GUyg=; b=nsQWIDpyJDNeRGycQWI50ZL7FI3EPnR3zToz+4MS/Xg
	Oc7O44aaJvexz8lIbaNXi3CenN7vBC9sCtozQrSf0oFTBDsuXwjpjoGaXxGkm1rJ
	XsPjFTdEbEY+qKi6/oc1A/w+ec0DLjzqFh+zozPHFOPFs17HalVxjSqYCJSnDRd+
	Sir+wLQcX8kmPZoU8r6FjsA7YFW9Kg9tAbafvga1hgR0LUnI2C/oZXVjxKW4jeim
	CtHDHj9nluU7X++aGZ4b1394dXaDEAbCWwtIth5aWlK6vbDY5iHfGrv0uVT7Xb/I
	4D7HA9n6j0gc0Xh9YENNtquz3lNpHfhkfpQQHP/i40Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv2w50251-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:01:29 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JH1T1X011027;
	Wed, 19 Jun 2024 17:01:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv2w5024y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:01:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JGPB5P009921;
	Wed, 19 Jun 2024 17:01:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgmx879-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:01:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JH1MZV20644542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 17:01:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FFE02004D;
	Wed, 19 Jun 2024 17:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E183520040;
	Wed, 19 Jun 2024 17:01:21 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.58.152])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Jun 2024 17:01:21 +0000 (GMT)
Date: Wed, 19 Jun 2024 19:01:20 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
        gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
Message-ID: <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <ZnHv/HmiYHoQRkUU@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnHv/HmiYHoQRkUU@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ydlArOymgCiWBcYrJc0SeY9h8EHxXeD
X-Proofpoint-ORIG-GUID: CCyZu4tz8LyEiIdFGZHQGbPtitGgzZXP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190127

On Tue, Jun 18, 2024 at 04:37:16PM -0400, Joe Lawrence wrote:
> On Mon, Feb 19, 2024 at 02:27:30PM +0100, Sumanth Korikkar wrote:
> > Hi All,
> > 
> > This is a rebased version of Josh's patch series with a few fixups.
> > https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390
> > 
> > This introduces the capability to compile the s390 relocatable kernel
> > with and without the -fPIE option.
> > 
> > When utilizing the kpatch functionality, it is advisable to compile the
> > kernel without the -fPIE option. This is particularly important if the
> > kernel is built with the -ffunction-sections and -fdata-sections flags.
> > The linker imposes a restriction on the number of sections (limited to
> > 64k), necessitating the omission of -fPIE.
> > 
> > [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
> > [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
> > 
> > Gcc recently implemented an optimization [1] for loading symbols without
> > explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
> > symbols to reside on a 2-byte boundary, enabling the use of the larl
> > instruction. However, kernel linker scripts may still generate unaligned
> > symbols. To address this, a new -munaligned-symbols option has been
> > introduced [2] in recent gcc versions. This option has to be used with
> > future gcc versions.
> > 
> > Older Clang lacks support for handling unaligned symbols generated
> > by kernel linker scripts when the kernel is built without -fPIE. However,
> > future versions of Clang will include support for the -munaligned-symbols
> > option. When the support is unavailable, compile the kernel with -fPIE
> > to maintain the existing behavior.
> > 
> > Patch 1 filters out -munaligned-symbol flag for vdso code. This is beneficial
> > when compiling kernel with -fno-PIE and -munaligned-symbols combination.
> > 
> > Patch 2 introduces the 'relocs' tool, which reads the vmlinux file and
> > generates a vmlinux.relocs_64 section, containing offsets for all
> > R_390_64 relocations.
> > 
> > Patch 3 enables the compilation of a relocatable kernel with or without
> > the -fPIE option. It  allows for building the relocatable kernel without
> > -fPIE.  However, if compiler cannot handle unaligned symbols, the kernel
> > is built with -fPIE.
> > 
> > Patch 4 handles orphan .rela sections when kernel is built with
> > -fno-PIE.
> > 
> > kpatch tools changes:
> > * -mno-pic-data-is-text-relative prevents relative addressing between
> >   code and data. This is needed to avoid relocation error when klp text
> >   and data are too far apart. kpatch already includes this flag.
> >   However, with these changes, ARCH_KFLAGS+="-fPIC" should be added to
> >   s390 kpatch tools, As -mno-pic-data-is-text-relative can be used only
> >   with -fPIC. The corresponding pull request will be sent to kpatch
> >   tools.
> 
> Hi Sumanth,
> 
> I noticed interesting compiler differences when adding -fPIC build
> option and not.  The difference in resulting output can confuse
> kpatch-build when it tries to verify that its reference build (with the
> mentioned options, plus --ffunction-sections and -fdata-sections),
> doesn't line up closely enough with the original vmlinux source (sans
> all these options).

Hi Joe,

kpatch for s390 already uses extra compiler flag -mno-pic-data-is-text-relative
inorder to prevent relative addressing between code and data. Also,
includes -ffunction-sections and -fdata-sections along with it to identify
modified functions and its relocations.

Both the source code and modified code are built with the same
options during kpatch-build (-fPIC added to
-mno-pic-data-is-text-relative). kpatch-build was able to identify
modified functions and its associated relocations and include these
changes in the final kpatch module.

May be I am missing some info: Does this deviation cause confusion to kpatch?

Adding -fPIC flag would end up with extra indirections via GOT for
eg: when accessing global vars. But, this is similar in case of previous
kpatch build as well (-fPIE + -mno-pic-data-is-text-relative).

Rela comparision which I performed on .rela.text.mmput:
1. with -fno-PIE kernel:
.rela.text.mmput:
0000000000000022  000001a800000014 R_390_PLT32DBL         0000000000000000 __cond_resched + 2
0000000000000040  0000017800000013 R_390_PC32DBL          0000000000000000 __s390_indirect_jump_r14 + 2
000000000000004a  000001a000000014 R_390_PLT32DBL         0000000000000000 uprobe_clear_state + 2
0000000000000054  000001a100000014 R_390_PLT32DBL         0000000000000000 exit_aio + 2
000000000000006c  000001a200000014 R_390_PLT32DBL         0000000000000000 exit_mmap + 2
000000000000009a  000001a300000014 R_390_PLT32DBL         0000000000000000 fput + 2
00000000000000b8  000001a400000013 R_390_PC32DBL          0000000000000000 mmlist_lock + 2  <<<
00000000000000cc  000001a500000014 R_390_PLT32DBL         0000000000000000 __list_del_entry_valid_or_report + 2
0000000000000100  000001a400000013 R_390_PC32DBL          0000000000000000 mmlist_lock + 4
000000000000011e  000001a600000014 R_390_PLT32DBL         0000000000000000 module_put + 2
0000000000000140  0000016f00000014 R_390_PLT32DBL         0000000000000000 __mmdrop + 2
000000000000014a  000001a700000014 R_390_PLT32DBL         0000000000000000 __ksm_exit + 2
0000000000000154  0000019700000014 R_390_PLT32DBL         0000000000000000 arch_spin_lock_wait + 2

2. With -fPIC flag added:
With Relocation section '.rela.text.mmput' at offset 0x84c80 contains 12 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000022  000001d500000014 R_390_PLT32DBL         0000000000000000 __cond_resched + 2
0000000000000040  0000017800000013 R_390_PC32DBL          0000000000000000 __s390_indirect_jump_r14 + 2
000000000000004a  000001d600000014 R_390_PLT32DBL         0000000000000000 uprobe_clear_state + 2
0000000000000054  000001d700000014 R_390_PLT32DBL         0000000000000000 exit_aio + 2
0000000000000070  000001d800000014 R_390_PLT32DBL         0000000000000000 exit_mmap + 2
000000000000007e  000001d300000014 R_390_PLT32DBL         0000000000000000 set_mm_exe_file + 2
0000000000000090  000001d90000001a R_390_GOTENT           0000000000000000 mmlist_lock + 2     <<< Difference GOTENT
00000000000000ac  000001da00000014 R_390_PLT32DBL         0000000000000000 __list_del_entry_valid_or_report + 2
00000000000000f8  000001db00000014 R_390_PLT32DBL         0000000000000000 module_put + 2
000000000000011a  0000016f00000014 R_390_PLT32DBL         0000000000000000 __mmdrop + 2
0000000000000124  000001dc00000014 R_390_PLT32DBL         0000000000000000 __ksm_exit + 2
0000000000000132  0000019500000014 R_390_PLT32DBL         0000000000000000 arch_spin_lock_wait + 2

3. built with -fPIE commit + -mno-pic-data-is-text-relative (Previous kpatch version):
Relocation section '.rela.text.__mmput' at offset 0x95bc8 contains 13 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
000000000000001c  000001c000000014 R_390_PLT32DBL         0000000000000000 uprobe_clear_state + 2 
0000000000000026  000001c100000014 R_390_PLT32DBL         0000000000000000 exit_aio + 2 
000000000000004c  000001c200000014 R_390_PLT32DBL         0000000000000000 exit_mmap + 2
0000000000000056  000001c300000014 R_390_PLT32DBL         0000000000000000 mm_put_huge_zero_page + 2
0000000000000084  000001c400000014 R_390_PLT32DBL         0000000000000000 fput + 2
000000000000009a  000001c50000001a R_390_GOTENT           0000000000000000 mmlist_lock + 2   <<<<
0000000000000106  000001c600000014 R_390_PLT32DBL         0000000000000000 module_put + 2
0000000000000124  0000019000000013 R_390_PC32DBL          0000000000000000 __s390_indirect_jump_r14 + 2
000000000000012e  000001c700000014 R_390_PLT32DBL         0000000000000000 __khugepaged_exit + 2
000000000000013c  000001c800000014 R_390_PLT32DBL         0000000000000000 __ksm_exit + 2 
000000000000014a  000001c900000014 R_390_PLT32DBL         0000000000000000 __list_del_entry_valid_or_report + 2
0000000000000158  000001a200000014 R_390_PLT32DBL         0000000000000000 arch_spin_lock_wait + 2
000000000000016c  0000018700000014 R_390_PLT32DBL         0000000000000000 __mmdrop + 2 


> 
> I don't think a kpatch-build PR was ever opened to add "-fPIC", but the
> compiler now warns that its required.  Have you ever seen optimization /
> build output changes when adding this option and if so, were there
> additional kpatch-build implications?

I missed adding "-fPIC" KCFLAGS in kpatch tool. I will send a PR request.

I expect and assume similar implications with (-fPIC added)
vs (-fPIE + -mno-pic-data-is-text-relative) build, as shown above in the rela
comparisions.

Other Note:
The latest kernel is built with -fPIC and linked with -no-pie (reference
commit: ca888b17da9b ("s390: Compile kernel with -fPIC and link with
-no-pie")) which also avoids generation of dynamic symbols and helps
kpatch usecases (when num of sections >=64k sections).  Also the build
options would be similar (-fPIC in kernel and -fPIC in kpatch-build)

For latest kernel, there is no need to add explicit -fPIC again
in kpatch tool.

But for the intermediate commits, yes, makes sense to add
it in kpatch-build tools and will create one PR.

> Here is a quick example that I stumbled on while investigating the
> kpatch-build shadow-newpid.patch integration test that modifies
> kernel/fork.c.  I couldn't reproduce with the s390 defconfig, but it
> shows up when building with RHEL-10 config.  Reproducer steps and
> disassembly examples follows.

Sorry Joe, I didnt get this question. "I couldnt reproduce with the s390
defconfig". Could you please clarify it ?

Thank you,
Sumanth
