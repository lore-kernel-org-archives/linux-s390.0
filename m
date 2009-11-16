Return-Path: <linux-kernel-owner+w=401wt.eu-S1754378AbZKPVN0@vger.kernel.org>
Date: Mon, 16 Nov 2009 22:13:29 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: ensure NUL termination by strncpy()
Message-ID: <20091116211328.GA5828@osiris.boeblingen.de.ibm.com>
References: <4B019FC2.3060004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B019FC2.3060004@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 16, 2009 at 07:53:54PM +0100, Roel Kluin wrote:
> For a larger source string, strncpy only NUL terminates when
> the size argument is less than the size of the destination string.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/s390/kernel/ipl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Is this maybe needed?

No, kernel_nss_name as well as the data.nss.name char array within ipl_info
have the same size. So it will always fit and it is always NUL terminated.

Maybe it should be changed to a simple memcpy, like we have it at a second
place in the same file. I think that's up to Michael.

> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 4890ac6..d52fcb4 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -1881,7 +1881,7 @@ void __init setup_ipl(void)
>  		break;
>  	case IPL_TYPE_NSS:
>  		strncpy(ipl_info.data.nss.name, kernel_nss_name,
> -			sizeof(ipl_info.data.nss.name));
> +			sizeof(ipl_info.data.nss.name) - 1);
>  		break;
>  	case IPL_TYPE_UNKNOWN:
>  		/* We have no info to copy */
