Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE934C815;
	Tue, 24 Mar 2026 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392753; cv=none; b=C6MWzb2n4zHZgUHnZ8P36h/NRxR9CCRJaZ6Y8lR1dCafkyFw8VADjZnGpIrT1UbZtJRU6tNj44809GYOrzKDZQkNkYFNBlUfjZQRfKYwnrYu2uuCuV2kCC1nQQv5ELelpEXXgejypH+2mLpDcevTwaAlUQjJY3Zgoanj/7lXA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392753; c=relaxed/simple;
	bh=bgrvnejPLQ0j8pKeCgzOkNKlhtXTMKm+gqSZAwi/5sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pOcD/aibR3tassP1NqhkxG+LPOxEHhDxf+0FjvVkaxdRFMdo9UkiOJ/WN8xlTr+f7HoJW7tl1rpoEaqlMsYerl/s26K2cDzfzwuoDJBKJW839F00UZT0XpLEfeQr8hkPJ55Z5c9H7IfN+iEtFpykdHFerriQyRVxyNEJ1XHsPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp5pp6wv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp5pp6wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A98C19424;
	Tue, 24 Mar 2026 22:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774392753;
	bh=bgrvnejPLQ0j8pKeCgzOkNKlhtXTMKm+gqSZAwi/5sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gp5pp6wviEpuE/8E+/zSFabzn8n5YfYTJiRtBpPsoRZaJ5Kqv+GFJOcoWIfDynByM
	 0f7JOnqwCEdwi8FXdEEHNDRPkkxQdhyGz4FJD/Gqc3zfxZDLtabT0Xe9iBHSwBeO/p
	 Os5OAcmRGToGLPDlqHlVFBuY/4BsB46o+jDZWebObMjLNHrrfRWmAjyL/nknBFVzn8
	 pP0GWARl8xYU3afhpb6VrzTBmK5HcpLQzBj7mBtGG3V6hy/dwugmuNH1/xu7Ar9dXG
	 PHZRKhWlhSW7ZnLqaWSDs9LpvPmnqnpwNEqL4HoDPXnk8rKmo5XHCbbvuIvAvwjxsY
	 GvDtBU1qNNlBw==
Date: Tue, 24 Mar 2026 17:52:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v11 3/9] PCI: Avoid saving config space state if
 inaccessible
Message-ID: <20260324225231.GA1162737@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05251498-1137-4eff-811a-52a5dff3adba@linux.ibm.com>

On Tue, Mar 24, 2026 at 03:38:33PM -0700, Farhan Ali wrote:
> On 3/24/2026 2:40 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 16, 2026 at 12:15:38PM -0700, Farhan Ali wrote:
> > > The current reset process saves the device's config space state before
> > > reset and restores it afterward. However errors may occur unexpectedly and
> > > it may then be impossible to save config space because the device may be
> > > inaccessible (e.g. DPC) or config space may be corrupted. This results in
> > > saving corrupted values that get written back to the device during state
> > > restoration.

> > > +	 * If device's config space is inaccessible it can return ~0 for
> > > +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> > > +	 * check Command and Status registers. At the very least we should
> > > +	 * avoid restoring config space for device with error bits set in
> > > +	 * Status register.
> > > +	 */
> > > +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> > > +	if (PCI_POSSIBLE_ERROR(val)) {
> >
> > Obviously this is still racy because the device may become
> > inaccessible partway through saving the state, and it might be worth
> > acknowledging that in the comment.  But I think this is an improvement
> > over what we do now.
> 
> Yeah, makes sense. Will update the comment. How about something like:
> 
> If device's config space is inaccessible it can return ~0 for
> any reads. Since VFs can also return ~0 for Device and Vendor ID
> check Command and Status registers. This can still be racy as a device
> can become inaccessible partway through saving the state, even after this
> check.

How about:

  Note that this is racy because the device may become inaccessible
  partway through saving the state.

It's not just "can still be racy"; it's *always* racy unless we detect
PCI errors on every access and recover from them.
