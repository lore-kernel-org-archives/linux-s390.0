Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA536F902;
	Fri,  5 Jun 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632874; cv=none; b=ZoaA5SQG6J+NhCVkwzwldbnwXyWU1gjq0F04fOmIb4FoKN37/pbEwMW9/0gCyPsXS6E9RfeIcjvNagmdeN5u31Ej+GN2ZWhBFobeTb2W/Uy5i4RaXCl99fiyfcc7nCKHuA4YUgCv+78DWmwACVMWkLqBqZURQe+6G9CRCm9WMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632874; c=relaxed/simple;
	bh=UxLcBfccjE2iOSL4mJQQJ6u6yRHEjxtDt1rmyLRSgIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMJr75hfceo/2CxIosztAVS9crzy9/8C5wCk/hPMvZ50t6AArlrGzmuF7wjXGWgbDLDlZYGHRaKtDkpBzgNY6e8Te7Ms8WAVSUEGjP/LSUHo47DFH95fkkBs42dVL0LchwsEg3Pthp9JU3mBR2wnzuAt9SJj+qQu+kePlvBH+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SA0RTFbt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SA0RTFbt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LJ7z4fiMTAZ7fAzEyfiZAHwdxVS2Jyf7F7sA34zhgfk=; b=SA0RTFbtw7++xeqM4/TBi2XyHl
	OsNHxj9gdfi0UgM2EebSZZ5pP6ZD20zBkoA1aRnOH1iKaGBpFvTFyAA6LA9t4HDaVEdA7kTTbx1N3
	UC9hF8blJBELprFrQ3F0S6pjYGlbCpJnJERQ5XapS7co2zJQCzPJZukheGd7mSzvM+9W2g1fNkurp
	s9n+QHKcf2b02WissFhhCZMd8QUsS4UOjeN/RYUWc1PPTNQF2fENqoiFet+BZXyy+T5KAY5KkP7ix
	Sy0Jy0Z9FTKpx0xD56IQ30IR1Y43bLhYMCck7lQouY6AJ7p8xjxiJ1odiPKjhItw8K+cdyeNIydU8
	epqVkWfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLx1-000000004Gb-1FHI;
	Fri, 05 Jun 2026 04:14:31 +0000
Date: Thu, 4 Jun 2026 21:14:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <aiJNJ0zP5BocG-Yy@infradead.org>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> Scalable I/O Virtualization (SIOV) is the next-generation alternative
> to SR-IOV.

It's not.  It is a yet another very different technology.
