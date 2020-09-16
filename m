Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 16 Sep 2020 14:20:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH -next] s390/ap: remove unnecessary spin_lock_init()
Message-ID: <20200916122046.GB7076@osiris>
References: <20200916062130.190910-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916062130.190910-1-miaoqinglang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:21:30PM +0800, Qinglang Miao wrote:
> The spinlock ap_poll_timer_lock is initialized statically. It is
> unnecessary to initialize by spin_lock_init().
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
