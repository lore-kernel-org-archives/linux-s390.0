From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/2] s390/qeth: fixes 2019-09-26
Date: Fri, 28 Sep 2018 23:08:09 -0700 (PDT)
Message-ID: <20180928.230809.662211084432486440.davem@davemloft.net>
References: <20180926160710.64739-1-jwi@linux.ibm.com>
        <20180926.103948.934917523873266650.davem@davemloft.net>
        <3d426fbf-9045-7af9-6a06-4c840ec7d690@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3d426fbf-9045-7af9-6a06-4c840ec7d690@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 28 Sep 2018 11:05:22 +0200

> On 26.09.2018 19:39, David Miller wrote:
>> From: Julian Wiedmann <jwi@linux.ibm.com>
>> Date: Wed, 26 Sep 2018 18:07:08 +0200
>> 
>>> please apply two qeth patches for -net. The first is a trivial cleanup
>>> required for patch #2 by Jean, which fixes a potential endless loop.
>> 
>> Series applied, thank you.
>> 
> 
> Odd, doesn't look like they arrived in -net though. Forgot to push them out?
> Thanks.

They are there.

When I say "applied" that means "in my tree and build testing".

Sometimes I have to run off somewhere while the build is still running
and thus the push doesn't happen until I get back, which can be up to
a day later.
