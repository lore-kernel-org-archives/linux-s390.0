Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD5476046
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006597; cv=none; b=gbgwL+dZVKfybor5KenXb7iXB2hd6dm7UoCicas/Ar/MaIvQML5Rx1UfnXBifqXc1FScHyCoMvBebjYu2vYXsNxZ6xfSfe8bfD9JEId79hG95Jtg1N3IL41BWuCJ0HUF1RsagpPm8iKUSQ9L2wru7U3W2a2T+lEMvwJFu9O+GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006597; c=relaxed/simple;
	bh=wRYl9zv6m0Ch9JBSrHRtgQ2RV2IMNTFqncd6T/xyVso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiiCuJqo6gbc/KTMTeAKrDsHi59jtob1mrJOPkNFTv3c5p1cDFlTadhu3j72HQ1SHmJhQ144MPXSKWLVYK8xnn9WaCfkpBbRqXd8B2FXZsfGLuRYc8kwpE4klqaXS+osW6dN32plR2oCKdzZtrovj8eDr6gPscC/YsF1D2totBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHfRUtKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHfRUtKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660F41F000FF;
	Mon, 21 Sep 2026 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006595;
	bh=wRYl9zv6m0Ch9JBSrHRtgQ2RV2IMNTFqncd6T/xyVso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHfRUtKF7bcG96+oqyuZTBzkpa8mHt6n3cWbtDzWc06ZtW9mUcaI5b8GXPCYMim7s
	 ELo+LnwCPohB1h3bfevwJifrSQEW414ygWe9rpYVNeuqXdH1oIdSS+q07RKD8zPyxc
	 HzKqCrsLH0auXIjlVzUsddbBv8isM/9hzm8hDspijQ2zQteYKBy0dqzw1BtSmixiqE
	 l9dUTBELkjyqSoct1dqZD8Qoo1wh2WoU08qGcE7HFrZy6J+8EVP7hgtS906tir/+P2
	 KpF4vqo+ycO20gjWY/kGztPusCiKeCAgfo2Obvko3Sgb9L1GkLvx23GBaGjvva/ATt
	 gQWB7ZrwlUMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/11] s390/percpu: Add sanity check to GEN_MVIY
 macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-3-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:03:14 +0000
Message-Id: <20260921160315.660F41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Emit an error if the GEN_MVIY macro fails to parse the passed register
> string. This will make it more obvious if something similar which was
> fixed with [1] happens again.
>=20
> [1] commit 101782f8945a ("s390/percpu: Fix MVIY_PERCPU() with older binut=
ils")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D2

