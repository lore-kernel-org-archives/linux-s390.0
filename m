Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273643E9FB;
	Thu, 26 Feb 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135517; cv=none; b=nH+PLsPvdxCpEWFRiZYTZ72+NZltFUholw36nrNsArkUE3Qaixpbumtx4VOaHnJnNg71xt4Q9mx78I+0BIs0UV2RtITqho/1cYehRGrQRzBFm7atKyldFccva+wCv3hxVSMfkx6x2uq12dmn1wmsbPRGuaDVWBTCnwnkFRGmagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135517; c=relaxed/simple;
	bh=ZDgGPYxk5aLb3Tw8nvDI2UYKx+pkPhiWC11VoCs7ijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfunzy7JTtDlVwIZ2j2uSiaxvSnLZojZO3qzKZOOtY8Y/6Hm7BX7I5rR0YzxGA9TqeI5FVLeCVjxxBaVRt28jSgs/RnRKIAxl+ddB8hwiW0DRYQImJjwm7mX5XnKyb/rrrf16oygJ2+D2LwLPAavfCvb/FgIDDxPFhHTknYGp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0V/R2qF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0V/R2qF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB439C116C6;
	Thu, 26 Feb 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772135517;
	bh=ZDgGPYxk5aLb3Tw8nvDI2UYKx+pkPhiWC11VoCs7ijc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0V/R2qFlBm6zD5ArfBUSU1PBVYbgJkTrNznOfLbRPF+soLiO79DlfsatvcvRoaKr
	 Iq1dgxWKervQyfYCHpJOCq8raCvLxAikCVfZ1yF7t9I3IwnEJkDh0Mij7mNrzH1XnS
	 JkUk5BXvFnYXNdenwhcgVLduM88yD6rFEq6rPmKCmcj0a9eHbbdR3fS/rjuWE66e78
	 TrMa85GlCrPi2E5kfMe6mk3R+Ap8Uhy6jAD/SCYEOvWxrI7OaJyS2mKiw1FDP0qQOW
	 YDaqt5S4wMpxSiE7LKOU6kTvnauepVQVlQdB6mEcbsNgL/xp6FTVtvlIMkNoO3plSi
	 3m45gyZMcd2vA==
Date: Thu, 26 Feb 2026 21:51:53 +0200
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
Message-ID: <20260226195153.GN12611@unreal>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
 <20260226083427.GF12611@unreal>
 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
 <20260226183945.GL12611@unreal>
 <42881e7b-3e29-4024-83e5-fef5cf109ee0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42881e7b-3e29-4024-83e5-fef5cf109ee0@linux.ibm.com>

On Thu, Feb 26, 2026 at 01:31:07PM -0600, Ramesh Errabolu wrote:
> 
> On 2/26/2026 12:39 PM, Leon Romanovsky wrote:
> > On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
> > > On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
> > > > On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
> > > > > Add a new write-only 'uevent' attribute to PCI slot sysfs
> > > > > entries. This provides a mechanism for userspace to explicitly
> > > > > synthesize PCI slot uevents when needed.
> > > > > 
> > > > > For cold-plugged PCI devices, slots may be created before
> > > > > udev is ready to receive events, causing the initial 'add'
> > > > > uevents to be missed. As a result, slot specific udev
> > > > > rules that define naming, permissions, and related policies,
> > > > > are not applied at boot. Allowing userspace to resynthesize
> > > > > the 'add' uevent ensures these rules are processed correctly.
> > > > This patch sounds like a hack to me. AFAIK, "udevadm trigger"
> > > > performs exactly that.
> > > > 
> > > > Thanks
> > > AFAIK, PCI slots do not yet raise a uevent.
> > Right
> > 
> > > Secondly there is no uevent attribute in slot-id directory to submit requests to raise a uevent. This
> > > patch fills that gap
> > Please start from the beginning and explain what you mean by 'the gap'.
> > Which scenario failed before and began working after this patch? From your
> > description, it sounds like the behavior should already be covered by the
> > 'udevadm trigger' command.
> > 
> > I want to note that drivers/pci/slot.c has remained largely unchanged since 2008.
> > 
> > Thanks
> PCI slots are surfaced early in the boot process before udev daemon is able
> to run and process these uevents. As a consequence any uevents raised by PCI
> slots are lost. To apply the relevant udev rules, we need to raise PCI slot
> uevents a second time. This cannot happen if uevent attribute is not surface
> by PCI slots.

I don't understand what you are saying. In previous email, we both
agreed that PCI slots doesn't have uevents and here you are again
repeating that these uevents are lost.

On my system:
➜  ~ ls /sys/bus/pci/slots/
0  12  14  8
➜  ~ ls /sys/bus/pci/slots/0
adapter  address  cur_bus_speed  max_bus_speed  power

> 
> To me the sequence is as follows:
> 
> - udevadm submits a request to raise a PCI Slot uevent
> - PCI slot uevent handler constructs and publishes a uevent to userspace
> - udev daemon receives the uevent and processes it i.e. apply configuration
> encoded by matching udev rules

I asked slightly different question. "Which scenario failed before and
began working after this patch?"

Thanks

> 
> 
