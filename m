From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND net-next 13/15] smc: receive data from RMBE
Date: Fri, 2 Sep 2016 15:05:01 +0200
Message-ID: <7121effc-5f89-ac22-bbab-a8aedebae9fd@linux.vnet.ibm.com>
References: <1470737580-43012-14-git-send-email-ubraun@linux.vnet.ibm.com>
 <20160809.143245.2022037008405834176.davem@davemloft.net>
 <653f839a-8098-da62-3437-8b002d929a50@linux.vnet.ibm.com>
 <20160810.104556.1507709019319192063.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20160810.104556.1507709019319192063.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

sorry for the late answer; I had to interrupt my SMC-R activities for a 
while; now I can continue ...

On 08/10/2016 07:45 PM, David Miller wrote:
> From: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Date: Wed, 10 Aug 2016 15:44:00 +0200
>
>> But there are still usages (and conn->rx_curs_confirmed is one of
>> them), where I need an 8-byte cursor field to be read and written
>> atomicaly, even though I do not care whether the write operation has
>> been beaten or not. But I do care that reading the cursor does not
>> return a partially updated cursor. Isn't xchg() a possible solution
>> in this case?
>
> Either the cpu supports 64-bit stores or it does not.
>
> xchg() and atomicity have absolutely nothing to do with this.
>

Understood, I wrongly used xchg() for atomicity. I now realize that I 
would need cursor locking for 32-bit architectures - something I would 
like to defer. Thus I would like to come up with V2 of SMC-R with builds 
restricted to 64-bit architectures only, and thus no usage of xchg() 
anymore.
