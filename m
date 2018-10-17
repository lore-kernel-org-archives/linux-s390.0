From: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [RFC PATCH v1 0/4] Add migration support for VFIO
 device
Date: Thu, 18 Oct 2018 02:29:52 +0530
Message-ID: <437bc057-03e6-a74d-8281-697247ea1667@nvidia.com>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
	<20181017104909.15ba95ff.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181017104909.15ba95ff.cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, cjia@nvidia.com, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 10/17/2018 2:19 PM, Cornelia Huck wrote:
> On Tue, 16 Oct 2018 23:42:34 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Add migration support for VFIO device
> 
> I'd love to take a deeper look at this; but sadly, I'm currently low on
> spare time, and therefore will only add some general remarks.
> 

Thanks. Those would be really helpful to have common infrastructure that
can be used across different types of vfio devices.

>>
>> This Patch set include patches as below:
>> - Define KABI for VFIO device for migration support.
>> - Generic migration functionality for VFIO device.
>>   * This patch set adds functionality only for PCI devices, but can be
>>     extended to other VFIO devices.
> 
> I've been thinking about how best to add migration to vfio-ccw; it
> might be quite different from what we do for vfio-pci, but I hope that
> we can still use some common infrastructure.
> 
> Basically, we probably need something like the following:
> 
> - Wait until outstanding channel programs are finished, and don't allow
>   new ones. Don't report back to userspace (or maybe do; we just don't
>   want to fence of too many new requests.)
> - Collect subchannel and related state, copy it over. That probably
>   fits in with the interface you're proposing.
> - Re-setup on the other side and get going again. The problem here
>   might be state that the vfio-ccw driver can't be aware of (like
>   replaying storage server configurations). Maybe we can send CRWs
>   (notifications) to the guest and leverage the existing suspend/resume
>   driver code for channel devices.
> 
> For vfio-ap, I frankly have no idea how migration will work, given the
> setup with the matrix device and the interesting information in the SIE
> control blocks (but maybe it just can replay from the info in the
> matrix device?) Keys etc. are likely to be the bigger problem here.
> 
> Cc:ing some s390 folks for awareness.
> 
>>   * Added all the basic functions required for pre-copy, stop-and-copy and
>>     resume phases of migration.
>>   * Added state change notifier and from that notifier function, VFIO
>>     device's state changed is conveyed to VFIO vendor driver.
> 
> I assume that this will, in general, be transparent for the guest; but
> maybe there'll be need for some interaction for special cases?

Ideally, this should be transparent for the guest for live migration.
Guest shouldn't see any functional change during live migration.

Thanks,
Kirti

> 
>>   * During save setup phase and resume/load setup phase, migration region
>>     is queried from vendor driver and is mmaped by QEMU. This region is
>>     used to read/write data from and to vendor driver.
>>   * .save_live_pending, .save_live_iterate and .is_active_iterate are
>>     implemented to use QEMU's functionality of iteration during pre-copy
>>     phase.
>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
>>     iteration to read data from vendor driver is implemented till pending
>>     bytes returned by vendor driver are not zero.
>>   * .save_cleanup and .load_cleanup are implemented to unmap migration
>>     region that was setup duing setup phase.
>>   * Added function to get dirty pages bitmap from vendor driver.
>> - Add vfio_listerner_log_sync to mark dirty pages.
>> - Make VFIO PCI device migration capable.
>>
>> Thanks,
>> Kirti
>>
>> Kirti Wankhede (4):
>>   VFIO KABI for migration interface
>>   Add migration functions for VFIO devices
>>   Add vfio_listerner_log_sync to mark dirty pages
>>   Make vfio-pci device migration capable.
>>
>>  hw/vfio/Makefile.objs         |   2 +-
>>  hw/vfio/common.c              |  32 ++
>>  hw/vfio/migration.c           | 716 ++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/pci.c                 |  13 +-
>>  include/hw/vfio/vfio-common.h |  23 ++
>>  linux-headers/linux/vfio.h    |  91 ++++++
>>  6 files changed, 869 insertions(+), 8 deletions(-)
>>  create mode 100644 hw/vfio/migration.c
>>
> 
