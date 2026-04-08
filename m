Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C353B4E8B;
	Wed,  8 Apr 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667423; cv=none; b=O0yXvPsG1NlTcWc8BF/ECCqKgPZuJ8ASYOHY1C+WuDO/v+xZqwvsPo+gN8B2rvxjazHM3J9rXAubFUdFmLwjsdu8PS9o+QbXSgybOFQmQFje6LQDq99PzLI1jKDNqj5OCKFe64B3oEsin4Z0HzZA8c3xO9h7cnrTI5jU+7IGQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667423; c=relaxed/simple;
	bh=Fyd2zhpxrgiBWe6iATMFl98c+D/8YDmtxcr+Cd6TbB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CyNfPkgl8iugXpdpfZZXw8ySswU3vtMCriCKtIm97eERFcw7F/KiSHM3FPi/CsqHOxtiGrKMlWKMsmqH/zNhFSo0VUF8WHzD2hjs/7MkV1XEtTDxrBtss8CY6a/FHsack2XelbPfuWkQqxsu8hPk+R/gIouFMTffayRCwPaXO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjmR8BBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjmR8BBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09662C19421;
	Wed,  8 Apr 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775667423;
	bh=Fyd2zhpxrgiBWe6iATMFl98c+D/8YDmtxcr+Cd6TbB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SjmR8BBzyo3kOL2RXsoqweOvvpg80BEqxHIdpLN5hezmtF5FfftkiNd/yCzJqnwJP
	 zv841WkXnntkui8zi4J/OD6S1Rngz1Ns9ug+mK/IrbFDQN78UPXpxq6L5/j0OIecCc
	 lciYjF4cNpc5cuDkWEtXJ2+CM7yDDZDrEQK36jL2nw1NQTQKbO6Xb5p/SNmmPLMCi8
	 o5oxds9BBwuXTpXr67c+/9tFxa2FgTSsWEj/mbw8T0MpiNVYIozudslU1lcrF7U7iT
	 U1bLz6iZ7lzPGFM7g6HdJEbETU6aR+SnuTLg2B1LeGBc4YkRjsp2C00Tmvz+izXmuG
	 4e7juJfBxbGMA==
Date: Wed, 8 Apr 2026 11:57:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Lukas Wunner <lukas@wunner.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Farhan Ali <alifm@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Ramesh Errabolu <ramesh@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v8 2/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Message-ID: <20260408165701.GA295705@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-uid_slot-v8-2-15ae4409d2ce@linux.ibm.com>

On Tue, Apr 07, 2026 at 03:24:46PM +0200, Niklas Schnelle wrote:
> On s390, an individual PCI function can generally be identified by two
> identifiers, the FID and the UID. Which identifier is used depends on
> the scope and the platform configuration.
> 
> The first identifier, the FID, is always available and identifies a PCI
> device uniquely within a machine. The FID may be virtualized by
> hypervisors, but on the LPAR level, the machine scope makes it
> impossible to create the same configuration based on FIDs on two
> different LPARs of the same machine, and difficult to reuse across
> machines.
> 
> Such matching LPAR configurations are useful, though, allowing
> standardized setups and booting a Linux installation on different LPARs.
> To this end the UID, or user-defined identifier, was introduced. While
> it is only guaranteed to be unique within an LPAR and only if indicated
> by firmware, it allows users to replicate PCI device setups.
> 
> On s390, which uses a machine hypervisor, a per PCI function hotplug
> model is used. The shortcoming with the UID then is, that it is not
> visible to the user without first attaching the PCI function and
> accessing the "uid" device attribute. The FID, on the other hand, is
> used as the slot name and is thus known even with the PCI function in
> standby.
> 
> Remedy this shortcoming by providing the UID as an attribute on the slot
> allowing the user to identify a PCI function based on the UID without
> having to first attach it. Do this via a macro mechanism analogous to
> what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> pdev->dev.groups") for the PCI device attributes.
> 
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/slot.c

> ---
>  Documentation/arch/s390/pci.rst |  7 +++++++
>  arch/s390/include/asm/pci.h     |  4 ++++
>  arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
>  drivers/pci/slot.c              | 13 ++++++++++++-
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
> index c3476de4f03278d07099aa32cbea0f868b6e9c9c..80f4ba19315994da056a10b4d216d61ff22ea5aa 100644
> --- a/Documentation/arch/s390/pci.rst
> +++ b/Documentation/arch/s390/pci.rst
> @@ -58,6 +58,13 @@ Entries specific to zPCI functions and entries that hold zPCI information.
>  
>    - /sys/bus/pci/slots/XXXXXXXX/power
>  
> +  In addition to using the FID as the name of the slot, the slot directory
> +  also contains the following s390-specific slot attributes.
> +
> +  - uid:
> +    The User-defined identifier (UID) of the function which may be configured
> +    by this slot. See also the corresponding attribute of the device.
> +
>    A physical function that currently supports a virtual function cannot be
>    powered off until all virtual functions are removed with:
>    echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c0ff19dab5807c7e1aabb48a0e9436aac45ec97d..5dcf35f0f325f5f44b28109a1c8d9aef18401035 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -208,6 +208,10 @@ extern const struct attribute_group zpci_ident_attr_group;
>  			    &pfip_attr_group,		 \
>  			    &zpci_ident_attr_group,
>  
> +extern const struct attribute_group zpci_slot_attr_group;
> +
> +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
> +
>  extern unsigned int s390_pci_force_floating __initdata;
>  extern unsigned int s390_pci_no_rid;
>  
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index c2444a23e26c4218832bb91930b5f0ffd498d28f..d98d97df792adb3c7e415a8d374cc2f3a65fbb52 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -187,6 +187,17 @@ static ssize_t index_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(index);
>  
> +static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
> +{
> +	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
> +					     hotplug_slot);
> +
> +	return sysfs_emit(buf, "0x%x\n", zdev->uid);
> +}
> +
> +static struct pci_slot_attribute zpci_slot_attr_uid =
> +	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);
> +
>  static umode_t zpci_index_is_visible(struct kobject *kobj,
>  				     struct attribute *attr, int n)
>  {
> @@ -243,6 +254,15 @@ const struct attribute_group pfip_attr_group = {
>  	.attrs = pfip_attrs,
>  };
>  
> +static struct attribute *zpci_slot_attrs[] = {
> +	&zpci_slot_attr_uid.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group zpci_slot_attr_group = {
> +	.attrs = zpci_slot_attrs,
> +};
> +
>  static struct attribute *clp_fw_attrs[] = {
>  	&uid_checking_attr.attr,
>  	NULL,
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 787311614e5b6ebb39e7284f9b9f205a0a684d6d..2f8fcfbbec24e73d0bb6e40fd04c05a94f518045 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -96,7 +96,18 @@ static struct attribute *pci_slot_default_attrs[] = {
>  	&pci_slot_attr_cur_speed.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(pci_slot_default);
> +
> +static const struct attribute_group pci_slot_default_group = {
> +	.attrs = pci_slot_default_attrs,
> +};
> +
> +static const struct attribute_group *pci_slot_default_groups[] = {
> +	&pci_slot_default_group,
> +#ifdef ARCH_PCI_SLOT_GROUPS
> +	ARCH_PCI_SLOT_GROUPS,
> +#endif
> +	NULL,
> +};
>  
>  static const struct kobj_type pci_slot_ktype = {
>  	.sysfs_ops = &pci_slot_sysfs_ops,
> 
> -- 
> 2.51.0
> 
