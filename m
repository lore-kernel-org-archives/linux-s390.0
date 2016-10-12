From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 net-next 15/15] smc: proc-fs interface for smc
 connections
Date: Wed, 12 Oct 2016 16:00:27 +0200
Message-ID: <a02646ea-9f36-85fc-f761-fd6ed123051c@linux.vnet.ibm.com>
References: <20160927164156.26184-1-ubraun@linux.vnet.ibm.com>
 <20160927164156.26184-16-ubraun@linux.vnet.ibm.com>
 <20160927.222741.584893707513031004.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20160927.222741.584893707513031004.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


Hi Dave,

thank you for your feedback. Following your guidance I studied the
inet_diag/tcp_diag kernel code for AF_INET sockets. It could make sense
to create an smc_diag module with an smc_diag_handler to provide
SMC-socket data to userspace. Userspace tools could exploit this by
receiving the SMC-socket data via AF_NETLINK sockets of protocol
NETLINK_SOCK_DIAG.
Please let me know, if this is the right direction.

Regards, Ursula

On 09/28/2016 04:27 AM, David Miller wrote:
> From: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Date: Tue, 27 Sep 2016 18:41:56 +0200
> 
>> Maintain a list of SMC sockets and display important SMC socket
>> information in /proc/net/smc.
>>
>> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
> 
> Dumping internal tables and information via /procfs is strongly
> deprecated.
> 
> Please use a more modern mechanism (such as netlink) to expose this
> information to the user.
> 
> You'll be most likely to succeed in your submission if you make use of
> or design a generic facility that allows other drivers similar to
> your's to provide this kind of information as well.
> 
> I'm sorry if this is frustrating, but this is a huge piece of
> infrastructure, therefore you can expect lots of pieces to get
> feedback and require changes like this.
> 
> 
