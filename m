Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:55175 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfJ3S3v (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 14:29:51 -0400
Subject: Re: [PATCH] scripts/gdb: fix debugging modules compiled with hot/cold
 partitioning
References: <20191028152734.13065-1-iii@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <130e31f0-ce38-77cb-58a9-cedf3b0f8113@siemens.com>
Date: Wed, 30 Oct 2019 19:29:33 +0100
MIME-Version: 1.0
In-Reply-To: <20191028152734.13065-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 28.10.19 16:27, Ilya Leoshkevich wrote:
> gcc's -freorder-blocks-and-partition option makes it group frequently
> and infrequently used code in .text.hot and .text.unlikely sections
> respectively. At least when building modules on s390, this option is
> used by default.
> 
> gdb assumes that all code is located in .text section, and that .text
> section is located at module load address. With such modules this is no
> longer the case: there is code in .text.hot and .text.unlikely, and
> either of them might precede .text.
> 
> Fix by explicitly telling gdb the addresses of code sections.
> 
> It might be tempting to do this for all sections, not only the ones in
> the white list. Unfortunately, gdb appears to have an issue, when telling
> it about e.g. loadable .note.gnu.build-id section causes it to think that
> non-loadable .note.Linux section is loaded at address 0, which in turn
> causes NULL pointers to be resolved to bogus symbols. So keep using the
> white list approach for the time being.

Did you report this to gdb?

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/gdb/linux/symbols.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 7b7c2fafbc68..be984aa29b75 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -99,7 +99,8 @@ lx-symbols command."""
>              attrs[n]['name'].string(): attrs[n]['address']
>              for n in range(int(sect_attrs['nsections']))}
>          args = []
> -        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss"]:
> +        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
> +                             ".text", ".text.hot", ".text.unlikely"]:
>              address = section_name_to_address.get(section_name)
>              if address:
>                  args.append(" -s {name} {addr}".format(
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
