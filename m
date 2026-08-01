Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5131E830
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582787; cv=none; b=WyDP/WtOnWuEE7XIzj23ZZt+T+rNaUaHnfWs0vHvXnt67hugRvp9uLK9bi6Io3XtO0/EVcBEGxDX6wv0v63oPq27CNKLoIa9O+uGXNiecdcJKbfQdAIwp/JSIT41/60yFPVNV9bOQzRzUXgKoDSNZofNBRzXxoDeWHPM1J5QzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582787; c=relaxed/simple;
	bh=Y4T/Bt5ovkYMxTLhqdtvI14cAQNSvjHRoSAoX6/3VDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rlaxzA7u7CTAt4mrTSqTdFM3P/wsDuoXoAbjo5yC4LMokm5D7y+fdGYN78q0i6SYr3OCBouCAAm4vVse4gE8pHihDEeozLElVh1/lrlUWKXHOUAv3kHFujzWOw3xcuXrewe+oSeAUSwPx8WlnaMx0N7yjtLZSq0j2gDV72tecRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9QpDukC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9QpDukC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A381F00AC4;
	Sat,  1 Aug 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785582786;
	bh=Y4T/Bt5ovkYMxTLhqdtvI14cAQNSvjHRoSAoX6/3VDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l9QpDukCg9XIvMATNd5kYfPlZvMXe/wcaSCsaEi8xrsbDizaIbe2CZ0qi/obuUt9u
	 yWzQDQ6v5Iy/8KIpPOzy9pBxcQchU9R3ng8jFd0msg3doWvHWSqu6Nl7s7gp2qEfZ3
	 9KcG48ncEEDFAmnA87ms5165kgWErbPxa+XFiWko58N9fz3PhomnSyHUVTBmusRXRo
	 COi52N2iSWOM73HAqDc6c7Qj8m/MkG4PhSkG9foTcq5blENK1hXqth1ALnqjqfKpfp
	 gi9BaJ5xZDsISEeL/oxu+aDjZGiPr87u4Me7p6I3w04iceFCs0emM0QGw7cW24LO+Q
	 Awb/Ue7G1m9/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/18] s390/dasd: Add defines for the Extended
 Address Volume track address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-7-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-7-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:13:05 +0000
Message-Id: <20260801111305.E1A381F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The track address of an Extended Address Volume (more than 65520
> cylinders) carries the high cylinder bits that do not fit the 16-bit cyl
> field in the upper part of the head field. set_ch_t() open-codes the
> corresponding shifts; name them so the encoding is explicit and can be
> reused.
>=20
> No functional change.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D6

