Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbhAGR23 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jan 2021 12:28:29 -0500
Subject: Re: [PATCH -next] s390: cio: Use DEFINE_SPINLOCK() for spinlock
References: <20201223141512.1178-1-zhengyongjun3@huawei.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <3aed4509-a903-5b26-3667-ad420b1bbb7b@linux.ibm.com>
Date: Thu, 7 Jan 2021 18:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <20201223141512.1178-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Zheng Yongjun <zhengyongjun3@huawei.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 23.12.20 15:15, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/s390/cio/css.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index cca1a7c4bb33..022f573f0bcc 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -647,13 +647,12 @@ static void css_sch_todo(struct work_struct *work)
>  }
>  
>  static struct idset *slow_subchannel_set;
> -static spinlock_t slow_subchannel_lock;
> +static DEFINE_SPINLOCK(slow_subchannel_lock);
>  static wait_queue_head_t css_eval_wq;
>  static atomic_t css_eval_scheduled;
>  
>  static int __init slow_subchannel_init(void)
>  {
> -	spin_lock_init(&slow_subchannel_lock);


>  	atomic_set(&css_eval_scheduled, 0);
>  	init_waitqueue_head(&css_eval_wq);

Mind turning these two into static initializations as well? Thanks.


>  	slow_subchannel_set = idset_sch_new();
> 
