Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Feb 2013 07:52:57 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/dis: Fix invalid array size
Message-ID: <20130225065257.GA4040@osiris>
References: <1361744145-28112-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1361744145-28112-1-git-send-email-s.syam@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, borntraeger@de.ibm.com, jang@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 25, 2013 at 03:45:45AM +0530, Syam Sidhardhan wrote:
> We are using sizeof operator for an array given as function argument,
> which is incorrect.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  arch/s390/kernel/dis.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
> index c50665f..3ad5e95 100644
> --- a/arch/s390/kernel/dis.c
> +++ b/arch/s390/kernel/dis.c
> @@ -1711,10 +1711,10 @@ int insn_to_mnemonic(unsigned char *instruction, char buf[8])
>  	if (!insn)
>  		return -ENOENT;
>  	if (insn->name[0] == '\0')
> -		snprintf(buf, sizeof(buf), "%s",
> +		snprintf(buf, 8, "%s",
>  			 long_insn_name[(int) insn->name[1]]);

Thanks, applied.
