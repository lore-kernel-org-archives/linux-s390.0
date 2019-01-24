Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 24 Jan 2019 13:27:54 +0900
Message-ID: <CAK7LNAQdndZMEUSkoVrSeqDL3rq2NXm83seFXC6a8SjMTNVmOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kbuild: simplify rules of data compression with
 size appending
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 17, 2019 at 7:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> All the callers of size_append pass $(filter-out FORCE,$^).
> Move $(filter-out FORCE,$^) to the definition of size_append.
>
> This makes the callers cleaner because $(call ...) is unneeded
> for a macro with no argument.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.


> Changes in v2: None
>
>  scripts/Makefile.lib | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ecad15b..ebaa348 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -321,7 +321,7 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>  # append the size as a 32-bit littleendian number as gzip does.
>  size_append = printf $(shell                                           \
>  dec_size=0;                                                            \
> -for F in $1; do                                                                \
> +for F in $(filter-out FORCE,$^); do                                    \
>         fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);  \
>         dec_size=$$(expr $$dec_size + $$fsize);                         \
>  done;                                                                  \
> @@ -335,23 +335,20 @@ printf "%08x\n" $$dec_size |                                              \
>  )
>
>  quiet_cmd_bzip2 = BZIP2   $@
> -cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
> -       bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
>
>  # Lzma
>  # ---------------------------------------------------------------------------
>
>  quiet_cmd_lzma = LZMA    $@
> -cmd_lzma = (cat $(filter-out FORCE,$^) | \
> -       lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
>
>  quiet_cmd_lzo = LZO     $@
> -cmd_lzo = (cat $(filter-out FORCE,$^) | \
> -       lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
>
>  quiet_cmd_lz4 = LZ4     $@
> -cmd_lz4 = (cat $(filter-out FORCE,$^) | \
> -       lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
> +                  $(size_append)) > $@
>
>  # U-Boot mkimage
>  # ---------------------------------------------------------------------------
> @@ -394,8 +391,7 @@ quiet_cmd_uimage = UIMAGE  $@
>  # decompression mode. A BCJ filter isn't used either.
>  quiet_cmd_xzkern = XZKERN  $@
>  cmd_xzkern = (cat $(filter-out FORCE,$^) | \
> -       sh $(srctree)/scripts/xz_wrap.sh && \
> -       $(call size_append, $(filter-out FORCE,$^))) > $@
> +       sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
>
>  quiet_cmd_xzmisc = XZMISC  $@
>  cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
