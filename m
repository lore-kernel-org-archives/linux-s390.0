From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
Date: Thu, 27 Sep 2018 10:21:09 -0400
Message-ID: <a9fca3fc-a874-930f-5305-858aeeed720a@linux.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926164222.74731b74@t450s.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/26/2018 06:42 PM, Alex Williamson wrote:
> On Tue, 25 Sep 2018 19:16:41 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   Documentation/s390/vfio-ap.txt | 782 +++++++++++++++++++++++++++++++++
>>   MAINTAINERS                    |   1 +
>>   2 files changed, 783 insertions(+)
>>   create mode 100644 Documentation/s390/vfio-ap.txt
> ...
>> +Example:
>> +=======
>> +Let's now provide an example to illustrate how KVM guests may be given
>> +access to AP facilities. For this example, we will show how to configure
>> +three guests such that executing the lszcrypt command on the guests would
>> +look like this:
>> +
>> +Guest1
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +05          CEX5C CCA-Coproc
>> +05.0004     CEX5C CCA-Coproc
>> +05.00ab     CEX5C CCA-Coproc
>> +06          CEX5A Accelerator
>> +06.0004     CEX5A Accelerator
>> +06.00ab     CEX5C CCA-Coproc
>> +
>> +Guest2
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +05          CEX5A Accelerator
>> +05.0047     CEX5A Accelerator
>> +05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Seems like an unfinished thought here.

I have no idea how that got in there, there must be a gremlin in my
laptop. It does not belong.

> 
>> +
>> +Guest2
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +06          CEX5A Accelerator
>> +06.0047     CEX5A Accelerator
>> +06.00ff     CEX5A Accelerator
>> +
>> +These are the steps:
>> +
>> +1. Install the vfio_ap module on the linux host. The dependency chain for the
>> +   vfio_ap module is:
>> +   * iommu
>> +   * s390
>> +   * zcrypt
>> +   * vfio
>> +   * vfio_mdev
>> +   * vfio_mdev_device
>> +   * KVM
>> +
>> +   To build the vfio_ap module, the kernel build must be configured with the
>> +   following Kconfig elements selected:
>> +   * IOMMU_SUPPORT
>> +   * S390
>> +   * ZCRYPT
>> +   * S390_AP_IOMMU
>> +   * VFIO
>> +   * VFIO_MDEV
>> +   * VFIO_MDEV_DEVICE
>> +   * KVM
>> +
>> +   If using make menuconfig select the following to build the vfio_ap module:
>> +   -> Device Drivers
>> +      -> IOMMU Hardware Support
>> +         select S390 AP IOMMU Support
>> +      -> VFIO Non-Privileged userspace driver framework
>> +         -> Mediated device driver frramework
>> +            -> VFIO driver for Mediated devices
>> +   -> I/O subsystem
>> +      -> VFIO support for AP devices
>> +
>> +2. Secure the AP queues to be used by the three guests so that the host can not
>> +   access them. To secure them, there are two sysfs files that specify
>> +   bitmasks marking a subset of the APQN range as 'usable by the default AP
>> +   queue device drivers' or 'not usable by the default device drivers' and thus
>> +   available for use by the vfio_ap device driver'. The sysfs files containing
>> +   the sysfs locations of the masks are:
>> +
>> +   /sys/bus/ap/apmask
>> +   /sys/bus/ap/aqmask
>> +
>> +   The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
>> +   (APID). Each bit in the mask, from most significant to least significant bit,
>> +   corresponds to an APID from 0-255. If a bit is set, the APID is marked as
>> +   usable only by the default AP queue device drivers; otherwise, the APID is
>> +   usable by the vfio_ap device driver.
>> +
>> +   The 'aqmask' is a 256-bit mask that identifies a set of AP queue indexes
>> +   (APQI). Each bit in the mask, from most significant to least significant bit,
>> +   corresponds to an APQI from 0-255. If a bit is set, the APQI is marked as
>> +   usable only by the default AP queue device drivers; otherwise, the APQI is
>> +   usable by the vfio_ap device driver.
>> +
>> +   The APQN of each AP queue device assigned to the linux host is checked by the
>> +   AP bus against the set of APQNs derived from the cross product of APIDs
>> +   and APQIs marked as usable only by the default AP queue device drivers. If a
>> +   match is detected,  only the default AP queue device drivers will be probed;
>> +   otherwise, the vfio_ap device driver will be probed.
>> +
>> +   By default, the two masks are set to reserve all APQNs for use by the default
>> +   AP queue device drivers. There are two ways the default masks can be changed:
>> +
>> +   1. The masks can be changed at boot time with the kernel command line
>> +      like this:
>> +
>> +         ap.apmask=0xffff ap.aqmask=0x40
>> +
>> +         This would give these two pools:
>> +
>> +            default drivers pool:    adapter 0-15, domain 1
>> +            alternate drivers pool:  adapter 16-255, domains 2-255
> 
> What happened to domain 0?  

As Halil stated, it should be:
alternate drivers pool:  adapter 16-255, domains 0, 2-255

I'm also a little confused by the bit
> ordering.  If 0x40 is bit 1 and 0xffff is bits 0-15, then the least
> significant bit is furthest left?  Did I miss documentation of that?

Up above, the apmask and aqmask are described. Both descriptions state,
"each bit in the mask, from most significant to least significant bit,
corresponds to an ... from 0-255". It could probably be clarified by
stating:

Each bit in the mask, from most significant to least significant bit
in big endian order, corresponds to an ... from 0-255

or

Each bit in the mask, from left to right, corresponds to an ... from
0-255

> 
>> +
>> +   2. The sysfs mask files can also be edited by echoing a string into the
>> +      respective file in one of two formats:
>> +
>> +      * An absolute hex string starting with 0x - like "0x12345678" - sets
>> +        the mask. If the given string is shorter than the mask, it is padded
>> +        with 0s on the right. If the string is longer than the mask, the
>> +        operation is terminated with an error (EINVAL).
> 
> And this does say zero padding on the right, but then in the next
> bullet our hex digits use normal least significant bit right notation,
> ie. 0x41 is 65, not 82, correct?

Again, I refer you back to the descriptions above for aqmask and apmask.
When configuring a mask, the value specified encompasses the entire
256-bit mask, so specifying 0x41 (65) is exactly like specifying the
following:

0x4100000000000000000000000000000000000000000000000000000000000000

The most significant byte is 0x41 (big endian), so if the mask bits
read from left to right (i.e., most significant to least significant
bit), the mask above identifies devices 1 and 7.

> 
>> +
>> +      * A plus ('+') or minus ('-') followed by a numerical value. Valid
>> +        examples are "+1", "-13", "+0x41", "-0xff" and even "+0" and "-0". Only
>> +        the corresponding bit in the mask is switched on ('+') or off ('-'). The
>> +        values may also be specified in a comma-separated list to switch more
>> +        than one bit on or off.
>> +
>> +   To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
>> +   06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
>> +   APQNs must be removed from the masks as follows:
>> +
>> +      echo -5,-6 > /sys/bus/ap/apmask
>> +
>> +      echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
> 
> Other than the bit ordering confusion, I like this +/- scheme.
> 
>> +
>> +   This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004,
>> +   06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device driver. The
>> +   sysfs directory for the vfio_ap device driver will now contain symbolic links
>> +   to the AP queue devices bound to it:
>> +
>> +   /sys/bus/ap
>> +   ... [drivers]
>> +   ...... [vfio_ap]
>> +   ......... [05.0004]
>> +   ......... [05.0047]
>> +   ......... [05.00ab]
>> +   ......... [05.00ff]
>> +   ......... [06.0004]
>> +   ......... [06.0047]
>> +   ......... [06.00ab]
>> +   ......... [06.00ff]
>> +
>> +   Keep in mind that only type 10 and newer adapters (i.e., CEX4 and later)
>> +   can be bound to the vfio_ap device driver. The reason for this is to
>> +   simplify the implementation by not needlessly complicating the design by
>> +   supporting older devices that will go out of service in the relatively near
>> +   future and for which there are few older systems on which to test.
>> +
>> +   The administrator, therefore, must take care to secure only AP queues that
>> +   can be bound to the vfio_ap device driver. The device type for a given AP
>> +   queue device can be read from the parent card's sysfs directory. For example,
>> +   to see the hardware type of the queue 05.0004:
>> +
>> +   cat /sys/bus/ap/devices/card05/hwtype
>> +
>> +   The hwtype must be 10 or higher (CEX4 or newer) in order to be bound to the
>> +   vfio_ap device driver.
>> +
>> +3. Create the mediated devices needed to configure the AP matrixes for the
>> +   three guests and to provide an interface to the vfio_ap driver for
>> +   use by the guests:
>> +
>> +   /sys/devices/vfio_ap/matrix/
>> +   --- [mdev_supported_types]
>> +   ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
>> +   --------- create
>> +   --------- [devices]
>> +
>> +   To create the mediated devices for the three guests:
>> +
>> +	uuidgen > create
>> +	uuidgen > create
>> +	uuidgen > create
>> +
>> +        or
>> +
>> +        echo $uuid1 > create
>> +        echo $uuid2 > create
>> +        echo $uuid3 > create
>> +
>> +   This will create three mediated devices in the [devices] subdirectory named
>> +   after the UUID written to the create attribute file. We call them $uuid1,
>> +   $uuid2 and $uuid3 and this is the sysfs directory structure after creation:
>> +
>> +   /sys/devices/vfio_ap/matrix/
>> +   --- [mdev_supported_types]
>> +   ------ [vfio_ap-passthrough]
>> +   --------- [devices]
>> +   ------------ [$uuid1]
>> +   --------------- assign_adapter
>> +   --------------- assign_control_domain
>> +   --------------- assign_domain
>> +   --------------- matrix
>> +   --------------- unassign_adapter
>> +   --------------- unassign_control_domain
>> +   --------------- unassign_domain
>> +
>> +   ------------ [$uuid2]
>> +   --------------- assign_adapter
>> +   --------------- assign_control_domain
>> +   --------------- assign_domain
>> +   --------------- matrix
>> +   --------------- unassign_adapter
>> +   ----------------unassign_control_domain
>> +   ----------------unassign_domain
>> +
>> +   ------------ [$uuid3]
>> +   --------------- assign_adapter
>> +   --------------- assign_control_domain
>> +   --------------- assign_domain
>> +   --------------- matrix
>> +   --------------- unassign_adapter
>> +   ----------------unassign_control_domain
>> +   ----------------unassign_domain
>> +
>> +4. The administrator now needs to configure the matrixes for the mediated
>> +   devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3).
>> +
>> +   This is how the matrix is configured for Guest1:
>> +
>> +      echo 5 > assign_adapter
>> +      echo 6 > assign_adapter
>> +      echo 4 > assign_domain
>> +      echo 0xab > assign_domain
>> +
>> +      Control domains can similarly be assigned using the assign_control_domain
>> +      sysfs file.
>> +
>> +      If a mistake is made configuring an adapter, domain or control domain,
>> +      you can use the unassign_xxx files to unassign the adapter, domain or
>> +      control domain.
>> +
>> +      To display the matrix configuration for Guest1:
>> +
>> +         cat matrix
>> +
>> +   This is how the matrix is configured for Guest2:
>> +
>> +      echo 5 > assign_adapter
>> +      echo 0x47 > assign_domain
>> +      echo 0xff > assign_domain
>> +
>> +   This is how the matrix is configured for Guest3:
>> +
>> +      echo 6 > assign_adapter
>> +      echo 0x47 > assign_domain
>> +      echo 0xff > assign_domain
>> +
> 
> I'm curious why this interface didn't adopt the +/- notation invented
> above for consistency.  Too difficult to do rollbacks with a string on
> entries?

These interfaces predate the AP bus interfaces by over six months,
and the AP bus interfaces are not part of this patch series.

> 
> Looks pretty reasonable other than the points of confusion noted.
> Thanks,
> 
> Alex
> 
