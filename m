Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-2-hch@lst.de>
 <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr> <20190214170510.GC32441@lst.de> <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
In-Reply-To: <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 18:30:09 +0900
Message-ID: <CAK7LNATnsMbciyEd-1HZZmb5A66-TBtq0R3X-=JPMNT6iADo4w@mail.gmail.com>
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Christoph Hellwig <hch@lst.de>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 15, 2019 at 5:18 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 14/02/2019 =C3=A0 18:05, Christoph Hellwig a =C3=A9crit :
> > On Thu, Feb 14, 2019 at 09:26:19AM +0100, Christophe Leroy wrote:
> >> Could you also remove the 'config GENERIC_CSUM' item in
> >> arch/powerpc/Kconfig ?
> >
> > All the separate declarations go away later in this series.
> >
>
> I saw, but the purpose of the later patch is to replace arch defined
> GENERIC_CSUM by a common one that arches select. For the powerpc you are
> not in that case as the powerpc does not select GENERIC_CSUM.
>
> So I really believe that all stale bits of remaining GENERIC_CSUM in
> powerpc should go away as a single dedicated patch, as a fix of commit
> d4fde568a34a ("powerpc/64: Use optimized checksum routines on
> little-endian")
>
> Regarding the #ifdef __KERNEL__ , I think we should do a wide cleanup in
> arch/powerpc/include/asm, not only asm/checksum.h
>
> Christophe


Please send such cleanups to PowerPC ML
instead of to me (Kbuild).


Christoph,
I think this one is independent of the rest of this series.
How about separating it if you volunteer to Powerpc cleansup?


--=20
Best Regards
Masahiro Yamada
