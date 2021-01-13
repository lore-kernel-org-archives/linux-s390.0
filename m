Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 Jan 2021 12:55:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <20210113185500.GA1918216@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5013a1-3dde-1633-a0cc-591fc439e29d@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> > On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
> >> We use the UID of a zPCI adapter, or the UID of the function zero if
> >> there are multiple functions in an adapter, as PCI domain if and only if
> >> UID Checking is turned on.
> >> Otherwise we automatically generate domains as devices appear.
> >>
> >> The state of UID Checking is thus essential to know if the PCI domain
> >> will be stable, yet currently there is no way to access this information
> >> from userspace.
> >> So let's solve this by showing the state of UID checking as a sysfs
> >> attribute in /sys/bus/pci/uid_checking

> >> +/* Global zPCI attributes */
> >> +static ssize_t uid_checking_show(struct kobject *kobj,
> >> +				 struct kobj_attribute *attr, char *buf)
> >> +{
> >> +	return sprintf(buf, "%i\n", zpci_unique_uid);
> >> +}
> >> +
> >> +static struct kobj_attribute sys_zpci_uid_checking_attr =
> >> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> > 
> > Use DEVICE_ATTR_RO instead of __ATTR.
> 
> It's my understanding that DEVICE_ATTR_* is only for
> per device attributes. This one is global for the entire
> Z PCI. I just tried with BUS_ATTR_RO instead
> and that works but only if I put the attribute at
> /sys/bus/pci/uid_checking instead of with a zpci
> subfolder. This path would work for us too, we
> currently don't have any other global attributes
> that we are planning to expose but those could of
> course come up in the future.

Ah, I missed the fact that this is a kobj_attribute, not a
device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
seems like it might fit?

Bjorn
