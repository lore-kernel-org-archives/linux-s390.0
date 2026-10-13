Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAE3FCB10
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899548; cv=none; b=PdEGCP8VgCmyLifEwoa9Jdst+M5+bUpMWH+hzFVKYuFBHIYkJKmmDdlaqBk4uSfPMrX+G75zT8I192LU0hJGgP/JwKYbILlDF/U/VefdsSlMx+XIj6jpRaLwYmKsWaNo/RHm0S4VVxbHLe0h/jF23Zy3GH37iJ8mzWsOg2YDhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899548; c=relaxed/simple;
	bh=PI++HOEudTUlCi+SZB5T9+M4MAmpYdzdqhJQWbH58/Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c2+cQ2ksOusSODjXpepp2kLUHeDhLngV9c6c6jePYXjruYqDl0rAFhdguB9GIK1CFTvEB8sDUWajqQKodWeDdDpTUZfzt0KyO70nbUM/NOj5q5el81wg0Tu0N/umNrSyhjIshNEK/4G3Ihkh4W3JFOriljObP7cw9fCgfu/snAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+MqNBEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+MqNBEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8031F000FF;
	Tue, 13 Oct 2026 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899546;
	bh=PI++HOEudTUlCi+SZB5T9+M4MAmpYdzdqhJQWbH58/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+MqNBEWAhierXDV5Qq3x78hbXROj08zAJVqTVOdSkFEcGx+FI1TReS0tMWrV/Pj8
	 2K0TZbS3tM4JmLOiBDVXm3C6AiMY7D9Z5ypJaUrZhNv+xdWD6UJsCjw8YSL6V3J/sb
	 IaL8DZtBSuq/ZUn/wdBB/pIQ5+rhnwU44Vh1BxxNz9Js/076VazmM9QzrOzBOrj22h
	 vzYUA63HlD87c3cQaqYO5jhW4jmYsP/2hODcqyUpl5Z8PgNaW87bNiuFfxqZj4vcdu
	 BCELs3E/KWG92RmtVoAsamU0s++ko+HxVt5G9e+bXR7UJf/4O8hdMa23d3OR1rF2VF
	 OSV0Xj11qIHgg==
Message-ID: <sashiko-outbox-169867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/ap: Cap AP maximum message size adjustable
 via module parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013134422.64155-3-freude@linux.ibm.com>
References: <20261013134422.64155-1-freude@linux.ibm.com>
 <20261013134422.64155-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:52:25 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With AP bus now supporting the new APMLM field with PQAP/TAPQ the AP
> max message size could be raised up to 960KB. As this amount of memory
> is tried to get allocated on each AP request/reply it would quickly
> cause some memory problems.
>=20
> Introduce a reasonable default upper limit
> AP_DEFAULT_MAX_MSG_SIZE_LIMIT (72KB) and expose it via a read-only
> module parameter 'max_msg_size_limit'. When creating an AP card, clip
> the calculated AP max message size from the hardware info fetched via
> PQAP/TAPQ to this upper limit and log a debug feature warning
> (AP_DBF_WARN) if the card's reported limit exceeds it.
>=20
> Also define some lower limit AP_MIN_MSG_SIZE (12KB) and ensure during
> module init that a user-supplied max_msg_size_limit parameter is not
> lower than this minimum, adjusting it with a warning if necessary.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013134422.6415=
5-1-freude@linux.ibm.com?part=3D2

