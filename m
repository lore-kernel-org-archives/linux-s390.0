Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [OPW kernel] [PATCH v3] drivers: s390: net: ctcm: migrate variables to handle y2038 problem
Date: Mon, 03 Nov 2014 10:40:30 +0100
Message-ID: <4030959.mWGrEP99VU@wuerfel>
In-Reply-To: <20141101001614.GA9494@localhost.localdomain>
References: <20141101001614.GA9494@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: opw-kernel@googlegroups.com
Cc: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>, ursula.braun@de.ibm.com, blaschka@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Saturday 01 November 2014 02:16:14 Aya Mahfouz wrote:
> This patch is concerned with migrating the time variables for the s390
> network driver. The changes handle the y2038 problem where timespec will
> overflow in the year 2038. timespec was replaced by unsigned long and
> all time variables get their values from the jiffies global variable.
> This was done for the sake of speed and efficiency.
> 
> Signed-off-by: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
> ---
> v1: Arnd has advised me to provide you with options for time
>     calculation. The first option: "accuracy" is used in this
>     patch. The second option: "speed" can be done through
>     jiffies.
> 
> v2: Moved on to the speed option. Let me know if I explicitly
>     need to include the jiffies header. The module compiles with
>     no problems on my side.
> 
> v3: Handled the error pointed out by Ursula. The current version
>     does not handle overflows. There are two solutions for this.
>     The first is to use jiffies_64 since s/390 is a 64-bit
>     architecture after all. The second is to use wrapper functions
>     like time_before and time_after. Two files were added too. 
>     They are: ctcm_main.c and netiucv.c. This patch could be sent
>     as a patchset in its final version for convenience. 

Hi Aya,

The patch looks correct to me now,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

There is one small change that you could do for efficiency:

>  
> -	duration =
> -	    (done_stamp.tv_sec - ch->prof.send_stamp.tv_sec) * 1000000 +
> -	    (done_stamp.tv_nsec - ch->prof.send_stamp.tv_nsec) / 1000;
> +	duration =  jiffies_to_usecs(done_stamp - ch->prof.send_stamp);
>  	if (duration > ch->prof.tx_time)
>  		ch->prof.tx_time = duration;
>  

This means you are doing the jiffies_to_usecs conversion for every
packet. s390 has a fast multiplication instruction, so it won't matter
in practice, but if you do more conversions like this, a better approach
is to store the 'jiffies' value in ch->prof.tx_time and only convert
it to another unit when printing the number.

	Arnd
