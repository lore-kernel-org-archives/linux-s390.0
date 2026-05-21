Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664C32E696;
	Thu, 21 May 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374936; cv=none; b=otSSrL/NIFWVDCreUdJtUtTnBqVaWBxEiF0Z8STerA+RergAX5EN5ZiozUrvlDup4rQEdNyx0KQCv/pd5i7oUIbZmq80qmh/W910m+9klvZxVb8nfQWECwpJyZ0d2qYAGO1x2uoagsGb3rETtjpFTurnFuox8D1gvLNAGNTC2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374936; c=relaxed/simple;
	bh=pHvmfcrhrurAq2ILFaCX2/i9A2dkXAZG6nS8cECg8ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PC/pzUT2usQrsz5VU6Cp6KYMSWOYJlCG8RcGsu5sodIxxq+Czg8x/SLwY/1VkJ/QnWomHga66daqRY0w9zt4TB1wo7Ah9E0vhGsl1pODGzPdT5KlOLGEng+DTiYCX4gKi6lwheYBDQqSdJyqfHag/L5tMFSP7oK0kpxZzfVO7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghnmj9gn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghnmj9gn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CB3D31F000E9;
	Thu, 21 May 2026 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374935;
	bh=VsFq90skGZw/EGTa/WEfY0J40QXH4oeLLeAltN7Tq/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Ghnmj9gnZEIRKYnPRT0EjkI+FemdXvo2nPl/XNKwYq0KjoyIAzi4emBvTvyKexayF
	 ADaHyEJ/x3LglFHgloWlmKitUSEQKYQXSYAV+SbAXyhMU7t0niQmDrNAFPpTppVZTV
	 AeG2/S8NC/NySbUDgxuSdCQDmrPrIp9+aHHWXBG66PLQIJxrWorabNaMNy83wpKYpk
	 2/7aJ3tsE2qxQuNvYc/lwRsuFJ0T4GstKbWrJOqNcxRe9svAy7HhP7YmuhWMKg3poI
	 2B7g/K3eypfdErXdPNordwsWs2nAymOC2cASd8LU5Cv8D9fKnGtWky6D+YdNAHZLo/
	 XC0Dgpzg8wBcQ==
Date: Thu, 21 May 2026 09:48:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v4] PCI: hotplug: Add 'uevent' sysfs attribute to trigger
 slot events
Message-ID: <20260521144853.GA163149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520221320.99788-1-ramesh@linux.ibm.com>

[+cc Leon, driver-core]

(Ramesh, when you post new versions of a series, please cc anybody who
responded to earlier versions.  Also, v2, v3, and v4 are identical, so
there's no need to post them as new "versions"; you can just ping the
original thread or label them as "RESEND")

On Wed, May 20, 2026 at 05:13:20PM -0500, Ramesh Errabolu wrote:
> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
> 
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
> 
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
> 
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index fadcf98a8a66..c3634b1cc7a8 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -173,12 +173,27 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
>  
>  static struct pci_slot_attribute hotplug_slot_attr_presence = {
>  	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO},
>  	.show = presence_read_file,
>  };
>  
> +static ssize_t uevent_write_file(struct pci_slot *slot,
> +				 const char *buf, size_t len)
> +{
> +	int rc;
> +
> +	rc = kobject_synth_uevent(&slot->kobj, buf, len);

I haven't followed the discussion closely, but I'm skeptical because
this would be the only use of kobject_synth_uevent() outside the
driver core.  That means a change like this should include a
description of something unique about this PCI slot situation that is
different from all other buses.

For driver-core, the preceding discussion is here:
https://lore.kernel.org/linux-pci/20260225150815.81268-1-ramesh@linux.ibm.com/t/#m57bf51ce1c073b685b391867d4a9932e5f9dccc9

> +	return rc ? rc : len;
> +}
> +
> +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> +	.show = NULL,

Unnecessary to set ".show = NULL" since that's the default.

> +	.store = uevent_write_file
> +};
> +
>  static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
>  			       size_t count)
>  {
>  	struct hotplug_slot *slot = pci_slot->hotplug;
>  	unsigned long ltest;
>  	u32 test;
> @@ -251,12 +266,17 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>  		if (retval)
>  			dev_err(&pci_slot->bus->dev,
>  				"Error creating sysfs link (%d)\n", retval);
>  		kobject_put(kobj);
>  	}
>  
> +	retval = sysfs_create_file(&pci_slot->kobj,
> +				   &hotplug_slot_attr_uevent.attr);

Krzysztof, any sysfs race issues here?  I assume this (and the
existing uses for power, attention, latch, etc) are not candidates for
static attributes?

> +	if (retval)
> +		goto exit_uevent;
> +
>  	if (has_power_file(slot)) {
>  		retval = sysfs_create_file(&pci_slot->kobj,
>  					   &hotplug_slot_attr_power.attr);
>  		if (retval)
>  			goto exit_power;
>  	}
> @@ -303,19 +323,24 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>  		sysfs_remove_file(&pci_slot->kobj,
>  				  &hotplug_slot_attr_attention.attr);
>  exit_attention:
>  	if (has_power_file(slot))
>  		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
>  exit_power:
> +	sysfs_remove_file(&pci_slot->kobj,
> +			  &hotplug_slot_attr_uevent.attr);
> +exit_uevent:
>  	sysfs_remove_link(&pci_slot->kobj, "module");
>  exit:
>  	return retval;
>  }
>  
>  static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>  {
> +	sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_uevent.attr);
> +
>  	if (has_power_file(slot))
>  		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
>  
>  	if (has_attention_file(slot))
>  		sysfs_remove_file(&pci_slot->kobj,
>  				  &hotplug_slot_attr_attention.attr);
> -- 
> 2.43.0
> 
