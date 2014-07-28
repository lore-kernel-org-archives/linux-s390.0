From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH/RFC 0/5] s390x/kvm: track the logical cpu state in QEMU and propagate it to kvm
Date: Mon, 28 Jul 2014 15:45:01 +0200
Message-ID: <DD61F981-585F-44D3-AB71-153EEB33CA36@suse.de>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>	<20140710151431.0b7e3c34@thinkpad-w530> <20140710152738.767002d4@thinkpad-w530> <53D65379.3040103@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53D65379.3040103@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>


On 28.07.2014, at 15:43, Alexander Graf <agraf@suse.de> wrote:

> 
> On 10.07.14 15:27, David Hildenbrand wrote:
>>>> This is the qemu part of kernel series "Let user space control the
>>>> cpu states"
>>>> 
>>>> Christian Borntraeger (1):
>>>>   update linux headers with with cpustate changes
>>>> 
>>>> David Hildenbrand (4):
>>>>   s390x/kvm: introduce proper states for s390 cpus
>>>>   s390x/kvm: proper use of the cpu states OPERATING and STOPPED
>>>>   s390x/kvm: test whether a cpu is STOPPED when checking "has_work"
>>>>   s390x/kvm: propagate s390 cpu state to kvm
>>>> 
>>>>  hw/s390x/ipl.c            |   2 +-
>>>>  hw/s390x/s390-virtio.c    |  32 --------------
>>>>  linux-headers/linux/kvm.h |   7 ++-
>>>>  target-s390x/cpu.c        | 106 +++++++++++++++++++++++++++++++++++++++-------
>>>>  target-s390x/cpu.h        |  33 +++++++++++++--
>>>>  target-s390x/helper.c     |  11 ++---
>>>>  target-s390x/kvm.c        |  49 ++++++++++++++++++---
>>>>  trace-events              |   6 +++
>>>>  8 files changed, 179 insertions(+), 67 deletions(-)
>>>> 
>>> Looks good to me
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
>> @all thought it was the final internal review :)
> 
> It's a perfectly good thing to say "looks good to me" in public too. The only major difference is that usually you would say "reviewed-by" ;).

Meh - only realized after I sent this that all those patches are From: you. Then of course it's not useful ;)


Alex
