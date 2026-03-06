Received: from mout6.gn-server.de (mout6.gn-server.de [87.238.194.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8418FDBD;
	Fri,  6 Mar 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.238.194.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820141; cv=none; b=mud1boGoEnEBk9YjqWr7qQAOlaouthdLs0wBIYVRThYYJIOA+jpQBSgMWm0WG4C+A9GgkPu87nbs+5su9rI6KgD8owSHS4tyuYFWll6yh4dGy7+3hfdOSHhwmzvx5YlvE1C3OfiOMnNUOgjwSqo7QffwakvnoIbkWJIBB8q6a+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820141; c=relaxed/simple;
	bh=mf5jm4j7kirSbdpTWnjWX7HcZ6qxHCVIc8ZIn86Qiko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrnyuel8hXBX6CB2mGVZZk0ORg04l0lpNrkwf1u3jY/4CKp6s9zRThURDFf4s0PV7dzYOp/+TLXiPcwvSlKnZuGPgId2N644tIwSWHf2WFf7Qb9e9hbKp2S//7p1CXbdZX+HDNoCBb+pDvpVFmZfaftlAVElgHLVlhzmKxJeNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org; spf=pass smtp.mailfrom=mageta.org; dkim=pass (2048-bit key) header.d=lc0.greatnet-hosting.de header.i=@lc0.greatnet-hosting.de header.b=ltHkvu8r; arc=none smtp.client-ip=87.238.194.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mageta.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lc0.greatnet-hosting.de header.i=@lc0.greatnet-hosting.de header.b="ltHkvu8r"
Received: from mout17.gn-server.de ([87.238.194.244])
	by mout6.gn-server.de with esmtps (envelope-from <lkml@mageta.org>)
	id 1vyZUo-0001ei-1K;
	Fri, 06 Mar 2026 18:01:54 +0000
Received: from lc0.greatnet-hosting.de ([178.254.50.20])
	by mout17.gn-server.de with esmtps (envelope-from <lkml@mageta.org>)
	id 1vyZUm-00058j-0t;
	Fri, 06 Mar 2026 18:01:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=lc0.greatnet-hosting.de; s=rsa1; t=1772820112;
	bh=mf5jm4j7kirSbdpTWnjWX7HcZ6qxHCVIc8ZIn86Qiko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltHkvu8r2btk5PDvXDaMn68CZkN11DYeqfmhj0YK9s6zTknfJfhiUnw6IsszuCs8w
	 XVr9FuqbkI7s9WiGixfAAcVceALMqTBBnxJ0uOeHAW31xrkccn68Z9QoOZN0slKnyc
	 mzZ+v4KH8g2eft7of6mO7QP+sLrPLO2iJTsPvFJeQSIcQ5W5seOA3xlnCGAtOzX3c1
	 vGOWpClpwp/FVjvb4ldgfZpEa5Wy08jL4J7uRC85TsNfKCXMNfmK2aszCpSkTcz01G
	 9n0ts5xVm8Zmn8IQqBv5i2Hh9Y0qI+9sVZgfj1R8V0cbqw1A1s64ljNroiyDFzinHH
	 A4vnvJxM5f0BA==
Received: from chlorum.ategam.org (ategam.org [88.99.83.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: work@mageta.org)
	by lc0.greatnet-hosting.de (Postfix) with ESMTPSA id 62586157BF0B;
	Fri,  6 Mar 2026 19:01:51 +0100 (CET)
Date: Fri, 6 Mar 2026 19:01:49 +0100
From: Benjamin Block <lkml@mageta.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Andreas Krebbel <krebbel@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Tobias Schumacher <ts@linux.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ionut Nechita <ionut.nechita@windriver.com>,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH 1/4] PCI: Move declaration of pci_rescan_remove_lock into
 public pci.h
Message-ID: <20260306180149.GD762467@chlorum.ategam.org>
References: <cover.1772815642.git.bblock@linux.ibm.com>
 <9afaf022cb8e37241c4d2e5356cb262266b0bf3d.1772815642.git.bblock@linux.ibm.com>
 <aasPgZkgCmW5kZgV@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aasPgZkgCmW5kZgV@kbusch-mbp>
User-Agent: Mutt/2.3 (50e3b1f3) (2026-01-25)
X-GN-Spam: 
X-GN-Spam-Score-INT: 0
X-GN-Spam-Report: Action: no action
 Symbol: ARC_NA(0.00)
 Symbol: R_SPF_ALLOW(0.00)
 Symbol: RCVD_NO_TLS_LAST(0.00)
 Symbol: IP_SCORE(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: RCPT_COUNT_TWELVE(0.00)
 Symbol: R_DKIM_ALLOW(0.00)
 Symbol: DMARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Message: (SPF): spf allow
 Message-ID: 20260306180149.GD762467@chlorum.ategam.org
X-GN-Spam-Score: 0.0 (/)

On Fri, Mar 06, 2026 at 10:31:45AM -0700, Keith Busch wrote:
> On Fri, Mar 06, 2026 at 05:49:13PM +0100, Benjamin Block wrote:
> > So far it is possible to use and call the functions
> > pci_lock_rescan_remove() and pci_unlock_rescan_remove() from any PCI
> > code, including modules and architecture code; but the lock
> > `pci_rescan_remove_lock` itself is private to objects residing in
> > `drivers/pci/` via the header `drivers/pci/pci.h`.
> > 
> > With that setup it is not possible to use lockdep annotations such as
> > lockdep_assert_held(), or sparse annotations such as __must_hold() in
> > modules or architecture code for PCI.
> > 
> > Since it is useful for `pci_rescan_remove_lock` to have such
> > annotations, move the variable declaration into `include/linux/pci.h`.
> 
> This big lock for pci scanning is way to easy to misuse to create
> deadlocks, many of which still exist today, 

I can fully appreciate that, having had to deal with bug reports that
stem from it's use for several months at this point.

> so I'm not sure making it easier to access is the right direction.

The thing is, I really would love to be able to annotate our
architecture code where appropriate, and I didn't see any other option.
Explicit annotations in the code highlight far better than putting a
comment in the function/-header.

-- 
Best Regards und Beste Grüße, Benjamin Block
               PGP KeyID: 9610 2BB8 2E17 6F65 2362  6DF2 46E0 4E05 67A3 2E9E
