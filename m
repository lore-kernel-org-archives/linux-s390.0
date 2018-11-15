From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2 0/5] net/smc: fixes 2018-11-12
Date: Thu, 15 Nov 2018 09:54:27 -0800 (PST)
Message-ID: <20181115.095427.1834989231745198763.davem@davemloft.net>
References: <20181115121120.98440-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181115121120.98440-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 15 Nov 2018 13:11:15 +0100

> v1->v2:
>    do not define 8-byte alignment for union smcd_cdc_cursor in
>    patch 4/5 "net/smc: atomic SMCD cursor handling"

This is even worse.

The atomic64_t must be properly 8 byte aligned, else it will
crash the kernel when an atomic operation is attempted on it.

You have a situation where your struct attributes are entirely
incompatible.  If the parent struct is __packed, you absolutely
cannot align the atomic64_t in the child structure properly.

One more time, __packed makes correctness here impossible.

I've warned strongly in the past to avoid __packed.

Now you have to untangle this mess somehow.
