Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 10 Sep 2018 08:35:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: zfcp_aux: remove unnecessary null pointer check
 before mempool_destroy
In-Reply-To: <1536399705-21676-1-git-send-email-zhongjiang@huawei.com>
References: <1536399705-21676-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Message-Id: <20180910083509.7a5359f5@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: zhong jiang <zhongjiang@huawei.com>
Cc: maier@linux.ibm.com, bblock@linux.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 8 Sep 2018 17:41:45 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> mempool_destroy has taken null pointer check into account. so remove the
> redundant check.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Applied to linux-390:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
