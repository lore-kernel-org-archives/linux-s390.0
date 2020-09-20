Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgITAOz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 19 Sep 2020 20:14:55 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA88235FA
        for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2020 00:14:54 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id a17so9155526wrn.6
        for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2020 17:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk> <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
 <20200919232411.GK3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200919232411.GK3421308@ZenIV.linux.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 19 Sep 2020 17:14:41 -0700
Message-ID: <CALCETrViwOdFia_aX4p4riE8aqop1zoOqVfiQtSAZEzheC+Ozg@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Sat, Sep 19, 2020 at 4:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 19, 2020 at 03:53:40PM -0700, Andy Lutomirski wrote:
>
> > > It would not be a win - most of the syscalls don't give a damn
> > > about 32bit vs. 64bit...
> >
> > Any reasonable implementation would optimize it out for syscalls that d=
on=E2=80=99t care.  Or it could be explicit:
> >
> > DEFINE_MULTIARCH_SYSCALL(...)
>
> 1) what would that look like?

In effect, it would work like this:

/* Arch-specific, but there's a generic case for sane architectures. */
enum syscall_arch {
  SYSCALL_NATIVE,
  SYSCALL_COMPAT,
  SYSCALL_X32,
};

DEFINE_MULTIARCH_SYSCALLn(args, arch)
{
  args are the args here, and arch is the arch.
}

> 2) have you counted the syscalls that do and do not need that?

No.

> 3) how many of those realistically *can* be unified with their
> compat counterparts?  [hint: ioctl(2) cannot]

There would be no requirement to unify anything.  The idea is that
we'd get rid of all the global state flags.

For ioctl, we'd have a new file_operation:

long ioctl(struct file *, unsigned int, unsigned long, enum syscall_arch);

I'm not saying this is easy, but I think it's possible and the result
would be more obviously correct than what we have now.
