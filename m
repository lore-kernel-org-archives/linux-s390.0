Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
In-Reply-To: <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
References: <cover.1604410035.git.yifeifz2@illinois.edu> <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu> <87wnz1to9n.fsf@mpe.ellerman.id.au> <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
Date: Thu, 05 Nov 2020 22:26:44 +1100
Message-ID: <87ft5ot56z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, David Laight <David.Laight@aculab.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org, Tycho Andersen <tycho@tycho.pizza>

YiFei Zhu <zhuyifei1999@gmail.com> writes:
> On Wed, Nov 4, 2020 at 4:22 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > +#ifdef __LITTLE_ENDIAN__
>>
>> As Kees mentioned this should (must?!) match the configured endian.
>>
>> But I think it would still be better to use the CONFIG symbol, which is
>> CONFIG_CPU_LITTLE_ENDIAN.
>
> My attempt here is to be consistent with asm/syscall.h
> syscall_get_arch [1]. Would it make sense to change that to
> CONFIG_CPU_LITTLE_ENDIAN then?
>
> [1] https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/syscall.h#L116

Looking across the tree with have thousands of usages of
__LITTLE_ENDIAN__, so it's probably not worth converting to
CONFIG_CPU_LITTLE_ENDIAN.

>> > +# define SECCOMP_ARCH_NATIVE         (AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
>>
>> You use __SECCOMP_ARCH_LE there, but previously you only defined
>> __SECCOMP_ARCH_LE_BIT.
>>
>> Is there some magic somewhere that defines __SECCOMP_ARCH_LE based on
>> __SECCOMP_ARCH_LE_BIT ?
>
> Oops, my bad here.

OK :)

>> > +# define SECCOMP_ARCH_NATIVE_NR              NR_syscalls
>> > +# define SECCOMP_ARCH_NATIVE_NAME    "ppc64"
>>
>> What's the name used for?
>
> This is used in the last patch in this series to report in procfs the
> name of each architecture tracked by the bitmap cache.

OK, yeah I think it would be better if the matched the uname -m values.

>> Usually we use "ppc64" for 64-bit big endian and "ppc64le" for 64-bit
>> little endian.
>>
>> And usually we use "ppc" for 32-bit.
>
> Ok.


cheers
