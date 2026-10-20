Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519348;
	b=Oupq397mvHO6gOu3BwueqDlGUm78HV195VCYeobaqQbUVKF+R3s5AOnDRl2OtHpTfbm2
	 Dk/EVLZtCb3L9n1tub0sdddk1xI2IJ+tocaOxaeQNGIEZYD9i0edxmKNcJNnwAfYOlX16
	 +ShoqDx+uc08yhHDIBXLTuxLFEKHxz3BOMYTneYAxIzayFvLn6N10wzjM+urBH1kSnmsL
	 if5LfkREm6wcR3j4DoiKAnik9h2bwc4Q+7mTQLH1oRx1u1HYkJucc3j3x8ePF/wNUr7nk
	 cRQCdv8njWVBoyhkejrruD4Z1qNXqPT9TPlXX7z/UCLXC0ck+H65dDSF2LAn4gOCxzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519348;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9HOedBtK1ZdmqFPGQEVloLuxKOnda8mejYb9A5T6DCk=;
	b=2i9dVvEH6wE18ooeReplFLj3jkUmS9H1/NT9LWMTK+0B5KJ2dh9btTmqcJfBZhKJBxbo
	 Sc8DuxuzQ+KVCOkS8Ylq3cc2CjxcuwS3LK3VTlYgvKoGWsD9j2vZLX76eNuUeLS79a0X4
	 s7Hjdk1wK2ZSwx3KwcyZRwek+c2U5meALBY3FDoroTreCjcQcd8Kc3UBtldOiDvkZaSmJ
	 SmGkRccR4xaXtJDFN7Lbx+1bd3NW9UnnwwQDRad1rcj5mNhBia4dS2D5cnhZNp8LpVRf2
	 By+zC9ok9n4c0n+8OYK0T1GWQ9P/APWS8aoPfMWvs4ouYLhlYNZ4GeKe7dG/KKR7cMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVWfn9VX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B4606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVWfn9VX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E9D1F000C9;
	Tue, 20 Oct 2026 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792519347;
	bh=9HOedBtK1ZdmqFPGQEVloLuxKOnda8mejYb9A5T6DCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVWfn9VXoQMdFGXTnqLJco7BCuJwRWzhcquleSg8AFqIeGPuVVWWVRLvhE+plOMGd
	 OyzrlzC2KDHkvN7PR8w7E/1hsUP/VNO/NSTPUeHlP9eLa3jqniOkJPHGmCDGlERllM
	 5mjCWexi1gxUjaid1eZ3Gv0R7J7G1IlXc9/AfwMiIUDxC0L9VCF8Qw1Kfcv0FZnMwy
	 WBZCjQlq1u7Q8N+H2lrcYeoIfnaiW9/GIzGZntSFfPFe9J7Wo071IBr1Mck5FmEXn1
	 njVJ0KW8DeLs5/AcCVQVsVg5KFfZkR8jXGjua17JKuyQZSFW9INaI4f5pUxYExTi5c
	 TUcCONaR6Cf+Q==
Message-ID: <sashiko-outbox-179450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: Set up async page faults only for faults
 that need to wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261020175818.375700-2-borntraeger@linux.ibm.com>
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
 <20261020175818.375700-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:02:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
> There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
> errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
> async_pf resulting in endless retries.
>=20
> Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
> the error otherwise.
>=20
> Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020175818.3757=
00-1-borntraeger@linux.ibm.com?part=3D1

