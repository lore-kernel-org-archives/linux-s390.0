Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579956;
	b=qbAVhkDBiWzxmHaOfccU5XAQqTciUQvADSfp6tOeDqT+JKdBq1gLqcSHDRu8V6s7lksf
	 f69mgdSfk8zOOUUTqj6nMoUK9zexnBTaApo7oaei6zQIjN1c8cZB+9+NgonVztMgYukMH
	 7EmvXdwIlbRiJAeZRD4zDYRqm1TnG9bwve2mQo1wb+wWqQsrBGAtK/+VqaQDt8kBuFg/Q
	 ngoyBW3ICmpAn3XfpV4FVwHfIBMMAYXS6h34hgMAWik+rp/hp9nws/YIMC8fSx74d5ru7
	 RSDgRKLhh75H3onaE+tbjOaziaOv2N+mfxfFZJOErXqog59FkKTlfZ+n48wJzyGqrMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G1YZYCTWLME34NCU79107btUn6XtVnC7XOEPGSEhtL4=;
	b=22hYFyv1pwrwUixF4rFrsd3B+Z73XqnAQ76s7MvzAgOvpe+dSYzjyoEkYmEnEqjCVfGZ
	 q2denHpzI86PriP+klxUIMSwtl5BuPOpt8Id5SiwuqyuXYudBFxgsyUipQgMNz9ykNiE3
	 BFq6mmKZsoavRJcqE3J/W2s90TrsL+sXsT6wyHr6STFS/xQ/cBkasHguPn7rmLIOXx92c
	 KVtlrZs0MXOXqfOVwrjn18PGgCH9jWlcK7tImwiLF1E7KU9Xs3dJC0DiN7nGONV9gxyrU
	 81W4GGUYupjBnAhak7gv1od9f0nezOr9pzihdwAYKnMlCrIAZTWrd8aRZDS5kT575Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK5AKuSI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55514606A327
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK5AKuSI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC86B1F000C4;
	Fri, 13 Nov 2026 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579956;
	bh=G1YZYCTWLME34NCU79107btUn6XtVnC7XOEPGSEhtL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DK5AKuSI7BJnEEj6bK0h3xC++/X8cwhdeHSrDrJQ7/3LvhS1VT138nqba3l0/47Fv
	 s66bQsfROSUgjWahu/4kjbyqwJv+3hX/x8e1HQfv5rXwOu9WyMvdGsA2xReCCVQUGM
	 VV39KTHMm4TFJN8EN0XzggJsNFZTUDrpOJUX3nGS92V9QPrOQKSnmhu1GOwe4PbkD4
	 35xkMXqlJJIO82Jchsz6GsqLwYSzN1zkih/A/pfod6fJN85zkIr/BTnFwimqFeOdG+
	 IoPnanjHylPWkk0A1t7K2c48BlOk1bnuvg5BGblK5yB5+0yGp7TN0A9J3w1roCACIt
	 J6wO/uy1zkzow==
Message-ID: <sashiko-outbox-212979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] mm: keep writable entries writable on protection
 changes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-6-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-6-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:55 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> change_protection() applies vma->vm_page_prot, which lacks the write bit
> for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
> entries writable again if a write fault would only set the write bit.
> In shared mappings, it relies on the dirty bit for this, as a clean
> entry might still need a write fault to notify the FS.
>=20
> However, this misses clean entries that were already writable. For
> example, a uffd-wp unprotect makes shmem PTEs read-only if they were
> mapped by a read fault before uffd-wp was registered, so the next write
> to each of them faults.
>=20
> Entries that were writable before the change can stay writable, as
> anything that relies on write faults write-protects the entry first, and
> MM_CP_TRY_CHANGE_WRITABLE is only set if the VMA stays writable. So
> check the old entry before the shared and private rules.
>=20
> Note: writable anonymous entries are always exclusive and thus already
> kept writable, so in private mappings this only affects PFNs that
> drivers map writable into them.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D4

