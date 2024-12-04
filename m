Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD631A8F92
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336825; cv=none; b=ZMnSzGekJ1drN1LPssyLLM19AV3pn/L+N1lxH4t33xAzQLwVyEy2o0PXXwYfi71rdAe3ZT4o+XCWqkLmTzdBgaOV6sTOkda8mwfDCxzl6XIeHPbqvKLf7eYvx9SuS6JuZw6skyh3ce0M1tnyrmG+JdbjyG1V3VVgLccQhI4rx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336825; c=relaxed/simple;
	bh=LfnACZY+IGBSKQrkb+/ytdtTyFyom5OHVAQ3TPIPS3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VRqqArzvtF+RVbOo3f6e9DrsqnDwxK18WBWhZ85ql8On3CTkt2NKISfDv9/GhlLMeY7eirJAzrQvItXzdanM4kq078tsz3uGntvUHND5vCBWBVlKWe9JeyCxMwAJXULN/epHiSgumq9BfD77LJ1WcJFXGynTDnB9lpifyuzQqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-kuq-hB3BMVmopGaamRm1bQ-1; Wed, 04 Dec 2024 18:26:55 +0000
X-MC-Unique: kuq-hB3BMVmopGaamRm1bQ-1
X-Mimecast-MFC-AGG-ID: kuq-hB3BMVmopGaamRm1bQ
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 18:26:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 18:26:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tejun Heo' <tj@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "lkft-triage@lists.linaro.org"
	<lkft-triage@lists.linaro.org>, Linux Regressions
	<regressions@lists.linux.dev>, Anders Roxell <anders.roxell@linaro.org>,
	"Arnd Bergmann" <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Jens
 Axboe <axboe@kernel.dk>
Subject: RE: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit
 1 greater than high limit active
Thread-Topic: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit
 1 greater than high limit active
Thread-Index: AQHbRlpA05groSrCOUKR/Ly6shl2PrLWPxCwgAAbZJCAAAuyAA==
Date: Wed, 4 Dec 2024 18:26:16 +0000
Message-ID: <be025b385bb94e0c92cd02ab57dc984b@AcuMS.aculab.com>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
 <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
 <7920126775c74fa5915afbeedcfe2058@AcuMS.aculab.com>
 <c795c090-430a-45a6-88b2-94033d50dea2@stanley.mountain>
 <Z1CUIT8zAqWOnot-@slm.duckdns.org>
In-Reply-To: <Z1CUIT8zAqWOnot-@slm.duckdns.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -2yfKjvbVfWFxSTBYPi48iQMUgQNl3xMe7qZbCmSxzI_1733336814
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Tejun Heo
> Sent: 04 December 2024 17:41
>=20
> Hello,
>=20
> On Wed, Dec 04, 2024 at 07:50:14PM +0300, Dan Carpenter wrote:
> > Tejun probably reads everything to linux-block, but let's CC him explic=
itly.
>=20
> Oh, I'm not. Thanks for cc'ing.
>=20
> > block/blk-iocost.c
> >   2222                          TRACE_IOCG_PATH(iocg_idle, iocg, now,
> >   2223                                          atomic64_read(&iocg->ac=
tive_period),
> >   2224                                          atomic64_read(&ioc->cur=
_period), vtime);
> >   2225                          __propagate_weights(iocg, 0, 0, false, =
now);
> >                                                           ^
> > Why is "active" zero?  __propagate_weights() does a clamp() to 1 as min=
imum and
> > we've added new build time asserts so this breaks the build.
> >
> >   2226                          list_del_init(&iocg->active_list);
> >
...
>=20
> This is a good catch. It's impressive that this can be caught at compile
> time. The upper limit can become zero but the lower limit should win as
> that's there to protect against divide by zero, so I think the right thin=
ig
> to do is replacing clamp() with max(min()). Is someone interested in writ=
ing
> up the patch and sending it Jens' way?

Perhaps if written as:
=09inuse =3D min(inuse, active) ?: 1;
it might stop someone changing it back.

=09David

=09

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

