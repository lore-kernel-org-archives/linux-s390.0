Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6611712;
	Fri, 18 Jul 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870419; cv=none; b=h6GxTKt2DzBNFLGsaGJp0ynhYU+R4TLVSWV7AwtzKUYe2YaNdKeIpst4xDi5owENbJ5ayDnlJbGNcGGOyKzD/xdtaD8TBskwsllTVMnYCypvDrvWcoEz8j0pnFsVJ7biY+XvC0N79GE8tAhkScUwozCHjkqiHZ9fKqDii1wOWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870419; c=relaxed/simple;
	bh=sP5S1hyxb6E0b3G4KWuQg8VfXJI1dv/IcFmy43EkqRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p23BRWpXv0mkVLPxrmov4iOUVDn3ao/9ZUINGllt5uL5jebbMoJJP2CeBiBGvLtAkGz/5oY8gjCPqvcKG7EoeY6HHCKjxdHxGgaZ4yWnuVzku1VjEClbfWPQttnyfc0z8W0wJhkh9IFTusZxz/OatS3RtdNS54d8kOx8LeOjC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYQS8nMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYQS8nMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CD8C4CEEB;
	Fri, 18 Jul 2025 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870418;
	bh=sP5S1hyxb6E0b3G4KWuQg8VfXJI1dv/IcFmy43EkqRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYQS8nMIldUQZLbGTAGAEEYVWvsJUWGQrsZ9qQ+xO5SGwWqgtpg7Fhc/lRpA9Elrm
	 Kb2VAdE3GVG56fwxxeLdK7/iZiv/1KphRbNKZlzpXP+RPrvooINbyik7EFqQWQlnJd
	 lZz2WTjBOU8IwRbRK59lBrAR2zIvu+sbzgKC8oqBuZl6A2VBfN2spHu44QDMcv1Jep
	 ITtmWkIeix+QMLbsb7aCZgVFFVw2gX/D/ubrD1Dc0JLTvhwaa8b6oF6ZNfnae4aFve
	 vfyaVwjb4NS8it6UwOWuAB+cMKiuodQ+Ha/VGys2LP1Xfbm1VgytQ2EP5v3gosHvk5
	 IlwH2at2eSFIA==
Date: Fri, 18 Jul 2025 21:26:53 +0100
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
	Aswin Karuvally <aswin@linux.ibm.com>
Subject: Re: [PATCH net-next] s390/qeth: Make hw_trap sysfs attribute
 idempotent
Message-ID: <20250718202653.GO2459@horms.kernel.org>
References: <20250718141711.1141049-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718141711.1141049-1-wintera@linux.ibm.com>

On Fri, Jul 18, 2025 at 04:17:11PM +0200, Alexandra Winter wrote:
> From: Aswin Karuvally <aswin@linux.ibm.com>
> 
> Update qeth driver to allow writing an existing value to the "hw_trap"
> sysfs attribute. Attempting such a write earlier resulted in -EINVAL.
> In other words, make the sysfs attribute idempotent.
> 
> After:
>     $ cat hw_trap
>     disarm
>     $ echo disarm > hw_trap
>     $
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

