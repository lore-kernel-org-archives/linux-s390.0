Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFIGtW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 02:49:22 -0400
Date: Tue, 9 Jun 2020 08:49:13 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390: vdso: Use $(LD) instead of $(CC) to link vDSO
Message-ID: <20200609064913.GA6796@osiris>
References: <CAKwvOdmCrM0eUZHR12OBgyRhNPFDzZKjrpZ0DW8Cg=wqTfzDFw@mail.gmail.com>
 <20200602192523.32758-1-natechancellor@gmail.com>
 <CAKwvOdnH8rxT7y1U0d=pyD19K38KwarrwA2s+Ji7ctgg+ks_kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnH8rxT7y1U0d=pyD19K38KwarrwA2s+Ji7ctgg+ks_kg@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Tue, Jun 02, 2020 at 12:52:26PM -0700, Nick Desaulniers wrote:
> On Tue, Jun 2, 2020 at 12:25 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Currently, the VDSO is being linked through $(CC). This does not match
> > how the rest of the kernel links objects, which is through the $(LD)
> > variable.
> >
> > When clang is built in a default configuration, it first attempts to use
> > the target triple's default linker, which is just ld. However, the user
> > can override this through the CLANG_DEFAULT_LINKER cmake define so that
> > clang uses another linker by default, such as LLVM's own linker, ld.lld.
> > This can be useful to get more optimized links across various different
> > projects.
> >
> > However, this is problematic for the s390 vDSO because ld.lld does not
> > have any s390 emulatiom support:
> >
> > https://github.com/llvm/llvm-project/blob/llvmorg-10.0.1-rc1/lld/ELF/Driver.cpp#L132-L150
> >
> > Thus, if a user is using a toolchain with ld.lld as the default, they
> > will see an error, even if they have specified ld.bfd through the LD
> > make variable:
> >
> > $ make -j"$(nproc)" -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- LLVM=1 \
> >                        LD=s390x-linux-gnu-ld \
> >                        defconfig arch/s390/kernel/vdso64/
> > ld.lld: error: unknown emulation: elf64_s390
> > clang-11: error: linker command failed with exit code 1 (use -v to see invocation)
> >
> > Normally, '-fuse-ld=bfd' could be used to get around this; however, this
> > can be fragile, depending on paths and variable naming. The cleaner
> > solution for the kernel is to take advantage of the fact that $(LD) can
> > be invoked directly, which bypasses the heuristics of $(CC) and respects
> > the user's choice. Similar changes have been done for ARM, ARM64, and
> > MIPS.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1041
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks, with this, I'm more confident that the linker flags don't change.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
...
> > -KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> > -                   -Wl,--hash-style=both
> > +ldflags-y := -fPIC -shared -nostdlib -soname=linux-vdso64.so.1 \
> > +            --hash-style=both -T

I added the --build-id flag according to commit 7a0a93c51799 ("arm64:
vdso: Explicitly add build-id option") and applied the patch.
Thanks!
