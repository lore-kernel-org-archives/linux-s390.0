Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8P3a2Mi+1yttyGk4k7HxRVrMtmFqJewouVhynqUL0PJycmog@mail.gmail.com>
 <D0791499-1190-4C3F-A984-0A313ECA81C7@amacapital.net> <563138b5-7073-74bc-f0c5-b2bad6277e87@gmail.com>
 <486c92d0-0f2e-bd61-1ab8-302524af5e08@gmail.com> <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
 <d5c6736a-2cb4-4e22-78da-a667bda5c05a@gmail.com> <CALCETrUEC81va8-fuUXG1uA5rbKxnKDYsDOXC70_HtKD4LAeAg@mail.gmail.com>
 <e0a1b4d1-ff47-18d1-d535-c62812cb3105@gmail.com>
In-Reply-To: <e0a1b4d1-ff47-18d1-d535-c62812cb3105@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 Sep 2020 09:23:37 +0200
Message-ID: <CAK8P3a2-6JNS38EbZcLrk=cTT526oP=Rf0aoqWNSJ-k4XTYehQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Tue, Sep 22, 2020 at 8:32 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> On 22/09/2020 03:58, Andy Lutomirski wrote:
> > On Mon, Sep 21, 2020 at 5:24 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> > I may be looking at a different kernel than you, but aren't you
> > preventing creating an io_uring regardless of whether SQPOLL is
> > requested?
>
> I diffed a not-saved file on a sleepy head, thanks for noticing.
> As you said, there should be an SQPOLL check.
>
> ...
> if (ctx->compat && (p->flags & IORING_SETUP_SQPOLL))
>         goto err;

Wouldn't that mean that now 32-bit containers behave differently
between compat and native execution?

I think if you want to prevent 32-bit applications from using SQPOLL,
it needs to be done the same way on both to be consistent:

   if ((!IS_ENABLED(CONFIG_64BIT) || ctx->compat) &&
        (p->flags & IORING_SETUP_SQPOLL))
            goto err;

I don't really see how taking away SQPOLL from 32-bit tasks is
any better than just preventing access to the known-broken files
as Al suggested, or adding the hack to make it work as in
Christoph's original patch.

Can we expect all existing and future user space to have a sane
fallback when IORING_SETUP_SQPOLL fails?

      Arnd
