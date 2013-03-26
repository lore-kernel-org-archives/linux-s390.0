From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 26 Mar 2013 08:16:22 +0000
Subject: Re: [PATCH 1/2] s390: remove unnecessary macro definisions in asm/bitops.h
Message-Id: <20130326081622.GA7499@osiris>
In-Reply-To: <1364047530-27458-1-git-send-email-akinobu.mita@gmail.com>
References: <1364047530-27458-1-git-send-email-akinobu.mita@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Mar 23, 2013 at 11:05:29PM +0900, Akinobu Mita wrote:
> Remove unused __BITOPS_ALIGN, and replace __BITOPS_WORDSIZE with
> BITS_PER_LONG.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/bitops.h | 110 ++++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 57 deletions(-)

Applied, thanks.
