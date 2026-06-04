Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A3366DB9;
	Thu,  4 Jun 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605737; cv=none; b=qMfHPrIifbs48hgBm2uDH0x3/0FJuCit2pIyKZjdpDTG14t1JzomcWleLsXoHQr/zut83mrD6Sw4EMEOJRI8LeytRReSCMp4b4o2ON/J7IKSHIio6mbg3vvz1Ee4UL0Ic1c/Vlm/m3T5EQBbf0iUA0tyGybtqfVLMBsX/lHXrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605737; c=relaxed/simple;
	bh=h1a8Y0EolPdAAR9/z6j6ymuVQVLd0LXIZ3fCQrpdwsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdaX+36c63BNqRc0pJAdhAKGPDvIJ3+qn8paHmGRXijFjl/vwDMUDrk/c4iu+NpM76Exjr0vaecC36BtSqDpSi0QhMuYdPGxqpIG7YTf756igNwQSVR9+grbKSe1gJb1dmq1y5SyNQfx6bOGCTbEeh5g5HYwfOAhZXXNaZ9MsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5M3FXHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5M3FXHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9143C1F00893;
	Thu,  4 Jun 2026 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605736;
	bh=+2SujRq0kyL31x40uO2iq2L7uAkk1TFof+VnK1qDBrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5M3FXHOQFnUv7HNMoxrBNZOwU5n11qiQt7knb7+oRI4NefiHWM1qiDIh0sGeqgNR
	 dWRwWXsuDYBBFtOeihj0Qq9fc13xJjl13OZh5AuZ4pCozVOq75D2+Ncc3QQKbk2SYh
	 EZZTkKzvY9i1UWpcQ++9S9XcH6LDTUWplrGec1xWkDkXPtxslJkxnMe34owkse/mRh
	 OAt4We2t6o6vyxqRYyL0l/rSKNsnnRV9M+8A4LYb9sPxN3J2fR61Ze0amALq35Bxvz
	 LXNm3wtDazfqwC7YCSsghtvY5oLs8O1CGRdTO/J5CPVuAlsBew2kSJv5iOVeB3U1cU
	 m5xW6tw4iyKVQ==
Date: Thu, 4 Jun 2026 21:42:11 +0100
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, helgaas@kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
Message-ID: <aiHjIyYB_8ogbxfz@kbusch-mbp>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com>
 <aiE3I0bL0TX1nOec@kbusch-mbp>
 <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>

On Thu, Jun 04, 2026 at 10:17:04AM -0700, Farhan Ali wrote:
> 
> On 6/4/2026 1:28 AM, Keith Busch wrote:
> > On Wed, Jun 03, 2026 at 11:24:14AM -0700, Farhan Ali wrote:
> > > +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> > > +{
> > > +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> > > +
> > > +	if (!vdev->pci_saved_state)
> > > +		return;
> > > +
> > > +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> > > +	pci_restore_state(pdev);
> > > +}
> > Shouldn't there be a cooresponding user space notification that the
> > device has been restored? There's an eventfd on the error detected side
> > so user space can know the device needs recovery, but how does it come
> > to know that the reset is completed?
> 
> I think if the VFIO_DEVICE_RESET ioctl completes successfully it should be
> an indication that the reset has completed? 

But isn't this reset initiated by the kernel via the kernel's AER
handler? The user space driven ioctl has nothing to do with it, unless
I'm missing something. I'm just mentioning it as I was recently asked to
look into DPC and AER handling for vfio, and I think there needs to be
coordination with userspace here for a more reliable recovery.
