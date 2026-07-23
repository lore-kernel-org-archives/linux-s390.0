Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0D42AFAE
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816062; cv=none; b=dJwzxLBslR989bJQQlTaIz/Mbwfr/yaxqUGg+iN3P9rV2oFj9zT1wU22f7aYPR4f7O9eHmAidnrvKPnMn6f+4hxE8U6oioSwZkdL7vP3WpfE3BLfjJH/grHFHpPgvJmyH4uDnhgcqdNOI4xb+HSGrUM9KKtot/7WiSHgtdEKmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816062; c=relaxed/simple;
	bh=w3iNiCFzmXufFOkqRHQjmX47arGWGixfF6Z3ZvNwz1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dbw2hfm5MZyLiYSS1BnSNACDSyG7tPOpn134DL80XsEBQNMEXYeedGT59TmD49Vs8f7WPBvHNhP806OiyBefCdAuYtlpDiV+P/5TJpHYO791m1Y7Cu6D0n0svy2KOJyXE+KtuG1z885DqQj2+NI/Nvz6GiRFyP56fKzPXG8+V78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWs7yWpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWs7yWpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A801F00A3A;
	Thu, 23 Jul 2026 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816055;
	bh=w3iNiCFzmXufFOkqRHQjmX47arGWGixfF6Z3ZvNwz1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWs7yWpDhzjKhKIZ3b+CyOWH43umIbAXmxrHAtYJZyTuYHce38/RNo4kJnkEpVKYD
	 C+P2GqDdmxt6HecUNZmj2m9JqE5VSaJtwpe+BRBximknWRQKHJ9Eos4iFBTBhbgUQQ
	 Vo/o0fo1EzuBdOAD7NBw5pBprTJyjR3uN4N4DRJDzMJ2/QSKk4epzrPNnziV47dAvz
	 afE4Jr8FZ5QKY658jre/OV1lNKqpGUFHg3w9alVoFxZf+hU2c3sXI1DNDeCSkTEAAh
	 ODECJaloTHU7bpwgk+JKMH/WFAdhlNObzph1XC6+AuvvpJjyYBC455b9sAK04WeA1G
	 OG66dwpEcireQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] s390/dasd: Report ESE capability and format
 mode at device online
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723134743.672413-12-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-12-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:14:14 +0000
Message-Id: <20260723141414.C1A801F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Extend the device information line logged when a volume comes online with
> the ESE hardware capability and the on-disk format mode. The format mode
> (full or on demand) is derived from the on-disk format label alone, so a
> volume that is not backed by ESE hardware but was still formatted on
> demand is reported correctly.
>=20
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D11

