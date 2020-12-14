Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395515AbgLNTSG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Dec 2020 14:18:06 -0500
Subject: Re: [PATCH -next] s390/crypto/zcrypt_cex2a: convert comma to
 semicolon
References: <20201214134403.4723-1-zhengyongjun3@huawei.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <3012ad5b-d667-2d27-9c4c-93742f25d1e3@linux.ibm.com>
Date: Mon, 14 Dec 2020 20:17:13 +0100
MIME-Version: 1.0
In-Reply-To: <20201214134403.4723-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Zheng Yongjun <zhengyongjun3@huawei.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

applied to the s390 subsystem. This will go upstream with the next kernel merge window.
Thanks

On 14.12.20 14:44, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_cex2a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
> index 226a5612e855..62ceeb7fc125 100644
> --- a/drivers/s390/crypto/zcrypt_cex2a.c
> +++ b/drivers/s390/crypto/zcrypt_cex2a.c
> @@ -175,7 +175,7 @@ static int zcrypt_cex2a_queue_probe(struct ap_device *ap_dev)
>  	atomic_set(&zq->load, 0);
>  	ap_queue_init_state(aq);
>  	ap_queue_init_reply(aq, &zq->reply);
> -	aq->request_timeout = CEX2A_CLEANUP_TIME,
> +	aq->request_timeout = CEX2A_CLEANUP_TIME;
>  	aq->private = zq;
>  	rc = zcrypt_queue_register(zq);
>  	if (rc) {
