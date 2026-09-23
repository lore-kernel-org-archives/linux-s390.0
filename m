Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0513F8891
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149955; cv=none; b=othCAKudh69YBJ8Z93+bN9jvEO8BYR+vKdbBHJ7Ii9GGHO4wuNMWYt70QTZuWFZBcoMa7aYPXRPukwWyXRNQ/rXCEvnfg7Yq/oCCsmoYlk8nQQLXNJSRVaCFutI5+aNU9zNvrxk2yoFzaemgo8EeErvSLDRhFO3dOvHon80aoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149955; c=relaxed/simple;
	bh=5NT85u01A3NaCQ2kIwZjXv85zBOUGKlNv01fZcI0cqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fHhknMfm3Wa2pgMG9FpQ75t+/XCp3all26iqCSeLKzHik+MsCOp2x/HJZfC2mwow4D+MD9rAHp7hwfCRVH9ypnbwC7ZE5IiFjnchsyVvRAVkUY8e1VWCUWbydCFAJwcd/K8rmXpjdVPWs0N8c/aNsH8S5mD5OzjmgotlworjJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUWAxii+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUWAxii+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691EC1F000FF;
	Wed, 23 Sep 2026 07:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149953;
	bh=Gz69u/axrgx4upMoAf+tqbSQWw3sMOUsSEMUtsdO0LY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RUWAxii+nz11grmkm8D8HMLrOrQHTwThziMR3SzvqRS6a7icdh9mT+g4ShwjrvbHl
	 GYoa4BzRH/044p5uk5QgtBZvwxzUEdVIj2qjYpO4eu9MhBxYuQ1Mc5onKUg4wD/sK2
	 Z7hFmQD39/zkxCEepPHnmgSwxRSnxZhJVAI8MpVmjwcwcQm0FLCEkDaM73TOuMez0k
	 7Aa1UqQsOt7UgJWquYGcztG2WzX+51rn3fyJNkMFFfj2j28v3DeE7KC/I4IwBHRuke
	 hasFof/noXXUzYSwIyaf4Wq1H+CFL4/qw0r0TAAmvldLS1TaVVKORIar5nFtBgPB8d
	 p1p3uQtk4jTaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] s390/sclp: Make parsing of received event
 buffers more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260923074006.3962077-2-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
 <20260923074006.3962077-2-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:52:33 +0000
Message-Id: <20260923075233.691EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/sclp: TOCTOU double fetch of sccb->length and evbuf->length
--

commit d21cb539ad66b7cd19d44f1b8944ce8a000b730d
Author: Alexander Egorenkov <egorenar@linux.ibm.com>

s390/sclp: Make parsing of received event buffers more robust

Validate header fields of SCCB and event buffers to protect from potential
out-of-range memory accesses which might be caused by malformed hardware
responses.

> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index 98e334724a627..5a4e4001dfa8d 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c
> @@ -532,8 +532,7 @@ EXPORT_SYMBOL(sclp_add_request);
> =20
>  /* Dispatch events found in request buffer to registered listeners. Retu=
rn 0
>   * if all events were dispatched, non-zero otherwise. */
> -static int
> -sclp_dispatch_evbufs(struct sccb_header *sccb)
> +static int sclp_dispatch_evbufs(struct sccb_header *sccb)
>  {
>  	unsigned long flags;
>  	struct evbuf_header *evbuf;
> @@ -542,14 +541,25 @@ sclp_dispatch_evbufs(struct sccb_header *sccb)
>  	int offset;
>  	int rc;
> =20
> +	/* Check for malformed hardware response */
> +	if (sccb->length > PAGE_SIZE)
> +		return -EINVAL;
> +

[Severity: High]
In drivers/s390/char/sclp.c:sclp_dispatch_evbufs(), is it possible for a
malicious hypervisor to mutate sccb->length after this initial validation?

Since sccb points to DMA shared memory, this validation is performed outside
the sclp_lock.

>  	spin_lock_irqsave(&sclp_lock, flags);
>  	rc =3D 0;
>  	for (offset =3D sizeof(struct sccb_header); offset < sccb->length;
>  	     offset +=3D evbuf->length) {

[Severity: High]
Does spin_lock_irqsave() act as a full compiler barrier here, forcing
sccb->length and evbuf->length to be re-fetched from shared memory on each =
loop
iteration?

If a malicious hypervisor mutates the lengths (e.g., setting sccb->length >
PAGE_SIZE or evbuf->length =3D 0) between the initial bounds checks and the=
se
re-fetches, could it bypass the mitigation and cause out-of-bounds memory
reads or infinite loops?

> -		evbuf =3D (struct evbuf_header *) ((addr_t) sccb + offset);
>  		/* Check for malformed hardware response */
> -		if (evbuf->length =3D=3D 0)
> +		if (offset + sizeof(struct evbuf_header) > sccb->length) {
> +			rc =3D -EINVAL;
>  			break;
> +		}
> +		evbuf =3D (struct evbuf_header *) ((addr_t) sccb + offset);
> +		if (evbuf->length < sizeof(*evbuf) ||
> +		    offset + evbuf->length > sccb->length) {

[Severity: High]
Do subsequent re-fetches of sccb->length and evbuf->length in these bounds
checks continue to expose a double-fetch TOCTOU window?

Because memory barriers like function calls or locking/unlocking occur duri=
ng
the rest of the loop, the compiler may be forced to repeatedly fetch these
values from untrusted shared memory.

> +			rc =3D -EINVAL;
> +			break;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923074006.3962=
077-1-egorenar@linux.ibm.com?part=3D1
