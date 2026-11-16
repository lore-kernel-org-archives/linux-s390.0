Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848886;
	b=Wk/iBUoAZ2OL29Gkm8cLOlaDsuSbBUEASNCRf7INFULkgEgcoM4UOd5aVp0ZdYP2+UEp
	 Ew/VTD/JmN2J8eo/i+rg4eO3kLi7C0uP1WEkwpGoPjHmubyaIqZP7yPIzgVxPJY+sOMCn
	 QmguELOWuph36z3wLEBn7zke8469gzum2VETQJFYnyjrEIKsimzQ6wS8TzEI4NN0eNY5E
	 oj6ky/nRbXQ27RuYBP/+DWZkt9RipLaFZDC7witXwGahh+Vl720JKu8YY65TWnW/LIPcr
	 fBUhef4szAWev4bAxOFyG3QcKJa0ApRdVyy85xyf9sMxFrBvVem9VNp07D7ZL3TbSfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848886;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Rws9IM96WmrQPasX9AuFrCVZ3jbuEmWff7YyNf2WuUs=;
	b=gkj97/AwhlWdQsA4flzFJ72sS+INFNGyG6JSwM9qAfxWaksf3PXhiX1Wy2aVUquIDk6v
	 /JTX8kDA6OuEXWxy4uoFCtHabref5v6xsg1U2hCOMq6JpCF606uxELlp8DAsuBpwBcTJF
	 w/l+bvVnPxgKxW4jdu0Ya+9RjPLpJu6nf/TPHFJ/+Ep+R1RY4M2pCw7TzZhlg3+kRfVFh
	 re+Ztz9YHF/RbX+gqD42Qr4oR3LovtKWsSSpXSqFRAroo/MQq0TyzVT6v+q3Zw8rYafH/
	 j/AXoHR8sTVHsFSInLt13JGRj2KfO4bzHO+RbCrLULjscpktCZpm8HKIGW6cAzQytvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSpm5IL5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3738E606A322;
	Mon, 16 Nov 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSpm5IL5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7B4841F000CA;
	Mon, 16 Nov 2026 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848886;
	bh=Rws9IM96WmrQPasX9AuFrCVZ3jbuEmWff7YyNf2WuUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BSpm5IL5rm3VwkjppU1CeSwuELoD2GXMA/uATjjhiRuVbkzeDkW8p9PxTRtiRKt+E
	 WTaJVi6i3bZMM+Ud0HN4k+RbhmdHUDzLozswaRs4qeODNU1id8DBKMdK9luZ3Asndm
	 jKriyGXoWj0lCeuNr7flJ0o74aE8Os2WSUZ4G0illBbhdVzvgAOZlxKfD/ifmYd+53
	 duvtVVGB8KecRn3/nL6bBOqFBeb9Fg+wTCF40rwAlbmuzlwue1V2DmCw3HZDaXTmmF
	 sJG/kMyI/EGRQm+1yUN9QeRM3oaAS2vVqEH1NZwjPVkfGTNj/hG4VaFHJ+zXwXbpA9
	 FUDx7am2JRpWg==
Date: Mon, 16 Nov 2026 19:08:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 03/15] s390/cert_store: Fix potential use-after-free in
 invalidate_keyring_keys()
Message-ID: <avs4cWmQqngvRU1L@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-4-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116143534.158375-4-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:22PM +0100, Heiko Carstens wrote:
> Drop the refcount of current_key behind all users of current_key which
> dereference it, like e.g. error logging.
> 
> Fixes a potential use-after-free bug.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 89cc3a1683a3..e5060777ce6f 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -344,12 +344,12 @@ static int invalidate_keyring_keys(struct key *keyring)
>  		pr_dbf_msg("Invalidating key %08x", current_key->serial);
>  
>  		key_invalidate(current_key);
> -		key_put(current_key);
>  		rc = key_unlink(keyring, current_key);
> -		if (rc) {
> +		if (rc)
>  			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
> +		key_put(current_key);
> +		if (rc)
>  			break;
> -		}
>  	}
>  out:
>  	kfree(key_array);
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
