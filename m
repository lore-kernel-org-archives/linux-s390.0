Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848975;
	b=k1PZaf8KYPi8s5p2dlPzSkrdv1yIoFuKPTmyGaNB/nYmFNU5+lzTK3MR18kUbGgPbgwY
	 /e43dlailNdb8gNC1ltJkY00KIwZDIOwH7eexRiPJHkChtK7g3/2sHGs5PQzK+f3IV1Wn
	 tDwjxLgwH6OTaUUujmtzExNQOJLrRjunONhNJXAuQGux2iIAYqtGOQ9piQ5+m1UkVmZ2/
	 eZENHepM/Ni5T6p6lVNoP5wBiE3PBgTBlLxoANrZkWSUCt/bjAcAvQgSiKFVzW0Nzt7fl
	 QMl8W7UoLWE7JCXDhzkjU5/9fHZb7N7oh3RHqMOD+3Ltf70/yHjYP3EbyPR/Ym8rq9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848975;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SZGwmW2Dtbhp3ulb+aVKrUf63MtAFyiC8g4PjAAdlM8=;
	b=WPZUbLHKZps0Fkp01OXCixDPF58kAv7X4g1MJAl7CSo9phiqHinxMY8kVg7AmHGpS1I0
	 ipwXz6WoQc9ZPiExO7sgj9dfeokwM3KftWOLfH/dBzJfwexluZ/2eKLhL0jRFzGX2fiPA
	 UiqhB113wk5saJ7MGmnII3O9JqbRoNM6IIHC9qhEhmk2MC2uegsNb7ymAkSmfvjV2q8gA
	 TmZnpIxKXrneC4NP4U5/Qrqpdr0v/Mi49URTJsn2Yx/f/JxND6JSf43Z8E34WNSbJvR+Q
	 vbA6YQMLa+EiTqFA0Eq9fwqa9RvBj6S/FQ6H8t6YW3rvOZnS32DdeecLGf1oRSAmf1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ky2ri1Se;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B490D606A322;
	Mon, 16 Nov 2026 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ky2ri1Se
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B13C91F000C4;
	Mon, 16 Nov 2026 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848975;
	bh=SZGwmW2Dtbhp3ulb+aVKrUf63MtAFyiC8g4PjAAdlM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ky2ri1SeHRnTuAyYKreA+rFaVZnq99tFpEYkmqS5SdqqHR6CiSk0NDtVfdEAIIa/h
	 22/fvH2Ow/CDwBOUJexUqmegHC+sMLb882t58sXclAs7wCQCMLg+IHgxAUpUZa8fhN
	 SGVSlekJKV0qHMpamMZ8bP8/xyDiL80bTz1di8TMaL109zPxYXlydeuXuCS9ceVU/W
	 UN6OHwYwTEmkCPzoe8MQzcGWObkiABqGLp2+0IHK4xOkPG1gNOuwTN5omrb/RF3tfa
	 4nZSi2DegjadXbOEJWISUfxq0ii3w/uXQKWK54MS3c3+xW/7i+QXOSCxUgmm67ay8x
	 u/7cgaUqYtqjQ==
Date: Mon, 16 Nov 2026 19:09:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 04/15] s390/cert_store: Check key_lookup() return code in
 invalidate_keyring_keys()
Message-ID: <avs4ywrq1Hsr2CoC@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-5-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-5-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:23PM +0100, Heiko Carstens wrote:
> keyring->sem is released after writing the key serial numbers into
> key_array. Keys corresponding to those serial numbers may have been
> removed before key_lookup() is called.
> 
> Therefore check the return code of key_lookup() before dereferencing it.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index e5060777ce6f..8eb32497ca24 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -339,8 +339,11 @@ static int invalidate_keyring_keys(struct key *keyring)
>  		goto out;
>  	}
>  
> +	rc = 0;
>  	for (key_index = 0; key_index < num_keys; key_index++) {
>  		current_key = key_lookup(key_array[key_index]);
> +		if (IS_ERR(current_key))
> +			continue;
>  		pr_dbf_msg("Invalidating key %08x", current_key->serial);
>  
>  		key_invalidate(current_key);
> -- 
> 2.56.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
