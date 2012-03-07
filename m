From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [patch 4/7] [PATCH] ctcm: make ctcmpc debugging compilable
Date: Wed, 07 Mar 2012 17:53:12 +0100
Message-ID: <1331139192.15095.12.camel@br9gv9yg.de.ibm.com>
References: <OFA80676C5.CF55E2E0-ONC12579BA.005B3444-C12579BA.005B44A4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <OFA80676C5.CF55E2E0-ONC12579BA.005B3444-C12579BA.005B44A4@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David.Laight@aculab.com
Cc: Uschi IBM <ursula.braun@de.ibm.com>, frank.blaschka@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> From: "David Laight" <David.Laight@aculab.com>
> To: <frank.blaschka@de.ibm.com>, <davem@davemloft.net>
> Cc: <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
>  <ursula.braun@de.ibm.com> 
> Date: 07/03/2012 13:20
> Subject: RE: [patch 4/7] [PATCH] ctcm: make ctcmpc debugging compilable
> 
> What is wrong with:
>                  char addr[24];
>                  snprintf(addr, sizeof addr, "%p", rptr);
> 
> There seemed to be other 'dangerous' unbounded string
> operations in that code as well.
> 
>                  David

David,

nothing is wrong with your proposal to make use of %p here. Quite the
contrary - it improves the ctcmpc-code. I will keep your proposal in my
mind for a future follow-on ctcmpc-patch. Thanks!

My patch targets compilability of ctcmpc debugging code only.

Ursula
