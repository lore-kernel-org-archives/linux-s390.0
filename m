From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] vfio: ccw: add traceponits for interesting error
 paths
Date: Mon, 30 Apr 2018 18:51:54 +0200
Message-ID: <42c331bf-8ba1-7a67-5ec8-6bebcfad4ed7@linux.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
 <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
 <20180427121353.4453bdc2.cohuck@redhat.com>
 <20180428055023.GS5428@bjsdjshi@linux.vnet.ibm.com>
 <20180430135153.1d108675.cohuck@redhat.com>
 <ca160353-696e-86f6-8a37-dd6a2f7fae8d@linux.ibm.com>
 <20180430170358.0ee6fe6a.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430170358.0ee6fe6a.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/30/2018 05:03 PM, Cornelia Huck wrote:
>> I think the naming of this fctl thing is a bit cryptic,
>> but if we don't see this as ABI I'm fine with it -- can be improved.
>> What would be a better name? I was thinking along the lines accept_request.
>> (Bad error code would mean that the request did not get accepted. Good
>> code does not mean the requested function was performed successfully.)
> I think fctl is fine (if you don't understand what 'fctl' is, you're
> unlikely to understand it even if it were named differently.)
> 

AFAIU this fctl is a bit more complicated than the normal fctl. But
better let sleeping dogs lie.

>> Also I think vfio_ccw_io_fctl with no zero error code would make sense
>> as dev_warn. If I were an admin looking into a problem I would very much
>> appreciate seeing something in the messages log (and not having to enable
>> tracing first). This point seems to be a good one for high level 'request gone
>> bad' kind of report. Opinions?
> I'd also exclude -EOPNOTSUPP (as this also might happen with e.g. a halt/clear enabled user space, which probes availability of halt/clear support by giving it a try once (yes, I really want to post my patches this week.))
> 

I'm looking forward to the clear/halt. It hope it will help me understand
the big vfio-ccw picture better. There are still dark spots, but I don't
feel like doing something against this, as there is quite some activity
going on here -- and I don't want to hamper the efforts by binding resources.

Regards,
Halil
