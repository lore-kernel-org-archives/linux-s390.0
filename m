From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V4 0/5] net/smc: fixes 2018-11-12
Date: Wed, 21 Nov 2018 16:15:14 -0800 (PST)
Message-ID: <20181121.161514.1667274033320128649.davem@davemloft.net>
References: <20181120154643.24111-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181120154643.24111-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 20 Nov 2018 16:46:38 +0100

> here is V4 of some net/smc fixes in different areas for the net tree.
> 
> v1->v2:
>    do not define 8-byte alignment for union smcd_cdc_cursor in
>    patch 4/5 "net/smc: atomic SMCD cursor handling"
> v2->v3:
>    stay with 8-byte alignment for union smcd_cdc_cursor in
>    patch 4/5 "net/smc: atomic SMCD cursor handling", but get rid of
>    __packed for struct smcd_cdc_msg
> v3->v4:
>    get rid of another __packed for struct smc_cdc_msg in
>    patch 4/5 "net/smc: atomic SMCD cursor handling"

Series applied, thanks.
