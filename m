Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180824094225.68b2adc6@mschwideX1>
References: <20180824094225.68b2adc6@mschwideX1>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 4 Sep 2018 17:16:31 -0700
Message-ID: <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 4.19 merge window #2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 24, 2018 at 12:42 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> Harald Freudenberger (5):
>       s390/zcrypt: hex string mask improvements for apmask and aqmask.

This (and an earlier 2017 commit) adds VLAs, which are being
removed[1] from the kernel:

drivers/s390/crypto/ap_bus.c:980:3: warning: ISO C90 forbids variable
length array =E2=80=98clrm=E2=80=99 [-Wvla]
drivers/s390/crypto/ap_bus.c:981:3: warning: ISO C90 forbids variable
length array =E2=80=98setm=E2=80=99 [-Wvla]
drivers/s390/crypto/ap_bus.c:995:3: warning: ISO C90 forbids variable
length array =E2=80=98setm=E2=80=99 [-Wvla]

static int process_mask_arg(const char *str,
                            unsigned long *bitmap, int bits,
                            struct mutex *lock)
...
                DECLARE_BITMAP(clrm, bits);
                DECLARE_BITMAP(setm, bits);

Can someone please adjust this to make these fixed size again?

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXydAa=
cU1RqZWA@mail.gmail.com

--=20
Kees Cook
Pixel Security
