Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857E15B10D
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328742; cv=none; b=Z6HKnfTwiiN0LX45StYRuzAZ8s33DGLJQMiHRja6J02ov3D25aAp5OajLDgtMYzqEWC3j/MO2Od9OJU2daHkky3WCtuK/4UBQbGDke70yKGkMSVZ0jNulRAwfMtUdqv6OBrTfXDQeK427dd1O88S8FYewTgDWNoViRQ07I0ZsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328742; c=relaxed/simple;
	bh=oPJAZmjGz3hig5ERXVpw1rcG2SyM62QcVUOtlyK08xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hXJfuUL4a4PsYBP1NwXvMVJOr+P0YXsX0rsXG7c5e209clOpO3SImwFQdn4KRYwT+GBysTj8wZfe+7N+vyJ1Hl8eUCHZGzPKDLvbUwk9oelHCehPzjAt/65kthgQq6mLs1die8oAZd8gau6w0ikU6KDTfW3U7Q0SW0CXbUMTudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-155-GqQcbuu3MrGacAW_QlZAsw-1; Wed, 04 Dec 2024 16:12:11 +0000
X-MC-Unique: GqQcbuu3MrGacAW_QlZAsw-1
X-Mimecast-MFC-AGG-ID: GqQcbuu3MrGacAW_QlZAsw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 16:11:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 16:11:33 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@linaro.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>
CC: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>, linux-block
	<linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>, "Linux
 Regressions" <regressions@lists.linux.dev>, Anders Roxell
	<anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor
	<nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: RE: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit
 1 greater than high limit active
Thread-Topic: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit
 1 greater than high limit active
Thread-Index: AQHbRlpA05groSrCOUKR/Ly6shl2PrLWPxCw
Date: Wed, 4 Dec 2024 16:11:33 +0000
Message-ID: <7920126775c74fa5915afbeedcfe2058@AcuMS.aculab.com>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
 <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
In-Reply-To: <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
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
X-Mimecast-MFC-PROC-ID: gb9NPRED1LVZtlbmdyE5qvefzqpxtSRJOJVjou-Y12M_1733328730
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: 04 December 2024 14:39
>=20
> Let's add David to the Cc list because he's the expert on clamp().

The traceback info misses the important point.
I can't see the 'inlined from line 2225' message.

We have (line 1084):
static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
=09=09=09=09bool save, struct ioc_now *now)
followed by:
=09=09inuse =3D clamp_t(u32, inuse, 1, active);

But line 2225 has:
=09__propagate_weights(iocg, 0, 0, false, now);

With aggressive inlining the compiler sees 'active =3D=3D 0'
and the lo > hi test correctly triggers.

The previous version only verified 'lo <=3D hi' if it was a constant
integer expression - which it isn't here.

No idea what the code is trying to do, nor what value it expects
clamp(val, 1, 0) to generate - likely to be 0 or 1 depending on
the order of the comparisons.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

