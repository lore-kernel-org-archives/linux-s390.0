From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [PATCH net-next 1/1] net/smc: add SMC rendezvous protocol
Date: Thu, 12 Oct 2017 12:48:04 +0200
Message-ID: <b37b38df-cbb8-ca86-d460-9d3ec7acc2c6@linux.vnet.ibm.com>
References: <20171010141419.88190-1-ubraun@linux.vnet.ibm.com>
 <20171011.140652.272274136617199385.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171011.140652.272274136617199385.davem@davemloft.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, hwippel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>


On 10/11/2017 11:06 PM, David Miller wrote:
> From: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Date: Tue, 10 Oct 2017 16:14:19 +0200
> 
>> The goal of this patch is to leave common TCP code unmodified. Thus,
>> it uses netfilter hooks to intercept TCP SYN and SYN/ACK
>> packets. For outgoing packets originating from SMC sockets, the
>> experimental option is added. For inbound packets destined for SMC
>> sockets, the experimental option is checked.
> 
> I think this really isn't going to pass.
> 
> It's a user experience nightmare when the kernel inserts and
> deletes filtering rules outside of what the user configures
> on their system.
> 
> This approach was also considerd for ipv6 ILA, and the same
> pushback was given.
> 
> Why not add support for these new options as a normal TCP
> socket option based feature?  Then normal userspace as well
> as the SMC stack can make use of it.
> 

Do you mean a solution like

https://www.mail-archive.com/netdev@vger.kernel.org/msg71321.html
https://www.mail-archive.com/netdev@vger.kernel.org/msg71324.html

with a new smc_rendezvous TCP socket option as trigger?
