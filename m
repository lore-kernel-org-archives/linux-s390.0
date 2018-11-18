From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V3 0/5] net/smc: fixes 2018-11-12
Date: Sat, 17 Nov 2018 21:29:51 -0800 (PST)
Message-ID: <20181117.212951.1737614895221053174.davem@davemloft.net>
References: <20181116123617.72948-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181116123617.72948-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Fri, 16 Nov 2018 13:36:12 +0100

> v2->v3:
>    stay with 8-byte alignment for union smcd_cdc_cursor in
>    patch 4/5 "net/smc: atomic SMCD cursor handling", but get rid of
>    __packed for struct smcd_cdc_msg

This SMC-D message is defined in some standard somewhere, right?  So
if this __packed removal changes the layout it will break things.

I see smc_cdc_msg has the same issue, and it's layout is defined in
RFC7609.

If the __packed removal doesn't change the layout, you should remove it
from smc_cdc_msg too for consistency.

This is why I tell people to never use __packed.
