Return-Path: <linux-kernel-owner+w=401wt.eu-S1752279AbZIKMS0@vger.kernel.org>
Date: Fri, 11 Sep 2009 14:18:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 04/10] s390: Convert BUG() to use unreachable()
Message-ID: <20090911141824.2c7ce579@skybase>
In-Reply-To: <1252627011-2933-4-git-send-email-ddaney@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
	<1252627011-2933-4-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 10 Sep 2009 16:56:45 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> Use the new unreachable() macro instead of for(;;);
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: linux390@de.ibm.com
> CC: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/bug.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> index 7efd0ab..efb74fd 100644
> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -49,7 +49,7 @@
> 
>  #define BUG() do {					\
>  	__EMIT_BUG(0);					\
> -	for (;;);					\
> +	unreachable();					\
>  } while (0)
> 
>  #define WARN_ON(x) ({					\

That seems simple enough ;-)

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
