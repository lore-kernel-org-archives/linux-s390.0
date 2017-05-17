From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 16:53:43 +0000
Subject: Re: [PATCH -next] s390/scm_block: fix error return code in scm_blk_dev_setup()
Message-Id: <alpine.LFD.2.20.1705171849360.1753@schleppi>
In-Reply-To: <20170517164028.5319-1-weiyj.lk@gmail.com>
References: <20170517164028.5319-1-weiyj.lk@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 May 2017, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Thanks, but we have the exact same patch queued up internally. It should
appear in linux-next in the next couple of days.

Regards,
Sebastian
