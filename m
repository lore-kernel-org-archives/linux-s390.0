Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66A224F6;
	Tue, 15 Jul 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590005; cv=none; b=WLdQKEznyJXYeS1QMatPqLLae0uTPy3NzFosXry7wM8gz6P1JAElmN07PwnM1QSf99x7HcrWf/4PynFIvA7HB/mi9KS5O+bO9cWVPJas5RuplcPkGuEIzM9hxgVY8qKOT0/xWQ8wC5mDSlKM0F3DLaLqeFnxO0Or+DEQdWSnhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590005; c=relaxed/simple;
	bh=baBgjYGZ7mShO2swbwkK/E5Ef7HNDvQmMre3VKQPWZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbNMLwj4QngeWJd51FUCLjnMldmuFBjus2TJfcGf8lfyZc5pAkAaMOg1eTySgWdP9NpN/S1EIK0mfcsJQarWcXpBDvfmtNJ8r1OHodny3y2E3Eypnj+F4Nhaxn4q1DNZMkaHotdgivcwrYxkNCqr2MCrKDP0EfnOWnXQ+LYELe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szr1j7Z3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szr1j7Z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C55C4CEE3;
	Tue, 15 Jul 2025 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590004;
	bh=baBgjYGZ7mShO2swbwkK/E5Ef7HNDvQmMre3VKQPWZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Szr1j7Z3u3xIrwkVAr+JbRqSthhxqIqPq0O3eC0WdxTjnhBTxaDyQu21tbPXyuaKF
	 ucvcvOMTe9+EEaGJCXR4cKDUp77rramHMMEn2bmxL4RyLHiaMpdxjL2/gxtuBNtz8O
	 ldmGHmra/RZGnzMlMwKk4eWn2ajHOdkOCvtd1MEDz4FNBllwit6lUV5FXvJqmdvDSF
	 VOg04DxiSgynCra0XqHrZNp8es/DLdwdP2Utz2LTWaHBUe2Y2enQc6FtB/bXOjZoI3
	 nM1FidXVuO9wF2/j87yX9jGuMFa4bVF9uQNjKZ4/2QM7SILA/dKTNAD1rz2MlE9Fkh
	 9feWHXAbHie6Q==
Date: Tue, 15 Jul 2025 15:33:19 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Nagamani PV <nagamani@linux.ibm.com>
Subject: Re: [PATCH net-next] s390/net: Remove NETIUCV device driver
Message-ID: <20250715143319.GC721198@horms.kernel.org>
References: <20250715074210.3999296-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715074210.3999296-1-wintera@linux.ibm.com>

On Tue, Jul 15, 2025 at 09:42:10AM +0200, Alexandra Winter wrote:
> From: Nagamani PV <nagamani@linux.ibm.com>
> 
> The netiucv driver creates TCP/IP interfaces over IUCV between Linux
> guests on z/VM and other z/VM entities.
> 
> Rationale for removal:
> - NETIUCV connections are only supported for compatibility with
>   earlier versions and not to be used for new network setups,
>   since at least Linux kernel 4.0.
> - No known active users, use cases, or product dependencies
> - The driver is no longer relevant for z/VM networking;
>   preferred methods include:
> 	* Device pass-through (e.g., OSA, RoCE)
> 	* z/VM Virtual Switch (VSWITCH)
> 
> The IUCV mechanism itself remains supported and is actively used
> via AF_IUCV, hvc_iucv, and smsg_iucv.
> 
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  Documentation/arch/s390/driver-model.rst |   21 -
>  drivers/s390/net/Kconfig                 |   12 -
>  drivers/s390/net/Makefile                |    1 -
>  drivers/s390/net/netiucv.c               | 2083 ----------------------
>  4 files changed, 2117 deletions(-)
>  delete mode 100644 drivers/s390/net/netiucv.c

Less is more :)

Reviewed-by: Simon Horman <horms@kernel.org>

