Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482737;
	b=k+sAsM8CHkZyjawgxaMFPdFdS8ddlVx2U7i0yiOCFIYV105pQp2WQMOkBuEg5YJhJEBX
	 j/2nIybIVZHErAXGx9ih0j/k6G1g+VF11UVl4gWMuOV0EqgIF45hC7HypliswC3qK/teD
	 F485Iv0yqp2r/DI8KiosJrymdpuoqknJDvenSbF7/WxtGXRW3uQGJ7Vh9/Hnr9U5nKRLp
	 2cM+qzsDb91COKAog0J/SAt5GkR6C05ujUa9DlF0HR3Xf9Das6WbNkVda+pSKt3r+97Wh
	 n5GvxX9kHNnp+BP3FHBDVLNLlol9bRYg6ljXHUvHWeDCemSkPYrCnKHm8oPQfrjIYUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3nXvkAeO7Bm2WcIP7t4PG/vLc+F7G7Lf+egf8x9mTLc=;
	b=t2wkrzw/lnOTyv/KuvKYoVYwcV0yz/DktGxbWNrupkN4gbEKr3kGQuYU9ZxeHnUA30dU
	 1/mg4pK7f5guUB+rrFSqMI1X85KQTm6Bub3WjKX243/KHbHuvgr9TJ6hWV9UGn0sZEooh
	 0GsWm61ZyYuQFyRJZIEduOIllkfVM8O5awk1knuzjHk00VFQP1vQsld8IEt2srMt1xdeI
	 2vJ+HrWXKKyn20TSqQbcFHiVwzHUyF4t8NmxuO6y2wRoyCq3ugFEzozaZDsuX6ZbFKcIw
	 6iCdBZmBzUaTzFOQuTOKLyrjKDzolDWuYgsSzuQ8NVptpbu7nuEIZWHkoRvV0k054tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVvzxf5+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A0606A330
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVvzxf5+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6F1F00A08;
	Thu, 12 Nov 2026 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482737;
	bh=3nXvkAeO7Bm2WcIP7t4PG/vLc+F7G7Lf+egf8x9mTLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVvzxf5+GOH5nwMsZHx11vwFa6qvKAXySRLmwc1L7bhkbSZecRf9U2VX4znfVLMAm
	 sh3WiUVnGgTRcrh06Odum3WoeCnk1Cep8DDg7soObl9rKz7+R0FZSRTwouU/o1HK5C
	 QVzVWAmiURH/YGr0RFoGeyFIoSBsUvQ5m4zpXZ38eeS3mE2NaidW3BvdDCqugQfH/h
	 bvXa1dZl8qgXpn/b+PdbEjjXJB39OfvZlilkiXL/X6EK4x9VeSgdjI0Gnx2OQBefHv
	 HvMy7VXQLX3ZA+Mm5MvXx+0ba1TfN26CtV0tAq+0oz2kAKg02n0ltQYyL4dSRG/pH7
	 Pgbj1Nd651YnQ==
Message-ID: <sashiko-outbox-211013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/8] Documentation: kdump: Add s390 to crashkernel
 CMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-9-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-9-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:25:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add s390 to the architectures supporting crashkernel=3Dsize,cma and
> mention that on s390 only kexec_file_load() passes the CMA memory on to
> the kdump kernel.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D8

