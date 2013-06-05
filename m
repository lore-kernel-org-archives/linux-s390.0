From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] clean up scary strncpy(dst, src, strlen(src)) uses
Date: Wed, 5 Jun 2013 16:48:04 -0700
Message-ID: <20130605164804.8071867d28c1f20cad8d7d2a@linux-foundation.org>
References: <20130531161807.GA9536@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130531161807.GA9536@www.outflux.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

On Fri, 31 May 2013 09:18:07 -0700 Kees Cook <keescook@chromium.org> wrote:

> Fix various weird constructions of strncpy(dst, src, strlen(src)). Length
> limits should be about the space available in the destination, not
> repurposed as a method to either always include or always exclude
> a trailing NULL byte. Either the NULL should always be copied
> (using strlcpy), or it should not be copied (using something like
> memcpy). Readable code should not depend on the weird behavior of strncpy
> when it hits the length limit. Better to avoid the anti-pattern entirely.
> 
> ...
>
> --- a/Documentation/accounting/getdelays.c
> +++ b/Documentation/accounting/getdelays.c
> @@ -23,6 +23,7 @@
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>  #include <signal.h>
> +#include <bsd/string.h>
>  
>  #include <linux/genetlink.h>
>  #include <linux/taskstats.h>
> @@ -299,7 +300,7 @@ int main(int argc, char *argv[])
>  			break;
>  		case 'C':
>  			containerset = 1;
> -			strncpy(containerpath, optarg, strlen(optarg) + 1);
> +			strlcpy(containerpath, optarg, sizeof(containerpath));
>  			break;
>  		case 'w':
>  			logfile = strdup(optarg);

Documentation/accounting/getdelays.c:26:24: fatal error: bsd/string.h: No such file or directory

I'll revert this part.
