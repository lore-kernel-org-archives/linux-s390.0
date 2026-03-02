Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C53FB04F;
	Mon,  2 Mar 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459285; cv=none; b=Vbp5tzk+PHymaKxMfv2BE3mH6sFVcW6ybZBQPl+upDr6QgrIrChGqQYPUuShkbPWgnWXfp9h04DDK4K4ehRGNsqOQUha54yVZmuzGlUC5CfZxNOc3vUw8zAZRw8dJKSP1UltrIq4dG2IMeo3NbNoy37MkvbRU3eHNhW0Cvsy+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459285; c=relaxed/simple;
	bh=efCNZ3go8omXMsBr/4kyOVSf9tvjvdsT7fDy6KPVAAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8KFkb4Zs9FBNUFwEbi1bx9UsXTg37eaUGE/9dTd3ZsH1IryI0z1VsbKtv9wB1ZFFJaMztenF04t3KbBZYl3RPzEnooKlq7rMFwzP1XCEOyJ/7jNqukAJKFpHwE7YcmM0nslMkR99kb/GpN2FYV4mfmK0xujx7VKt012lNbkseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C25068B05; Mon,  2 Mar 2026 14:47:52 +0100 (CET)
Date: Mon, 2 Mar 2026 14:47:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] s390: Fix and improve inline assembly constraints
Message-ID: <20260302134751.GA21924@lst.de>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302133500.1560531-1-hca@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 02, 2026 at 02:34:57PM +0100, Heiko Carstens wrote:
> While looking at xor_xc_2() I realized that its inline assembly constraints
> are incorrect. Also the inline assembly constraints for the other xor()
> function look incorrect, but are not (execute instruction vs register
> zero). However that revealed another real bug on __stackleak_poison() with
> another incorrect inline assembly constraint.

No expert on the constraints, but have you considered to just convert
this code to pure assembly?

Otherwise please try to get it into Linus' tree ASAP so that I easily
rebase on that for the XOR series.

