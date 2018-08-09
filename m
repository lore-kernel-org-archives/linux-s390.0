Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 08 Aug 2018 19:14:53 -0700 (PDT)
Message-Id: <20180808.191453.882749744399950889.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] net/smc: fixes 2018-08-08
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180808121321.516-1-ubraun@linux.ibm.com>
References: <20180808121321.516-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed,  8 Aug 2018 14:13:18 +0200

> here are small fixes for SMC: The first patch makes sure, shutdown code
> is not executed for sockets in state SMC_LISTEN. The second patch resets
> send and receive buffer values for accepted sockets, since TCP buffer size
> optimizations for the internal CLC socket should not be forwarded to the
> outer SMC socket. The third patch solves a race between connect and ioctl
> reported by syzbot.

Series applied, thank you.
