Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639D15ECDB;
	Mon, 17 Jun 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662489; cv=none; b=EOZQtPqIIh+Seqfm58+2XmyZMx+1O+g7jG8f+367F5I7a8m6s995YAo+Y444kmjvRzWPlKYR3lOKiRRShZemWvEKp4mCIsnbVBqHm4x6MvnnOiOuqeEYtcaFJtLVoyc64WjiZ5IsAUtW+fHkc5Rz2YhKXQkYQOQaf6uqxIbjplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662489; c=relaxed/simple;
	bh=1oX3ZC6xwTaVBfH4BIeS86A6EMZLyOb3r5G+/0XsSYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djafWXOqdXVPIIBa2OoR2PvmGxfmoku2ovJM6nqpLzjUr6/NFwT+KKkHroAyL+Nx7lKGelHvZIGW77pAc+TOIGdyHF40uobr2Uqdaj+qPuOiHMDXdzJjBYEk1UsNxkZt96rcnx3te1SlmkrIpxx/7rPB7I5+jq0hZp8Vr4s388s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qiXugXhc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qiXugXhc"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9958945E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718662485; bh=GfPGv7ZuTIdJXV58onL8E7MR590qh5BVjzuAA1k0ArM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qiXugXhcJupBbutE8cTJrwjgneHZ+DP11i27wlAgBKE01UYg7wYWY2nGyPiqH9uo4
	 iegPIDRYCeJo9ohhVysf358VC1cEIIa1dTPWMX+XPp7I2wfoGk2/SbKoQwZrrCOcKC
	 aut+Y7eFeY9bABHltOm5PSM+CN8VS+60EcXFZkQEtK8ZoYllYBjEHCsp3409LglK5T
	 xcP8FaayZ01CgeKskeHk0V4gHBpaMxsRRq5pVWyzP8IHNe6UDWsdsp6nph50vHeubI
	 eX+plV5l7V5BGlXpqPCHwVHR4jrFpWvhN6knE43u4oAHpdGF8HQmsZhL7P3I6iUhgj
	 WCXGTHbqe/SuQ==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9958945E08;
	Mon, 17 Jun 2024 22:14:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] Documentation: Add "S390" to the swiotlb kernel parameter
In-Reply-To: <20240614081438.553160-1-thuth@redhat.com>
References: <20240614081438.553160-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:14:44 -0600
Message-ID: <87bk3zi5d7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> The "swiotlb" kernel parameter is used on s390 for protected virt since
> commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> and thus should be marked in kernel-parameters.txt accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Applied, thanks.

For the record, this is a great set of cleanups, thanks for doing this.

>  PS: I wonder whether we could remove IA-64 nowadays...?

Yes, references to IA-64 should come out at this point.  If you want to
do that, I'd suggest doing it as one big patch...  in theory, that
architecture could come back if enough maintenance initiative is shown.
I don't think it will happen but, if it does, it would be nice to be
able to undo the docs change with a single revert.

Thanks,

jon
