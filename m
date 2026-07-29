Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C93DEAC1;
	Wed, 29 Jul 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361834; cv=none; b=JQJxJu5Fw5awgq4Pus2EX9mBb9QU4Haa+L4+IRUDYD1YIFtmLGhQtpe4K3k59o+xWvu8TgQpLfRbLRxIQIzu+ssIPaP/We0guu/KN+eD4xxLDfVI5dTzT62pPNbnhv1RgfaI//T2tpwHiW2VG0GR4wKClDJpfrbnQQr9XcPJ/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361834; c=relaxed/simple;
	bh=FztkdQ/dtyZfDkZCpEWl1/Wb9XGMy69s9lywCcQKXEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHqcpI+s3hHbVW+61Puh2vfOzFxYpyeEE82u/zA/151v6LEbJE8I7/diJAsRtTFWPwxs7pUXK/udenUps24pDPRtUr0lAJMDrVtTxe0H65QYXRHyeUr3epq0FSpNyG+iRXveVecROHXNgpKcvRb1XG9WF/ADzZZNcD18ZGBVGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=jzf8yYap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e25RWTak; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="jzf8yYap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e25RWTak"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 97FF0EC05EF;
	Wed, 29 Jul 2026 17:50:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 29 Jul 2026 17:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785361824;
	 x=1785448224; bh=AmXe2mWigapj/LtemwBsm8npUZDPmncTefVXCJhauO0=; b=
	jzf8yYapzZgckZ3P+4z7UFSHPKZUO/8v+u0lPPxibb6u2h52cIAomNQd2fXse0xL
	SLuLggw3bOy5ryKKSp2WkQoDNfQcDHixv8WVN1X4vleSu4eYPEqkqfyDGpelanRO
	tWfuHGkNlwuBUBjfxlyyFGaCTK0aDypcX1amZPTd/LllKn2T8JeiH002vLkVcPQy
	qt/hRdc+Pw7YqSQwgazSEFCA//98Rt0ykNJlU5O4zQulYY8jk1ivtY+xDd8gcuzf
	J48b1j2JCGSbosTgxKkS1q63elVn5IG8wfVnOF9vtEtqTUoi5unvTLqXf5mqZiqL
	kvX0snenPAj7Ac6CEPIjBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785361824; x=
	1785448224; bh=AmXe2mWigapj/LtemwBsm8npUZDPmncTefVXCJhauO0=; b=e
	25RWTakdBPX8/4g2NbOXhUtlDn9OtRnxye8AMJZyovPUnwnNvbskB5iq0NzRjAJa
	lX3DURDpD2mu30vSg8FbbjUQeuzxsfyqzRPwzyC0fTAPEraOsAMUJcRwQRnTXEdx
	97KITwYkhtzgwTVexZqDslY50rvtTRUFXg4hbOKHD3kANYO0i3eEWUE8OXODU/5i
	klxP5vTODMiyLwRQupvoPz93vmJ+GbNou6tZ1T4gxDdZlbPC1k0kMsOAXWCqaY5Y
	JRCxoKr9QqB6uw9CAWPilXjFguTPNFGBoQlRhBYmgKODKpiZp02/v2MfO+LUTVw0
	/GIhiw3d6WEmTcuXOyPHw==
X-ME-Sender: <xms:oHVqauhc7utDy6mQIUCMDLxLDt6cH-py94hxFcn2sKh6WnVAsavQsg>
    <xme:oHVqanMPSDTbeh_oAWvqr51zvd6mOzFQvrG9r4T7F6eCAQdqW9hdtX9VYXp4ALV5E
    FjFqnBCtM9ateLOo-QyybCljfytAnY3nM5hjlUXbmJDCIPP1YNZUGM>
X-ME-Received: <xmr:oHVqahqoDoIobJWl6rqG-sPKUSW0Ja-NYE92ZI0i8iHWuRYH33fhXSTwVdN1Pw>
X-ME-Proxy-Cause: dmFkZTFgGM8ARVN1z2IjFiKnuxC1m8+je2NAQyueXYStGiu0zrGeiKsIKYyWCZWTd47RCQ
    RjRokuv9oDWLAk+3OHouRf5XICnYiJaIugi+7M5AtEZ2f6T4hmwInY0nZTsfs2eq0ZSUBj
    JkRr8TMKqZJT7Z0PBsBlwzV5SUT6AtskuUB9OUkB3rhV4CUsmFp4dQri/1fVjy94YJJgMS
    umUzsPqSabqQjEL85dTeQV1Xd1KauHl+x9DKNKVin7Hc8Tp2b/GhiOX/Yt5W3FvNaQsbIf
    LlRKotKpqp0YK9WbNcckBlxWI+OGnrucAFnzJ5sgDvFKcpYArqOnTfcdcB263Mwi4J+iYn
    p7kI6J2C/aEhmpkD8oBMj/GNtsYr1OlSMLCjxKAcJw/0KKfFeAEY1hMnHoX1sdmvtMNpig
    NCL+tq/QAr99AzNg4tkMJPFh7TisdT0NKbxPYAisfJAwSHbhWNt+er0KAKKyJwPPNhfMLq
    yJ0d/AqmcC0oY9GVO1M8E7252z5+g3HmN50N5HQiZtba3uUU/JjV8/UsMMwbat5lv+swaO
    16NE3MNHyvCU3ynVybADXsAzntq8M8rB3NKVESao+vv+VuC3XOOdPxCLrWTX/Tjaizam4j
    hjTv6rdPM9K/ZChwqX+R8IiFDtX9gxKf3DvN5nSOxJwFXREO4Vj+MzcY+RUw
X-ME-Proxy: <xmx:oHVqah51tXEEDgVL_1CC4G1qQ7McO48O6ZBX1fSH4gjENPGDPsPP9w>
    <xmx:oHVqangVcmSxIQyeo7yOSvtCRQnB2mqv0GWVfAzzY0bAwERT61-a2Q>
    <xmx:oHVqav7GYRWYPmpPXvfnBkxEKyDcvtK9f4YnO4CunDNOLEg8_y6NYQ>
    <xmx:oHVqakEJXXnD6sMzPnsk-J1fzyPLro8zfH2pQdgPK1PzNA1x-nU_1w>
    <xmx:oHVqasidtOW6N1IOKBRJcJatIx-L4sFLuvcHq5fqW6G7lnaJQ9HLFHI6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:50:23 -0400 (EDT)
Date: Wed, 29 Jul 2026 15:50:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@linux.ibm.com,
 mattev@meta.com, schnelle@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
Message-ID: <20260729155021.64f7e1ba@shazbot.org>
In-Reply-To: <42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
References: <20260729181116.1373-1-alifm@linux.ibm.com>
	<e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
	<46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
	<20260729143603.175f60a7@shazbot.org>
	<42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 14:32:45 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 7/29/2026 1:36 PM, Alex Williamson wrote:
> > On Wed, 29 Jul 2026 13:28:46 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> On 7/29/2026 12:41 PM, Matthew Rosato wrote:  
> >>> On 7/29/26 2:11 PM, Farhan Ali wrote:  
> >>>> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
> >>>> all devices support having their BARs mapped by the CPU. The
> >>>> non_mappable_bars flag indicates that a PCI device's BARs cannot be
> >>>> accessed by the CPU. The ISM device on s390 is one such device. The BAR
> >>>> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
> >>>> to warnings:
> >>>>
> >>>> vmalloc_node_range for size 281474976714752 failed: Address range
> >>>> restricted to 0x2110bab00000 - 0x21903ab00000
> >>>>
> >>>> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
> >>>> is set by the PCI core at enumeration time and already serves the same
> >>>> purpose in vfio_pci_probe_mmaps().
> >>>>
> >>>> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
> >>>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> >>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >>>> ---
> >>>>    drivers/vfio/pci/vfio_pci_core.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >>>> index 3f11a9624b9c..6a184588ff23 100644
> >>>> --- a/drivers/vfio/pci/vfio_pci_core.c
> >>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >>>> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> >>>>    
> >>>>    		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
> >>>>    
> >>>> +		if (pdev->non_mappable_bars)
> >>>> +			continue;
> >>>> +  
> >>> This would work for the ISM case at least, but I wonder: should we check
> >>> vdev->bar_mmap_supported[bar] instead?
> >>>
> >>> My question boils down to: do we still want messages for some of the
> >>> cases where we set vdev->bar_mmap_supported[bar] = false in
> >>> vfio_pci_probe_mmaps()?  
> >> AFAIU vfio_pci_probe_mmaps() is only called in
> >> vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called
> >> in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(),
> >> bar_mmap_supported would be false here for all devices. So I don't think
> >> it would work here, unless I missed something?  
> > Also IO Port and sub-page MMIO BARs are things that do exist.  Thanks,
> 
> Just to clarify, are you suggesting we expand this check to also avoid 
> mapping IO port and sub-page MMIO BARs?

Sorry, no, I'm not.  I think we're conflating that the barmap is
related to mmap access.  The barmap itself is holding the iomap of the
BAR, used for read/write.  The only real relation to the mmap is that
we request the resource via this path as well.

Therefore not only is the ordering of setting up bar_mmap_supported
wrong, it's flagging entirely the wrong thing here and keying on it
would entirely break IO port and sub-page MMIO BAR access.  Thanks,

Alex
