Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:35555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgIWSqO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 14:46:14 -0400
MIME-Version: 1.0
References: <20200923060547.16903-1-hch@lst.de> <20200923060547.16903-6-hch@lst.de>
 <20200923142549.GK3421308@ZenIV.linux.org.uk> <20200923143251.GA14062@lst.de>
 <20200923145901.GN3421308@ZenIV.linux.org.uk> <20200923163831.GO3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200923163831.GO3421308@ZenIV.linux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 23 Sep 2020 20:45:51 +0200
Message-ID: <CAK8P3a3nkLUOkR+jwz2_2LcYTUTqdVf8JOtZqKWbtEDotNhFZA@mail.gmail.com>
Subject: Re: [PATCH 5/9] fs: remove various compat readv/writev helpers
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Networking <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Wed, Sep 23, 2020 at 6:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I wonder if we should do something like
>
> SYSCALL_DECLARE3(readv, unsigned long, fd, const struct iovec __user *, vec,
>                  unsigned long, vlen);
> in syscalls.h instead, and not under that ifdef.
>
> Let it expand to declaration of sys_...() in generic case and, on x86, into
> __do_sys_...() and __ia32_sys_...()/__x64_sys_...(), with types matching
> what SYSCALL_DEFINE ends up using.
>
> Similar macro would cover compat_sys_...() declarations.  That would
> restore mismatch checking for x86 and friends.  AFAICS, the cost wouldn't
> be terribly high - cpp would have more to chew through in syscalls.h,
> but it shouldn't be all that costly.  Famous last words, of course...
>
> Does anybody see fundamental problems with that?

I've had some ideas along those lines in the past and I think it should work.

As a variation of this, the SYSCALL_DEFINEx() macros could go away
entirely, leaving only the macro instantiations from the header to
require that syntax. It would require first changing the remaining
architectures to build the syscall table from C code instead of
assembler though.

Regardless of that, another advantage of having the SYSCALL_DECLAREx()
would be the ability to include that header file from elsewhere with a different
macro definition to create a machine-readable version of the interface when
combined with the syscall.tbl files. This could be used to create a user
space stub for calling into the low-level syscall regardless of the
libc interfaces,
or for synchronizing the interfaces with strace, qemu-user, or anything that
needs to deal with the low-level interface.

      Arnd
