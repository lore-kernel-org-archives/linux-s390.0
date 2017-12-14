Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Dec 2017 09:40:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 39/45] arch/s390: remove duplicate includes
References: <1512930417-4796-1-git-send-email-pravin.shedge4linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512930417-4796-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-Id: <20171214084058.GC4238@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: schwidefsky@de.ibm.com, gregkh@linuxfoundation.org, mingo@kernel.org, labbott@redhat.com, tglx@linutronix.de, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Dec 10, 2017 at 11:56:57PM +0530, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
> 
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
> ---
>  arch/s390/kernel/kprobes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> index af3722c..943d13e 100644
> --- a/arch/s390/kernel/kprobes.c
> +++ b/arch/s390/kernel/kprobes.c
> @@ -20,7 +20,6 @@
>  #include <linux/ftrace.h>
>  #include <asm/set_memory.h>
>  #include <asm/sections.h>
> -#include <linux/uaccess.h>
>  #include <asm/dis.h>

Applied, thanks.
