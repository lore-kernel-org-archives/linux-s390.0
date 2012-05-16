From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH/RFC net-next 0/4] Delete token ring support.
Date: Tue, 15 May 2012 21:00:20 -0400 (EDT)
Message-ID: <20120515.210020.1631343759962418692.davem@davemloft.net>
References: <1337128544-18680-1-git-send-email-paul.gortmaker@windriver.com>
	<m2k40dkl2o.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <m2k40dkl2o.fsf@firstfloor.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: andi@firstfloor.org
Cc: paul.gortmaker@windriver.com, netdev@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Andi Kleen <andi@firstfloor.org>
Date: Tue, 15 May 2012 17:48:15 -0700

> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>>
>> What I mean by (2) is the implicit absence of anyone fixing _runtime_
>> bugs, going all the way back to 2.6.12 in 2005.  If the code was being
>> _used_, we'd see runtime regressions reported and their associated
>> fixes.
> 
> Removal sounds good to me. In fact I would argue to remove any other driver
> which did not get a real change since 2005 too.

I also support removing the token ring stuff, and in fact I'm more
than happy to add your patch set to the net-next tree right now.
