Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CE25BF19;
	Wed, 25 Jun 2025 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854264; cv=none; b=kXc9irVM6NKaS+UkxUZOw06xSql4osFQYkXL2csha/Ifc7/hP7VsT1OqgNq7aHpCZoXAfO3fbOSfjQrkrP4lhI3NbOW45ISXiKZC6YnfRmkt0XE+M4bD2Q/Hs4Ac86k0asJANDwOWsLVlZ3ocxYrKZVWj+3Ry5c3VdLEUUa/iEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854264; c=relaxed/simple;
	bh=SJ5NkjC+cOiMPwKXMdsR+3xgXJFhGnL3/wL1U2zUcWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbwLjtuX35yZQLJ6KpL4NsHxJzIMsBmMQO+VDJf6YjJft4xC18ofFqeNPGZq1j2q3Ts12JJT6Gml37+aG6TX7aOXJR1o3D1vQy6Utnmcs6tGbMLx0Mhoej561Sk6o/5G+q2PnbYlJaQYcIaDrY7bXKu0IAnNYs7/nRcyr2uh+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=deQNk4HU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="deQNk4HU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SJ5NkjC+cOiMPwKXMdsR+3xgXJFhGnL3/wL1U2zUcWg=;
	t=1750854263; x=1752063863; b=deQNk4HU4w9n6Q8YM9nROna5D6UmUkojSYkeC7SyJS9vG2k
	m5YaFzxq+paAWGwrpk0U0BrBUtLZpwVtrXmOqmQz51P3vib/jGV2ZFInyuQOO9FgwS3hMDpVgDDwb
	wYRiDsDXzQXlaxHt8zYDGpEeiow5sPWKHgQYmRA3Cl4CCSGWzwa+h+R2XuhElJNpcUtFA89xYiyUj
	50DNayGV1i57mfzR1A4uQulxN4Wc45SczI2y4vEHTCuHxEjAckeXEGFgXkjIDF3cDYxjKqAyscjJs
	GDOvT2np43KU62jyCcgbth7wtOb8uRYRhtVsO+kwjUkpkCSUyb20jLbplEDuPvYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUPAV-00000009xvR-1M4X;
	Wed, 25 Jun 2025 14:23:59 +0200
Message-ID: <81a8b60be5b99ecd9b322d188738016376aff4aa.camel@sipsolutions.net>
Subject: Re: [PATCH 2/9] kasan: replace kasan_arch_is_ready with
 kasan_enabled
From: Johannes Berg <johannes@sipsolutions.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Sabyrzhan Tasbolatov	
 <snovitoll@gmail.com>, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, 	maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, hca@linux.ibm.com, 	gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 	svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, 	chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org, 
	tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 	kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Date: Wed, 25 Jun 2025 14:23:57 +0200
In-Reply-To: <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu>
References: <20250625095224.118679-1-snovitoll@gmail.com>
	 <20250625095224.118679-3-snovitoll@gmail.com>
	 <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-06-25 at 12:27 +0200, Christophe Leroy wrote:
>=20
> Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit=C2=A0:
> > Replace the existing kasan_arch_is_ready() calls with kasan_enabled().
> > Drop checks where the caller is already under kasan_enabled() condition=
.
>=20
> If I understand correctly, it means that KASAN won't work anymore=20
> between patch 2 and 9, because until the arch calls kasan_init_generic()=
=20
> kasan_enabled() will return false.
>=20
> The transition should be smooth and your series should remain bisectable.
>=20
> Or am I missing something ?
>=20

Seems right to me, it won't work for architectures that define
kasan_arch_is_ready themselves I think?

But since they have to literally #define it, could #ifdef on that
temporarily?

johannes
