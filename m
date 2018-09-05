Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 5 Sep 2018 07:56:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for the 4.19 merge window #2
In-Reply-To: <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
References: <20180824094225.68b2adc6@mschwideX1>
        <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20180905075641.5c9e5421@mschwideX1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 4 Sep 2018 17:16:31 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Fri, Aug 24, 2018 at 12:42 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > Harald Freudenberger (5):
> >       s390/zcrypt: hex string mask improvements for apmask and aqmask.
> 
> This (and an earlier 2017 commit) adds VLAs, which are being
> removed[1] from the kernel:
> 
> drivers/s390/crypto/ap_bus.c:980:3: warning: ISO C90 forbids variable
> length array ‘clrm’ [-Wvla]
> drivers/s390/crypto/ap_bus.c:981:3: warning: ISO C90 forbids variable
> length array ‘setm’ [-Wvla]
> drivers/s390/crypto/ap_bus.c:995:3: warning: ISO C90 forbids variable
> length array ‘setm’ [-Wvla]
> 
> static int process_mask_arg(const char *str,
>                             unsigned long *bitmap, int bits,
>                             struct mutex *lock)
> ...
>                 DECLARE_BITMAP(clrm, bits);
>                 DECLARE_BITMAP(setm, bits);
> 
> Can someone please adjust this to make these fixed size again?

Oops, sorry about that. We will provide a solution for this.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
