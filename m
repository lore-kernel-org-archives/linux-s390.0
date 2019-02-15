Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-7-hch@lst.de>
 <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
In-Reply-To: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 15 Feb 2019 15:58:11 +0800
Message-ID: <CAEbi=3ctaYwjCxOVaCyUrvT=741keKPwXj6v8rS9bzoTZPcsOA@mail.gmail.com>
Subject: Re: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Vincent Chen <deanbo422@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Yamada,

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B42=E6=
=9C=8815=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:17=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> +CC Greentime Hu
> +CC Vincent Chen
>
>
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add one definition to lib/Kconfig.debug and let the architectures
> > select if it supported.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
>
> This changes the behavior of nds32.
>
> So please leave a note in the commit description.
> (Ideally, we want Ack of a NDS32 maintainer)
>
> Also, please do compile test for NDS32.
>
>
> -------------------------
> This commit changes CONFIG_LOCKDEP_SUPPORT to y for nds32.
>
> NDS32 selects LOCKEP_SUPPORT, but there was previously
> no config entry of LOCKDEP_SUPPORT in nds32.
>
> It is now available in lib/Kconfig.debug,
> so this commit enables LOCKDEP_SUPPORT for nds32.
> -------------------------

Thank you to let us know this change.
I think it's ok to enable LOCKDEP_SUPPORT for nds32.
I just verified it in 5.0.0-rc1.
