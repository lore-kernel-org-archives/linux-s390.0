Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF698233704;
	Mon,  3 Aug 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786863; cv=none; b=gEWJog+/kSRED/bQm082X0D6EqqT5ZogT+jjWxaZWnd0f0+8m7FqRztypriSmu7I1N3YKYUnthiiJ6byeD1cWAnTYbuJNe8WO7p3xezOb0m3NYkhm7v9qdYu9MIDHsaEXCe2nJksyW/APdLVvBwCPXhABm08j3GBfc7Ad47a11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786863; c=relaxed/simple;
	bh=6e/HZpZPILJEKifBNLBLxosvOjZJ/QaSMn5G6qLB+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SExrzJ4fZhxeRw8jG1qDWF+VOKRv7SXxgPkDYyy50ezqFljZvi0oszPp1dWtfLzM5srpn2EAZt3QbqKxGZZEZ1H9nXa17rqM/jdS4hQHRi/s7dwBpvwDOT2D9K/Jt2Pm+o8w8NIEU5WIhgND1rgOor+N88uVU9P7djZKRaLPhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Sj9mfymY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBJH0kYR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Sj9mfymY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBJH0kYR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E6BD7A0027;
	Mon,  3 Aug 2026 15:54:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 15:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785786858;
	 x=1785873258; bh=6gvqG0h/fnfFqw/tyXSjXEQXU3l/ydB7TEWvbht+nMM=; b=
	Sj9mfymYe69Bakliu9nrsUmEo/Pat63TMV7uS89z3b9L8hGY0Gutko5gWTpjcSQt
	H6GLgCirsQJwQn6PBC5IpzHLpfLCKSTftgXrIQrpbIt9NlhInoR3pgAFYm2h7su6
	1Q2dNlp6lp6aMWRr+Iq4XylKE0zcyAq5vKa7iUZRpTYTksnOyr2VTsFfROexmZNd
	U5B7esjICFOf5kwwKGhYR10FSIJ5VjA2iEouKFE/MFEsRqi4ONwCxhFQOdF2Ni4/
	JyqIdUyG9UdRTbBv6AwIrA5K6oKx97o+t5Ocgnk8/K+Zn2k7VYlpCSuvmUOtkPzS
	n0ov3R626sCgiaGD8fYIfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785786858; x=
	1785873258; bh=6gvqG0h/fnfFqw/tyXSjXEQXU3l/ydB7TEWvbht+nMM=; b=D
	BJH0kYR4t5Mk/RywNw8lSa3FYZUUC55+8OQhHX7AWDZlnGgkL3Wi+rkj7PpooIpk
	qIGYT+nomqYHp6osL8gDu88COXF2goht/euTohtjPX9vrR+Nx9MrwS3oRhd6xPag
	nJRSburNYM9ygJBmnLohHvtkwJsk+uVzbV0S70jKMhsebSThF9vXR++IoaT+YlVr
	kp4GIj0JpuFkl3/1lmEtgm8ip5H6xHINIx8B/vs2CdL15B8VXKXpjcv6dttNiDEg
	6mLPnLDXQG2b0qzpTJ8RyCRXYJuVYF0tKkNqWaqQ2ovcYLg/ysT/ysmal2voUVti
	sJqhsV1xHgOTMq/+Ih2Jg==
X-ME-Sender: <xms:6vFwas_biVn3knImByGQp3QAfjnb-ZXjOGY3FS8qy0LudxzE5xZgRw>
    <xme:6vFwas6hdOJtwxp_y9ugpLYri1CwLA-uU1Imo9nBpbik-eYH4HdOjDoq4IMEGWpPQ
    QDByiy7x_aKfKbp-aA1zzaP6zV69kmcn3RFL4ne5u4kXyxEitN_Ig>
X-ME-Received: <xmr:6vFwatm6aowWXeqwCAUmGxwUsKYrSb5J1IyjfA208iQKM0Bq0QCkE9pXy3Rw4A>
X-ME-Proxy-Cause: dmFkZTGltzPlwtmti0E2Nh31khFASEJ+ar9YxNqtyAevun1jv7a1T+z1vDJEvEhgJZm9x+
    Fg/mgO2N+BKvSKB1WjxoRaWku66YQLbE5obBRr6hJ10xTiimC+SN4ABMnnyaXs7eYjB/hf
    WNa6AGagpZ66ucru3QotzyCBR6Qfr2T+Kqymqc84GPjH+Ww7LnjLH4M61vdgHI0kEH+WdV
    cRf6EurkUMcICU8gGxz2V7KwrbcDPPzcrSGLrvnIVIHPhR/etzqx6sbzE2DPfIjoQRhRSW
    aF3yq4V66AFW2fT8N9x9i6N5dsS5iGvFs/vm/uurpTx9ktJiHQbZI0i1cjaSICV4SSvBst
    JO+30QiMoOmCnNqXGqoxtmny+z0scYPK9h8TnOJGwQT5s4lteB0/HxhZFaoh0cwNKNl/aP
    aXUHW4b/mxgu3ZlXDqZn1XCSstiKo/Ec62FHtvNyaCCjKpH9H04kiTBeUD/1TgTHcth42E
    0bSo+dBeBpXAtm33/X7oZ7rHb5/9Bq6msaG99OSIiilvFIR0PAWEyGBq1uv3UbCCy2MQm+
    JoynWvqFfxgyOVoBx1hjz7wrBLT5lw7+ASA8Fgvkg+k7V6iXRDyDdKh797GpR3iay0+7Ry
    9HOoaKCt06FmZbjc1kaVFaEY6DywQpwCvWlkPspew6+aw2p8IOJyKm1YxIVw
X-ME-Proxy: <xmx:6vFwanEK1X1e7UW1z-J4jVYJQ7v9G_GE1CtthfzedPfRBbpu3NkcoA>
    <xmx:6vFwas87kZC4MDqTN5oCmWudgLf2iMfa6ah-SJjKOjZ-b4H602OjHw>
    <xmx:6vFwaglES6WfjMt8qdjdlhlouOooj7ol7D8YYnEYsex1ih3ehWczOA>
    <xmx:6vFwavAoQ1bL7bHD9dfr5XA8Y7y-kHrLsouPuCTgF950cSCFRQY4pQ>
    <xmx:6vFwah9zX0s96clh4sFZs3ZBpXe9kVqyC6cLdzYLAvfjCzcRqf1yKXnS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 15:54:17 -0400 (EDT)
Date: Mon, 3 Aug 2026 13:54:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@linux.ibm.com,
 mattev@meta.com, schnelle@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
Message-ID: <20260803135415.2cfd37bb@shazbot.org>
In-Reply-To: <c0e6803f-7e57-4dfa-a4cd-f2ee188070c8@linux.ibm.com>
References: <20260729181116.1373-1-alifm@linux.ibm.com>
	<e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
	<46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
	<20260729143603.175f60a7@shazbot.org>
	<42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
	<20260729155021.64f7e1ba@shazbot.org>
	<c0e6803f-7e57-4dfa-a4cd-f2ee188070c8@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 09:39:19 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 7/29/2026 2:50 PM, Alex Williamson wrote:
> > On Wed, 29 Jul 2026 14:32:45 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> On 7/29/2026 1:36 PM, Alex Williamson wrote:  
> >>> On Wed, 29 Jul 2026 13:28:46 -0700
> >>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>     
> >>>> On 7/29/2026 12:41 PM, Matthew Rosato wrote:  
> >>>>> On 7/29/26 2:11 PM, Farhan Ali wrote:  
> >>>>>> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
> >>>>>> all devices support having their BARs mapped by the CPU. The
> >>>>>> non_mappable_bars flag indicates that a PCI device's BARs cannot be
> >>>>>> accessed by the CPU. The ISM device on s390 is one such device. The BAR
> >>>>>> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
> >>>>>> to warnings:
> >>>>>>
> >>>>>> vmalloc_node_range for size 281474976714752 failed: Address range
> >>>>>> restricted to 0x2110bab00000 - 0x21903ab00000
> >>>>>>
> >>>>>> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
> >>>>>> is set by the PCI core at enumeration time and already serves the same
> >>>>>> purpose in vfio_pci_probe_mmaps().
> >>>>>>
> >>>>>> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
> >>>>>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> >>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >>>>>> ---
> >>>>>>     drivers/vfio/pci/vfio_pci_core.c | 3 +++
> >>>>>>     1 file changed, 3 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >>>>>> index 3f11a9624b9c..6a184588ff23 100644
> >>>>>> --- a/drivers/vfio/pci/vfio_pci_core.c
> >>>>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >>>>>> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> >>>>>>     
> >>>>>>     		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
> >>>>>>     
> >>>>>> +		if (pdev->non_mappable_bars)
> >>>>>> +			continue;
> >>>>>> +  
> >>>>> This would work for the ISM case at least, but I wonder: should we check
> >>>>> vdev->bar_mmap_supported[bar] instead?
> >>>>>
> >>>>> My question boils down to: do we still want messages for some of the
> >>>>> cases where we set vdev->bar_mmap_supported[bar] = false in
> >>>>> vfio_pci_probe_mmaps()?  
> >>>> AFAIU vfio_pci_probe_mmaps() is only called in
> >>>> vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called
> >>>> in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(),
> >>>> bar_mmap_supported would be false here for all devices. So I don't think
> >>>> it would work here, unless I missed something?  
> >>> Also IO Port and sub-page MMIO BARs are things that do exist.  Thanks,  
> >> Just to clarify, are you suggesting we expand this check to also avoid
> >> mapping IO port and sub-page MMIO BARs?  
> > Sorry, no, I'm not.  I think we're conflating that the barmap is
> > related to mmap access.  The barmap itself is holding the iomap of the
> > BAR, used for read/write.  The only real relation to the mmap is that
> > we request the resource via this path as well.
> >
> > Therefore not only is the ordering of setting up bar_mmap_supported
> > wrong, it's flagging entirely the wrong thing here and keying on it
> > would entirely break IO port and sub-page MMIO BAR access.  Thanks,
> >
> > Alex  
> 
> Hi Alex,
> 
> I wanted some guidance on how we should proceed with this patch? The 
> warning messages are a regression on s390 for ISM devices, so we would 
> like to fix it.

I think the original proposal is probably the correct one.  The
non_mmapable_bars flag doesn't restrict its application to specific BAR
types or access, at least not beyond "can't be mapped to CPU or peers."

If we can't map the BAR to the CPU, then we don't need to request the
region or perform the pci_iomap(), which is what I understand explodes
here.  Therefore we really only need to establish the errno in the
barmap here.

The bar_mmap_supported flag describes something else, whether the BAR
can be mapped into the user address space.  My intention was only to
point out that there are BARs that cannot be mapped to the user address
space because either they're not MMIO or we can't safely map the full
page, therefore bar_mmap_supported is an invalid test for whether we
should request the region or iomap the BAR.

Is there still a gap with the original proposal that I'm missing?
Thanks,

Alex
