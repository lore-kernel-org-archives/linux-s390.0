From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 8/8] s390: Add new channel I/O based virtio transport.
Date: Wed, 12 Dec 2012 01:38:36 +0100
Message-ID: <D75F2E96-0AE9-46E6-B8AA-CC75CEA17A0C@suse.de>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com> <1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com> <DC47DBAD-3386-4443-BBE4-48BD0BDACEE6@suse.de> <50C721B2.9030200@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50C721B2.9030200@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 11.12.2012, at 13:06, Christian Borntraeger wrote:

> On 11/12/12 11:53, Alexander Graf wrote:
>> 
>> On 07.12.2012, at 13:50, Cornelia Huck wrote:
>> 
>>> Add a new virtio transport that uses channel commands to perform
>>> virtio operations.
>>> 
>>> Add a new machine type s390-ccw that uses this virtio-ccw transport
>>> and make it the default machine for s390.
>>> 
>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> ---
>>> hw/s390-virtio.c       | 149 ++++++--
>>> hw/s390x/Makefile.objs |   1 +
>>> hw/s390x/virtio-ccw.c  | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
>>> hw/s390x/virtio-ccw.h  |  81 +++++
>>> trace-events           |   4 +
>>> 5 files changed, 1124 insertions(+), 20 deletions(-)
>>> create mode 100644 hw/s390x/virtio-ccw.c
>>> create mode 100644 hw/s390x/virtio-ccw.h
>>> 
>>> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
>>> index 9e1afb2..f29ff74 100644
>>> --- a/hw/s390-virtio.c
>>> +++ b/hw/s390-virtio.c
>>> @@ -33,6 +33,8 @@
>>> 
>>> #include "hw/s390-virtio-bus.h"
>>> #include "hw/s390x/sclp.h"
>>> +#include "hw/s390x/css.h"
>>> +#include "hw/s390x/virtio-ccw.h"
>>> 
>>> //#define DEBUG_S390
>>> 
>>> @@ -47,6 +49,7 @@
>>> #define KVM_S390_VIRTIO_NOTIFY          0
>>> #define KVM_S390_VIRTIO_RESET           1
>>> #define KVM_S390_VIRTIO_SET_STATUS      2
>>> +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
>>> 
>>> #define KERN_IMAGE_START                0x010000UL
>>> #define KERN_PARM_AREA                  0x010480UL
>>> @@ -63,6 +66,7 @@
>>> 
>>> static VirtIOS390Bus *s390_bus;
>>> static S390CPU **ipi_states;
>>> +VirtioCcwBus *ccw_bus;
>>> 
>>> S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>> {
>>> @@ -76,15 +80,21 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>> int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
>>> {
>>>    int r = 0, i;
>>> +    int cssid, ssid, schid, m;
>>> +    SubchDev *sch;
>>> 
>>>    dprintf("KVM hypercall: %ld\n", hypercall);
>>>    switch (hypercall) {
>>>    case KVM_S390_VIRTIO_NOTIFY:
>>>        if (mem > ram_size) {
>>> -            VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
>>> -                                                               mem, &i);
>>> -            if (dev) {
>>> -                virtio_queue_notify(dev->vdev, i);
>>> +            if (s390_bus) {
>>> +                VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
>>> +                                                                   mem, &i);
>>> +                if (dev) {
>>> +                    virtio_queue_notify(dev->vdev, i);
>>> +                } else {
>>> +                    r = -EINVAL;
>>> +                }
>> 
>> We really want to factor out the DIAG handling code similar to how spapr handles its hypercalls. That way the legacy s390-virtio machine can register a VIRTIO_NOTIFY hypercall that works for it here, while the s390-virtio-ccw machine doesn't.
>> 
> 
> Agreed, but this has nothing to do with virtio-ccw and should be part of a follow-up cleanup. no?

I think it'd make the virtio-ccw machine implementation easier to implement and easier to separate. I can cook up a patch that does this though if you say you don't have anyone to work on this atm.


Alex
