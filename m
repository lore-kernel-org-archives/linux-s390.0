Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E47512D742
	for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954067; cv=none; b=UiTdKhmTsCDkhGwEO8AWnc9XNP+zXmf+nfuAULYVyQs1IzPZ5oh2ANXPvxsUUv40hot52JrkV3ABpVy3Gu+NKnb0NdP4eViCuXaa3A76O2kTD8f42EzW3Fbi32lkFLI8lPEq/teIFQKpNS/Pbvf3qfYUL0zjKgq6riKoJngAfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954067; c=relaxed/simple;
	bh=1219e9zqdNsXoUjglT2wXN0kk5OuA/hPtE/GgPez8uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGkFwptExy3S3vBOsHM7ty+z69nV/b2x3uAF9qRWXjhVAFXYYZwc0pHgttKAJ4uuYIwGbn8/HhKI0amqy6HaUXPJx/EHGuZq1AEdIIhMLabiPiF+U3O84sIASWJKJ8gbhvBkFzD06SM+dSHhmdOgvZdWHDM2dT0JPEJPcaMmHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VxWr7dfl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VxWr7dfl"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L60Ac9013780;
	Fri, 21 Jun 2024 07:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=Y6zXADO5CSKbW4b2j1FWrwqssxG
	SjE0Njd7eQWyOQME=; b=VxWr7dflYXuLeMTwSyJmjfgh3gJteuIoxNCo8BVxzVp
	jFqaVAe1knNCHbJRed7WMMJeTnucPHPnKVk/auXgrtdFJL44f7fi9zUU1gAOvFKe
	kE70v9f6KSkkl0IVFb7AUNp3HnqZvekrhEC9kAlI0nmhamRPJJLP45rsvRbsbW7B
	dNcDDCJbceCMKfF+TIEvTRneISVyJZS2j0izLNFZep0o74HHAOwQhbmJNQB0VsaW
	m2P6MFFiH18wz/I1yUOcP5w+tW49VJlIpyX8F58LUHUwYaViFMaRA3/chos1tiEi
	LrbOfXXwcQlvPe7YP0ilnXTCH/A1E9ZDMOxsLkBpZ3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw3ung5q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:14:20 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L7EKkT001175;
	Fri, 21 Jun 2024 07:14:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw3ung5q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:14:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L5HY5e032346;
	Fri, 21 Jun 2024 07:14:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspn5r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:14:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L7EE4G16908552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 07:14:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D49D2004D;
	Fri, 21 Jun 2024 07:14:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A70C420063;
	Fri, 21 Jun 2024 07:14:13 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.67.123])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Jun 2024 07:14:13 +0000 (GMT)
Date: Fri, 21 Jun 2024 09:14:12 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
        gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
Message-ID: <ZnUoRESborBG95aJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <ZnHv/HmiYHoQRkUU@redhat.com>
 <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4dccTrttsB1HF1uT341kPhVGUlGvFnzb
X-Proofpoint-GUID: jTH1XoTC1JwiUDwL_3YHxf7SjX6dQYAk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_01,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210050

On Wed, Jun 19, 2024 at 02:23:49PM -0400, Joe Lawrence wrote:
> On 6/19/24 13:01, Sumanth Korikkar wrote:
> > On Tue, Jun 18, 2024 at 04:37:16PM -0400, Joe Lawrence wrote:
> >> On Mon, Feb 19, 2024 at 02:27:30PM +0100, Sumanth Korikkar wrote:
> >>> Hi All,
> >>>
> >>> This is a rebased version of Josh's patch series with a few fixups.
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390
> >>>
> >>> This introduces the capability to compile the s390 relocatable kernel
> >>> with and without the -fPIE option.
> >>>
> >>> When utilizing the kpatch functionality, it is advisable to compile the
> >>> kernel without the -fPIE option. This is particularly important if the
> >>> kernel is built with the -ffunction-sections and -fdata-sections flags.
> >>> The linker imposes a restriction on the number of sections (limited to
> >>> 64k), necessitating the omission of -fPIE.
> >>>
> >>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
> >>> [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
> >>>
> >>> Gcc recently implemented an optimization [1] for loading symbols without
> >>> explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
> >>> symbols to reside on a 2-byte boundary, enabling the use of the larl
> >>> instruction. However, kernel linker scripts may still generate unaligned
> >>> symbols. To address this, a new -munaligned-symbols option has been
> >>> introduced [2] in recent gcc versions. This option has to be used with
> >>> future gcc versions.
> >>>
> >>> Older Clang lacks support for handling unaligned symbols generated
> >>> by kernel linker scripts when the kernel is built without -fPIE. However,
> >>> future versions of Clang will include support for the -munaligned-symbols
> >>> option. When the support is unavailable, compile the kernel with -fPIE
> >>> to maintain the existing behavior.
> >>>
> >>> Patch 1 filters out -munaligned-symbol flag for vdso code. This is beneficial
> >>> when compiling kernel with -fno-PIE and -munaligned-symbols combination.
> >>>
> >>> Patch 2 introduces the 'relocs' tool, which reads the vmlinux file and
> >>> generates a vmlinux.relocs_64 section, containing offsets for all
> >>> R_390_64 relocations.
> >>>
> >>> Patch 3 enables the compilation of a relocatable kernel with or without
> >>> the -fPIE option. It  allows for building the relocatable kernel without
> >>> -fPIE.  However, if compiler cannot handle unaligned symbols, the kernel
> >>> is built with -fPIE.
> >>>
> >>> Patch 4 handles orphan .rela sections when kernel is built with
> >>> -fno-PIE.
> >>>
> >>> kpatch tools changes:
> >>> * -mno-pic-data-is-text-relative prevents relative addressing between
> >>>   code and data. This is needed to avoid relocation error when klp text
> >>>   and data are too far apart. kpatch already includes this flag.
> >>>   However, with these changes, ARCH_KFLAGS+="-fPIC" should be added to
> >>>   s390 kpatch tools, As -mno-pic-data-is-text-relative can be used only
> >>>   with -fPIC. The corresponding pull request will be sent to kpatch
> >>>   tools.
> >>
> >> Hi Sumanth,
> >>
> >> I noticed interesting compiler differences when adding -fPIC build
> >> option and not.  The difference in resulting output can confuse
> >> kpatch-build when it tries to verify that its reference build (with the
> >> mentioned options, plus --ffunction-sections and -fdata-sections),
> >> doesn't line up closely enough with the original vmlinux source (sans
> >> all these options).
> > 
> > Hi Joe,
> > 
> > kpatch for s390 already uses extra compiler flag -mno-pic-data-is-text-relative
> > inorder to prevent relative addressing between code and data. Also,
> > includes -ffunction-sections and -fdata-sections along with it to identify
> > modified functions and its relocations.
> > 
> > Both the source code and modified code are built with the same
> > options during kpatch-build (-fPIC added to
> > -mno-pic-data-is-text-relative). kpatch-build was able to identify
> > modified functions and its associated relocations and include these
> > changes in the final kpatch module.
> > 
> > May be I am missing some info: Does this deviation cause confusion to kpatch?
> > 
> 
> Hi Sumanth,
> 
> Yes, in the example I provided, the __mmput() function is only inlined
> in kpatch builds, but not the builds that create the target vmlinux.
> Here is a reproducer tarball that you can try against a local
> create-diff-object binary:
> 
> https://file.rdu.redhat.com/~jolawren/repro-s390x-shadow-newpid.tar.gz
> 
> create-diff-object: ERROR: fork.ORIG.o: find_local_syms: 222: couldn't
> find matching fork.c local symbols in vmlinux symbol table.

Hi Joe,

I tried to download the tarball and rhel config. Both are unreachable.
Failed to resolve 'file.rdu.redhat.com' (Name or service not known)

Could you please provide alternative link to it?

Thank you,
Sumanth
