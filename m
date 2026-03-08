Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CA368940;
	Sun,  8 Mar 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772967897; cv=none; b=MFZq1lNxWnQytaSdvlDme7/sjPxdLh2+vKZwssrsUTWAE1yPvrddO6TtdoPRzLmxr7YQzeoT7HHIDCDvUJ530k1qJNGjrPq+na06Thsxk2IjRyxIMAJIywYsUz2tkznR0eCGvKGUhqzCkjDZ24Y2JJXt23ceiBzHzha7eomM/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772967897; c=relaxed/simple;
	bh=kTWmwkjqAuxbZE1dJfJkIkunYo6hoZH2L1Nl2Atky8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqRZED3mzIa7OYn9A0bm6YBxKeL+/N6pDKQew5u1A2/F5nTSG3NsGsC6Q1+SrdFCvzE9nqAM1s+cl+LAjmxODsKB5u31UnLokH72iB+9tmJU960ikf0+PCzh2KRALUTmFZLauLALGVVlCko/CBMEoZJL1xcBgA66hU4AFUGMFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QxykAMG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QxykAMG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0497C116C6;
	Sun,  8 Mar 2026 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772967897;
	bh=kTWmwkjqAuxbZE1dJfJkIkunYo6hoZH2L1Nl2Atky8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxykAMG6oEUGhgixi0hOLGjBm1FJMnwS/NiQs0WEjN/4FpgIz5+wlPIcbuH7J+k5e
	 /W4NiVa+echEHKBe2tCOAuUHsxz+mf1MnLpGRWzFu+kF6evFSGPx60F1zA3ZJbdUlm
	 GZ9CMgj/ri2Z1Xlajtt6BA4bSUkoQrpLSEwpBanE=
Date: Sun, 8 Mar 2026 12:04:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: s390: hmcdrv_dev: remove commented out code
Message-ID: <2026030844-tarantula-train-0b62@gregkh>
References: <20260308103255.757461-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308103255.757461-1-jkoolstra@xs4all.nl>

On Sun, Mar 08, 2026 at 11:32:51AM +0100, Jori Koolstra wrote:
> The create_class() api is retiring in favor of class_register() (see:
> https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/).
> The HMCDRV_DEV_CLASS define is hiding a use of create_class(), but it is
> permanently disabled as it is commented out. To avoid supporting code
> that is disabled, the suggestion is to remove all code hiding be behind
> any #ifdef HMCDRV_DEV_CLASS.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/s390/char/hmcdrv_dev.c | 114 +--------------------------------
>  1 file changed, 1 insertion(+), 113 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
