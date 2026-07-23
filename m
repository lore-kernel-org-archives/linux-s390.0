Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D60476CCF
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815903; cv=none; b=emvkmPkQA+Pe7nBShTx9R9+J2Jd/z9nJ9c6uhWjFfB8AzlvvkHC6E8VhQvEeZL+GyhrH/EbZ7amr0YqUp/t1lTB7UmnkV4uAZgqiBpJSVz2xk/TscWe0rr4uF2a6ffVQncx4ZbiRsxmjx8XpG0swm4/rGZlqfeiyAwdeC2JvKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815903; c=relaxed/simple;
	bh=+ScEbVRNzVI3XOF8MVp9cPLSljG5g9Pn+XfCiduirck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z3GMnXzY8x1b5l8YlSX4t7PnGkG6lk4vtOOqQpSJmD2seIrfso78TcEI4MHT+/kcf8pzOb+2usCbs05zs8D26uPwv2rsPgMW8mD1zRdJOK2oU2zW/WtgTlvCSI+dwsNk7swk5pfP1TMCdNbuJT668eoU2EJuJOQbclM6jz0TlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBm3EvWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBm3EvWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F91F000E9;
	Thu, 23 Jul 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815890;
	bh=TvdVum7i6K3Xo4gGdjj0gZSmDI+qnf73DIEPbZP0kwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GBm3EvWb7qvVwDY/WXKnfqgq2USPqFKFoUwsfTjgsGXBJdKtmYq8vUOBBhu3gNS/g
	 j955Ugo7XpoPQ5HBX5o7ZvXxnftO7BSMmSRWkTgeu15whUTC+n/dEAy42AyIYtAox2
	 6RalpQpZ1rNwELxJzPrHo8CGhjdI+r2v2KUgxZOX6swY/sAlYgEXlCpuKS9s8V4WSZ
	 T/hlK7qEu5BWO0kcif76QkMlEiNygphPHorlF4k0KCKYuzcN7Yrk5zR9ZyH1ILILyW
	 vDrirgeCHvqEl+ngBwLmJsZPKahZtQqqWCQThmzt16DKlmB/hu1VP6EFyUvhO9irjR
	 AcebEemIg+c8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] s390/dasd: Add infrastructure for ESE
 full-track write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723134743.672413-3-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:11:29 +0000
Message-Id: <20260723141130.304F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The newly added check `else if (status =3D=3D DASD_CQR_ABORTED=
)` erroneously compares the boolean return value of `free_cp` to an integer=
 constant, rendering the intended abort early-return unreachable and causin=
g fatal double-completion of block requests.
--

--- Patch [2]: [PATCH v3 02/13] s390/dasd: Add infrastructure for ESE full-=
track write ---
commit fa055a0513f53e5dc907e4af42753941bd1ec384
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add infrastructure for ESE full-track write

This commit adds driver internals to build WRITE_FULL_TRACK FCX channel
programs in response to unformatted tracks on ESE devices. It introduces
new CQR states like DASD_CQR_ABORTED to retire origin requests when they
are replaced. It also enlarges CCW and ESE format pools to keep two
maximum-size requests in flight.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 3181c06d91ce3..2289f36d38b11 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c

[ ... ]

> @@ -2714,7 +2759,9 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req =
*cqr)
>  			error =3D BLK_STS_IOERR;
>  			break;
>  		}
> -	}
> +	} else if (status =3D=3D DASD_CQR_ABORTED)
> +		/* aborted requests are replaced with a new one so do not complete thi=
s */
> +		return;

[Severity: Critical]
Is it possible for this check to ever evaluate to true?

The 'status' variable is assigned the return value of
cqr->block->base->discipline->free_cp(cqr, req) earlier in this function.
Looking at dasd_eckd_free_cp(), it appears to return a boolean:

drivers/s390/block/dasd_eckd.c:dasd_eckd_free_cp() {
    ...
    status =3D cqr->status =3D=3D DASD_CQR_DONE;
    dasd_sfree_request(cqr, cqr->memdev);
    return status;
}

Since DASD_CQR_ABORTED is defined as 0x06, this check would always be false.
When free_cp() returns 0 for an aborted request, the code will fall into the
'else if (status =3D=3D 0)' block above and attempt to complete the request=
 via
blk_mq_end_request().

Because the replacement request will also try to complete the same req, does
this result in a double-completion of the block request?

> =20
>  	/*
>  	 * We need to take care for ETIMEDOUT errors here since the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D2
