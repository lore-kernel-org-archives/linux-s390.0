From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 14 Sep 2012 06:24:11 +0000
Subject: Re: [PATCH] [S390] topology: using for_each_set_bit to simplify the code
Message-Id: <20120914062411.GA4343@osiris.de.ibm.com>
In-Reply-To: <CAPgLHd97TX3Xr2w7ckVzMQV3NGG=cco_QqRArKk7drCvcR=VFQ@mail.gmail.com>
References: <CAPgLHd97TX3Xr2w7ckVzMQV3NGG=cco_QqRArKk7drCvcR=VFQ@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 14, 2012 at 10:31:21AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Using for_each_set_bit() to simplify the code.
> 
> spatch with a semantic match is used to found this.
> (http://coccinelle.lip6.fr/)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, Thanks!
