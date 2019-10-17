Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:50691 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQOLm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Oct 2019 10:11:42 -0400
Subject: Re: [PATCH v2] scripts/gdb: fix debugging modules on s390
References: <20191017085917.81791-1-iii@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a6114e4d-0b5b-4e71-8408-f2f1d41bb9d1@siemens.com>
Date: Thu, 17 Oct 2019 16:11:20 +0200
MIME-Version: 1.0
In-Reply-To: <20191017085917.81791-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 17.10.19 10:59, Ilya Leoshkevich wrote:
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
> 
> v1 -> v2: print the adjusted address.
> 
>  scripts/gdb/linux/symbols.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f0d8f2ecfde7..df4c810de663 100644
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
> @@ -111,6 +111,12 @@ lx-symbols command."""
>              module_file = self._get_module_file(module_name)
>  
>          if module_file:
> +            if utils.is_target_arch('s390'):
> +                # Module text is preceded by PLT stubs on s390.
> +                module_arch = module['arch']
> +                plt_offset = int(module_arch['plt_offset'])
> +                plt_size = int(module_arch['plt_size'])
> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
>              gdb.write("loading @{addr}: {filename}\n".format(
>                  addr=module_addr, filename=module_file))
>              cmdline = "add-symbol-file {filename} {addr}{sections}".format(
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
