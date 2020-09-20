Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUt1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 20 Sep 2020 16:49:27 -0400
MIME-Version: 1.0
References: <20200918124533.3487701-1-hch@lst.de> <20200918124533.3487701-2-hch@lst.de>
 <20200920151510.GS32101@casper.infradead.org> <20200920180742.GN3421308@ZenIV.linux.org.uk>
 <20200920190159.GT32101@casper.infradead.org> <20200920191031.GQ3421308@ZenIV.linux.org.uk>
 <20200920192259.GU32101@casper.infradead.org> <CALCETrXVtBkxNJcMxf9myaKT9snHKbCWUenKHGRfp8AOtORBPg@mail.gmail.com>
In-Reply-To: <CALCETrXVtBkxNJcMxf9myaKT9snHKbCWUenKHGRfp8AOtORBPg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 20 Sep 2020 22:49:03 +0200
Message-ID: <CAK8P3a37BRFj_qg61gP2oVrjJzBrZ58y1vggeTk_5n55Ou5U2Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Sun, Sep 20, 2020 at 9:28 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Sep 20, 2020 at 12:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 20, 2020 at 08:10:31PM +0100, Al Viro wrote:
> > > IMO it's much saner to mark those and refuse to touch them from io_uring...
> >
> > Simpler solution is to remove io_uring from the 32-bit syscall list.
> > If you're a 32-bit process, you don't get to use io_uring.  Would
> > any real users actually care about that?
>
> We could go one step farther and declare that we're done adding *any*
> new compat syscalls :)

Would you also stop adding system calls to native 32-bit systems then?

On memory constrained systems (less than 2GB a.t.m.), there is still a
strong demand for running 32-bit user space, but all of the recent Arm
cores (after Cortex-A55) dropped the ability to run 32-bit kernels, so
that compat mode may eventually become the primary way to run
Linux on cheap embedded systems.

I don't think there is any chance we can realistically take away io_uring
from the 32-bit ABI any more now.

      Arnd
