Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E452D0C73;
	Fri, 24 Oct 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337695; cv=none; b=lN649rcmTYvXLqnBAzAriCs0ydpqz/B2sYyV9DCFOnbac/Gl1NL4cmzDI9557CrPS5bIVxC1QArcwVK4dNlfSaLWtgatdtjOrkTR230KCq67rAWNuVDQoJvWG82wurRaOlDUv49hRau0lxL54SqiSGtEu0ni2CE3rMPQuFJEJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337695; c=relaxed/simple;
	bh=tqPX8RIzyW6k8iQG5uq/xHVvyyym1A6Z+YPgBJAhrnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSTDFJUhrA2u3VpsKMX2AjF8wh9lS0MGLJS7fsltda5EJFCeYXIWfV28PL0lQmcReSe0C5jytlwy9noR8rPIeO59cR4ynVnDChnAs1t+GRKFvqVLyatsv3I1Xa/Hc1rQOw66592+iKdA35FrNPwZll/mshjNEqDI/efHVl0vti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=DON9QBSd; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="DON9QBSd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tqPX8RIzyW6k8iQG5uq/xHVvyyym1A6Z+YPgBJAhrnw=; b=DON9QBSdIIC6MDwKtU7xmml3kR
	eVyZ6cFpO1CT9m1WxZKrna65At7/mhta/jnDDgt57jLzYpoTBTBU3sl85GKdV1ZOJ6cJ5gsRBROa/
	bYsZyWHyXxSndU1OMRt497qbN/d047EE8Nni/L+spuWg+98Ztapehhk8hUk96yGoBvy4eqELM68eL
	mtTFduhuKIMKrTm0eoBmdXKsszBendnTiIYPct4VCgqyRF9xoldhyfsxn0vR84OcoQYrWDxS7WXDZ
	aCozudIW+2R4u3NnccyR2QNiIFXFQiT0vBGjcyTaGuUvpx2wYB7Y13i2VhfTUGufhgLaOHEeZgSYr
	VQGkWgEA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vCOB4-000000000Om-3Ub7;
	Fri, 24 Oct 2025 16:14:22 -0400
Message-ID: <a461ddd3adc2a4c53cd44b34fc58cf3cf0fae41e.camel@surriel.com>
Subject: Re: [PATCH 1/3] Change enter_lazy_tlb to inline on x86
From: Rik van Riel <riel@surriel.com>
To: Xie Yuanbin <qq570070308@gmail.com>, linux@armlinux.org.uk, 
	mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, 	gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, 	svens@linux.ibm.com, davem@davemloft.net,
 andreas@gaisler.com, tglx@linutronix.de, 	mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, 	luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 	irogers@google.com, adrian.hunter@intel.com, anna-maria@linutronix.de, 
	frederic@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, 	vschneid@redhat.com, thuth@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, 	lorenzo.stoakes@oracle.com,
 segher@kernel.crashing.org, ryan.roberts@arm.com, 
	max.kellermann@ionos.com, urezki@gmail.com, nysal@linux.ibm.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, will@kernel.org
Date: Fri, 24 Oct 2025 16:14:22 -0400
In-Reply-To: <20251024182628.68921-2-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
	 <20251024182628.68921-2-qq570070308@gmail.com>
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
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 02:26 +0800, Xie Yuanbin wrote:
> This function is very short, and is called in the context switching,
> so it is called very frequently.
>=20
> Change it to inline function on x86 to improve performance, just like
> its code in other architectures
>=20
> Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>

Might as well inline it into what I remember
being its only caller.

Reviewed-by: Rik van Riel <riel@surriel.com>


--=20
All Rights Reversed.
