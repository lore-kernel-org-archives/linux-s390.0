From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 5/5] KVM: s390: Split out early console code.
Date: Tue, 30 Oct 2012 14:43:10 +0100
Message-ID: <508FD96E.1010209@suse.de>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com> <1351516046-30037-6-git-send-email-cornelia.huck@de.ibm.com> <1440F0DC-0DC5-40FB-88E2-EE203A7C5F66@suse.de> <20121030135926.2db07255@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121030135926.2db07255@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 10/30/2012 01:59 PM, Cornelia Huck wrote:
> On Mon, 29 Oct 2012 19:14:19 +0100
> Alexander Graf<agraf@suse.de>  wrote:
>
>> On 29.10.2012, at 14:07, Cornelia Huck wrote:
>>
>>> This code is transport agnostic and can be used by both the legacy
>>> virtio code and virtio_ccw.
>> Would it be possible to actually send real virtio or sclp console commands for early printk? That'd make things a lot easier on the user space end. Combining two completely separate character channels (early printk + sclp or early printk + virtio-console) is really tricky.
>>
> This code is only used if we use a virtio console device. The sclp
> code path is completely different.

Ah, so the sclp early console works differently?

> What do you mean with "real virtio console commands"? The message is
> just put on the output queue anyway.

For virtio-console, yes. For the early printk it is sent to the 
hypervisor using a hypercall, not through the virtio queue. So it 
arrives at a completely different end point that usually has no 
knowledge of the virtio-console output driver.


Alex
