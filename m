Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 Sep 2020 14:22:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200923132254.GI3421308@ZenIV.linux.org.uk>
References: <563138b5-7073-74bc-f0c5-b2bad6277e87@gmail.com>
 <486c92d0-0f2e-bd61-1ab8-302524af5e08@gmail.com>
 <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
 <d5c6736a-2cb4-4e22-78da-a667bda5c05a@gmail.com>
 <CALCETrUEC81va8-fuUXG1uA5rbKxnKDYsDOXC70_HtKD4LAeAg@mail.gmail.com>
 <e0a1b4d1-ff47-18d1-d535-c62812cb3105@gmail.com>
 <CAK8P3a2-6JNS38EbZcLrk=cTT526oP=Rf0aoqWNSJ-k4XTYehQ@mail.gmail.com>
 <f25b4708-eba6-78d6-03f9-5bfb04e07627@gmail.com>
 <CAK8P3a39jN+t2hhLg0oKZnbYATQXmYE2-Z1JkmFyc1EPdg1HXw@mail.gmail.com>
 <91209170-dcb4-d9ee-afa0-a819f8877b86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91209170-dcb4-d9ee-afa0-a819f8877b86@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Wed, Sep 23, 2020 at 11:01:34AM +0300, Pavel Begunkov wrote:

> > I'm not following why that would be considered a valid option,
> > as that clearly breaks existing users that update from a 32-bit
> > kernel to a 64-bit one.
> 
> Do you mean users who move 32-bit binaries (without recompiling) to a
> new x64 kernel? Does the kernel guarantees that to work?

Yes.

No further (printable) comments for now...
