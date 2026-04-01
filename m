Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0B274B43;
	Wed,  1 Apr 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074825; cv=none; b=a/iqnw3Ogl+19ABPcQrMGY4jmhL+oajfmNGd3S7/S+p5KnAPQjeXQBBu7yaKWkcaEcV0lLEGc0XyjMb4mYWZRgJUh/g+8fJmHtFZ1Eut3R+HJ6xIg9czPOwIT0Y3x086+E65vUO/jMRbqyoVrwFToc/tqNKEMbT4O28H03qApmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074825; c=relaxed/simple;
	bh=jJpM26h9oe8n7q6Hvm1xeeXmFVZfsBaJDXWfRegnSMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHmrnkFYlPtzrzaBAWavuhVLsyZTrnfOJcrGCuZaYM2rfAcdoLzk22/juYgcrg7MMSQB2E7M8r/SiEPD97hv1AyovjvIL4sWd/MWCOqhah1/xgd8xGU6V1MaH6OIbu7DEgVlSP0iFg1oB5akjdeahz0XEFgTRF9QeAznIgXxt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=znsnxuFq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="znsnxuFq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=H9qSC3broUCBXnOQSqpaeJBR2UID5sJJa3MOpmV/ZGw=; b=znsnxuFqhGxrDlf6gARPHjzcM+
	jo9UCkRvDizT7+LNysOGYddv+Lmbbg/zbUDAtMxG2Jntkfse7xMmfR0eMhop6Ka1yQquwhJZFeTnL
	ijEHokbkVMDuvxHmC+qTGIatIT+m1Zwg/jsXtGX22UNGv/K8mPsN9zl4lg1Uc+twpgt/tyOhPr7nd
	qfnvSA2znaQ1mwv79EbQUz9jhRfxSA7Z3zqhYgxfrgqTdgRjtKqLvyx7MPo/iKLisBd5hWII1wm8n
	eUwlV03UMP/385pEW0KPcyJlXu3ga6fw0CeR3wIi0VYA9hAHfsx9sTWavdkC1DF8BNgQWXVSL+2y9
	8mpkt81w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8230-0000000G3OW-1GBY;
	Wed, 01 Apr 2026 20:20:19 +0000
Message-ID: <21cec18e-6c1b-4981-9479-03fa0bcc0c70@infradead.org>
Date: Wed, 1 Apr 2026 13:20:17 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Julian Ruess <julianr@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Ramesh Errabolu <ramesh@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20260401-uid_slot-v5-1-e73036c74bf6@linux.ibm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260401-uid_slot-v5-1-e73036c74bf6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/26 7:50 AM, Niklas Schnelle wrote:
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
> ---
> Note: I considered adding the UID as a generic slot index attribute
> analogous to the PCI device index attribute (SMBIOS index / s390 UID)
> but decided against it as this seems rather s390 specific.
> 
> v4->v5:
> - Rebase on v7.0-rc6
> - Reworded note
> - Add documentation for the new attribute
> - Link to v4: https://lore.kernel.org/r/20251217-uid_slot-v4-1-559ceb59ba69@linux.ibm.com
> 
> v3->v4:
> - Rebase on v6.19-rc1
> - Collect R-bs
> - Link to v3: https://lore.kernel.org/r/20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com
> ---
> 
> ---
>  Documentation/arch/s390/pci.rst |  7 +++++++
>  arch/s390/include/asm/pci.h     |  4 ++++
>  arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
>  drivers/pci/slot.c              | 13 ++++++++++++-
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
> index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..03afb57ece4df90a75597cb34c1f048c2e162b67 100644
> --- a/Documentation/arch/s390/pci.rst
> +++ b/Documentation/arch/s390/pci.rst
> @@ -55,6 +55,13 @@ Entries specific to zPCI functions and entries that hold zPCI information.
>  
>    - /sys/bus/pci/slots/XXXXXXXX/power
>  
> +  In addition to using the FID as the name of the slot the slot directory
> +  also contains the following s390 specific slot attributes

                                 s390-specific

Use a period (full stop, '.') at the end of the sentence above.

> +
> +  - uid
> +    The User-defined identifier (UID) of the function which may be configured
> +    by this slot. See also the corresponding attribute of the device.

These 3 lines are run together in html output. Maybe add a ':' or '-' after
uid?

> +>    A physical function that currently supports a virtual function cannot be
>    powered off until all virtual functions are removed with:
>    echo 0 > /sys/bus/pci/devices/XXXX:XX:XX.X/sriov_numvf


-- 
~Randy

