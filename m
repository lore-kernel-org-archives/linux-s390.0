Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A941D61B7;
	Fri, 24 Oct 2025 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341883; cv=none; b=TSbJz2GYZcO5YKtnhmNdOBewaa7RenQjHtkW2FbYg8c3DSeqz1o4FlqJdzoOmu6Of/kKyaIzkB/CWLw1k633/AO0onR0iwPGXAovR7sfjrLiLTnRLPQfhhoHoNBIBZDltcvtw9D/bCu5cLOWB7JJ/KOT7BdwOHvLnUfE2ESfAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341883; c=relaxed/simple;
	bh=AdZv2kUB1G+gRD8CSgpDBsJ60BPFkQUuJ8yYQs6IiPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syWA1Iv6yR5+4vtKqjhBeXZUoLLDmYbxa/rXr78I4NekIN6HWFww2WdrnhU1HDCa5NihMKBVv2rCxfHjSLPKTQyr2WitCT9QjLXQNfiBixCANbIH6mzw+RQQESvwfxAAQeFp9ckaOHalJs+ilHDciirmNJ/nugx2ohdsxtLEB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=eirEBfxT; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="eirEBfxT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AdZv2kUB1G+gRD8CSgpDBsJ60BPFkQUuJ8yYQs6IiPw=; b=eirEBfxTgpIotEWF93BmQLaU+K
	mwc9CzZUmufZkl62CYBwLsTlYh23gSM9Lb7TY5qB5bijOgCihqmHNV0rueXZHAlxC3G9Iu2+kd/XK
	/rZkHGvewhmdszfmoOhU+5KgctL5Ou7KT40r5HlMGeCRMY8VmC1qlZmb6PyVyHiNUGb8kz7V014L2
	prijPRt4pCP92nDEoQFojDXD81rKR/7K5kAEYG5pOil+5+Z+p+uV7j2BJWouF0e7Ub9dM0pwLI2aJ
	WuXyQoUZfCFqgFQDi4K9YaRJVodneDbAowg5mnDq2PbT2sH6XD21zwSkzT/+wujOlJ/IIs4w2oCV+
	zWOle8WA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vCPSA-0000000013r-3I5H;
	Fri, 24 Oct 2025 17:36:06 -0400
Message-ID: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
Subject: Re: [PATCH 2/3] Provide and use an always inline version of
 finish_task_switch
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
Date: Fri, 24 Oct 2025 17:36:06 -0400
In-Reply-To: <20251024183541.68955-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
	 <20251024183541.68955-1-qq570070308@gmail.com>
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

On Sat, 2025-10-25 at 02:35 +0800, Xie Yuanbin wrote:
> finish_task_switch is called during context switching,
> inlining it can bring some performance benefits.
>=20
> Add an always inline version `finish_task_switch_ainline` to be
> called
> during context switching, and keep the original version for being
> called
> elsewhere, so as to take into account the size impact.

Does that actually work, or does the compiler
still inline some of those "non-inlined" versions,
anyway?

Also, what kind of performance improvement
have you measured with these changes?

--=20
All Rights Reversed.
