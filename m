Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 10 Sep 2018 08:37:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/2] s390: Use ARRAY_SIZE instead of reimplementing its
 function
In-Reply-To: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Message-Id: <20180910083725.6e5a74d2@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: zhong jiang <zhongjiang@huawei.com>
Cc: heiko.carstens@de.ibm.com, jwi@linux.ibm.com, ubraun@linux.ibm.com, jdelvare@suse.de, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 8 Sep 2018 18:26:26 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> I find the issue with the help of Coccinelle.
> 
> zhong jiang (2):
>   s390: vmlogrdr: Use ARRAY_SIZE instead of reimplementing its function
>   s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its
>     function
> 
>  drivers/s390/char/vmlogrdr.c     | 2 +-
>  drivers/s390/net/qeth_core_mpc.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Both patches applied to linux-s390:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
