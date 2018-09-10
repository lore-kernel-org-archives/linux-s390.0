Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 10 Sep 2018 08:34:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/zcrypt: Use kmemdup to replace kmalloc + memcpy
In-Reply-To: <1536396621-19363-1-git-send-email-zhongjiang@huawei.com>
References: <1536396621-19363-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Message-Id: <20180910083450.62379f4b@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: zhong jiang <zhongjiang@huawei.com>
Cc: freude@linux.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 8 Sep 2018 16:50:21 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> kmemdup has implemented the function that kmalloc() + memcpy() will
> do. and we prefer to use the kmemdup rather than the open coded implementation.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied to linux-390:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
