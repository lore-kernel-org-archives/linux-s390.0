Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F164A3E
	for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305868; cv=none; b=J4DD5fPG6vbh7LFq60F/utvcc8gkH2Hg0oPGOPGP9XqOKJLSaw5DRfZm02HCI1z+bcQj0ugceOBAZ1SkxQRYNlw0kE+YcX03BWDuU0P1hnWL4ZVKBdQkbR22bsDELug44ivC4dfEXn87td6DPCuY27tuYt5KknQT5Vt2WGU3m1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305868; c=relaxed/simple;
	bh=UYQ/heBMSwesBf4ndeJdw8Tnd7iUiwyxPBtUng/3UNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn/rM3RqeJqvNdZ/ALVVTs7e2vQgP57dKljxvWbN+1+4hhZjSx8D2SKIDXNP78zUDRTl7+oxrRaHvpizGPjdw/E9HPutfzENU1bzqmXaahfSvUdKhkAAoISAlZg8YJ1Urf8wYvElWDGbfmv3UqilZAzMAJs3V3ELE8SxjCsvbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7/D//+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7/D//+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758305865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tP8qgX24boDvqrfxOc41UrXAFnZAOnA7a7ICmrly80=;
	b=W7/D//+AAzrsFhfJuBmqimxbi0nbNwlKgLoRfiNJffPU+JGqnKy8qUWgQig8ERxyML3+QC
	jI0pUeEH4DVtMyISqyAk0abURfRAAjw71SXVdShZagJXxSV7vVovFVkJ0swSlhEAPqR+bg
	TN9kAvqcc02B7E2eaZWl27UGoZ71rWI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-E9lNI6FqMSqOGpDg7fQfAg-1; Fri, 19 Sep 2025 14:17:44 -0400
X-MC-Unique: E9lNI6FqMSqOGpDg7fQfAg-1
X-Mimecast-MFC-AGG-ID: E9lNI6FqMSqOGpDg7fQfAg_1758305863
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4240abfbce2so4261015ab.1
        for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305863; x=1758910663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tP8qgX24boDvqrfxOc41UrXAFnZAOnA7a7ICmrly80=;
        b=oKdg8OaHEKBlP+qPECvW0F+9tRR1gvjzNdKjc1fM7XIncs+3FpaedbPOLd27cEsLrg
         c3olUJZEvTURX3cGvF9+r/44TlYJK2fCf9ishKNKyOmffyvpZBFNsN5g4JpMlyZXDonR
         uwPkH7b44wOdDx3xvCwwz7jatEMsHQ6cR0Htir3kgplMJHB2P0mk9LofU/eLm0PrBWnZ
         gI4khOy/9He+qqacSVDrhhzdyL6W3Jue7MihDZPkSZgI3n8qD/BYw3UcCBo+H8ph2ew+
         8yefGoBNEAnuy9rqXoQD+4EYtakziFzdHWUV0y3xSZu1HL/OqC3EgGT4xiAqHkYMOANh
         wNqA==
X-Forwarded-Encrypted: i=1; AJvYcCVQwlmRjKIgfT746N58oaVJBn+f1uxfYA1h1VEupj6vG8ijMh9YJ2mQq47CrToAIWdpZVAGMOg/hPxx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6osIvst2+L0FY+jBJpSForUiKmeYfjRcOpGmA4mR+yU9OkyQx
	tC1Z9fQWfX8CroTDh4KBBTWSG0iG83ivufK+6x8dFEGWNE2IfLDhbDaa3B27L7RsSma2eR/7N5D
	5yXke++oIMOgZiJA1CKR0IIAGoY1AY67FTVH0XXAFhHybjtiqMmg+OXQbW3V6UQk=
X-Gm-Gg: ASbGncviNhz6E0aEcjjgoc3vDoqb5pWDqwWHj0B+NLLnWEnUqEwgMHmIn5ziEzj2Xi/
	YD6v7BvsHxERjZmSca9+EuxMWJCJCe7i3U0TRBLGk0VpS34YotvuQ4ncRPckqy+Vy2rz/A70LjP
	+x970h/7zVx6PhpQLozaKuvOEHjhxDv+WhzK66p3g3RoYnTRHF7GxZ1SPPDVYn3FBiPgwKKTMIy
	Yg3muB+Gsp84O386zGgRP85tYB7V+njUAiPBMgz4tgIJ/Ir9OCrbFdSPEgCCF3oqyb1mHpZEraX
	Q9/N6Z5j+DCvRxTNPw7Y8WUMcBJj+Wk6wsJ7pcx1k4Y=
X-Received: by 2002:a05:6e02:1d9d:b0:424:69b:e8d0 with SMTP id e9e14a558f8ab-4248190395emr19310665ab.1.1758305863186;
        Fri, 19 Sep 2025 11:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb10MnB7zhkH1dVW9AEzJVk+z8ybEB8AlSck6uXI8Tp5xc6aeeZCL649awhtncJC1hXa8bVg==
X-Received: by 2002:a05:6e02:1d9d:b0:424:69b:e8d0 with SMTP id e9e14a558f8ab-4248190395emr19310505ab.1.1758305862772;
        Fri, 19 Sep 2025 11:17:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm24280945ab.22.2025.09.19.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:17:42 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:17:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3 01/10] PCI: Avoid saving error values for config
 space
Message-ID: <20250919121739.53f79518.alex.williamson@redhat.com>
In-Reply-To: <d6655c44-ca97-4527-8788-94be2644c049@linux.ibm.com>
References: <20250916180958.GA1797871@bhelgaas>
	<d6655c44-ca97-4527-8788-94be2644c049@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 13:00:30 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 9/16/2025 11:09 AM, Bjorn Helgaas wrote:
> > On Thu, Sep 11, 2025 at 11:32:58AM -0700, Farhan Ali wrote:  
> >> The current reset process saves the device's config space state before
> >> reset and restores it afterward. However, when a device is in an error
> >> state before reset, config space reads may return error values instead of
> >> valid data. This results in saving corrupted values that get written back
> >> to the device during state restoration.
> >>
> >> Avoid saving the state of the config space when the device is in error.
> >> While restoring we only restorei the state that can be restored through
> >> kernel data such as BARs or doesn't depend on the saved state.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/pci/pci.c      | 29 ++++++++++++++++++++++++++---
> >>   drivers/pci/pcie/aer.c |  5 +++++
> >>   drivers/pci/pcie/dpc.c |  5 +++++
> >>   drivers/pci/pcie/ptm.c |  5 +++++
> >>   drivers/pci/tph.c      |  5 +++++
> >>   drivers/pci/vc.c       |  5 +++++
> >>   6 files changed, 51 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b0f4d98036cd..4b67d22faf0a 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1720,6 +1720,11 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
> >>   	struct pci_cap_saved_state *save_state;
> >>   	u16 *cap;
> >>   
> >> +	if (!dev->state_saved) {
> >> +		pci_warn(dev, "Not restoring pcie state, no saved state");
> >> +		return;  
> Hi Bjorn
> 
> Thanks for taking a look.
> 
> > Seems like a lot of messages.  If we want to warn about this, why
> > don't we do it once in pci_restore_state()?  
> 
> I thought providing messages about which state is not restored would be 
> better and meaningful as we try to restore some of the state. But if the 
> preference is to just have a single warn message in pci_restore_state 
> then I can update it. (would also like to hear if Alex has any 
> objections to that)

I thought it got a bit verbose as well.

> > I guess you're making some judgment about what things can be restored
> > even when !dev->state_saved.  That seems kind of hard to maintain in
> > the future as other capabilities are added.
> >
> > Also seems sort of questionable if we restore partial state and keep
> > using the device as if all is well.  Won't the device be in some kind
> > of inconsistent, unpredictable state then?

To an extent that's always true.  Reset is a lossy process, we're
intentionally throwing away the internal state of the device and
attempting to restore the architected config space as best as we can.
It's hard to guarantee it's complete though.

In this case we're largely just trying to determine whether the
pre-reset config space is already broken, which would mean that some
forms of reset are unavailable and our restore data is bogus.  In
addition to the s390x specific scenario resolved here, I hope this
might eliminate some of the "device stuck in D3" or "device stuck with
pending transaction" errors we currently see trying to do PM or FLR
resets on broken devices.  Failing to actually reset the device in any
way, then trying to write back -1 for restore data is what we'd see
today, which also isn't what we intend.

It probably doesn't make sense to note the specific capabilities that
aren't being restored.  Probably a single pci_warn indicating the
device config space is inaccessible prior to reset and will only be
partially restored is probably sufficient.  Thanks,

Alex

