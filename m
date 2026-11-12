Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480207;
	b=KlQhdWgdNObxu5g8gu7B1nLo6uhAC6pR1wK+OvIvHXR0I/HC4VmeM/q2q+7XBcuIGvJI
	 p/YCGJSV8VwvaHAciG+RvGAd2DpIP5gyeF1ZWbcAO7TJeylZdEE06SmY+8ga3S1N+HdVU
	 ogKHBLQ7GCZyrjhnUzGRopcOQc9niggWXI5yJ+sMLIDEeTRKQjzDnjjsal1j9+v/n09gS
	 0TCqFD5tBE9sRH3WzSHPBhn8HIt71J+hKTMwwZH2ScdI4sK/zU2O1odys/6ihG0DPMlqf
	 luke/ZKA2S1PLB+eqxwrn9Jj/o9g8F3SI2097k65c2GNN/kLeEMisnxxKum/q73MM/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4fTa9XjEKPwNyNYYhWk8U21HDGHGx3pqKym5kHsn4W4=;
	b=FZMxwgwi/ofqXQjiF2s7VCHFAmD/oUrlSRUTkQnBfLgZJ5G7KSN9EH6u7lMrAYhyIGNX
	 XbxGxXqARXmYqBOcah8fujMFR2+kyOggecDBZK7e7VXnTDw8M3zTeyXT6fn5jPB3fcNOF
	 5Giir5136lU/KRs3akqDIFmWbysBe4Rsa4jBTh/i2VEEPM3e2a1uBcgcqrz+rdJsnNYj+
	 P6/EetlmXyyIvnPOYXl2F57ppnqbC3+9ock19qWVPMr0wGPKXX54cWqibwd1tRVcHTAaB
	 1YDmXRwmapdtrKzOSP9hicB+hofgRvivtl7keql78nOun+Qnmgf4tIE1+ZMtIp1YK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWmU3go9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8A606A332
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWmU3go9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF731F00A05;
	Thu, 12 Nov 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480207;
	bh=4fTa9XjEKPwNyNYYhWk8U21HDGHGx3pqKym5kHsn4W4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWmU3go9CUobvnbKMeotEk5hAK77D214THyiPMv+W6Q6OrIV+FAkfM4zSSGhZVTNZ
	 WeuOUVax1phJbOxTtIvdVdc5o3w551mQsI/fUOrDbJojS5EJIizj3k4qmHOrLSbJap
	 WagceZOd2o4Fr2464YqDYFyXUQRcOf0611pD2znzUVbtk61xRhlMMhoLf1W6Ob1l43
	 irlL//gFBVBcX//LYD8SeKGjezk5n2ZX9hzvxRibdcuDehbBq/DqVLDAaUkPCDb1UU
	 fgLyrgAG7n3Des7PmXULTJrHIB/wa4wAv4Jc5vfVaVWVgTsHeDCGd2WmooBOuJJIYS
	 0/GuqiJhlUjeg==
Message-ID: <sashiko-outbox-210968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] s390/dasd: Fix wrong free and refcount leak in
 build_check_tcw error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112102608.1057852-4-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
 <20261112102608.1057852-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:43:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] s390/dasd: inaccurate Fixes tag and crash description in commit
  message
--

commit b485d08acd9f888238bf37617a7cb2fffa1637cc
Author: Stefan Haberland <sth@linux.ibm.com>

> s390/dasd: Fix wrong free and refcount leak in build_check_tcw error path
>
> dasd_eckd_build_check_tcw() allocates its request with
> dasd_fmalloc_request(), but its out_err path frees it with
> dasd_sfree_request(). The latter uses a different pool and therefor,
> leading to invalid pointer arithmetic and a crash.
> Use the matching dasd_ffree_request() instead.
>
> The same error path also leaves start_priv->count incremented
> without ever decrementing it again.
> This leaks a permanent reference on every build failure.
> Decrement it before freeing the request.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260722103704.1709668-1-sth@linux=
.ibm.com
> Fixes: 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT")
> Cc: stable@vger.kernel.org #4.7
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

[Severity: Low]
Are the Fixes tag, the #4.7 stable hint, and the crash description in the
commit message accurate?

Commit 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT") introduced
the missing start_priv->count decrement, but it paired dasd_smalloc_request=
()
with dasd_sfree_request().  Commit 5e2b17e712cf ("s390/dasd: Add dynamic
formatting support for ESE volumes") in v4.18 introduced
dasd_fmalloc_request() and dasd_ffree_request() and switched
dasd_eckd_build_check_tcw() to dasd_fmalloc_request(), so backporting this
patch to v4.7..v4.17 will fail to build, and this commit should also carry:

  Fixes: 5e2b17e712cf ("s390/dasd: Add dynamic formatting support for ESE v=
olumes")

Also, since commit 9cebfced1324 ("s390/dasd: Add infrastructure for ESE
full-track write"), dasd_sfree_request() checks cqr->mem_chunk and frees
requests with a NULL mem_chunk from device->ese_chunks rather than crashing:

drivers/s390/block/dasd.c:dasd_sfree_request() {
    ...
	if (cqr->mem_chunk)
		dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
	else
		dasd_free_chunk(&device->ese_chunks, cqr);
    ...
}

So the invalid pointer arithmetic and crash only occur on kernels between
5e2b17e712cf ("s390/dasd: Add dynamic formatting support for ESE volumes")
and 9cebfced1324 ("s390/dasd: Add infrastructure for ESE full-track write").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112102608.1057=
852-1-sth@linux.ibm.com?part=3D3
