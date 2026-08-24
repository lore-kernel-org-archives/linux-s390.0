Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00433383C80
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596169; cv=none; b=TEb8lpgZo7hm3707bM7NUoCw8CP2I5daULmFGYX1DBunwjL08m5rZF/LOnghEgUwtZjB1JnCRul38kWZtpA0U/uqUiX8l2BUg5OItGdcGwlTPgfZbFDhXP/cBOC7b7xS0zMI/wrlMSkheXIcJ4qhGAApt/UPJrYmkbh/F8bj75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596169; c=relaxed/simple;
	bh=vneEVqbupcQabJxu8kWTwHb6ra6+uyN8D1N8WTAPuQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmVJNHSqDibmLqo7CkfikmM/YAB/BrF/bKxWHQH4b+2h1KH/lC+4dYXr/J/XX6+RxpYSra8EmvfT4kSQQucniUj9ShEw47QFJw895EUT59Cc+m75xR8zG9OGJZl05FMlrIHQHXy3OuzSmiS732YiCPba6Zd/+DpuSzyMUPc4VMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TmS/iezu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TmS/iezu"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f758014b8so420715966b.3
        for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787596166; x=1788200966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vneEVqbupcQabJxu8kWTwHb6ra6+uyN8D1N8WTAPuQc=;
        b=TmS/iezuqyGJ/j874tAS+6xx3BTol9hlHLHxcO6OCLVGYlB5ScEFz8Q0wns6zojcZY
         YHm4LSa2N+jG14Ie1ZEIiUFvQDyqCAauxnVVhEZyUl7TvkgoxedL0Mr6cXWy39PaCLC2
         NI+LA5G+NyGJz0Ka47WmxX5JaL3cHF7TdTw0frDl60EbALTxC9pdJd6o0Fct5teoTQ8G
         arn8uZmu/2EJyGDDTEyoS6m5+WeGcbhhFZ0MAY7kDnr6Oa7qFCg8Tj8XhZ69pq0PwKyF
         Jci/imSEaRmRrQNzS8SCpXR92YNO5tyIAboLNlrSZ77wBSGcXzk6W1Oqgd4GJ237+wZK
         M27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596166; x=1788200966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vneEVqbupcQabJxu8kWTwHb6ra6+uyN8D1N8WTAPuQc=;
        b=n83fn6lbq+B8WaHseOXxcTHnrarzIoYcdzM+dAoTHOuKMaeCiTTNhX5Y5qhz8lEX7n
         DPDsWZCa5eet9EMpjO0iLi19HzzKyNh2wgm2oEyJixg85OEHvxd05YKyrFs/xNUbAGcf
         A5kdymjn6KUYGFUdUljTqGWw3rJG+KKxwx+VfHtA3A6rNtgbL3+TAAytGWubLjEuBrcc
         f36INzqXwR7wrGP3b0yMu7eRJG5NvVuxdA0rIERQ8hixh2pVsVzZ1wvrRhxuIsHUQVa2
         DVFhVfec0Yn1F9l1i4f87M25yV9zHj8srEGMhcumXnDzFtiOJ3y5AlrEOkmvQN7MVTRm
         HG2A==
X-Forwarded-Encrypted: i=1; AHgh+RpTuciSUG+3mvglNtv5fpXRP9kkRaFUh1UW11B30ydRk1sQQhZx5IN19Uay7jS+mo/lfYez91sh6SE9@vger.kernel.org
X-Gm-Message-State: AFuF++mSB9ASQPdyM9pDM1qucV8nCJHpnVVkzaZxVLxvK1fkdG+9HNLh
	03aunCsG5fym1oSlTM0i9qb+8OL3mYn6uz9eYiSdSzbzFSKXbtHnsmQeRouq0mvAsgA=
X-Gm-Gg: AR+sD12yoTVvdNTCrLNRImk3a2kQaOL0ScKGVQBv7QVrLorRzresRA0NLAb5V6LdxvV
	Cf0zUXVlDLWO/rr1hfITLiugd5pQWey2hOE0p+8h0thsS3J4701SSipioPKYFBjms1540ZZ9HSS
	GCFa8P5oaxBaZdhKfvxvKkMmFhCpCuKaj8stZyfNf15/3GLhhR9LRh2Qk2DkPBvuC52IJRR0fw1
	/1DmAcSThTJjysGLHFxxcN7fUSP3JK1yZ+nRmiDtcbltNjWgi6cFAE6vx3Br85vgO5Nn24dpVBP
	WxTVzzvX9T2zRzoGx7z56Orv61QzQ0AHamrFmQg7dDJpf3R5RQMW3l1z71mZ5fiEjuBbQk6otC+
	Cmy+nnAYTgoPulfXfGlWc/1J+qRZFc3KBiEO166tSK3WblxERBm/zaBHpg838LdwCD10RvejYi2
	A+yN0gCEAaeg2m3aCafYhd+BhTpOG7tTqj+RnuuX4NQdxKsLRzkE9aea3TKLqFk20=
X-Received: by 2002:a17:906:fe48:b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c24b3ebee48mr1527958466b.12.1787596166247;
        Mon, 24 Aug 2026 11:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24d8375776sm315993966b.31.2026.08.24.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:29:25 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:29:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jgg@ziepe.ca, leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	cmeiohas@nvidia.com, roman.gushchin@linux.dev, bvanassche@acm.org, 
	zyjzyj2000@gmail.com, shuah@kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com, 
	wenjia@linux.ibm.com, yanjun.zhu@linux.dev, cui.tao@linux.dev
Subject: Re: [PATCH rdma-next v3 08/14] RDMA/cgroup: Disambiguate devices
 across net namespaces
Message-ID: <aoyNXoZ4K2i_TNi-@localhost.localdomain>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxu7rzeeuvesxlev"
Content-Disposition: inline
In-Reply-To: <20260716132316.1495242-9-jiri@resnulli.us>


--cxu7rzeeuvesxlev
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH rdma-next v3 08/14] RDMA/cgroup: Disambiguate devices
 across net namespaces
MIME-Version: 1.0

Hello Jiri.

On Thu, Jul 16, 2026 at 03:23:09PM +0200, Jiri Pirko <jiri@resnulli.us> wro=
te:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> RDMA device names are unique only within a network namespace, but an
> RDMA cgroup can account resources for devices from multiple namespaces.
> Duplicate names therefore make cgroup output ambiguous and can cause
> limit writes to select the wrong device.

=46rom the cover letter:
| A device in one network namespace therefore cannot use a name already
| taken in another, even in exclusive netns mode (netns_mode=3D0) where
| the two are otherwise isolated. Net devices have no such restriction -
| their names only need to be unique within a network namespace.

If this is modelled after net devices, why not make the visibility netns
based?
I.e. only list (write to) devices of the caller's netns.

>=20
> Use the system-wide RDMA device index to distinguish duplicate names
> while preserving the existing UAPI for unique names. Reject ambiguous
> name-only writes with -ENOTUNIQ and expose a complete device view to
> administrators.

I admit, the administrators won't get the full view but that's no
different from the netns devices situation.

Regards,
Michal

--cxu7rzeeuvesxlev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaoyNfxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ag9cgEAmqyg7SX/4xxY6jGBQ6Ho
ldb//2ddSquKpPFaT3oiD/8BAOPzNVL2AFncp/3gajGpePR8JfvA8gWP67r2kNjr
koMD
=6AcV
-----END PGP SIGNATURE-----

--cxu7rzeeuvesxlev--
