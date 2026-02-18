Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC94283FF9;
	Wed, 18 Feb 2026 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443305; cv=none; b=P/bB+0JfxZ3XHSPKiKkwmdT1oyDrwBiVhKnzUgJ7qgddQGzQ0RcUc0SjzVXFT7fhwSpKFo2XRGTK5iKr/A7ico77GK7oHOZ/H1kvuGbZvjqysrULpXk2LW5uAmy2ldiG7hpTvwlGMg9IypCFzykUM6NLAr772DFnmnxl4Zu/g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443305; c=relaxed/simple;
	bh=FjLu5CznaeFKLzVYmsmLBYP5J6SfF1a1c7geRoqAlkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ICYthIUaidi684LQ/bsySPkDtSvnCRieRuZG1UyV95UuhLSZd0fPqJZeo82COYlnt/hGpnZ2wmI5jviganJdl4l1rdHYuWOADUFkDf4+u5JaGm40qvM6vx8KlFkHtt9n9AXpA3FR9Y8OzljTv/MN2XrsQfR264qU2TCvsy/bvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQxi5xzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQxi5xzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70275C116D0;
	Wed, 18 Feb 2026 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771443304;
	bh=FjLu5CznaeFKLzVYmsmLBYP5J6SfF1a1c7geRoqAlkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UQxi5xzqxcyGnO7cmu6659GRIHkf+vpOvwlkSMM4rwtHmiGDPHYrXS1O4lpvpxLV3
	 mkHaLn2lpoPTuwDsaN0Ij0M4Z0DgHKYbH0xQaikFq/cLl7z4lDzUuWSoiAVaRABWAD
	 /VFpmENxeRBqrkmy03ZUorejIRvBuzPNhxXF29mpWJBs+9J/cpKPIkAca9ybJHu4Dt
	 TgGM7QLNKHQpOuKONw+bUt02BYulF4Iu/yGg6F7nNvWPHGRzlYpCO2D2lZEn6Y16Xh
	 trSAk5t01YvN7VVkBBq4A1rslibtvKG1XbaT8v09lkyvwls1ayJt2qBNz0wpuS06Cf
	 voxGW1O+ge3Xw==
Date: Wed, 18 Feb 2026 13:35:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
	stable@vger.kernel.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
Message-ID: <20260218193503.GA3439585@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZYMqQhB6nZNMh8i@kbusch-mbp>

On Wed, Feb 18, 2026 at 12:02:01PM -0700, Keith Busch wrote:
> On Tue, Feb 17, 2026 at 11:55:43AM -0800, Farhan Ali wrote:
> > 
> > Yes I think you are right, with this change the PCI Command
> > register gets restored to state at enumeration. So we will lose
> > the updated state after pci_clear_master() and
> > pci_enable_device(). I think we can update the vfio driver to call
> > pci_save_state() after pci_enable_device()?
> 
> Either that, or move the pci_enable_device() call to after the
> function reset.

I kind of like the latter idea because it seems a little simpler for
the rule of thumb to be that a reset done by the PCI core returns the
device to the same state as when the driver first probed the device.
Drivers would generally not use pci_save_state() at all, and they
could share some initialization logic between probe and post-reset
recovery.

But I would really like to have Lukas's take on this.  Clearly some
drivers would have to be adapted if we stop saving config space in the
PCI core reset path.  We can take care of that for upstream drivers,
but it seems risky for out-of-tree drivers.

Bjorn
