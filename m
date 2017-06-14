Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1497447578.18751.51.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: [HLP]LIST_HEAD is also declaration
From: Joe Perches <joe@perches.com>
Date: Wed, 14 Jun 2017 06:39:38 -0700
In-Reply-To: <20170614133512.89425-1-maier@linux.vnet.ibm.com>
References: <1497437132.18751.45.camel@perches.com>
         <20170614133512.89425-1-maier@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2017-06-14 at 15:35 +0200, Steffen Maier wrote:
> Fixes the following false warning
> among others for LLIST_HEAD and PLIST_HEAD:
> 
>     WARNING: Missing a blank line after declarations
>     #71: FILE: drivers/s390/scsi/zfcp_fsf.c:422:
>     +	struct hlist_node *tmp;
>     +	HLIST_HEAD(remove_queue);
> 
> Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
> ---
> Changes from v1:
> Extended it to also support LLIST_HEAD and PLIST_HEAD as suggested by
> Joe Perches.

Acked-by: Joe Perches <joe@perches.com>

>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4b9569fa931b..86818b0ba8be 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -732,7 +732,7 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
>  
>  our $declaration_macros = qr{(?x:
>  	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
> -	(?:$Storage\s+)?LIST_HEAD\s*\(|
> +	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
>  	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(
>  )};
>  
