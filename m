Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF4407CF1;
	Mon,  3 Aug 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761702; cv=none; b=aadLA+06vWJrzyZ7ztD2UQGcPiAA3RSuPulK0kKWQOBJuO/frRICaoAaQf3S/av3GlKUzOwmn0C7nCVjN4qqHS7UO0Ja0IdXZYG4kCzIO6aaLbxZV8bPOEFBMlYY6hWgg+yq6v7GAaFH4WeuxZXGjGn0r9eoWwvZwt4FP3Hwdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761702; c=relaxed/simple;
	bh=gRKb2XdkMsd/8OX06fyRyQY7Tr1uWV0zkNfOQuHfrgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brOe1ZfUXymbSEnXlTKoEnDbcsrzEqdz7iGbaZvSUmGkkjXpa0/+RHDMLAKBr/4PjLD8umdsLNVwF8BDzvMvPvXr1eXqFsbZ7gWSKw2IMVv9mzLrRGWmkNyXYCcLMLezfQnL0Au2U2AVjhX+s3o+yBJIbfkA4lOP9ELwqWPt2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ag59Qs94; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ag59Qs94"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8iGm/MuAMiKvq0ZdaXGrFNRjTUjnJwT/JV0KUDX31Y=; b=Ag59Qs94Wj8AlYNLt4szcXeW5Z
	c2wwPlWWvfxb0Gh6gMG1hARr2BaqNdH3dvSOINl3KV1vDqS1qz/VfVWmaWRyLUhAJEEGMFce7E80k
	c0PU//vFtFfu4BKvsYXouGajDLU4uYfTM0dKiI4VEjQ+3rnQdf9NEm98zleCOXnSwiljWnn0cYFZn
	ckc4K3KfaKjQNE7nO8lQIAAqsFu6ec6GODlA+5nR0xIvrka07n3jE40K2gtRXs88jn20dSzHkTdfX
	Uo5sO4pFi/UzlBdiI7YhtwB9ZmRB+N9QAWAF7oEwt+dnKgtq7R/OFyNrMU6U0Pu5ambU8smdb+DcS
	cdl9s0mg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqsBs-00CN8F-0f;
	Mon, 03 Aug 2026 12:54:48 +0000
Date: Mon, 3 Aug 2026 05:54:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	horms@kernel.org, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, hidayath@linux.ibm.com, pasic@linux.ibm.com, 
	netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out()
 and listener close
Message-ID: <anCPZl_Rvqj2B7vI@gmail.com>
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803070701.126339-1-sidraya@linux.ibm.com>
X-Debian-User: leitao

> @@ -1931,11 +1931,12 @@ static void smc_listen_out(struct smc_sock *new_smc)
>  		atomic_dec(&lsmc->queued_smc_hs);
>  
>  	release_sock(newsmcsk); /* lock in smc_listen_work() */
> +	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>  	if (lsmc->sk.sk_state == SMC_LISTEN) {
> -		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>  		smc_accept_enqueue(&lsmc->sk, newsmcsk);
>  		release_sock(&lsmc->sk);
>  	} else { /* no longer listening */
> +		release_sock(&lsmc->sk);
>  		smc_close_non_accepted(newsmcsk);
>  	}

Do you need to call smc_close_non_accepted() without the lock? otherwise
you can have the lock around the whole if/else clause.
