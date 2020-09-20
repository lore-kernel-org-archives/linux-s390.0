Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:46411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgITN4J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 20 Sep 2020 09:56:09 -0400
MIME-Version: 1.0
References: <20200918124533.3487701-1-hch@lst.de> <20200918124533.3487701-2-hch@lst.de>
 <20200918134012.GY3421308@ZenIV.linux.org.uk> <20200918134406.GA17064@lst.de>
 <20200918135822.GZ3421308@ZenIV.linux.org.uk> <20200918151615.GA23432@lst.de> <20200919220920.GI3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200919220920.GI3421308@ZenIV.linux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 20 Sep 2020 15:55:47 +0200
Message-ID: <CAK8P3a3QApj3isPu3TkLahArsfb5jaABb7DJ7EKMxey1T1YPbA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Networking <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Sun, Sep 20, 2020 at 12:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Sep 18, 2020 at 05:16:15PM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
> > > Said that, why not provide a variant that would take an explicit
> > > "is it compat" argument and use it there?  And have the normal
> > > one pass in_compat_syscall() to that...
> >
> > That would help to not introduce a regression with this series yes.
> > But it wouldn't fix existing bugs when io_uring is used to access
> > read or write methods that use in_compat_syscall().  One example that
> > I recently ran into is drivers/scsi/sg.c.
>
> So screw such read/write methods - don't use them with io_uring.
> That, BTW, is one of the reasons I'm sceptical about burying the
> decisions deep into the callchain - we don't _want_ different
> data layouts on read/write depending upon the 32bit vs. 64bit
> caller, let alone the pointer-chasing garbage that is /dev/sg.

Would it be too late to limit what kind of file descriptors we allow
io_uring to read/write on?

If io_uring can get changed to return -EINVAL on trying to
read/write something other than S_IFREG file descriptors,
that particular problem space gets a lot simpler, but this
is of course only possible if nobody actually relies on it yet.

      Arnd
