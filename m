Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B521B192;
	Wed, 19 Aug 2026 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118363; cv=none; b=NwGuaJ7ZqCjkX6GcCuqTnqr8s7/7mf0Mjvan0o9rB9zvBR/K/H4qiU7j7ZT3tlhNT6Mt9No2nfxENl5+5Y5OHWZVCZUIqxdP3mJIF/vUEcGXEY/y3xAOywoFPv/stZyl0zQiyTd9qWnwycUFQ4HG3hUZzz8EMgbI6gF2zgT4ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118363; c=relaxed/simple;
	bh=m9GMffcTCBIpFX5Wtj/3DKzJgAvIXS6S1yXbiZ2YwhU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OLDXNO3BDtkWnwAWkXdm2OuzSIEeO22r0GrQt6BACQ/R4EkR2sshNAcNHJZ4DNskm5L4jgyU9HKjsz9EZree9YErf4KzWnamrYlzNI533dvcfrkkXaQ63Lduid/cz5NNxORRYB3e3ahVJ0fH2k90/5qO13cZOvG5NqRDD/xLzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UgmG816c; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UgmG816c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787118339; x=1787723139; i=markus.elfring@web.de;
	bh=RTx2OCCGx6fUUOOdNjNJYoq72xdmOdyVk8gxiWIC0C4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UgmG816cJcEKzOG+LfUhhQyGEDshTw4YypjyQ4Ina/CkbJAsJ3F3nKpNygeXLKXk
	 rzATrV1EBytMTiKdrEw2C7EJZbKnCkEauX/Lu1MYwmKYufoNFkxD3lGTMo4fSjmEx
	 tjwv70sUfG/CxrPEHY6qcULchjzvVfaGvg80sfCFPX2L6nU8/JxESw5ZSRktnWkBQ
	 +/D3eHYO3KCA4BP6mDvYwoV8d9/Q2RlMciPXTIXCv1NK0Y0vAOmN7qXyOojOEOqhu
	 NpP5GGRVrQX2n6S4GlDYT5t5yuM1d+8XXUem0VFuW14NeeK4rFTDJnq8Ji9hk6w/P
	 nOppdwTN8IgN0GkMvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1x6mfU1qpD-00F6LO; Wed, 19
 Aug 2026 07:45:39 +0200
Message-ID: <50599d8d-6c06-423a-8cbc-6866d59906fa@web.de>
Date: Wed, 19 Aug 2026 07:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Triet Hoang <triet.hoang.dev@gmail.com>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20260818073205.1669781-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH v2] s390: raw3270: Handle allocation failures
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260818073205.1669781-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZIwpZlWZpTpvm3weppUvQIZcYrc62tLkL/Aw8CAPrardXFfz/nM
 EtTO9eomrG/UZQ3tLGjIcCfxxWTJRq/74KP+vRlKXIMkh5mBo+Z+yV9AUFJSH9p/WO18Get
 VeOe+tInObcWJLPBpIiJ3rnt4zlVxpBmmxEDwXlloroBaqy8cfYqbJlasRPnsM5O5WIcMuQ
 YaeK/c96Tz2lT5ozaIc3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RReFNo4iOW0=;TMM6vXcrMlCWd9/O3zxmsCJEDLq
 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
 j8EksvA==

> Check the return values of kzalloc_obj() and kzalloc() before using the
> allocated memory. Free the allocated resources on subsequent initializat=
ion
> failures to avoid leaking memory.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2#n145
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

* Please avoid duplicate source code also for an improved implementation o=
f
  the function =E2=80=9Craw3270_setup_console=E2=80=9D.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv7.2#n526
  https://elixir.bootlin.com/linux/v7.2/source/drivers/s390/char/raw3270.c=
#L802-L839

* How do you think about to increase the application of scope-based resour=
ce management?


Regards,
Markus
