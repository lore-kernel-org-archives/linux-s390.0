Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgK3JwE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 04:52:04 -0500
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
 <20201127095633.60f8a544.pasic@linux.ibm.com>
 <16fe9017-407f-1bb0-1599-fb46d93009fc@linux.ibm.com>
 <20201127163936.38a51c15.pasic@linux.ibm.com>
 <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
 <20201130095549.27da927f.pasic@linux.ibm.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <bc52205b-9ae8-98c6-0eb0-9fff551c7868@linux.ibm.com>
Date: Mon, 30 Nov 2020 10:50:02 +0100
MIME-Version: 1.0
In-Reply-To: <20201130095549.27da927f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 11/30/20 9:55 AM, Halil Pasic wrote:
> On Mon, 30 Nov 2020 09:30:33 +0100
> Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> 
>> I'm not really familiar, with it but I think this is closely related
>> to what I asked Bernd Nerz. I fear that if CPUs go away we might already
>> be in trouble at the firmware/hardware/platform level because the CPU Address is
>> "programmed into the device" so to speak. Thus a directed interrupt from
>> a device may race with anything reordering/removing CPUs even if
>> CPU addresses of dead CPUs are not reused and the mapping is stable.
> 
> From your answer, I read that CPU hot-unplug is supported for LPAR. 

I'm not sure about hot hot-unplug and firmware
telling us about removed CPUs but at the very least there is:

echo 0 > /sys/devices/system/cpu/cpu6/online

>>
>> Furthermore our floating fallback path will try to send a SIGP
>> to the target CPU which clearly doesn't work when that is permanently
>> gone. Either way I think these issues are out of scope for this fix
>> so I will go ahead and merge this.
> 
> I agree, it makes on sense to delay this fix.
> 
> But if CPU hot-unplug is supported, I believe we should react when
> a CPU is unplugged, that is a target of directed interrupts. My guess
> is, that in this scenario transient hiccups are unavoidable, and thus
> should be accepted, but we should make sure that we recover.

I agree, I just tested the above command on a firmware test system and
deactivated 4 of 8 CPUs.
This is in /proc/interrupts after that:

...
  3:       9392          0          0          0   PCI-MSI  mlx5_async@pci:0001:00:00.0
  4:     282741          0          0          0   PCI-MSI  mlx5_comp0@pci:0001:00:00.0
  5:          0          2          0          0   PCI-MSI  mlx5_comp1@pci:0001:00:00.0
  6:          0          0        104          0   PCI-MSI  mlx5_comp2@pci:0001:00:00.0
  7:          0          0          0          2   PCI-MSI  mlx5_comp3@pci:0001:00:00.0
  8:          0          0          0          0   PCI-MSI  mlx5_comp4@pci:0001:00:00.0
  9:          0          0          0          0   PCI-MSI  mlx5_comp5@pci:0001:00:00.0
 10:          0          0          0          0   PCI-MSI  mlx5_comp6@pci:0001:00:00.0
 11:          0          0          0          0   PCI-MSI  mlx5_comp7@pci:0001:00:00.0
...

So it looks like we are left with registered interrupts
for CPUs which are offline. However I'm not sure how to
trigger a problem with that. I think the drivers would
usually only do a directed interrupt to a CPU that
is currently running the process that triggered the
I/O (I tested this assumption with "taskset -c 2 ping ...").
Now with the CPU offline there cannot be such a
process. So I think for the most part the queue would
just remain unused. Still, if we do get a directed
interrupt for it's my understanding that currently
we will lose that.

I think this could be fixed with
something I tried in a prototype code a while back that
is in zpci_handle_fallback_irq() I handled the IRQ locally.
Back then it looked like Directed IRQs would make it to z15 GA 1.5 and
this was done to help Bernd to debug a Millicode issue (Jup 905371).
I also had a version of that code meant as a possible performance
improvement that would check if the target CPU is
available and only then send the SIGP and otherwise handle it
locally.

> 
> Regards,
> Halil
> 
