From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RESEND PATCH v3 05/11] mtd: rawnand: vf610_nfc: add
 initializer to avoid -Wmaybe-uninitialized
Date: Fri, 3 May 2019 13:11:52 +0200
Message-ID: <20190503131152.57b4ce25@xps13>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
        <20190423034959.13525-6-yamada.masahiro@socionext.com>
        <20190502161346.07c15187@xps13>
        <CAK7LNAQH8v8_HG6-cytT4qe05W9iiYwEP1mud4zG2NxxYcFptQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQH8v8_HG6-cytT4qe05W9iiYwEP1mud4zG2NxxYcFptQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri, 3 May
2019 19:36:35 +0900:

> Hi Miquel,
> 
> On Thu, May 2, 2019 at 11:14 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 23 Apr
> > 2019 12:49:53 +0900:
> >  
> > > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > > place. We need to eliminate potential issues beforehand.
> > >
> > > Kbuild test robot has never reported -Wmaybe-uninitialized warning
> > > for this probably because vf610_nfc_run() is inlined by the x86
> > > compiler's inlining heuristic.
> > >
> > > If CONFIG_OPTIMIZE_INLINING is enabled for a different architecture
> > > and vf610_nfc_run() is not inlined, the following warning is reported:
> > >
> > > drivers/mtd/nand/raw/vf610_nfc.c: In function ‘vf610_nfc_cmd’:
> > > drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >    vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
> > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >             nfc->regs + NFC_MAIN_AREA(0) + offset,
> > >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >             trfr_sz, !nfc->data_access);
> > >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> >
> > IMHO this patch has no dependencies with this series.  
> 
> 
> This patch is the prerequisite for 11/11.
> https://lore.kernel.org/patchwork/patch/1064959/
> 
> 
> Without the correct patch order,
> the kbuild test robot reports the warning.
> 
> 
> > Would you mind sending it alone with the proper Fixes tag?  
> 
> 
> I do not think Fixes is necessary.

IMHO it is. Even if today the warning does not spawn, there is a
real C error which might already be an issue.

> 
> Nobody has noticed this potential issue before.
> Without 11/11, probably we cannot reproduce this warning.
> 
> 
> BTW, this series has been for a while in linux-next.

Missed that. Ok, nevermind.


Thanks,
Miquèl
