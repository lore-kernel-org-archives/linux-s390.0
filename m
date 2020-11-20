Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgKTVS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Nov 2020 16:18:29 -0500
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
 <300d4404-3efe-880e-ef30-692eabbff5f7@de.ibm.com>
 <da1a1fa7-a1de-d0e6-755b-dd587687765e@amazon.de>
 <20201119173800.GD8537@kernel.org>
 <1cdb6fac-0d50-3399-74a6-24c119ebbaa5@amazon.de>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <106f56ca-49bc-7cad-480f-4b26656e90ce@gmail.com>
Date: Fri, 20 Nov 2020 21:18:23 +0000
MIME-Version: 1.0
In-Reply-To: <1cdb6fac-0d50-3399-74a6-24c119ebbaa5@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Graf <graf@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Catangiu, Adrian Costin" <acatan@amazon.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>, Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-s390 <linux-s390@vger.kernel.org>, "areber@redhat.com" <areber@redhat.com>, Pavel Emelyanov <ovzxemul@gmail.com>, Andrey Vagin <avagin@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>Adrian Reber <areber@redhat.com>

Hello,

+Cc Eric, Adrian

On 11/19/20 6:36 PM, Alexander Graf wrote:
> On 19.11.20 18:38, Mike Rapoport wrote:
>> On Thu, Nov 19, 2020 at 01:51:18PM +0100, Alexander Graf wrote:
>>> On 19.11.20 13:02, Christian Borntraeger wrote:
>>>> On 16.11.20 16:34, Catangiu, Adrian Costin wrote:
>>>>> - Background
>>>>>
>>>>> The VM Generation ID is a feature defined by Microsoft (paper:
>>>>> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by
>>>>> multiple hypervisor vendors.
>>>>>
>>>>> The feature is required in virtualized environments by apps that work
>>>>> with local copies/caches of world-unique data such as random values,
>>>>> uuids, monotonically increasing counters, etc.
>>>>> Such apps can be negatively affected by VM snapshotting when the VM
>>>>> is either cloned or returned to an earlier point in time.
>>>>>
>>>>> The VM Generation ID is a simple concept meant to alleviate the issue
>>>>> by providing a unique ID that changes each time the VM is restored
>>>>> from a snapshot. The hw provided UUID value can be used to
>>>>> differentiate between VMs or different generations of the same VM.
>>>>>
>>>>> - Problem
>>>>>
>>>>> The VM Generation ID is exposed through an ACPI device by multiple
>>>>> hypervisor vendors but neither the vendors or upstream Linux have no
>>>>> default driver for it leaving users to fend for themselves.
[..]

>>> The only piece where I'm unsure is how this will interact with CRIU.
>>
>> To C/R applications that use /dev/vmgenid CRIU need to be aware of it.
>> Checkpointing and restoring withing the same "VM generation" shouldn't be
>> a problem, but IMHO, making restore work after genid bump could be
>> challenging.
>>
>> Alex, what scenario involving CRIU did you have in mind?
> 
> You can in theory run into the same situation with containers that this
> patch is solving for virtual machines. You could for example do a
> snapshot of a prewarmed Java runtime with CRIU to get full JIT speeds
> starting from the first request.
> 
> That however means you run into the problem of predictable randomness
> again.
> 
>>
>>> Can containers emulate ioctls and device nodes?
>>
>> Containers do not emulate ioctls but they can have /dev/vmgenid inside
>> the container, so applications can use it the same way as outside the
>> container.
> 
> Hm. I suppose we could add a CAP_ADMIN ioctl interface to /dev/vmgenid
> (when container people get to the point of needing it) that sets the
> generation to "at least X". That way on restore, you could just call
> that with "generation at snapshot"+1.
> 
> That also means we need to have this interface available without virtual
> machines then though, right?

Sounds like a good idea.
I guess, genvmid can be global on host, rather than per-userns or
per-process for simplicity. Later if somebody will have a bottleneck on
restore when every process on the machine wakes up from read() it could
be virtualized, but doing it now sounds too early.

ioctl() probably should go under
checkpoint_restore_ns_capable(current_user_ns()), rather than
CAP_SYS_ADMIN (I believe it should be safe from DOS as only CRIU should
run with this capability, but worth to document this).

Thanks,
         Dmitry
