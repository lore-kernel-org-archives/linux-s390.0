Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274D22083;
	Tue,  7 Apr 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597529; cv=none; b=nGabGAVX3A7uu9NTQnaGlzFxQFdk3PPfrQ2hQy+6Uae7oRWTh43Nh6VGslLFW4p25nsCqZ+epyYk62xKJd0WPfkNsBbV5c8Z8F8Af92mgyDE8kGABQ58h6zK3qMUzE+Mo59G+ShC7V77ag1NLPHdG1HiHtbmEZPfQDZ4qFkSQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597529; c=relaxed/simple;
	bh=F7Gq/InG6FMeqrX96X8bAvhA2N0AOOwIL5tUSMRBc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n3IfxfJfdJWyZIS+GjdTZkZe0Ajyais9K4amhvIL160XKLtjmDPXRADUs9nA+Jj3XPS2ldUYP2jgYoiyU33ZDvdlenmJ/u6wSRb9etFMToYaJZ1r648v/8EtnM0Qp6X0dSTHzddr2jZK4mqJBM8ColznYdWh9mT4guDbjG+z4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxkfO1Hs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxkfO1Hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C82DC116C6;
	Tue,  7 Apr 2026 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775597529;
	bh=F7Gq/InG6FMeqrX96X8bAvhA2N0AOOwIL5tUSMRBc1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CxkfO1HspbfgdmRyknYfi9Si6tmUSPlsRrTBfIFlRgRjYbdMFbC2OLMUWVZxDT9I9
	 okg+S10mDtSqioHL76a56f4lttkBRa5SsT3RTbFIS/9mbMcXYdAH5TNM8hBaqx2eCf
	 SWz1RpOh7q0Whpg2YCypTYbGWwtCrqw/U/xjEkWjhtbCstV3gg/zfO0ARLW5iYwVvt
	 sYOxRWz9dTSnR0Ljs5p/2KnyxAwcGw+uclBj22mMTOSLSYb8yvLvZ812z/QVFPVQJN
	 cgTJJw60je4etizuYTkSfHB2XpRSCXROQijVOLDiD/PXV3/yhrenm6y6zxxk1OgLH8
	 HjFtmVBmskwFg==
Date: Tue, 7 Apr 2026 16:32:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 2/7] PCI: Avoid saving config space state if
 inaccessible
Message-ID: <20260407213207.GA257253@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8451fcee-8585-4daa-808a-c76c98f1cd23@linux.ibm.com>

On Tue, Apr 07, 2026 at 02:17:07PM -0700, Farhan Ali wrote:
> On 4/7/2026 12:56 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 30, 2026 at 10:40:06AM -0700, Farhan Ali wrote:
> > > The current reset process saves the device's config space state before
> > > reset and restores it afterward. However errors may occur unexpectedly and
> > > it may then be impossible to save config space because the device may be
> > > inaccessible (e.g. DPC). This results in saving invalid values that get
> > > written back to the device during state restoration.
> > > 
> > > With a reset we want to recover/restore the device into a functional state.
> > > So avoid saving the state of the config space when the device config space
> > > is inaccessible.
> > > 
> > > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >   drivers/pci/pci.c | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 70162f15a72c..b36263834289 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> > > +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > +{
> > > +	u32 val;
> > > +
> > > +	/*
> > > +	 * If device's config space is inaccessible it can return ~0 for
> > > +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> > > +	 * check Command and Status registers. Note that this is racy
> > > +	 * because the device may become inaccessible partway through
> > > +	 * next access.
> > > +	 */
> > > +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> > > +	if (PCI_POSSIBLE_ERROR(val)) {
> > > +		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
> > > +				msg);
> > > +		return false;
> > I wonder if it's feasible to do the pci_save_state() into a temporary
> > buffer, check the buffer for PCI_POSSIBLE_ERROR(), and copy the temp
> > buffer into the real buffer if we think the save was successful.  I
> > know this is a lot more work, but I would like to avoid the raciness
> > if possible.
> 
> I just want to clarify, are you suggesting we do that in pci_save_state()
> function? If not then we need to do something similar to pci_save_state()
> and then check for errors. At that point wouldn't it just make sense to add
> the check in places where we save the bits the kernel wants? Please correct
> me if I misunderstood you.

This is kind of a blue-sky idea for exploration, so maybe it's not
practical.  I think it have to be done inside pci_save_state().  It
would be a little messy to implement since the pci_cap_saved_state
structures are in the save_cap_space list, not all in one place.  So I
think we'd have to allocate a duplicate list for this purpose.
