Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEA19A2A3;
	Sun, 14 Dec 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765756431; cv=none; b=KEDCDsov/lPv+5y25uTAbrgs4YNels7PY2DC1twNR0Nd2TP/A8QiENiza5cDsVMuzn72h9AnPIGrgcmqkkaU9KT1kKQDb/V0RJuQSR5B3+dqd/h0UVvNkA8FhoUxaIdRtyvi4EKAX9NsdH6mO0cfMonG2+nYFk0lVzl5Ly6pBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765756431; c=relaxed/simple;
	bh=24kY9Nr5wlYZDF7jnKs9v6WeM4iMH9sHuTP5M2EV7I8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eB5TfJpKK9rQJIQBNyVQV2fAlkzTy9qVWT0/pCP381KlWKKghC+O9XR+hX1GKJNwlw7VnvI8a7bRkO/SAGQgmjJlAUH4sKUfLL/5jGZUpgHxOtU88eimYaoRnBHKtfj+Em7X2SzqWOpkR9Fl9T9CuNkUmMWZjDIFh1OOcDUlZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=WXbduQIY; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="WXbduQIY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=24kY9Nr5wlYZDF7jnKs9v6WeM4iMH9sHuTP5M2EV7I8=; b=WXbduQIYx6FgowO4SUfZ6UQl8P
	es6kKDSIyUC81IRgmPtsbh+zvONXuh8F1ntYsGSJ8xdAThIZdkwX9XlhvtqzPCbuBM1D4cxC2xKwA
	opuECmoBWHf337R/5oq41e1VeSiKyHsglXCKnuPrghV5bxnd3CqEFW6jxaaPMPLi7wTF8qQtdJbAS
	B9u9iNZDrTMvqVOoPBRu6RRtycVbFB1OY/IuCcsQjEm/75/P7FxC/6jOKZ8vI5+CZxc6AaGP5rkYo
	gUCxc0xFH5f4buE701MUd96DxLK5EJ8SxwPRYSCYnXsBWlfzFYY0SQtprriLKSo/yXcJ9dFI30JQr
	/IKZRalA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vUvgx-000000003ch-1imb;
	Sun, 14 Dec 2025 18:39:56 -0500
Message-ID: <ce226891413fe9c1d6f0c02697a32b646b4e0a0c.camel@surriel.com>
Subject: Re: [PATCH v5 2/3] sched: Make raw_spin_rq_unlock() inline
From: Rik van Riel <riel@surriel.com>
To: Xie Yuanbin <qq570070308@gmail.com>, tglx@linutronix.de, 
	peterz@infradead.org, segher@kernel.crashing.org, david@kernel.org,
 hpa@zytor.com, 	arnd@arndb.de, acme@kernel.org, adrian.hunter@intel.com,
 agordeev@linux.ibm.com, 	akpm@linux-foundation.org, alex@ghiti.fr,
 alexander.shishkin@linux.intel.com, 	andreas@gaisler.com,
 anshuman.khandual@arm.com, aou@eecs.berkeley.edu, 
	borntraeger@linux.ibm.com, bp@alien8.de, bsegall@google.com, 
	dave.hansen@linux.intel.com, davem@davemloft.net, dietmar.eggemann@arm.com,
 	frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
 irogers@google.com, 	james.clark@linaro.org, jolsa@kernel.org,
 juri.lelli@redhat.com, 	justinstitt@google.com, lorenzo.stoakes@oracle.com,
 luto@kernel.org, 	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 max.kellermann@ionos.com, 	mgorman@suse.de, mingo@redhat.com,
 morbo@google.com, namhyung@kernel.org, 	nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, nysal@linux.ibm.com, 	palmer@dabbelt.com,
 paulmck@kernel.org, pjw@kernel.org, rostedt@goodmis.org, 
	ryan.roberts@arm.com, svens@linux.ibm.com, thuth@redhat.com,
 urezki@gmail.com, 	vincent.guittot@linaro.org, vschneid@redhat.com,
 linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Date: Sun, 14 Dec 2025 18:39:56 -0500
In-Reply-To: <20251214190907.184793-3-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
	 <20251214190907.184793-3-qq570070308@gmail.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 03:09 +0800, Xie Yuanbin wrote:
> raw_spin_rq_unlock() is short, and is called in some hot code paths
> such as finish_lock_switch.
>=20
> Make raw_spin_rq_unlock() inline to optimize performance.
>=20
> Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: David Hildenbrand (Red Hat) <david@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: H. Peter Anvin (Intel) <hpa@zytor.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
