Return-Path: <linux-arch-owner@vger.kernel.org>
From: sbaugh@catern.com
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
Date: Mon, 26 Aug 2019 19:50:50 +0000
Message-ID: <854l2366zp.fsf@catern.com>
References: <20190820033406.29796-1-cyphar@cyphar.com>
        <20190820033406.29796-8-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.orglinux-kernel@vger.kernel.orglinux-api@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-fsdevel@vger.kernel.orglinux-ia64@vger.kernel.orglinux-mips@vger.kernel.orglinux-parisc@vger.kernel.orglinuxppc-dev@ozlabs.orglinux-sh@vger.kernel.orgsparclinux@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:
> To this end, we introduce the openat2(2) syscall. It provides all of the
> features of openat(2) through the @how->flags argument, but also
> also provides a new @how->resolve argument which exposes RESOLVE_* flags
> that map to our new LOOKUP_* flags. It also eliminates the long-standing
> ugliness of variadic-open(2) by embedding it in a struct.

I don't like this usage of a structure in memory to pass arguments that
would fit in registers. This would be quite inconvenient for me as a
userspace developer.

Others have brought up issues with this: the issue of seccomp, and the
issue of mismatch between the userspace interface and the kernel
interface, are the most important for me. I want to add another,
admittedly somewhat niche, concern.

This interfaces requires a program to allocate memory (even on the
stack) just to pass arguments to the kernel which could be passed
without allocating that memory. That makes it more difficult and less
efficient to use this syscall in any case where memory is not so easily
allocatable: such as early program startup or assembly, where the stack
may be limited in size or not even available yet, or when injecting a
syscall while ptracing.

A struct-passing interface was needed for clone, since we ran out of
registers; but we have not run out of registers yet for openat, so it
would be nice to avoid this if we can. We can always expand later...
