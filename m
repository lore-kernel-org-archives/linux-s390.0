Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04328A3F7;
	Thu, 24 Apr 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512091; cv=none; b=bfpFrsxUn42YSWIDi1rfDcbV/YuTakAM/M03RW1i4WyODSyMC7JObPBOVuDBWBdHK8r0buG2j6WtqlM97I3e4GkjLc9GzDbR5ywaN+n3XNLFGU0I6sYmUJv0zCa6VdE7oZYcp+tW+VJ3cgVYdTBIq8/nxyOQn5pwBP9iswzQhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512091; c=relaxed/simple;
	bh=59is39G0tJQyo0VGzGC284IheoKhzQgoSprG32X7hPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5G9L7e2zPcgdj9d6VBI7BDBCbHK4Q+0W4wbl/22j3A59aJmFV2ggmXW8nAwe31+uMb63eoY8GK0SOPiKfQLJ5tf9rq7xOTGje6ZymrHMaV+eX8JbAr0P3q0+y9xtpT9PBtuH0h6r4SoxZ69Yi9sf10zxQVJAV7INjgYLyhQK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwhClznX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwhClznX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E1FC4CEEE;
	Thu, 24 Apr 2025 16:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745512091;
	bh=59is39G0tJQyo0VGzGC284IheoKhzQgoSprG32X7hPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwhClznXMyo1oERZnHSNonEvORjio2lYE0iaPrrLK7zsM+BTVp4ls89r0O5cA1SS4
	 +tHoc4Se0haMRI+VVEzLe6KMql57iGo9ZJpqX+1tTboO27dz8VEAAlSHxfsdZo4rQK
	 Tg5Ocs4laawMQUwEA5gdaQFQAW73c2bbejKg3OcV/ucv14petCwVxiOlCXq6if5Lwc
	 qczcqvUuQqTrIW1RomRbu65QnWITuLKI7BeDbHQGlyfiCRp3aIsQJFEmtxrFE5kBgv
	 slsIRFtad20j5iBDiTx5BpKsEXvCD0qaAJ3qwIp0N2IodsvGF1hoAx14uO428kH5Co
	 QBWBYV8i6eWkw==
Date: Thu, 24 Apr 2025 17:28:05 +0100
From: Simon Horman <horms@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next] s390: ism: Pass string literal as format
 argument of dev_set_name()
Message-ID: <20250424162805.GI3042781@horms.kernel.org>
References: <20250417-ism-str-fmt-v1-1-9818b029874d@kernel.org>
 <20250417110814.12521Bf4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417110814.12521Bf4-hca@linux.ibm.com>

On Thu, Apr 17, 2025 at 01:08:14PM +0200, Heiko Carstens wrote:
> On Thu, Apr 17, 2025 at 11:28:23AM +0100, Simon Horman wrote:
> > GCC 14.2.0 reports that passing a non-string literal as the
> > format argument of dev_set_name() is potentially insecure.
> > 
> > drivers/s390/net/ism_drv.c: In function 'ism_probe':
> > drivers/s390/net/ism_drv.c:615:2: warning: format not a string literal and no format arguments [-Wformat-security]
> >   615 |  dev_set_name(&ism->dev, dev_name(&pdev->dev));
> >       |  ^~~~~~~~~~~~
> > 
> > It seems to me that as pdev is a PCIE device then the dev_name
> > call above should always return the device's BDF, e.g. 00:12.0.
> > That this should not contain format escape sequences. And thus
> > the current usage is safe.
> > 
> > But, it seems better to be safe than sorry. And, as a bonus, compiler
> > output becomes less verbose by addressing this issue.
> > 
> > Compile tested only.
> > No functional change intended.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  drivers/s390/net/ism_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> It might make sense to say that -Wformat-security was explicitly enabled in
> order to trigger this (probably with KCFLAGS=-Wformat-security ?), since this
> warning is by default disabled.
> 
> Just mentioning this, since I was wondering why I haven't seen this.

Thanks Heiko,

Yes, you are right on both counts. I should have mentioned this.
And I did compile with KCFLAGS=-Wformat-security.
