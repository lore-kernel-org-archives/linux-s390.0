From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 08 Oct 2012 07:01:20 +0000
Subject: Re: [PATCH] [S390] zcrypt: remove duplicated include from zcrypt_pcixcc.c
Message-Id: <20121008070120.GA4170@osiris.de.ibm.com>
In-Reply-To: <CAPgLHd9aVhxpHuPSBpD2qi3ztJ4nuCQge5hGx8Jta4HVBK8BTA@mail.gmail.com>
References: <CAPgLHd9aVhxpHuPSBpD2qi3ztJ4nuCQge5hGx8Jta4HVBK8BTA@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Oct 07, 2012 at 09:28:49PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/s390/crypto/zcrypt_pcixcc.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks!
