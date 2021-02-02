Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234661AbhBBOfh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 09:35:37 -0500
Received: by mail-wm1-f72.google.com with SMTP id z25so1564416wml.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Feb 2021 06:34:09 -0800 (PST)
Date: Tue, 2 Feb 2021 09:34:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/2] System Generation ID driver and VMGENID backend
Message-ID: <20210202093337-mutt-send-email-mst@kernel.org>
References: <1610453760-13812-1-git-send-email-acatan@amazon.com>
 <20210112074658-mutt-send-email-mst@kernel.org>
 <9952EF0C-CD1D-4EDB-BAB8-21F72C0BF90D@amazon.com>
 <20210127074549-mutt-send-email-mst@kernel.org>
 <7bcd1cf3-d055-db46-95ea-5c023df2f184@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bcd1cf3-d055-db46-95ea-5c023df2f184@amazon.de>
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Graf <graf@amazon.de>
Cc: "Catangiu, Adrian Costin" <acatan@amazon.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "rppt@kernel.org" <rppt@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>, "jannh@google.com" <jannh@google.com>, "w@1wt.eu" <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, "luto@kernel.org" <luto@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, "ebiggers@kernel.org" <ebiggers@kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "corbet@lwn.net" <corbet@lwn.net>, "mhocko@kernel.org" <mhocko@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "areber@redhat.com" <areber@redhat.com>, "ovzxemul@gmail.com" <ovzxemul@gmail.com>, "avagin@gmail.com" <avagin@gmail.com>, "ptikhomirov@virtuozzo.com" <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>

On Thu, Jan 28, 2021 at 01:58:12PM +0100, Alexander Graf wrote:
> Hey Michael!
> 
> On 27.01.21 13:47, Michael S. Tsirkin wrote:
> > 
> > On Thu, Jan 21, 2021 at 10:28:16AM +0000, Catangiu, Adrian Costin wrote:
> > > On 12/01/2021, 14:49, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > >      On Tue, Jan 12, 2021 at 02:15:58PM +0200, Adrian Catangiu wrote:
> > >      > The first patch in the set implements a device driver which exposes a
> > >      > read-only device /dev/sysgenid to userspace, which contains a
> > >      > monotonically increasing u32 generation counter. Libraries and
> > >      > applications are expected to open() the device, and then call read()
> > >      > which blocks until the SysGenId changes. Following an update, read()
> > >      > calls no longer block until the application acknowledges the new
> > >      > SysGenId by write()ing it back to the device. Non-blocking read() calls
> > >      > return EAGAIN when there is no new SysGenId available. Alternatively,
> > >      > libraries can mmap() the device to get a single shared page which
> > >      > contains the latest SysGenId at offset 0.
> > > 
> > >      Looking at some specifications, the gen ID might actually be located
> > >      at an arbitrary address. How about instead of hard-coding the offset,
> > >      we expose it e.g. in sysfs?
> > > 
> > > The functionality is split between SysGenID which exposes an internal u32
> > > counter to userspace, and an (optional) VmGenID backend which drives
> > > SysGenID generation changes based on hw vmgenid updates.
> > > 
> > > The hw UUID you're referring to (vmgenid) is not mmap-ed to userspace or
> > > otherwise exposed to userspace. It is only used internally by the vmgenid
> > > driver to find out about VM generation changes and drive the more generic
> > > SysGenID.
> > > 
> > > The SysGenID u32 monotonic increasing counter is the one that is mmaped to
> > > userspace, but it is a software counter. I don't see any value in using a dynamic
> > > offset in the mmaped page. Offset 0 is fast and easy and most importantly it is
> > > static so no need to dynamically calculate or find it at runtime.
> > 
> > Well you are burning a whole page on it, using an offset the page
> > can be shared with other functionality.
> 
> Currently, the SysGenID lives is one page owned by Linux that we share out
> to multiple user space clients. So yes, we burn a single page of the system
> here.
> 
> If we put more data in that same page, what data would you put there? Random
> other bits from other subsystems? At that point, we'd be reinventing vdso
> all over again, no? Probably with the same problems.
> 
> Which gets me to the second alternative: Reuse VDSO. The problem there is
> that the VDSO is an extremely architecture specific mechanism. Any new
> architecture we'd want to support would need multiple layers of changes in
> multiple layers of both kernel and libc. I'd like to avoid that if we can
> :).
> 
> So that leaves us with either wasting a page per system or not having an
> mmap() interface in the first place.
> 
> The reason we have the mmap() interface is that it's be easier to consume
> for libraries, that are not hooked into the main event loop.
> 
> So, uh, what are you suggesting? :)

I'd drop mmap at this point. I haven't seen a way to use it
that isn't racy.

> 
> Alex
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
