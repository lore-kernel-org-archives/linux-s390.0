From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [PATCH net-next 13/13] s390/qeth: remove OSN-devices
Date: Fri, 13 Jan 2017 12:55:28 +0100
Message-ID: <3e706715-0b5f-8011-3a2d-e1f66a37661f@linux.vnet.ibm.com>
References: <20170111115600.4524-1-ubraun@linux.vnet.ibm.com>
 <20170111115600.4524-14-ubraun@linux.vnet.ibm.com>
 <20170111.090502.567203023670760362.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170111.090502.567203023670760362.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 01/11/2017 03:05 PM, David Miller wrote:
> From: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Date: Wed, 11 Jan 2017 12:56:00 +0100
> 
>> CHPID type "OSN" is a device type which had been used by IBM product
>> "Communication Controller for Linux". This product has reached end of
>> service in March 2016. Thus OSN support can be removed from the qeth
>> driver.
>>
>> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
>> Reviewed-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
>> Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> 
> IBM can certainly decide what physical products it wants to support
> or not, but this doesn't directly apply to what the Linux kernel
> driver supports.
> 
> We do not unilaterally remove support for a chip from a driver just
> because the vendor decides to stop supporting that chip.  In fact this
> is one of the main benefits and value-adds of Linux.
> 
> I'm not applying a patch series that removes support for a chipset
> for this reason, sorry.
> 
Dave, 

I am not sure, if the stopped chip support of vendors is something
equivalent to the removal of OSN-CHPID support for s390. Probably
I used misleading terms like "OSN-device" in my patch description:

The standard networking card on s390 is called
"Open Systems Adapter-Express card" (shortly "OSA-card"), and for sure
the qeth driver continues to support it in general. Besides covering
traditional Ethernet traffic, an OSA-card can also be used for very
IBM-specific purposes.
The mode an OSA-card is running is configured outside of Linux in
the mainframe hardware configuration. Linux supports a subset of
these modes with the qeth and lcs drivers.

One very specific OSA-mode is the OSN-mode. This mode is one building
block for a Linux-assisted approach that allows
existing IBM mainframe operating systems to continue to run
IBM Systems Network Architecture (SNA) protocol programs.
Just these SNA related code parts in qeth would be removed with
this patch.

Do you still think it is important to keep code just needed for
IBM SNA traffic in the kernel?
Token Ring support for instance has been removed in 2012. Isn't this
something comparable to my intended removal of OSN-mode support in qeth?

In other words: Would it make sense to resend my patch with a better
description?

Kind regards, Ursula
