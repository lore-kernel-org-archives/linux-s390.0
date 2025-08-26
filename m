Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFF35083A
	for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223336; cv=none; b=QAlXmsCbhmOjYKqt6AKCKNvjovCRl2sfj84f8TjzSF1tUghU3Cl9qQzmRLtZWU1zmqBBkPKL/b2yluQJvbb84xZOBQRSjtYhlzy1h90n0u0m1h7RADVi/SDp/U5F8yMj8PA0JNf4uzpWthc5+cbyz1h7ktOQXB9GPJQe1x70alE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223336; c=relaxed/simple;
	bh=Y0eks1YaOqbzuug07KZLAOR4Y6H+hh0TiHWBe8OcU2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDxF8Kuy+T2icdLO+0FgZRwnzK4X/evJpDtv1IAyVlmw5z0nd8SjL3zprKVMHlEZxGPdUELjVlb/r9+i6nVk3+niqiHSZkpupvlKEHF+gyuVDaF0fx7STIAGl60Yj411uxYCE7DXxsLafN1Pd1i3hNyszMioanx1aP8Uu190pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVg1fBmV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVg1fBmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756223333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHNXd9VyNqrFX2UZhtEPC0je8otxXnW6I6u8evl0zzQ=;
	b=TVg1fBmV7p5m4UX/x6AIMhxPN8s3uOrqcuzN3MJ+qUuE9JgUNWLaP5OUuiX022e2yH1waa
	jT/WsenKad/kzo/mZXy5p11LQ6X8TIfJvv00Ar+wjiEVZ6rlaRr32mD+FJ2MjT/NjObxT/
	Wf3SZESvgYod++UXm0lGgZH6o/LVo8k=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-PgHne1VwOxy_s2yKCkRoTA-1; Tue, 26 Aug 2025 11:48:50 -0400
X-MC-Unique: PgHne1VwOxy_s2yKCkRoTA-1
X-Mimecast-MFC-AGG-ID: PgHne1VwOxy_s2yKCkRoTA_1756223329
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ef2fe37189so1100635ab.1
        for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 08:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756223329; x=1756828129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHNXd9VyNqrFX2UZhtEPC0je8otxXnW6I6u8evl0zzQ=;
        b=oZ5N7Jzn+fGBt/+N81TEzYfb0KRNvftXz4MNtoSSOJ2DqQVi2UT1POcI6X5kQi5cIk
         BI7R25pjiYGu2y9xsxFSH2ohBErR/xLQr4r2lZwbK2XmYWO3gd6s1KA9qdQCg71W3O5f
         RcH/U/wZ0XlW3dzvoMNm3aBJbPBRLq4aKpK04WkZXBNvtnCGpK09RDkMejIcrCLmBReS
         IxvxZS6hf5bk2bkm6fnXt4+w6TwOzSW7GOO1cIoZGoCe1jW1Dks9Z30zIubFFYZc7lVo
         MPd1+UfMBgJjiAJV2lMxJmPkovrzb27hjm4rplffhVS9JetbILEEBC5SJ3tEb/L7FqGW
         lNXw==
X-Gm-Message-State: AOJu0YzoKrFJboMM55g3RXeWRqRRrU1fBwoW4eJGryn9eTORUnIX6lWM
	Ijbi6fQdKzoByPuspa+htX8duegcq5GFKQRMEmCc4j7A7y4EJ/GYcQero/KCPoF0FktagdToa01
	foSru3K4CnG2mrqPr/GxFHeOC4IltaiGNiqcMvPb/aqQISVoEMfAhqap3QCDseho=
X-Gm-Gg: ASbGncvheNhH3YEoXh+bijvjR/PjsGrDcQd26X5SP1KnWd6kzlOfNvGiDmiC9zGdlo3
	aQD7viuwJIKbM9KriEXnBlGsxFka22DsCbm7eMAqevhwbB74YVSBgjwYQV2YjrFKsnMeKSub1cS
	HUrlyuEDybjwwImfSbqXffCrpLc0LiCBUgWjcVCl1DiWw6Ih8rRerx4h8Fva/OwPihH92KLq582
	t0BFm0uBMtPfwAG2VeOowiH11WRjXoMhlY0W4MbO+zBoLPioiz8donB+HZSvdH4JGjhK0rRvCJr
	gBBZTOwL+jKJAVCK5vImuSJofYlIgRZsM6WNV9Zde/E=
X-Received: by 2002:a05:6e02:1a48:b0:3e6:67f9:2061 with SMTP id e9e14a558f8ab-3e91cfae117mr88824215ab.0.1756223329379;
        Tue, 26 Aug 2025 08:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41ooOBFFuOfcZRxU06TfSGWwzTnjM8fsjevvJOvWhDhebSC+xJEVzKrEMkNTbsTkk0XUw5w==
X-Received: by 2002:a05:6e02:1a48:b0:3e6:67f9:2061 with SMTP id e9e14a558f8ab-3e91cfae117mr88824085ab.0.1756223328938;
        Tue, 26 Aug 2025 08:48:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4ec1f6d0sm68656065ab.40.2025.08.26.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:48:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 09:48:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v2 1/9] PCI: Avoid restoring error values in config
 space
Message-ID: <20250826094845.517e0fa7.alex.williamson@redhat.com>
In-Reply-To: <eb6d05d0-b448-4f4e-a734-50c56078dd9b@linux.ibm.com>
References: <20250825171226.1602-1-alifm@linux.ibm.com>
	<20250825171226.1602-2-alifm@linux.ibm.com>
	<20250825153501.3a1d0f0c.alex.williamson@redhat.com>
	<eb6d05d0-b448-4f4e-a734-50c56078dd9b@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 15:13:00 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 8/25/2025 2:35 PM, Alex Williamson wrote:
> > On Mon, 25 Aug 2025 10:12:18 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> The current reset process saves the device's config space state before
> >> reset and restores it afterward. However, when a device is in an error
> >> state before reset, config space reads may return error values instead of
> >> valid data. This results in saving corrupted values that get written back
> >> to the device during state restoration. Add validation to prevent writing
> >> error values to the device when restoring the config space state after
> >> reset.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/pci/pci.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b0f4d98036cd..0dd95d782022 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1825,6 +1825,9 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> >>   	if (!force && val == saved_val)
> >>   		return;
> >>   
> >> +	if (PCI_POSSIBLE_ERROR(saved_val))
> >> +		return;
> >> +
> >>   	for (;;) {
> >>   		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
> >>   			offset, val, saved_val);  
> >
> > The commit log makes this sound like more than it is.  We're really
> > only error checking the first 64 bytes of config space before restore,
> > the capabilities are not checked.  I suppose skipping the BARs and
> > whatnot is no worse than writing -1 to them, but this is only a
> > complete solution in the narrow case where we're relying on vfio-pci to
> > come in and restore the pre-open device state.
> >
> > I had imagined that pci_save_state() might detect the error state of
> > the device, avoid setting state_saved, but we'd still perform the
> > restore callouts that only rely on internal kernel state, maybe adding a
> > fallback to restore the BARs from resource information.  
> 
> I initially started with pci_save_state(), and avoid saving the state 
> altogether. But that would mean we don't go restore the msix state and 
> for s390 don't call arch_restore_msi_irqs(). Do you prefer to avoid 
> saving the state at all? This change was small and sufficient enough to 
> avoid breaking the device in my testing.

If we're only reading -1 from the device anyway, I'm not sure what
value we're adding to continue to save bogus data from the device.
There are also various restore sub-functions that don't need that saved
state, ex. PASID, PRI, ATS, REBAR, AER, MSI, MSIX, ACS, VF REBAR,
SRIOV.  We could push the state_saved check down into the functions
that do need the prior device state, add warnings and let the remaining
function proceed.  We really need to at least pull BAR values from
resources information for there to be a chance of a functional device
without relying on vfio-pci to restore that though.  Thanks,

Alex

