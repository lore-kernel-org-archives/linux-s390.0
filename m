From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [patch 1/1] tcp: introduce TCP experimental option for SMC-R
Date: Mon, 01 Jul 2013 16:53:24 +0200
Message-ID: <1372690404.15336.8.camel@BR9GV9YG.de.ibm.com>
References: <20130625135904.840700403@linux.vnet.ibm.com>
	 <20130625140033.744208982@linux.vnet.ibm.com>
	 <20130626.152228.1637104209838437474.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20130626.152228.1637104209838437474.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2013-06-26 at 15:22 -0700, David Miller wrote:
> We've already been bitten by having things like the VXLAN port number
> change on us after we've deployed the feature already.  So this must
> be finalized in a real RFC before I am willing to consider this patch.
> 
> Also, I and everyone else, wants to see the user of these new flags
> and behavior.  That means you must post the entire SMC-R protocol stack
> implementation at the time that you want this set of changes integrated.
> 
> I'm not applying this patch until both of those issues are fully resolved.
> 
> Thanks.
> 

Dave,

thanks for your response. I understand that you do not want to apply it
this time when we do not have the using code ready. This will take us
some more time.
IBM intends to close the "Shared Memory Communications over RDMA" RFC
[1] within a couple of months making it a published RFC, which should
promote it into a status you would accept -- right? 
By the way, the TCP experimental option for SMC-R is already an official
ID assigned from IANA [2]. 
Thus we are working on resolving both of your issues and intend to come
back with this base tcp patch and its exploiting new address family in a
few months. 

Kind regards, Ursula Braun

[1] http://datatracker.ietf.org/doc/draft-fox-tcpm-shared-memory-rdma/
[2] http://www.iana.org/assignments/tcp-parameters
