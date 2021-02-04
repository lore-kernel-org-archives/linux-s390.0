Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Feb 2021 09:32:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH -next] KVM: s390: Return the correct errno code
Message-ID: <20210204093227.3f088c8a.cohuck@redhat.com>
In-Reply-To: <20210204080523.18943-1-zhengyongjun3@huawei.com>
References: <20210204080523.18943-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Zheng Yongjun <zhengyongjun3@huawei.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 4 Feb 2021 16:05:23 +0800
Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> When valloc failed, should return ENOMEM rather than ENOBUF.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2f177298c663..6b7acc27cfa2 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2252,7 +2252,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
>  	 */
>  	buf = vzalloc(len);
>  	if (!buf)
> -		return -ENOBUFS;
> +		return -ENOMEM;
>  
>  	max_irqs = len / sizeof(struct kvm_s390_irq);
>  

This breaks a user space interface (see the comment right above the
vzalloc).
