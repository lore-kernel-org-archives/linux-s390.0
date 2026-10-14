Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF800525A90
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988027; cv=none; b=udnxLXmr8Qi/vJBCODXhKw0XmjBzjaq7Hn5qF7E/7upkjY7O0odT0AFTpvol5FVZiAbK6FkXPV3a9V9X4rWQZdCAjU81bdumAOn+qRZnsoJ7ThJoCRwws3UiUTm/r6pO8udXPM3kWyQVoUKc4r0HFHogSTnuIxWbgTpVcfWW2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988027; c=relaxed/simple;
	bh=rJ96Q4NwNxsZxDFd+nBQv0lamb4Zyj25BeszHMNuprU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SLTqFDEi/CaCSIjuH3k1/Jjfg0J0f6q77eOkGsLGuj/U8OEa0ezdvd2JWjQDB9LPyUSTpZ96Nx7jpUI2S+T7AmEOkjtZLiOgrfhh+yokz7AQSaH0q63BRntNvOmscomlLpze8H9xsal/ljIXykZOm644wX1oi1ofxkRkE/5xSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZKqMLhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZKqMLhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD161F000C4;
	Wed, 14 Oct 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988026;
	bh=rJ96Q4NwNxsZxDFd+nBQv0lamb4Zyj25BeszHMNuprU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZKqMLhyFSdR/qLW0NnlbtpQFuRbxXlX1BWRkwaXMIY918BiPSwPBmt7NL8PW/0tv
	 k6yf3GWUzOY/8Zok0tagMJ2OBipZmUMPTw2FB8YEOqowE9QJcHPqrJoytVjbfbZeaY
	 dwQfAY54OjzGgZc8cjTv9G+ip8/a1s/UfdwLOOXdz+iZDAOA58jdsXruatfXUs4ESs
	 LcoM7xdLOsrU5WruD2dgxfWxSJ3bu++iSj5naq3bbf9Lry75nSUa9sSsvECNCrsayh
	 E21LjV8UokcDv1+pIgsDuYo8gqiIros/hcQEmymQfcRFfGk8RAW7+tpqcFDyfYxZe1
	 gNDFd1gMQPQmA==
Message-ID: <sashiko-outbox-171416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] s390/dasd: Fix memory leak in FBA driver
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Volkan Unal" <vunal@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261014142130.756272-1-vunal@linux.ibm.com>
References: <20261014142130.756272-1-vunal@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:27:05 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Fix memory leak in dasd_fba_init() where the allocated zero page
> is not freed if ccw_driver_register() fails.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Volkan Unal <vunal@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014142130.7562=
72-1-vunal@linux.ibm.com?part=3D1

