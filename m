Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] scripts/gdb: fix debugging modules on s390
References: <20191015105313.12663-1-iii@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
Date: Tue, 15 Oct 2019 17:21:16 +0200
MIME-Version: 1.0
In-Reply-To: <20191015105313.12663-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 15.10.19 12:53, Ilya Leoshkevich wrote:
> Currently lx-symbols assumes that module text is always located at
> module->core_layout->base, but s390 uses the following layout:
> 
> +------+  <- module->core_layout->base
> | GOT  |
> +------+  <- module->core_layout->base + module->arch->plt_offset
> | PLT  |
> +------+  <- module->core_layout->base + module->arch->plt_offset +
> | TEXT |     module->arch->plt_size
> +------+
> 
> Therefore, when trying to debug modules on s390, all the symbol
> addresses are skewed by plt_offset + plt_size.
> 
> Fix by adding plt_offset + plt_size to module_addr in
> load_module_symbols().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/gdb/linux/symbols.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f0d8f2ecfde7..41c6d1a55b03 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -15,7 +15,7 @@ import gdb
>  import os
>  import re
>  
> -from linux import modules
> +from linux import modules, utils
>  
>  
>  if hasattr(gdb, 'Breakpoint'):
> @@ -113,6 +113,12 @@ lx-symbols command."""
>          if module_file:
>              gdb.write("loading @{addr}: {filename}\n".format(
>                  addr=module_addr, filename=module_file))
> +            if utils.is_target_arch('s390'):
> +                # Module text is preceded by PLT stubs on s390.
> +                module_arch = module['arch']
> +                plt_offset = int(module_arch['plt_offset'])
> +                plt_size = int(module_arch['plt_size'])
> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)

Shouldn't we report the actual address above, ie. reorder this tuning
with the gdb.write?

>              cmdline = "add-symbol-file {filename} {addr}{sections}".format(
>                  filename=module_file,
>                  addr=module_addr,
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
