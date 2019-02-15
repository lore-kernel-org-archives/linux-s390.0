Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-10-hch@lst.de>
In-Reply-To: <20190213174005.28785-10-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 17:03:19 +0900
Message-ID: <CAK7LNAQL-7fMadH1R2SrmwJyDBRoCiECJ-WSJrztO2o+wkV06w@mail.gmail.com>
Subject: Re: [PATCH 09/11] lib: consolidate the GENERIC_CSUM symbol
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 14, 2019 at 2:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add one definition to lib/Kconfig and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>



> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index 52b4d48e351a..9de1d983a99a 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -29,9 +29,6 @@ config UNICORE32
>           designs licensed by PKUnity Ltd.
>           Please see web page at <http://www.pkunity.com/>.
>
> -config GENERIC_CSUM
> -       def_bool y
> -
>  config NO_IOPORT_MAP
>         bool
>



You missed to add 'select GENERIC_CSUM' for unicore32.



-- 
Best Regards
Masahiro Yamada
