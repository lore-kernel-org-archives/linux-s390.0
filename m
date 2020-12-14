Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH -next] s390/crypto/zcrypt_cex4: convert comma to semicolon
References: <20201214134341.4671-1-zhengyongjun3@huawei.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <b3da0c24-056a-7975-07b8-7096cd7f26b7@linux.ibm.com>
Date: Mon, 14 Dec 2020 20:16:39 +0100
MIME-Version: 1.0
In-Reply-To: <20201214134341.4671-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Zheng Yongjun <zhengyongjun3@huawei.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

applied to the s390 subsystem. This will go upstream with the next kernel merge window.
Thanks

On 14.12.20 14:43, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_cex4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
> index f5195bca1d85..f4a6d3744241 100644
> --- a/drivers/s390/crypto/zcrypt_cex4.c
> +++ b/drivers/s390/crypto/zcrypt_cex4.c
> @@ -631,7 +631,7 @@ static int zcrypt_cex4_queue_probe(struct ap_device *ap_dev)
>  	atomic_set(&zq->load, 0);
>  	ap_queue_init_state(aq);
>  	ap_queue_init_reply(aq, &zq->reply);
> -	aq->request_timeout = CEX4_CLEANUP_TIME,
> +	aq->request_timeout = CEX4_CLEANUP_TIME;
>  	aq->private = zq;
>  	rc = zcrypt_queue_register(zq);
>  	if (rc) {
