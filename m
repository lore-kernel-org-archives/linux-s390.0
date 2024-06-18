Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428C53E24
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743049; cv=none; b=APF0ws5lPn4LVnQNvs4bWlBz7CtEgzpvYnSfg0wQN5OALihjwlU68zNzf/TpOaNgAMjJ5PM63MayaPkRZsTTaGm9zyhWf41psBgCjt1cvQL/tNfGVC8rHwrLBYdug/VFHZtCpRCYh1YUbXwdkk/O6GlfN0bFN0ZW1KKz18VhYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743049; c=relaxed/simple;
	bh=cwbtpnCv+fDNWajoOHdqF3OGFMklVWPxpQAyV6owIXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig4pj+9hCzHOCUM5X4Gq5xG6KiowO9gru26IrWddUVElcJvg5WafMb9p/M8CYFwlFUNSz+owgOWinW3MlpvdGc0suORNSIQj1f3vITqNQf+wvX9CKwA0YQJQW5qhZPVedfhx2eHvzquRPtjCRGgvlMoP4nJ0t8vQ8bUJteYInhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqORvqk2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqORvqk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718743046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1j1rWC33aF+kp/PEd0oGa89Xq6X7j21RxFRoBdcWw+8=;
	b=YqORvqk2TcxtI7yrRQ8NqRqeCBXxHid+OKHwGO3M/TmgSfcOEbzIuz9MQqTT7hKZCMRCO+
	BggZH8GG9Pit5MGaReodzGcq577PFpFhFi+Skvndt9X7/d8hpX6uOLhGtqaQfyjKQaaf1j
	r5AQmyEta9PKwW4esKqvpZTYZDDtmYQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-w7CB-BfSNy2bsmw8Vhee1w-1; Tue,
 18 Jun 2024 16:37:23 -0400
X-MC-Unique: w7CB-BfSNy2bsmw8Vhee1w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 967CD195609E;
	Tue, 18 Jun 2024 20:37:21 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75DD23000229;
	Tue, 18 Jun 2024 20:37:19 +0000 (UTC)
Date: Tue, 18 Jun 2024 16:37:16 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
	gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
Message-ID: <ZnHv/HmiYHoQRkUU@redhat.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219132734.22881-1-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Feb 19, 2024 at 02:27:30PM +0100, Sumanth Korikkar wrote:
> Hi All,
> 
> This is a rebased version of Josh's patch series with a few fixups.
> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390
> 
> This introduces the capability to compile the s390 relocatable kernel
> with and without the -fPIE option.
> 
> When utilizing the kpatch functionality, it is advisable to compile the
> kernel without the -fPIE option. This is particularly important if the
> kernel is built with the -ffunction-sections and -fdata-sections flags.
> The linker imposes a restriction on the number of sections (limited to
> 64k), necessitating the omission of -fPIE.
> 
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
> [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
> 
> Gcc recently implemented an optimization [1] for loading symbols without
> explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
> symbols to reside on a 2-byte boundary, enabling the use of the larl
> instruction. However, kernel linker scripts may still generate unaligned
> symbols. To address this, a new -munaligned-symbols option has been
> introduced [2] in recent gcc versions. This option has to be used with
> future gcc versions.
> 
> Older Clang lacks support for handling unaligned symbols generated
> by kernel linker scripts when the kernel is built without -fPIE. However,
> future versions of Clang will include support for the -munaligned-symbols
> option. When the support is unavailable, compile the kernel with -fPIE
> to maintain the existing behavior.
> 
> Patch 1 filters out -munaligned-symbol flag for vdso code. This is beneficial
> when compiling kernel with -fno-PIE and -munaligned-symbols combination.
> 
> Patch 2 introduces the 'relocs' tool, which reads the vmlinux file and
> generates a vmlinux.relocs_64 section, containing offsets for all
> R_390_64 relocations.
> 
> Patch 3 enables the compilation of a relocatable kernel with or without
> the -fPIE option. It  allows for building the relocatable kernel without
> -fPIE.  However, if compiler cannot handle unaligned symbols, the kernel
> is built with -fPIE.
> 
> Patch 4 handles orphan .rela sections when kernel is built with
> -fno-PIE.
> 
> kpatch tools changes:
> * -mno-pic-data-is-text-relative prevents relative addressing between
>   code and data. This is needed to avoid relocation error when klp text
>   and data are too far apart. kpatch already includes this flag.
>   However, with these changes, ARCH_KFLAGS+="-fPIC" should be added to
>   s390 kpatch tools, As -mno-pic-data-is-text-relative can be used only
>   with -fPIC. The corresponding pull request will be sent to kpatch
>   tools.

Hi Sumanth,

I noticed interesting compiler differences when adding -fPIC build
option and not.  The difference in resulting output can confuse
kpatch-build when it tries to verify that its reference build (with the
mentioned options, plus --ffunction-sections and -fdata-sections),
doesn't line up closely enough with the original vmlinux source (sans
all these options).

I don't think a kpatch-build PR was ever opened to add "-fPIC", but the
compiler now warns that its required.  Have you ever seen optimization /
build output changes when adding this option and if so, were there
additional kpatch-build implications?

Here is a quick example that I stumbled on while investigating the
kpatch-build shadow-newpid.patch integration test that modifies
kernel/fork.c.  I couldn't reproduce with the s390 defconfig, but it
shows up when building with RHEL-10 config.  Reproducer steps and
disassembly examples follows.

Regards,

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

# Setup - v6.9 with a RHEL-10 config

  $ git clone --depth=1 --branch v6.9 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  $ cd linux

  $ curl -o .config https://file.rdu.redhat.com/~jolawren/kernel-s390x-rhel.config
  $ make olddefconfig


# Build and disassemble kernel/fork.c :: mmput()

  $ make -s -j$(nproc) kernel/fork.o
  $ objdump -Dr -j.text --disassemble=mmput kernel/fork.o

  kernel/fork.o:     file format elf64-s390


  Disassembly of section .text:

  0000000000001090 <mmput>:
      1090:       c0 04 00 00 00 00       jgnop   1090 <mmput>
      1096:       a7 18 ff ff             lhi     %r1,-1
      109a:       eb 01 21 3c 00 f8       laa     %r0,%r1,316(%r2)
      10a0:       07 e0                   bnor    %r0
      10a2:       ec 08 00 06 01 7e       cije    %r0,1,10ae <mmput+0x1e>
      10a8:       c0 f4 00 00 00 00       jg      10a8 <mmput+0x18>
                          10aa: R_390_PC32DBL     __s390_indirect_jump_r14+0x2
      10ae:       c0 f4 00 00 00 00       jg      10ae <mmput+0x1e>
                          10b0: R_390_PLT32DBL    __mmput+0x2


# Build with -fPIC and disassemble kernel/fork.c :: mmput()

  $ make -s clean
  $ KCFLAGS="-fPIC -mno-pic-data-is-text-relative -fno-section-anchors" make -s -j$(nproc) kernel/fork.o
  $ objdump -Dr -j.text --disassemble=mmput kernel/fork.o

  kernel/fork.o:     file format elf64-s390


  Disassembly of section .text:

  0000000000002430 <mmput>:
      2430:       c0 04 00 00 00 00       jgnop   2430 <mmput>
      2436:       a7 18 ff ff             lhi     %r1,-1
      243a:       eb 01 21 3c 00 f8       laa     %r0,%r1,316(%r2)
      2440:       07 e0                   bnor    %r0
      2442:       ec 08 00 06 01 7e       cije    %r0,1,244e <mmput+0x1e>
      2448:       c0 f4 00 00 00 00       jg      2448 <mmput+0x18>
                          244a: R_390_PC32DBL     __s390_indirect_jump_r14+0x2
      244e:       eb 9f f0 60 00 24       stmg    %r9,%r15,96(%r15)
      2454:       b9 04 00 ef             lgr     %r14,%r15
      2458:       e3 f0 ff c0 ff 71       lay     %r15,-64(%r15)
      245e:       e3 e0 f0 98 00 24       stg     %r14,152(%r15)
      2464:       b9 04 00 b2             lgr     %r11,%r2
      2468:       c0 e5 00 00 00 00       brasl   %r14,2468 <mmput+0x38>
                          246a: R_390_PLT32DBL    uprobe_clear_state+0x2
      246e:       b9 04 00 2b             lgr     %r2,%r11
      2472:       c0 e5 00 00 00 00       brasl   %r14,2472 <mmput+0x42>
                          2474: R_390_PLT32DBL    exit_aio+0x2
      2478:       e3 20 b4 f8 00 04       lg      %r2,1272(%r11)
      247e:       a7 20 00 01             tmlh    %r2,1
      2482:       a7 74 00 6f             jne     2560 <mmput+0x130>
      2486:       e3 30 b4 f8 00 04       lg      %r3,1272(%r11)
      248c:       a7 30 00 02             tmlh    %r3,2
      2490:       a7 74 00 61             jne     2552 <mmput+0x122>
      2494:       b9 04 00 2b             lgr     %r2,%r11
      2498:       41 90 b1 88             la      %r9,392(%r11)
      249c:       c0 e5 00 00 00 00       brasl   %r14,249c <mmput+0x6c>
                          249e: R_390_PLT32DBL    exit_mmap+0x2
      24a2:       b9 04 00 2b             lgr     %r2,%r11
      24a6:       c0 e5 00 00 00 00       brasl   %r14,24a6 <mmput+0x76>
                          24a8: R_390_PLT32DBL    mm_put_huge_zero_page+0x2
      24ac:       a7 39 00 00             lghi    %r3,0
      24b0:       b9 04 00 2b             lgr     %r2,%r11
      24b4:       c0 e5 00 00 00 00       brasl   %r14,24b4 <mmput+0x84>
                          24b6: R_390_PLT32DBL    set_mm_exe_file+0x2
      24ba:       e3 40 b1 88 00 04       lg      %r4,392(%r11)
      24c0:       ec 94 00 2f 80 64       cgrje   %r9,%r4,251e <mmput+0xee>
      24c6:       c4 a8 00 00 00 00       lgrl    %r10,24c6 <mmput+0x96>
                          24c8: R_390_GOTENT      mmlist_lock+0x2
      24cc:       58 10 03 ac             l       %r1,940
      24d0:       a7 58 00 00             lhi     %r5,0
      24d4:       ba 51 a0 00             cs      %r5,%r1,0(%r10)
      24d8:       ec 56 00 53 00 7e       cijne   %r5,0,257e <mmput+0x14e>
      24de:       b9 04 00 29             lgr     %r2,%r9
      24e2:       c0 e5 00 00 00 00       brasl   %r14,24e2 <mmput+0xb2>
                          24e4: R_390_PLT32DBL    __list_del_entry_valid_or_report+0x2
      24e8:       ec 28 00 0f 00 7c       cgije   %r2,0,2506 <mmput+0xd6>
      24ee:       e3 e0 b1 90 00 04       lg      %r14,400(%r11)
      24f4:       e3 20 b1 88 00 04       lg      %r2,392(%r11)
      24fa:       e3 e0 20 08 00 24       stg     %r14,8(%r2)
      2500:       e3 20 e0 00 00 24       stg     %r2,0(%r14)
      2506:       e5 48 b1 88 01 00       mvghi   392(%r11),256
      250c:       e5 48 b1 90 01 22       mvghi   400(%r11),290
      2512:       a7 08 00 00             lhi     %r0,0
      2516:       47 00 00 00             nop     0
      251a:       40 00 a0 02             sth     %r0,2(%r10)
      251e:       e3 30 b4 68 00 02       ltg     %r3,1128(%r11)
      2524:       a7 84 00 08             je      2534 <mmput+0x104>
      2528:       e3 20 30 10 00 04       lg      %r2,16(%r3)
      252e:       c0 e5 00 00 00 00       brasl   %r14,252e <mmput+0xfe>
                          2530: R_390_PLT32DBL    module_put+0x2
      2534:       a7 48 ff ff             lhi     %r4,-1
      2538:       eb 94 b0 00 00 f8       laa     %r9,%r4,0(%r11)
      253e:       07 e0                   bnor    %r0
      2540:       ec 98 00 17 01 7e       cije    %r9,1,256e <mmput+0x13e>
      2546:       eb 9f f0 a0 00 04       lmg     %r9,%r15,160(%r15)
      254c:       c0 f4 00 00 00 00       jg      254c <mmput+0x11c>
                          254e: R_390_PC32DBL     __s390_indirect_jump_r14+0x2
      2552:       b9 04 00 2b             lgr     %r2,%r11
      2556:       c0 e5 00 00 00 00       brasl   %r14,2556 <mmput+0x126>
                          2558: R_390_PLT32DBL    __khugepaged_exit+0x2
      255c:       a7 f4 ff 9c             j       2494 <mmput+0x64>
      2560:       b9 04 00 2b             lgr     %r2,%r11
      2564:       c0 e5 00 00 00 00       brasl   %r14,2564 <mmput+0x134>
                          2566: R_390_PLT32DBL    __ksm_exit+0x2
      256a:       a7 f4 ff 8e             j       2486 <mmput+0x56>
      256e:       b9 04 00 2b             lgr     %r2,%r11
      2572:       eb 9f f0 a0 00 04       lmg     %r9,%r15,160(%r15)
      2578:       c0 f4 00 00 00 00       jg      2578 <mmput+0x148>
                          257a: R_390_PLT32DBL    __mmdrop+0x2
      257e:       b9 04 00 2a             lgr     %r2,%r10
      2582:       c0 e5 00 00 00 00       brasl   %r14,2582 <mmput+0x152>
                          2584: R_390_PLT32DBL    arch_spin_lock_wait+0x2
      2588:       a7 f4 ff ab             j       24de <mmput+0xae>


# GCC information

  $ gcc -v
  Using built-in specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/libexec/gcc/s390x-redhat-linux/14/lto-wrapper
  Target: s390x-redhat-linux
  Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --disable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --without-isl --enable-gnu-indirect-function --with-long-double-128 --with-arch=z14 --with-tune=z15 --enable-decimal-float --build=s390x-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1 --enable-host-pie --enable-host-bind-now
  Thread model: posix
  Supported LTO compression algorithms: zlib zstd
  gcc version 14.1.1 20240507 (Red Hat 14.1.1-1) (GCC)

