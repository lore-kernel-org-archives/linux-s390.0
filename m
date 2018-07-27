From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 27 Jul 2018 08:38:35 +0000
Subject: Re: [PATCH v7 00/22]  vfio-ap: guest dedicated crypto adapters
Message-Id: <20180727103835.2df878e4.cohuck@redhat.com>
In-Reply-To: <20180726195429.31960-1-borntraeger@de.ibm.com>
References: <20180726195429.31960-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Jul 2018 21:54:07 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:


> v6 => v7 Change log:
> ===================
> * The AP bus gained the ability to designate queues as 'used by host'
>   or as 'used by alternate driver(s)'. This allows us to authorise access
>   (via the CRYCB) to queues that are not currently bound to the vfio_ap
>   driver. If a  vfio_ap owned queue diss- and reapears it's guaranteed
>   to get bound back to the vfio_ap driver.

Hm... how does this interact with the ability to modify the reserved
masks via sysfs? (I have taken only a quick look at that patch, and I'm
not 100% confident that this is race-free; I'll need to think about it
some more.) If the reserved masks can be changed dynamically, this kind
of voids the guarantee, doesn't it? (Although that probably is a
shoot-yourself-in-the-foot case.)

Who is supposed to manage the reserved masks? libvirt in conjunction
with managing the vfio-ap matrix?

> * The mediated device gained an 'activate' attribute. Sharing conflicts are
>   checked on activation now. If the device was not activated, the mdev
>   open still implies activation. An active ap_matrix_mdev device claims
>   it's resources -- an inactive does not.

This means we have a 'commit' workflow?

> * An active ap_matrix_mdev device can not be removed. An ap_matrix_mdev
>   that is hooked up with a guest can not be deactivated.
> * An active ap_matrix_mdev device rejects assign_* and deassign_*
>   operations. Thus changing the CRYCB masks of a guest in order to
>   accomplys certain hotplug scenarios is planned, but not supported yet. In
>   previous versions it was possible to do those operations on a ap_matrix_mdev
>   that is hooked up to a guest, but the changes would take effect on the next
>   mdev_open. 
> * Synchronisation was reworked.
> * The sysfs path of the parent device changed from /sys/devices/vfio_ap/matrix/
>   to /sys/devices/virtual/misc/vfio_ap/. The parent device is a misc
>   device now.

Any particular reason for that change? (Not that I object to misc
devices...)

> * The severity for most of the messages were reduced form error to
>   warning.
> *  We are not as thick headed about the zapq as we used to be in v6.

Hm?
