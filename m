Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A123535E;
	Fri,  5 Jun 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621216; cv=none; b=hx28wJbz+r9UBHC6DC33wUSxssvz7UcB7qE266jnUc3DxpAK++5WDHxvvvtvV8tH48TLXhjAtjdiX+reke4gqYQTYLsNUvLsujZOcyAMjaLD7RYr5OSTfkSxC7hFXX9jbGRkdg7ZeuhLK9MrdoHBNO4Rhck/JVxCwr/eRgWeAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621216; c=relaxed/simple;
	bh=uvxQ8m/0FnjSq2hX2DJ7JY5O6ptuAhKyFcmM0+SqdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYl0UbDhFeNncG6SEth+K4kN9CcCflu0cuhVESpTVRu3Kzrui2SPSbKSxANp9WclIV+n7FT8TVVbQsWxwXoQB/y2A6isoW9nM1E+bJ+vESpE9DH/mcw8C0qZVSN9okUotSv4mKJTqYrB9fz0i3+XHVYuW7lUE7s/zTUqyXf0kSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV7UuTIA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV7UuTIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEDF1F00893;
	Fri,  5 Jun 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621197;
	bh=uvxQ8m/0FnjSq2hX2DJ7JY5O6ptuAhKyFcmM0+SqdDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FV7UuTIA9nXYCTQdrZZfkYLPla7MfXoMk9JBQGXD8E6O3JeVZ8noXFwAiRTcGSkiG
	 W1E6UfVYL1zDmwogaVZj3DwZpjueen+dGCzKQo0ke5ZCdkt5y4s6jQvB3vcBr0q2k/
	 5zMUf1gXU4yYCb9VaqZ1FpKBYaxlJRzL8seAwf8I1EV3xbsR5RzcirVhuu+7mcYerp
	 2iHf8scUUAf0UGYnrFlhzWpP25WM1cMsSOLI91OeLkt8yMjFwVNEf8x7lNB0JkDCVX
	 FA7XptQIIQkiVR9RNrq6zyb+w3n9rtX2CXGMXtneI5zgxSgBjxNGwz6mh+H34odnWw
	 kP5OoFOiPLZYg==
Date: Thu, 4 Jun 2026 17:59:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Keith Busch <kbusch@kernel.org>, Alexander
 Duyck <alexanderduyck@fb.com>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604175955.56ca1406@kernel.org>
In-Reply-To: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
	<20260604182031.GB2487554@ziepe.ca>
	<a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 16:49:05 -0700 Dimitri Daskalakis wrote:
> Hey Jason, thanks for the feedback. We (at Meta) are definitely
> interested in SIOV-like capabilities for device passthrough to containers.

I think "definitely interested" is quite an exaggeration.
More importantly, which big company is interested in what
tech should be irrelevant upstream. Please don't make these
sort of arguments. The code has to stand on its own.
