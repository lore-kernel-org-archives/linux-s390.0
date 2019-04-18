Return-Path: <SRS0=5x4E=SU=vger.kernel.org=netdev-owner@kernel.org>
Date: Wed, 17 Apr 2019 23:25:49 -0700 (PDT)
Message-Id: <20190417.232549.1308308517577845890.davem@davemloft.net>
Subject: Re: [PATCH net] s390: ctcm: fix ctcm_new_device error return code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190417162913.90238-1-jwi@linux.ibm.com>
References: <20190417162913.90238-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com, arnd@arndb.de
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 17 Apr 2019 18:29:13 +0200

> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang points out that the return code from this function is
> undefined for one of the error paths:
> 
> ../drivers/s390/net/ctcm_main.c:1595:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true
>       [-Wsometimes-uninitialized]
>                 if (priv->channel[direction] == NULL) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1638:9: note: uninitialized use occurs here
>         return result;
>                ^~~~~~
> ../drivers/s390/net/ctcm_main.c:1595:3: note: remove the 'if' if its condition is always false
>                 if (priv->channel[direction] == NULL) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1539:12: note: initialize the variable 'result' to silence this warning
>         int result;
>                   ^
> 
> Make it return -ENODEV here, as in the related failure cases.
> gcc has a known bug in underreporting some of these warnings
> when it has already eliminated the assignment of the return code
> based on some earlier optimization step.
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied.
