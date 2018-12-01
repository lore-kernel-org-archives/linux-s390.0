Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com> <20181126083633.GA10604@light.dominikbrodowski.net>
In-Reply-To: <20181126083633.GA10604@light.dominikbrodowski.net>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 1 Dec 2018 23:55:22 +0900
Message-ID: <CAK7LNASVcFj2-ooroLsyZgpVyv_xW1RJCkVtayg7sNxVjvHN=A@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: remove per-arch PCMCIA config entry
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Dike <jdike@addtoit.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 26, 2018 at 6:24 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Mon, Nov 26, 2018 at 05:15:41PM +0900, Masahiro Yamada wrote:
> > Now that all architectures include drivers/pcmcia/Kconfig where
> > the PCMCIA config is defined, the PCMCIA config entries in per-arch
> > Kconfig files are redundant.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > I will queue this up to my kbuild tree
> > along with Christoph's clean-up patch set.
>
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Thanks,
>         Dominik

Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
