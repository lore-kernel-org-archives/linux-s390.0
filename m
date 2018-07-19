Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 16:40:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/dasd: replace PTR_RET with PTR_ERR_OR_ZERO
In-Reply-To: <20180719045050.GA25103@embeddedor.com>
References: <20180719045050.GA25103@embeddedor.com>
MIME-Version: 1.0
Message-Id: <20180719164059.5e689f4f@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Jul 2018 23:50:50 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index bbf95b7..c5a5551 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -3535,7 +3535,7 @@ static int prepare_itcw(struct itcw *itcw,
> 
>  	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
>  		     &pfxdata, sizeof(pfxdata), total_data_size);
> -	return PTR_RET(dcw);
> +	return PTR_ERR_OR_ZERO(dcw);
>  }
> 
>  static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(

Applied to the s390/linux tree for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
