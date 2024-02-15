Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB812B8B
	for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994507; cv=none; b=qbalc0gbqXjSikeztOmsu8mPua7EZL6wyjwhoXoYVxr4U7eM2TFS8shfDrZao0tW0ELd3i+pcOoUs3fc6r1GxgKBC4L7OgJ0vLI7IeNtKRFkd/dF8USkRalZPcs5Hw3A3/3znKT+olrF7TIATmFTysyR9Pk5OfK60iNKQ0SKKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994507; c=relaxed/simple;
	bh=GnBOHlbJBUdBNlSUW2CKkMR/J2k3pLuDI57BYK4PXvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R4qxKsPViDhWeayn3z73hlSCDyxtaOJ/sOI0HiFSMaSM0qrGi1F4Im1XXfqeUfv40f5Uv8PUc0nkc5Nx1ucUkAmTi7H+oslNarftE/dhXJZaFjGuoPlNsYwATfBlz4uKWWsuePELbUGbNfKTEE2bNYNiT87NizBB5M2EVRibxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Am/0PO24; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Am/0PO24"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FAt2eb016261;
	Thu, 15 Feb 2024 10:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=BaA1iVk9oEaxt+5hk2szayVtJHCGIS7HU6caWUP7fNA=;
 b=Am/0PO24neyUyPSsKVpqOBB4eh0B+MXcy9C5QSgfC3jQyVAy/y/y9TPOD7FqN+/fdbVB
 Q4nve4pWaFry1/uiQtu1b5GvkJXe7eV7/CuTqUkYuKCEBlN0kqfA4s5FjxeU6/QJ6yHE
 zyZ46rZSoThYcrdpHDNtfru+gb6KTpCTo+PTV0j2kZnIkOh/zyoze6WVubFNFjZo4jGM
 NoI/ILNqLRi/za+vVTW0m3saoIjMREZNWkJtN5K7+GkAPoAEmL0pQGWBK4/9aihbf61n
 3s0clpxiwZukt6jK5OPvJYQ5z8JMonn+Oe0TLt/6GNR4iOKGft65WSXsKxJXp/6VRhrB bg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h12rfuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:55:02 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FAt2NI016250;
	Thu, 15 Feb 2024 10:55:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h12rfcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:55:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F8xKIA010045;
	Thu, 15 Feb 2024 10:51:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm3t08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:51:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FApVHu17891870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:51:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F3D2004B;
	Thu, 15 Feb 2024 10:51:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94CED20040;
	Thu, 15 Feb 2024 10:51:30 +0000 (GMT)
Received: from localhost (unknown [9.171.10.232])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 10:51:30 +0000 (GMT)
Date: Thu, 15 Feb 2024 11:51:29 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        hca@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH 3/4] s390: Compile relocatable kernel without -fPIE
Message-ID: <your-ad-here.call-01707994289-ext-2381@work.hours>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
 <20240213104707.673053-4-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213104707.673053-4-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1GZkyo2ilc7rhQfkzb3S4Ei68wyNEIjw
X-Proofpoint-ORIG-GUID: tW6dHRW6LqLFH9ijsXn5i2d6vKYfTOK-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150086

On Tue, Feb 13, 2024 at 11:47:06AM +0100, Sumanth Korikkar wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> On s390, currently kernel uses the '-fPIE' compiler flag for compiling
> vmlinux.  This has a few problems:
> 
>   - It uses dynamic symbols (.dynsym), for which the linker refuses to
>     allow more than 64k sections.  This can break features which use
>     '-ffunction-sections' and '-fdata-sections', including kpatch-build
>     [1] and Function Granular KASLR.
> 
>   - It unnecessarily uses GOT relocations, adding an extra layer of
>     indirection for many memory accesses.
> 
> Instead of using '-fPIE', resolve all the relocations at link time and
> then manually adjust any absolute relocations (R_390_64) during boot.
> 
> This is done by first telling the linker to preserve all relocations
> during the vmlinux link.  (Note this is harmless: they are later
> stripped in the vmlinux.bin link.)
> 
> Then use the 'relocs' tool to find all absolute relocations (R_390_64)
> which apply to allocatable sections.  The offsets of those relocations
> are saved in a special section which is then used to adjust the
> relocations during boot.
> 
> (Note: For some reason, Clang occasionally creates a GOT reference, even
> without '-fPIE'.  So Clang-compiled kernels have a GOT, which needs to
> be adjusted.)
> 
> On my mostly-defconfig kernel, this reduces kernel text size by ~1.3%.
> 
> [1] https://github.com/dynup/kpatch/issues/1284
> [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
> [3] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
> 
> Compiler consideration:
> 
> Gcc recently implemented an optimization [2] for loading symbols without
> explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
> symbols to reside on a 2-byte boundary, enabling the use of the larl
> instruction. However, kernel linker scripts may still generate unaligned
> symbols. To address this, a new -munaligned-symbols option has been
> introduced [3] in recent gcc versions. This option has to be used with
> future gcc versions.
> 
> Older Clang lacks support for handling unaligned symbols generated
> by kernel linker scripts when the kernel is built without -fPIE. However,
> future versions of Clang will include support for the -munaligned-symbols
> option. When the support is unavailable, compile the kernel with -fPIE
> to maintain the existing behavior.
> 
> In addition to it:
> move vmlinux.relocs to safe relocation
> 
> When the kernel is built with CONFIG_KERNEL_UNCOMPRESSED, the entire
> uncompressed vmlinux.bin is positioned in the bzImage decompressor
> image at the default kernel LMA of 0x100000, enabling it to be executed
> in-place. However, the size of .vmlinux.relocs could be large enough to
> cause an overlap with the uncompressed kernel at the address 0x100000.
> To address this issue, .vmlinux.relocs is positioned after the
> .rodata.compressed in the bzImage. Nevertheless, in this configuration,
> vmlinux.relocs will overlap with the .bss section of vmlinux.bin. To
> overcome that, move vmlinux.relocs to a safe location before clearing
> .bss and handling relocs.
> 
> [Rebased Josh Poimboeuf patches and move vmlinux.relocs
>  to safe location: Sumanth Korikkar <sumanthk@linux.ibm.com>]
> Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/s390/Kconfig                    | 15 ++++--
>  arch/s390/Makefile                   |  8 ++-
>  arch/s390/boot/.gitignore            |  1 +
>  arch/s390/boot/Makefile              | 14 ++++-
>  arch/s390/boot/boot.h                |  6 +++
>  arch/s390/boot/startup.c             | 80 +++++++++++++++++++++++++---
>  arch/s390/boot/vmlinux.lds.S         | 18 +++++++
>  arch/s390/include/asm/physmem_info.h |  1 +
>  arch/s390/kernel/vmlinux.lds.S       |  9 ++++
>  9 files changed, 139 insertions(+), 13 deletions(-)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
