From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: s390: kernel: reset 'c->hotpluggable' when failure
 occurs
Date: Tue, 25 Jun 2013 17:31:27 +0800
Message-ID: <51C9636F.1050709@asianux.com>
References: <51C8F685.6000209@asianux.com> <20130625064832.GA4999@osiris> <51C94599.1020707@asianux.com> <20130625090928.GA8981@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20130625090928.GA8981@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/25/2013 05:09 PM, Heiko Carstens wrote:
> On Tue, Jun 25, 2013 at 03:24:09PM +0800, Chen Gang wrote:
>> On 06/25/2013 02:48 PM, Heiko Carstens wrote:
>>> On Tue, Jun 25, 2013 at 09:46:45AM +0800, Chen Gang wrote:
>>>>> When smp_add_present_cpu() fails, it has reset all things excluding
>>>>> 'c->hotpluggable', so need reset it as original state completely.
>>>>>
>>>>> +	c->hotpluggable = 0;
>>>>>  	return rc;
>>> No, that doesn't make sense. All cpus on s390 are always hotplugable.
>>> It really doesn't matter if the value of this field is 0 or 1 after
>>> an error.
>>>
>>
>> If so, is it better to set 'c->hotpluggable' for all cpus on s390 during
>> initializing ?
> 
> No, just leave the code as it is.
> 

Currently we have 3 possible states for 'struct cpu':
  initialized, and set hotplugable.
  unitialized, and set hotplugable.
  unitialized, and unset hotplugable.

Either 2nd or 3rd is inconsistent.

The cpu_is_hotplugable() will be used in kernel/rcutorture.c. I do not
know whether it will cause issue or not, but it seems dangerous when
__smp_rescan_cpus() has already called, and has some unsucessfull call
of smp_add_present_cpu().

Please help check.

Thanks.
-- 
Chen Gang

Asianux Corporation
