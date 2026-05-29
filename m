Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14003AE6E6
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038828; cv=none; b=nkah8WF9VhU3PhUo/P5vMM7FOE1jv0HQJqrp5C3wSQL9bTPRCMGWW3QCXd/fQgnGZHvmvyGyJdBhcM4sF5rM2Q+03sMiWmeIfZWlUXkGF9NDQkV0Mb1tOkdyO5fMSxe/gBc3PqaZdRUv97wemZ8q2uVgIgZjZYy7q/DkRqn6uTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038828; c=relaxed/simple;
	bh=VnyAxGMhe+u6MjzjNeUdLPQ36fOKX0ROHI6mvjRRDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyPzSacD6+0L2xy+sgVJU66gQJAkCsUu8EQGWb8QB6UJ0MNAvpJjrJgqzG4WSiq0509CnCVyROKh8kKLR+GEFXxPAhXBnSCrQYiCskRmHZUnz+NsIGftZ/vfW5ksrDbpydMdgAeJU0UTLu+jSVQ2NVi0CPoXQkFgN5WGDFecLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAxCJloW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAxCJloW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA4B1F00893;
	Fri, 29 May 2026 07:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780038827;
	bh=NYHB2/mGo5jPxMyxzTMzcLeHZE9RuRkQ3hYyxvhSF2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAxCJloWHSPI3pyOo/gAAF7++a0jlgbFNuB6h/n3m+W3hZzujJ3RdU3rBSRarl9iC
	 4sLggIJWX8J7YxbnQ/LDarDhvxpKK6pd0+7cowQFD+ve+6P5v4T7cNI3iT7dWBwZe/
	 2IL95ZRMFJulXdjjdKXW7YnzQdzhn/a1gcpm7MYf3dcUkKiT2Jf5twzaHAD1pQy7JF
	 w5cgff78lRLY7gQIW1UsoJahBY0ko8mfolsm2sJNT678u+95AC6+u08f45hN8TsFgA
	 E45ZcAMes2U9tlXPx9tq2gNvJ2WX5cM5ieeXJavSM+pZ0KD/aM++RcZ5WoKhWscCrl
	 Gf7V4X3qZABCg==
Date: Fri, 29 May 2026 10:13:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] s390/drivers: replace __get_free_pages() call with
 kmalloc()
Message-ID: <ahk8o1tsikPr8NG1@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <894c759b-fe6c-4dfe-8b60-3b74916498c6-agordeev@linux.ibm.com>
 <ahhcTBxuT154MmNI@kernel.org>
 <1d5ee7bd-b8f3-44f5-b3f4-52bb2bc7c79f-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5ee7bd-b8f3-44f5-b3f4-52bb2bc7c79f-agordeev@linux.ibm.com>

On Fri, May 29, 2026 at 08:21:59AM +0200, Alexander Gordeev wrote:
> On Thu, May 28, 2026 at 06:16:28PM +0300, Mike Rapoport wrote:
> > > Did you use a particular tool/script to identify these locations?
> > > The immediat question would by why these sources only and not the
> > > others that also use the old functions?
> > 
> > I used an LLM to identify "the most safe callers to convert" to being with. 
> > 
> > Since every call site requires a manual review of the surrounding code and
> > the actual usage, for the first round I limited the changes to allocations
> > that are temporary or staging buffers.
> > 
> > With a less restrictive prompt I've got 57 patches to s390 (both arch/ and
> > drivers/), bu that's too much for me to chew in a single setting :)
> 
> Thanks for the explanation!
> 
> > If you are curious, overall changes (before the human review) are here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=gfp-to-kmalloc/v0.2
> 
> So you are planning to address all of those?

Yeah, that's the plan.
Slowly but steadily :)
 
-- 
Sincerely yours,
Mike.
