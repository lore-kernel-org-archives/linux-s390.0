Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [PATCH net-next 0/8] net/smc: improve termination handling (part
 3)
References: <20191114120247.68889-1-kgraul@linux.ibm.com>
 <20191115.123014.497961657029798608.davem@davemloft.net>
From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sat, 16 Nov 2019 17:37:48 +0100
MIME-Version: 1.0
In-Reply-To: <20191115.123014.497961657029798608.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <59756a0d-d0c3-8e9a-a586-ca55fb092baf@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On 15/11/2019 21:30, David Miller wrote:
> From: Karsten Graul <kgraul@linux.ibm.com>
> Date: Thu, 14 Nov 2019 13:02:39 +0100
> 
>> Part 3 of the SMC termination patches improves the link group
>> termination processing and introduces the ability to immediately
>> terminate a link group.
> 
> Series applied, thanks.
> 
> I wonder if you need an explicit ATOMIC_INIT() for that new atomic_t you
> add to the data structures?

I will discuss this question with Ursula next week, thanks for pointing it out.

> 

-- 
Karsten
