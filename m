Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1549352017-3503-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1549352017-3503-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 14 Feb 2019 11:09:47 +0900
Message-ID: <CAK7LNATM-A_+KE59Q2oJTsvd_sgYnkuN4QqXjWdZrB_zxT94MA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move archive command to scripts/Makefile.lib
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 5, 2019 at 4:34 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> scripts/Makefile.build and arch/s390/boot/Makefile use the same
> command (thin archiving with symbol table creation).
>
> Avoid the code duplication, and move it to scripts/Makefile.lib.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>  arch/s390/boot/Makefile | 3 ---
>  scripts/Makefile.build  | 6 +-----
>  scripts/Makefile.lib    | 6 ++++++
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index 11ca879..c844eaf 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -57,9 +57,6 @@ $(obj)/section_cmp%: vmlinux $(obj)/compressed/vmlinux FORCE
>  $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
>         $(Q)$(MAKE) $(build)=$(obj)/compressed $@
>
> -quiet_cmd_ar = AR      $@
> -      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> -
>  $(obj)/startup.a: $(OBJECTS) FORCE
>         $(call if_changed,ar)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index f8e2794..99be01c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -424,13 +424,9 @@ $(modorder-target): $(subdir-ym) FORCE
>  # Rule to compile a set of .o files into one .a file (with symbol table)
>  #
>  ifdef lib-target
> -quiet_cmd_link_l_target = AR      $@
> -
> -# lib target archives do get a symbol table and index
> -cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
>
>  $(lib-target): $(lib-y) FORCE
> -       $(call if_changed,link_l_target)
> +       $(call if_changed,ar)
>
>  targets += $(lib-target)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index c0abd9a..8a1f64f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -233,6 +233,12 @@ $(obj)/%: $(src)/%_shipped
>  quiet_cmd_ld = LD      $@
>        cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
>
> +# Archive
> +# ---------------------------------------------------------------------------
> +
> +quiet_cmd_ar = AR      $@
> +      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> +
>  # Objcopy
>  # ---------------------------------------------------------------------------
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
