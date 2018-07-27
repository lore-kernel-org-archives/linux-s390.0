From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 27 Jul 2018 17:44:16 +0000
Subject: Re: [PATCH v7 22/22] s390: doc: detailed specifications for AP virtualization
Message-Id: <20180727114416.55611f3a@t450s.home>
In-Reply-To: <20180726195429.31960-23-borntraeger@de.ibm.com>
References: <20180726195429.31960-23-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Jul 2018 21:54:29 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:
...
> +The process for reserving an AP queue for use by a KVM guest is:
> +
> +* The vfio-ap driver during its initialization will perform the following:
> +  * Create the 'vfio_ap' root device - /sys/devices/virtual/misc/vfio_ap
> +  * Create the 'matrix' device in the 'vfio_ap' root
> +  * Register the matrix device with the device core
> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
> +  newer) and to provide the vfio_ap driver's probe and remove callback
> +  interfaces. The reason why older devices are not supported is because there
> +  are no systems available on which to test.
> +* The admin needs to reserve the AP Queue for vfio_ap driver. This can be
> +  done by writing the AP adapter mask to /sys/bus/ap/apmask and the AP domain
> +  mask to /sys/bus/ap/aqmask.
> +
> +  For example to reserve all the AP Queues on the system for vfio_ap driver:
> +
> +  echo 0x0000000000000000000000000000000000000000000000000000000000000000 > /sys/bus/ap/apmask
> +  echo 0x0000000000000000000000000000000000000000000000000000000000000000 > /sys/bus/ap/aqmask

And this is a reasonable user syntax? ;)

...
> +  * mdev_attr_groups
> +    This attribute group identifies the user-defined sysfs attributes of the
> +    mediated device. When a device is registered with the VFIO mediated device
> +    framework, the sysfs attributes files identified in the 'mdev_attr_groups'
> +    structure will be created in the mediated matrix device's directory. The
> +    sysfs attributes for a mediated matrix device are:
> +    * assign_adapter:
> +      A write-only file for assigning an AP adapter to the mediated matrix
> +      device. To assign an adapter, the APID of the adapter is written to the
> +      file.
> +    * assign_domain:
> +      A write-only file for assigning an AP usage domain to the mediated matrix
> +      device. To assign a domain, the APQI of the AP queue corresponding to a
> +      usage domain is written to the file.
> +    * matrix:
> +      A read-only file for displaying the APQNs derived from the adapters and
> +      domains assigned to the mediated matrix device.
> +    * assign_control_domain:
> +      A write-only file for assigning an AP control domain to the mediated
> +      matrix device. To assign a control domain, the ID of a domain to be
> +      controlled is written to the file. For the initial implementation, the set
> +      of control domains will always include the set of usage domains, so it is
> +      only necessary to assign control domains that are not also assigned as
> +      usage domains.


How will the user know when this changes?  What's the transition plan
to maintain compatibility when it does change?

...
> +4. The administrator now needs to configure the matrixes for mediated
> +   devices $uuid1 (for Guest1) and $uuid2 (for Guest2).
> +
> +   This is how the matrix is configured for Guest1:
> +
> +   echo 5 > assign_adapter
> +   echo 6 > assign_adapter
> +   echo 4 > assign_domain
> +   echo 0xab > assign_domain
> +
> +   For this implementation, all usage domains - i.e., domains assigned
> +   via the assign_domain attribute file - will also be configured in the ADM
> +   field of the KVM guest's CRYCB, so there is no need to assign control
> +   domains here unless you want to assign control domains that are not
> +   assigned as usage domains.
> +
> +   If a mistake is made configuring an adapter, domain or control domain,
> +   you can use the unassign_xxx files to unassign the adapter, domain or
> +   control domain.

Would it be more consistent with other sysfs entries to call these
"bind" and "unbind" rather than "assign" and "unassign"?

> +
> +   To display the matrix configuration for Guest1:
> +
> +   cat matrix
> +
> +   This is how the matrix is configured for Guest2:
> +
> +   echo 5 > assign_adapter
> +   echo 0x47 > assign_domain
> +   echo 0xff > assign_domain
> +
> +5. The adminstrator now needs to activate the mediated devices.
> +   echo 1 > activate

Or optionally not.  As in reply to cover letter, I don't think this
interface is sufficiently justified, or necessarily desirable.

> +6. Start Guest1:
> +
> +   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on,apft=on \
> +      -device vfio-ap,sysfsdev=/sys/devices/virtual/misc/vfio_ap/mdev_supported_types/vfio_ap-passthrough/devices/$uuid1 ...
> +
> +7. Start Guest2:
> +
> +   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on,apft=on \
> +      -device vfio-ap,sysfsdev=/sys/devices/virtual/misc/vfio_ap/mdev_supported_types/vfio_ap-passthrough/devices/$uuid2 ...
> +
> +When the guest is shut down, the mediated matrix device may be removed.
> +
> +Using our example again, to remove the mediated matrix device $uuid1:
> +
> +   /sys/devices/virtual/misc
> +      --- [vfio_ap]
> +      --------- [mdev_supported_types]
> +      ------------ [vfio_ap-passthrough]
> +      --------------- [devices]
> +      ------------------ [$uuid1]
> +      --------------------- activate
> +      --------------------- remove
> +
> +
> +   echo 0 > activate
> +   echo 1 > remove
> +
> +   This will release all the AP queues for the mediated device and
> +   remove all of the mdev matrix device's sysfs structures. To
> +   recreate and reconfigure the mdev matrix device, all of the steps starting
> +   with step 4 will have to be performed again.
> +
> +   It is not necessary to remove an mdev matrix device, but one may want to
> +   remove it if no guest will use it during the lifetime of the linux host. If
> +   the mdev matrix device is removed, one may want to unbind the AP queues the
> +   guest was using from the vfio_ap device driver and bind them back to the
> +   default driver. Alternatively, the AP queues can be configured for another
> +   mdev matrix (i.e., guest). In either case, one must take care to change the
> +   secure key configured for the domain to which the queue is connected.

This seems prime for data leakage, extremely sensitive data at that.
Who's responsibility is it to prevent this?  Shouldn't closing the
device reset the device, which should perhaps wipe any key
configuration?

> +
> +
> +Limitations
> +===========
> +An admin needs to be careful when writing to sysfs files
> +/sys/bus/ap/apmask and /sys/bus/ap/aqmask. These files control the driver
> +to which an AP queue is bound to. Once an AP queue is bound vfio_ap
> +driver and assigned to a mediated device, admin should not re-assign the
> +AP queues back to the default driver, because of technical limitations.
> +The kernel does not prevent you from re-assigning from AP queues reserved
> +for the vfio_ap driver back to default driver.  Future enhancements in
> +the ap_bus and vfio_ap are likely to introduce complete support for such
> +dynamic reconfiguration. But until then be extremely careful.

Why don't we have these enhancements now?  Should the whole thing be
marked experimental without them?  This sounds similar to a vfio-pci
case where a group with multiple devices could have device which is
unused by the user unbound from vfio-pci and re-bound to a native host
driver.  We BUG_ON when this occurs to protect the data.

Probably also need to evaluate updates to
Documentation/ABI/testing/sysfs-bus-vfio-mdev, especially if libvirt is
supposed to interact with an 'activate' attribute.  Thanks,

Alex
