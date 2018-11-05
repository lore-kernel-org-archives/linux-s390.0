From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v4.20-rc1
Date: Mon, 5 Nov 2018 23:12:12 +0100
Message-ID: <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
References: <20181105220559.27458-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105220559.27458-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.20-rc1[1] compared to v4.19[2].
>
> Summarized:
>   - build errors: +3/-0
>   - build warnings: +449/-2712
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
>
>
> *** ERRORS ***
>
> 3 error regressions:
>   + /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3:  => 130:61

s390-all{mod,yes}config

>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3

sh4-all{mod,yes}config

Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
pci_iomap() on SH")
is not sufficient?

>   + {standard input}: Error: Unrecognized opcode: `slbfee.':  => 89, 37

powerpc-all{mod,yes}config

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
