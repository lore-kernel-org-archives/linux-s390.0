Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhBDKku (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 4 Feb 2021 05:40:50 -0500
Date: Thu, 4 Feb 2021 11:40:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
Message-ID: <YBvPBD+fCtQkCFFD@kroah.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
 <20210204094353.63819-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204094353.63819-2-schnelle@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

On Thu, Feb 04, 2021 at 10:43:53AM +0100, Niklas Schnelle wrote:
> The global UID uniqueness attribute exposes whether the platform
> guarantees that the user-defined per-device UID attribute values
> (/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
> a global identifier for the associated PCI device. With this commit
> it is exposed at /sys/bus/pci/zpci/unique_uids
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 25c9c39770c6..812dd9d3f80d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -375,3 +375,12 @@ Description:
>  		The value comes from the PCI kernel device state and can be one
>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>  		The file is read only.
> +What:		/sys/bus/pci/zpci/unique_uids

No blank line before this new line?

And why "zpci"?

> +Date:		February 2021
> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
> +Description:
> +		This attribute exposes the global state of UID Uniqueness on an
> +		s390 Linux system. If this file contains '1' the per-device UID
> +		attribute is guaranteed to provide a unique user defined
> +		identifier for that PCI device. If this file contains '0' UIDs
> +		may collide and do not provide a unique identifier.

What are they "colliding" with?  And where does the UID come from, the
device itself or somewhere else?

thanks,

greg k-h
