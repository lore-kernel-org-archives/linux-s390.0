From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Sun, 31 Jul 2016 12:09:28 +0000
Subject: Re: [PATCH -next] s390/zcrypt: fix possible memory leak in ap_module_init()
Message-Id: <20160731080928.1f466366@mschwide>
In-Reply-To: <1469722402-14588-1-git-send-email-weiyj.lk@gmail.com>
References: <1469722402-14588-1-git-send-email-weiyj.lk@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 28 Jul 2016 16:13:22 +0000
Wei Yongjun <weiyj.lk@gmail.com> wrote:

> ap_configuration is malloced in ap_module_init() and should be freed
> before leaving from the error handling cases, otherwise it may cause
> memory leak.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Nice catch, applied.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
