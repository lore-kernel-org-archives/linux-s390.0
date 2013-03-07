From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 07 Mar 2013 06:27:31 +0000
Subject: Re: [PATCH v1] s390: Remove redundant NULL check before kfree
Message-Id: <20130307062731.GA4115@osiris>
In-Reply-To: <1362600235-5993-1-git-send-email-s.syam@samsung.com>
References: <1362600235-5993-1-git-send-email-s.syam@samsung.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 07, 2013 at 01:33:55AM +0530, syamsidhardh@gmail.com wrote:
> From: Syam Sidhardhan <s.syam@samsung.com>
> 
> kfree on NULL pointer is a no-op.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>

Applied, thanks.
