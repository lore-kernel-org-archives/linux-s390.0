Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDB3921C2;
	Thu, 26 Feb 2026 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094873; cv=none; b=NagiuLAu/FVMizaomK3W8GhFVlFyDRcLCFAB8mAAA2VgbpDwaI77LQ7OBlQ+uRbMrO/G9tpJYm0tyOqo6ckac6GrMSjtV/skEAF+/gVwzZDaHvtyqTdCimjOCoQiKbwvLk/s0LBq+IQBhFL27L15rTNa0Un3+H57D6gQmnBMXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094873; c=relaxed/simple;
	bh=mzOWD7mNshXx7nO5MZ/qJg04qYnAJtMUBh8qbBXsI9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TETPNpfYVCRbhv6i8ilvFdRm4+K63QOGwEK9/DvIX6de7tjhLMBxbA7hUrRqrwj6ZK3I59JvZg4HH9hHXbFWRf+pffSXzbNDZiL+8aak0UUljWESIAf7OhYd03j9jONdc094Q8jSYa+Hjs0EoWpozVSdNZuauEH7QgezjbU5rw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3z6MHfv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3z6MHfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564CC19422;
	Thu, 26 Feb 2026 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772094873;
	bh=mzOWD7mNshXx7nO5MZ/qJg04qYnAJtMUBh8qbBXsI9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3z6MHfvpib4/bK4lwRNcneTS9mLJOI5+tcz0bevnlp2s6jA/4VgZYOlp7HLSnjvq
	 Y4sm91jJXe9lS0YDlI82S+pIhu9eEFlTTdyNwDcYNSTl6/iyccVg9Bji+abwdDnJiV
	 DXpYBfvS2BmA+MdpJwA1gARIc40PzJZkB9pBfTE4jLSncjL6fjLDR7Jn8zqKX6AaXp
	 oAwvDCofeJsKub8Lz2NtkHaFxYiuDbzW4rbM5Fj80C5Vp3281i2QCHSEdXSTzrIZFs
	 ++P/p8c/MuK5FycrMO+7QDI8tZdI9XTjivGUiEPSKs/IjyUEfEvtEu646FdKEfBA1Y
	 qPyTfLr9e5BOg==
Date: Thu, 26 Feb 2026 10:34:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI
 slots
Message-ID: <20260226083427.GF12611@unreal>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225150815.81268-1-ramesh@linux.ibm.com>

On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
> Add a new write-only 'uevent' attribute to PCI slot sysfs
> entries. This provides a mechanism for userspace to explicitly
> synthesize PCI slot uevents when needed.
> 
> For cold-plugged PCI devices, slots may be created before
> udev is ready to receive events, causing the initial 'add'
> uevents to be missed. As a result, slot specific udev
> rules that define naming, permissions, and related policies,
> are not applied at boot. Allowing userspace to resynthesize
> the 'add' uevent ensures these rules are processed correctly.

This patch sounds like a hack to me. AFAIK, "udevadm trigger"
performs exactly that.

Thanks

> 
> The patch was validated by manually triggering PCI slot 'add'
> uevents through the slot’s 'uevent' sysfs file and confirming
> that udev received and processed those events. The following
> command raises an 'add' uevent for a specific PCI slot:
> 
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
> 
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
> ---
>  drivers/pci/slot.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 787311614e5b..cbc7cf6ab7ad 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -63,6 +63,15 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
>  
> +static ssize_t uevent_write_file(struct pci_slot *slot,
> +				 const char *buf, size_t len)
> +{
> +	int rc;
> +
> +	rc = kobject_synth_uevent(&slot->kobj, buf, len);
> +	return rc ? rc : len;
> +}
> +
>  static void pci_slot_release(struct kobject *kobj)
>  {
>  	struct pci_dev *dev;
> @@ -89,11 +98,14 @@ static struct pci_slot_attribute pci_slot_attr_max_speed =
>  	__ATTR(max_bus_speed, S_IRUGO, max_speed_read_file, NULL);
>  static struct pci_slot_attribute pci_slot_attr_cur_speed =
>  	__ATTR(cur_bus_speed, S_IRUGO, cur_speed_read_file, NULL);
> +static struct pci_slot_attribute pci_slot_attr_uevent =
> +	__ATTR(uevent, S_IWUSR, NULL, uevent_write_file);
>  
>  static struct attribute *pci_slot_default_attrs[] = {
>  	&pci_slot_attr_address.attr,
>  	&pci_slot_attr_max_speed.attr,
>  	&pci_slot_attr_cur_speed.attr,
> +	&pci_slot_attr_uevent.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(pci_slot_default);
> -- 
> 2.43.0
> 
> 
