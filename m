From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 26 Mar 2013 08:16:36 +0000
Subject: Re: [PATCH 2/2] s390/cio: Use BITS_TO_LONGS() instead of __BITOPS_WORDS()
Message-Id: <20130326081636.GB7499@osiris>
In-Reply-To: <1364047530-27458-2-git-send-email-akinobu.mita@gmail.com>
References: <1364047530-27458-2-git-send-email-akinobu.mita@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Mar 23, 2013 at 11:05:30PM +0900, Akinobu Mita wrote:
> Use BITS_TO_LONGS() instead of __BITOPS_WORDS() that is considered
> to be private macro in asm/bitops.h for s390.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/cio/idset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
