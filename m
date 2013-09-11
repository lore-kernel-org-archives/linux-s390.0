From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 11 Sep 2013 05:32:50 +0000
Subject: Re: [PATCH] s390/3270: fix return value check in tty3270_resize_work()
Message-Id: <20130911053250.GA4111@osiris>
In-Reply-To: <CAPgLHd9h2yi1NQdpQGXuCwewLY1ycuUqBx7Hp14=DJaVgGAEgw@mail.gmail.com>
References: <CAPgLHd9h2yi1NQdpQGXuCwewLY1ycuUqBx7Hp14=DJaVgGAEgw@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 11, 2013 at 06:49:20AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function tty3270_alloc_screen() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks!
