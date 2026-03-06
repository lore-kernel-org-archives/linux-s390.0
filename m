Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC3311C01;
	Fri,  6 Mar 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818308; cv=none; b=CsINHtZevTx7H+4dgldfyEt+hqL4Q946plX27YJJRB8d4boR4PXUxy8PiKqWVV7Xw+ZmiqSX7a02vT7EQIK3L72sxXiJCGHMJKOifuxQDpGBPQAKkqa8VgwAzl3LCx5qATMpzR9/zGlYywDdguQhxnhzjr6izja5XWg+f8fN2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818308; c=relaxed/simple;
	bh=6iE70g58/qwlybpeZab3Rb/sA2FkT0ozgGH89xGh4p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMRWXinhDjfvPLQTcbYf5N5lTIhRcTpro5Xldoulmu9lJlpkMAlAIouy8HhLuk0Tl3o5abifNs2gTzn5KMeYnFGYNglhCr2NopQB04eUCnWiANtKZYAksZJ7mmULep+daOCGiwJd9aqoMCqp1qf+i4OeSr8PKglAGCx+YurT4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt3Sf0KN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt3Sf0KN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CF1C4CEF7;
	Fri,  6 Mar 2026 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772818308;
	bh=6iE70g58/qwlybpeZab3Rb/sA2FkT0ozgGH89xGh4p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rt3Sf0KN923Unc/toFJYb55B18boZgDf6U+uoM9263V+gs2vR76k2ITgL71g84buc
	 PLQXKALixqabNOfbbkiWB0wpyJXkxGI5MSFFdjgIhVKUwdh5bu+v3hCGCTPhCK9Pou
	 uz+pRt7dDrhldDfKNhLsDjUbsdFgeWlMLQlYAuPtB6cxvDWebV35QMY30mo4W1FTMY
	 sWkZHukzIV6PwhBjug5yNn7k0sdyvYL/LXt74KpTaDnNKaTT6KaTh9QKmkQMHVa0Hl
	 1hGCCxW+Hhz40inlUtXl9quHXdStzaDC1v4HFsChUw+DEqM70vco73XoVXcXrBUC8+
	 tAQRdreh9+lGg==
Date: Fri, 6 Mar 2026 10:31:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <aasPgZkgCmW5kZgV@kbusch-mbp>
References: <cover.1772815642.git.bblock@linux.ibm.com>
 <9afaf022cb8e37241c4d2e5356cb262266b0bf3d.1772815642.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9afaf022cb8e37241c4d2e5356cb262266b0bf3d.1772815642.git.bblock@linux.ibm.com>

On Fri, Mar 06, 2026 at 05:49:13PM +0100, Benjamin Block wrote:
> So far it is possible to use and call the functions
> pci_lock_rescan_remove() and pci_unlock_rescan_remove() from any PCI
> code, including modules and architecture code; but the lock
> `pci_rescan_remove_lock` itself is private to objects residing in
> `drivers/pci/` via the header `drivers/pci/pci.h`.
> 
> With that setup it is not possible to use lockdep annotations such as
> lockdep_assert_held(), or sparse annotations such as __must_hold() in
> modules or architecture code for PCI.
> 
> Since it is useful for `pci_rescan_remove_lock` to have such
> annotations, move the variable declaration into `include/linux/pci.h`.

This big lock for pci scanning is way to easy to misuse to create
deadlocks, many of which still exist today, so I'm not sure making it
easier to access is the right direction.
