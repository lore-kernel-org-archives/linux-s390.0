Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgKSNLC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 08:11:02 -0500
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
 <300d4404-3efe-880e-ef30-692eabbff5f7@de.ibm.com>
 <da1a1fa7-a1de-d0e6-755b-dd587687765e@amazon.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <c06a298e-a851-f637-6fc3-9a8dca991c6f@de.ibm.com>
Date: Thu, 19 Nov 2020 14:09:58 +0100
In-Reply-To: <da1a1fa7-a1de-d0e6-755b-dd587687765e@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Graf <graf@amazon.de>, "Catangiu, Adrian Costin" <acatan@amazon.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>
Cc: Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-s390 <linux-s390@vger.kernel.org>, "areber@redhat.com" <areber@redhat.com>, Pavel Emelyanov <ovzxemul@gmail.com>, Andrey Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>



On 19.11.20 13:51, Alexander Graf wrote:
> 
> 
> On 19.11.20 13:02, Christian Borntraeger wrote:
>>
>> On 16.11.20 16:34, Catangiu, Adrian Costin wrote:
>>> - Background
>>>
>>> The VM Generation ID is a feature defined by Microsoft (paper:
>>> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by
>>> multiple hypervisor vendors.
>>>
>>> The feature is required in virtualized environments by apps that work
>>> with local copies/caches of world-unique data such as random values,
>>> uuids, monotonically increasing counters, etc.
>>> Such apps can be negatively affected by VM snapshotting when the VM
>>> is either cloned or returned to an earlier point in time.
>>>
>>> The VM Generation ID is a simple concept meant to alleviate the issue
>>> by providing a unique ID that changes each time the VM is restored
>>> from a snapshot. The hw provided UUID value can be used to
>>> differentiate between VMs or different generations of the same VM.
>>>
>>> - Problem
>>>
>>> The VM Generation ID is exposed through an ACPI device by multiple
>>> hypervisor vendors but neither the vendors or upstream Linux have no
>>> default driver for it leaving users to fend for themselves.
>>
>> I see that the qemu implementation is still under discussion. What is
> 
> Uh, the ACPI Vmgenid device emulation is in QEMU since 2.9.0 :).

Ah right. Found it. 
> 
>> the status of the other existing implementations. Do they already exist?
>> In other words is ACPI a given?
>> I think the majority of this driver could be used with just a different
>> backend for platforms without ACPI so in any case we could factor out
>> the backend (acpi, virtio, whatever) but if we are open we could maybe
>> start with something else.
> 
> I agree 100%. I don't think we really need a new framework in the kernel for that. We can just have for example an s390x specific driver that also provides the same notification mechanism through a device node that is also named "/dev/vmgenid", no?
> 
> Or alternatively we can split the generic part of this driver as soon as a second one comes along and then have both driver include that generic logic.

Yes. I think it is probably the best variant to check if we split this into a front end /back end or provide a new driver when we have something. 
> 
> The only piece where I'm unsure is how this will interact with CRIU. Can containers emulate ioctls and device nodes?
> 
> 
> Alex
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
