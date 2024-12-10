Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECD23312A;
	Tue, 10 Dec 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733805203; cv=none; b=f6mE2u2X3x2YwuYcO7fi5WXXjRl3QIDDo+QiAevbzkTaJmnzdqSHbbuqxfODS/xSQ8gWmgWTgN0y4KanPNWCZvl3rfeQV+0RhHxgFzM6racGDvjwaFm1gxEHJkvoJkOwnckp/gLdpSzqyejsEy49U7xUsfeACbbQ3Wga8Q8PBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733805203; c=relaxed/simple;
	bh=t5waVAzNALBU70hsF89/OfqKkEFf6t1GIMsIoR2cszU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSLrHwgF0zzMVhTjjfvdP7GMIqs2fUk2ov0aLQMF8AfrzcajLw5ET4o14HRZbkBQVvb1gOJoubeiwG2MoMM68oBBQGFffn3VB73Jpvt6PSemcd27yO0GImjTav2znyQNfGkiEgQnMuLsJxVdoY+LW2onMOIOeBQ7VHz+KQyT69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nzEj6mPI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzEj6mPI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yHQ6nHpSWovH60gzu0oE4BkrgsHEhWRJ/1lstw88FCA=; b=nzEj6mPI7NnBhOWvRt55mC84A2
	laccC44oUYfbXdTgTqDwaSOyEHTVsRUeeLqzlf1PqGRWb5FRn3HNSU+KslYYfLAeTD+pywD/GsjEq
	j8DpUZ+6k06F3ZGS1nozCZ7+hDBlpkYLJMQ5kQUUPngTzppxoA/ZPSrhNJTsDRucTd28E4PJdm0aN
	1H6REVxRnIsxfEQ3OT89PwmB6GaoVwodA1ao7JL8YnnhUD+I3NsuQ+UID2YDpSbKFaQ7YZc5SbZOb
	BvIYq9guyGLa4PHQO1suhF0/X5o/pCrc+c/vQmrmrmq2qB7Ah1RY+4mt1HAAdGGIOIGnZ45qLq+Vz
	TVAk+atw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKrvz-0000000ACOO-0LdG;
	Tue, 10 Dec 2024 04:33:19 +0000
Date: Mon, 9 Dec 2024 20:33:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, borntraeger@linux.ibm.com,
	farman@linux.ibm.com, clegoate@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/6] s390: enable ARCH_HAS_PHYS_TO_DMA
Message-ID: <Z1fEj_6beeRdGpJL@infradead.org>
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
 <20241209192403.107090-3-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209192403.107090-3-mjrosato@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 09, 2024 at 02:23:59PM -0500, Matthew Rosato wrote:
> PCI devices on s390 have a DMA offset that is reported via CLP.  In
> preparation for allowing identity domains, enable ARCH_HAS_PHYS_TO_DMA
> for s390 and get the dma offset for all PCI devices from the reported
> CLP value.

Nothing new should select ARCH_HAS_PHYS_TO_DMA, please fill out the
bus_dma_region attached to the device instead.

