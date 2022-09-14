Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7A4ECAAD3
	for <linux-s390@archiver.kernel.org>; Wed, 14 Sep 2022 09:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiINJBU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiINJAu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Sep 2022 05:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7413F43
        for <linux-s390@vger.kernel.org>; Wed, 14 Sep 2022 02:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 631CC6193B
        for <linux-s390@vger.kernel.org>; Wed, 14 Sep 2022 09:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1CEC433D6;
        Wed, 14 Sep 2022 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663146045;
        bh=sgpDerYkbDG4klPC90B2naZIuPYbFIbEonVX9p0w3+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=if9BVfabNcM1Ep8Iuy/8IKuNlZ2kIvGy0mvpgaUPQMCE3NZhN6hJ4NwWHTmMhnWlL
         hEB4HJS5WNgCxA4i44QKFYZzK++C2CTf5daVhROxlQgim11YGrkHPPJCuXenMvEtXc
         u62ydSezcOUTrnYFpzgoKC9Yi3TRqmHDuAaHtJ7WWGWTz/Y87qUDgSjo4rFll95XVY
         TKSfpmQ5AIjqPgOXLJ7citfa1dfLyjLvrFmMwcAz0I3Jy7/hs8H+ThZkRznHSe9WUo
         g8tYzJbxHVrejWu1I6fxnV3J6BbWplpsQZsDUIj1o2gp1pSWIXpq+enWxDBjbSHyNq
         ftkX2iMkf8oXw==
Date:   Wed, 14 Sep 2022 02:00:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: Illegal operation with clang + CONFIG_MARCH_Z13
Message-ID: <YyGYO0mmNzMYgF9d@dev-arch.thelio-3990X>
References: <YyC/JvFONhtTYjM/@dev-arch.thelio-3990X>
 <ed01ea25-7abd-4564-0a9d-ad8b0cb9f1b4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed01ea25-7abd-4564-0a9d-ad8b0cb9f1b4@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 14, 2022 at 08:03:47AM +0200, Christian Borntraeger wrote:
> Am 13.09.22 um 19:34 schrieb Nathan Chancellor:
> > Hi all,
> > 
> > Recently, Fedora moved their baseline from CONFIG_MARCH_ZEC12 to
> > CONFIG_MARCH_Z13:
> > 
> > https://src.fedoraproject.org/rpms/kernel/c/aff6e8acdaa437e9f06ef4166ca2209071223f8d
> > 
> > Unfortunately, this causes clang built kernels to have an "illegal
> > operation" panic when booting in QEMU. This is trivially reproducible on
> > mainline with the versions of clang that s390 supports.
> > 
> > # Switch from CONFIG_MARCH_ZEC12 to CONFIG_MARCH_Z13
> > $ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- defconfig menuconfig bzImage
> > 
> > $ qemu-system-s390x \
> > -M s390-ccw-virtio \
> > -kernel arch/s390/boot/bzImage \
> > -display none \
> > -initrd .../boot-utils/images/s390/rootfs.cpio \
> > -m 512m \
> > -nodefaults \
> > -no-reboot \
> > -serial mon:stdio
> > ...
> > [    0.558817] Linux version 6.0.0-rc5-00017-gd1221cea11fc (nathan@distrobox-oTN5YGrt3J.thelio-3990X) (clang version 14.0.5 (Fedora 14.0.5-7.fc38), GNU ld version 2.38-4.fc37) #1 SMP Tue Sep 13 08:35:38 MST 2022
> > ...
> > [    1.675787] illegal operation: 0001 ilc:3 [#1] SMP
> > [    1.675888] Modules linked in:
> > [    1.676044] CPU: 0 PID: 59 Comm: modprobe Not tainted 6.0.0-rc5-00017-gd1221cea11fc #1
> > [    1.676134] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> 
> What qemu version is that and what command line did you use (any cpu model?)

I was able to reproduce this with QEMU 6.0.0 through 7.1.0, which are
the versions that can boot a clang built kernel. I don't think we
specify a cpu model, you can see the full command above. If there is
something we should be doing differently, please let us know!

> > [    1.676202] Krnl PSW : 0704d00180000000 0000000000579fbc (load_elf_binary+0x31c/0x11c0)
> > [    1.676459]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> > [    1.676489] Krnl GPRS: 0000000000000001 00000000044f0000 0000000000000000 0000000000000000
> > [    1.676506]            8000000000000080 0000000000000000 0000000000000000 00000000035fa900
> > [    1.676522]            0000000000000001 000000000353ce00 0000000000000001 00000000044693c0
> > [    1.676538]            000000000276fa00 000000000446a000 0000000000579f9e 00000380002ebc78
> > [    1.677128] Krnl Code: 0000000000579fac: a7f405b8            brc     15,000000000057ab1c
> > [    1.677128]            0000000000579fb0: e31003400004        lg      %r1,832
> > [    1.677128]           #0000000000579fb6: e3001780003b        lzrf    %r0,1920(%r1)
> 
> QEMU does support lzrf as far asI can tell as soon as you have S390_FEAT_STFLE_53 which is part
> of the qemu_V4_1 cpu model.
> 
> > [    1.677128]           >0000000000579fbc: 50001780            st      %r0,1920(%r1)
> > [    1.677128]            0000000000579fc0: e31003400004        lg      %r1,832
> > [    1.677128]            0000000000579fc6: c40800aa99a9        lgrl    %r0,0000000001acd318
> > [    1.677128]            0000000000579fcc: e3001d400124        stg     %r0,7488(%r1)
> > [    1.677128]            0000000000579fd2: e31003400004        lg      %r1,832
> > [    1.677343] Call Trace:
> > [    1.677564]  [<0000000000579fbc>] load_elf_binary+0x31c/0x11c0
> > [    1.677635] ([<0000000000579f9e>] load_elf_binary+0x2fe/0x11c0)
> > [    1.677652]  [<00000000004e1ae6>] bprm_execve+0x4f6/0x7b0
> > [    1.677671]  [<00000000004e1256>] kernel_execve+0x3b6/0x3d0
> > [    1.677687]  [<000000000017e1c8>] call_usermodehelper_exec_async+0x158/0x1d0
> > [    1.677706]  [<0000000000103a9a>] __ret_from_fork+0x3a/0x60
> > [    1.677719]  [<0000000000f8562a>] ret_from_fork+0xa/0x40
> > [    1.677748] Last Breaking-Event-Address:
> > [    1.677757]  [<0000000000579fa2>] load_elf_binary+0x302/0x11c0
> > [    1.678012] Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 
> > The rootfs image is available in our boot-utils repo [1], should it be
> > necessary for reproducing this issue. I do not see any problems with
> > booting a CONFIG_MARCH_Z13 kernel compiled with GCC 12.2.1 from Fedora
> > but it is possible that clang and GCC generate different code. I am not
> > sure if this is a compiler problem or an emulation one, which is where I
> > was looking for some input from you all.
> > 
> > [1]: https://github.com/ClangBuiltLinux/boot-utils
> > 
> > Cheers,
> > Nathan
