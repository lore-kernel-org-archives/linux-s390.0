Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200918124533.3487701-1-hch@lst.de> <20200918124533.3487701-2-hch@lst.de>
 <20200918134012.GY3421308@ZenIV.linux.org.uk> <20200918134406.GA17064@lst.de>
In-Reply-To: <20200918134406.GA17064@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Sep 2020 15:59:29 +0200
Message-ID: <CAK8P3a3_DL0T33e7CAuyRxgpRy8LaJO9h1sER7sebcX26hVVjA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Networking <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Fri, Sep 18, 2020 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 18, 2020 at 02:40:12PM +0100, Al Viro wrote:
> > >     /* Vector 0x110 is LINUX_32BIT_SYSCALL_TRAP */
> > > -   return pt_regs_trap_type(current_pt_regs()) == 0x110;
> > > +   return pt_regs_trap_type(current_pt_regs()) == 0x110 ||
> > > +           (current->flags & PF_FORCE_COMPAT);
> >
> > Can't say I like that approach ;-/  Reasoning about the behaviour is much
> > harder when it's controlled like that - witness set_fs() shite...
>
> I don't particularly like it either.  But do you have a better idea
> how to deal with io_uring vs compat tasks?

Do we need to worry about something other than the compat_iovec
struct for now? Regarding the code in io_import_iovec(), it would
seem that can easily be handled by exposing an internal helper.
Instead of

#ifdef CONFIG_COMPAT
     if (req->ctx->compat)
            return compat_import_iovec(rw, buf, sqe_len, UIO_FASTIOV,
iovec, iter);
#endif
        return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);

This could do

    __import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec,
                     iter, req->ctx->compat);

With the normal import_iovec() becoming a trivial wrapper around
the same thing:

ssize_t import_iovec(int type, const struct iovec __user * uvector,
                 unsigned nr_segs, unsigned fast_segs,
                 struct iovec **iov, struct iov_iter *i)
{
     return __import_iovec(type, uvector, nr_segs, fast_segs, iov,
              i, in_compat_syscall());
}


         Arnd
