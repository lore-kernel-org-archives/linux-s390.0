Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbhALVur (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 16:50:47 -0500
Date: Tue, 12 Jan 2021 15:50:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <20210112215004.GA1855697@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111093857.24070-2-schnelle@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
> We use the UID of a zPCI adapter, or the UID of the function zero if
> there are multiple functions in an adapter, as PCI domain if and only if
> UID Checking is turned on.
> Otherwise we automatically generate domains as devices appear.
> 
> The state of UID Checking is thus essential to know if the PCI domain
> will be stable, yet currently there is no way to access this information
> from userspace.
> So let's solve this by showing the state of UID checking as a sysfs
> attribute in /sys/bus/pci/uid_checking

Cosmetic: can't tell if the above is two paragraphs separated by blank
lines or four separated by either blank lines or short last lines.
Please separate or reflow to avoid the ambiguity.

I don't have any input on the s390 issues, and I assume this will go
via the s390 tree.

> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++++
>  arch/s390/include/asm/pci.h             |  3 +++
>  arch/s390/pci/pci.c                     |  4 +++
>  arch/s390/pci/pci_sysfs.c               | 34 +++++++++++++++++++++++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 25c9c39770c6..a174aac0ebb0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -375,3 +375,14 @@ Description:
>  		The value comes from the PCI kernel device state and can be one
>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>  		The file is read only.
> +What:		/sys/bus/pci/zpci/uid_checking
> +Date:		December 2020
> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
> +Description:
> +		This attribute exposes the global state of UID Checking on
> +		an s390 Linux system. If UID Checking is on this file
> +		contains '1' otherwise '0'. If UID Checking is on the UID of
> +		a zPCI device, or the UID of function zero for a multi-function
> +		device will be used as its PCI Domain number. If UID Checking
> +		is off PCI Domain numbers are generated automatically and
> +		are not stable across reboots.
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 212628932ddc..3cfa6cc701ba 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -285,6 +285,9 @@ void zpci_debug_exit_device(struct zpci_dev *);
>  /* Error reporting */
>  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
>  
> +/* Sysfs Entries */
> +int zpci_sysfs_init(void);
> +
>  #ifdef CONFIG_NUMA
>  
>  /* Returns the node based on PCI bus */
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 41df8fcfddde..c16c93e5f9af 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -881,6 +881,10 @@ static int __init pci_base_init(void)
>  	if (rc)
>  		goto out_find;
>  
> +	rc = zpci_sysfs_init();
> +	if (rc)
> +		goto out_find;
> +
>  	s390_pci_initialized = 1;
>  	return 0;
>  
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index 5c028bee91b9..d00690f73539 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -172,3 +172,37 @@ const struct attribute_group *zpci_attr_groups[] = {
>  	&pfip_attr_group,
>  	NULL,
>  };
> +
> +/* Global zPCI attributes */
> +static ssize_t uid_checking_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%i\n", zpci_unique_uid);
> +}
> +
> +static struct kobj_attribute sys_zpci_uid_checking_attr =
> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);

Use DEVICE_ATTR_RO instead of __ATTR.

> +static struct kset *zpci_global_kset;
> +
> +static struct attribute *zpci_attrs_global[] = {
> +	&sys_zpci_uid_checking_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group zpci_attr_group_global = {
> +	.attrs = zpci_attrs_global,
> +};
> +
> +int __init zpci_sysfs_init(void)
> +{
> +	struct kset *pci_bus_kset;
> +
> +	pci_bus_kset = bus_get_kset(&pci_bus_type);
> +
> +	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);
> +	if (!zpci_global_kset)
> +		return -ENOMEM;
> +
> +	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
> +}
> -- 
> 2.17.1
> 
