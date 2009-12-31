From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 31 Dec 2009 10:07:06 +0000
Subject: Re: [PATCH] S390:  Have param.h simply include
Message-Id: <20091231100706.GB7098@osiris.boeblingen.de.ibm.com>
In-Reply-To: <alpine.LFD.2.00.0912300352450.12926@localhost>
References: <alpine.LFD.2.00.0912300352450.12926@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 30, 2009 at 03:54:31AM -0500, Robert P. J. Day wrote:
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>   since the files have identical content, might as well simplify.
> 
> diff --git a/arch/s390/include/asm/param.h b/arch/s390/include/asm/param.h
> index 34aaa46..c616821 100644
> --- a/arch/s390/include/asm/param.h
> +++ b/arch/s390/include/asm/param.h

...

> +#include <asm-generic/param.h>

Applied, thank you!
