Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D942DCBE3;
	Mon, 26 May 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271620; cv=none; b=LMz8MFbTZzWWv4AjAxbS5TtcvZJZkrg0kI3VSsCiguohNtX4unvpNuYhjvCKVQkx8FciCstTGYkZiVZwSY4dpbAZLH846pioFvWmRDM7HpSc3DOigrbDUV96vbGZKC3JRa/TrZxmodBBUL5b7MyJ8kcSGbxKzFcJ+E0U5GRYXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271620; c=relaxed/simple;
	bh=UYR8NFT7inRfGAcxP5CIJ/y4nSFCEgktZ1kfDarHDE8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VdLLHnw+JJklRkAyrmlx97qgdzuYBzIUo6X//4SxV73TvbJflZvIrvHsSrM/yuPMF4PaMYIqz1JqonbYqWhv5Rtg9vHKBfuiCVVjHlLeuTs5CquwDZdcYS/eUGOAMD2weywZLTO6MjgQF7LaCD4981V2+bTHioYiBq/oPiiSQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oWmieSks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7+jvylU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oWmieSks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7+jvylU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 76B781140140;
	Mon, 26 May 2025 11:00:16 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 26 May 2025 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748271616;
	 x=1748358016; bh=feW6Vp46TNKhZ8Vj3iv8V/8iTtcBEILvVp4173xslUA=; b=
	oWmieSksPKUR4UIwRVJhQOYw8dGbyM5cxuy+Qi7SiuY8lbTGRax47AQ4vNmTEP3h
	mohCij0Qmcv14GX+c8pHiO5uQga240lYV+QA7JUDlmoInHOdq6GRpj6ytv68PKry
	oNr89/pSiYevh8fJ2vbfLNzTe+aDT2rflSdO4Qtf8ogqooiHuzkinF9YTeYJgkrV
	iXz6yhV4FlV30B4xitqFryBBnJH3NZi1/OUcdX6URZL4LF1/wuifJCSqAktwiT03
	SH4Deu/vvADk0SBrxF9/1JnpMS0PuIAdR4Hm33rJ5lk2622oSIKb4+YmfFkHRTsj
	zxB3B4rb9MFy5QOwwRunUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748271616; x=
	1748358016; bh=feW6Vp46TNKhZ8Vj3iv8V/8iTtcBEILvVp4173xslUA=; b=a
	7+jvylUX5eL1HsEccPZmAO3uNWOpmMbTo6eReV9isWwjn2djQo2bxwFnc7SXsF7e
	46EwC8J/Dis8Z1x/ttsJcNTeO5x7Ad010ntM+Ii629PVxU2okv7KKPHTHqeAogC+
	T4fs3fRpCsLrcCRnQ+7VVrECIxhQF7cJK6fZGNSK1D4Sesu7IhQDRbeKwLllbasT
	qH0LD4xjR0NuDohI2ZY/iuBCymIAS87QY6JZyIJhyrbbi+EHQHXGMZL8y2sZC/mX
	y5jFwhlrdKOK2OIh4sZ0iUw+6epsJENz9yqxCz6xMEbznKAgUqicq3u7KZLow3eh
	vKj2YbnVeAqYz3f72Cvuw==
X-ME-Sender: <xms:_4E0aEmOL2R-OOBmaN2wXMIJSY5fdP0RREDfNy3zsmgNoqUTsmtQTQ>
    <xme:_4E0aD1HVyNBtlbP6GTdMVLG9ZiSwV3U0Td6zSg5mnk807jr_uYQYYvUtcpTC-1So
    Y5VL5nSaLehgNIIBNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeekfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfd
    cuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeeh
    udekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
    pdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    gvvhgvlhesughrihhvvghruggvvhdrohhsuhhoshhlrdhorhhgpdhrtghpthhtohepshgr
    shhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlh
    hlsehlihhnrghrohdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehl
    ihhnrghrohdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinh
    grrhhordhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgt
    ohhmpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhope
    hhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:_4E0aCp7xv_pBB7vSuHXqsVgSsezML81qXvrHLB9euypNssojnOkmg>
    <xmx:_4E0aAmZxXVakWbUSIHtUdn3l_urHikskWjoQEpmRWIV_XTjh092Yg>
    <xmx:_4E0aC0DMMtnyMGXTBKiAdqwOIyihsAV05s5Ro7B0lpqmQcR751MAw>
    <xmx:_4E0aHtkrhoiKTgzOtPGoSnO8vbeQBWGuWokr1mVdsa0Wv5QSn8ETg>
    <xmx:AII0aBkCeEoxCFLFYIKWC8cGfWykS_zNOttIDqOodMIU3aC34_2nyV2Y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F54C700061; Mon, 26 May 2025 11:00:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf1409be64a9c26e1
Date: Mon, 26 May 2025 16:59:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-stable <stable@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, lkft-triage@lists.linaro.org
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Sasha Levin" <sashal@kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
Message-Id: <cdf339b3-f3a4-4ed3-9d40-8125b50c0991@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtSrmuXzvYbCrmT_4RHggpaYi__Qwr2SB2Y0=X3mB=byw@mail.gmail.com>
References: 
 <CA+G9fYtSrmuXzvYbCrmT_4RHggpaYi__Qwr2SB2Y0=X3mB=byw@mail.gmail.com>
Subject: Re: stable-rc/queue/6.14: S390: devres.h:111:16: error: implicit declaration
 of function 'IOMEM_ERR_PTR' [-Werror=implicit-function-declaration]
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 26, 2025, at 16:49, Naresh Kamboju wrote:
> Regressions on S390 tinyconfig builds failing with gcc-13, gcc-8 and
> clang-20 and clang-nightly tool chains on the stable-rc/queue/6.14.
>
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Yes
>
> Build regression: S390 tinyconfig devres.h 'devm_ioremap_resource'
> implicit declaration of function 'IOMEM_ERR_PTR'
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>
> Build log:
> ---------
> In file included from include/linux/device.h:31,
>                  from include/linux/node.h:18,
>                  from include/linux/cpu.h:17,
>                  from arch/s390/kernel/traps.c:28:
> include/linux/device/devres.h: In function 'devm_ioremap_resource':
> include/linux/device/devres.h:111:16: error: implicit declaration of
> function 'IOMEM_ERR_PTR' [-Werror=implicit-function-declaration]
>   111 |         return IOMEM_ERR_PTR(-EINVAL);
>       |                ^~~~~~~~~~~~~

The backport of 
a21cad931276 ("driver core: Split devres APIs to device/devres.h")
also needs a backport of
18311a766c58 ("err.h: move IOMEM_ERR_PTR() to err.h")

      Arnd
