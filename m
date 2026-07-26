Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE7231832;
	Sun, 26 Jul 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086831; cv=none; b=KTAEvwd2nLbU1KcI/+DD4tkC3jnWsEYcVOeBt0GLVopdvWS3zN72tZzMzUDp0ztaz5qs/accIirzGETsSZSzZ27I8T27x/BE8Y0huPAABxr86prfFYaIWfKEHjITbMBeYlhyLDfdPYs8C8+qokFNNXyHQAxvO3CQCwAdnh4Rv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086831; c=relaxed/simple;
	bh=3GQH3zZWru/0JKcIMo/B+5PKx3I/GgL6wm5QYQ5QTHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UA3O69D+dbgqAOVL5OzY8GkCXMYwpbGW12FxJSVIUOcGj2o12xvSh4xf1Uc5s6qG5EctxfrUxEwkNu91DAlqoKg/pCXXCx6sScUpyQOKpxhD987kfFSvCv+rM2R/mv5olJdsEl9an7w+6OC57ciBF6v82x/MDptMef9EdCpCObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pytg8ho0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pytg8ho0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFB01F000E9;
	Sun, 26 Jul 2026 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785086830;
	bh=3GQH3zZWru/0JKcIMo/B+5PKx3I/GgL6wm5QYQ5QTHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pytg8ho0kYr6LfeIBKvoc3kq9jtQ2cAm1d89vb+GeATiMO/GiKiEjDOolv18Uf+7h
	 tXli+uYOAmnWPeetWWowSn6/GOePcLoe+1Af8Vew0+8QxLnNT8h6+YLGSU9lvuilEy
	 Kr4x+ry0dxJh9DK8GNM/+x9r99hc+kx7WJSfDeTYYMMfVZf8t5hCDbZfR1yycLdndd
	 aiiOHjU+Wzw6fre8oynIZLnww/RqmKCCTmri6xRLPDkKsjMNokBSATJafUwNL5IXa3
	 b5+3fjyjS0zIOxyRhITK5w+giVkjO2uLBbxZTJZDyDH6OvPzOlhdkq0Q9NeUgMzC6N
	 7P1A72REq1kNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260726172153.1818056-4-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:27:09 +0000
Message-Id: <20260726172710.2DFB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The routine ccwchain_calc_length() counts the number of channel
> command words (CCWs) that are chained together in a single channel
> program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
>=20
> The loop itself is "do..while (count < 257)", and while the logic in
> is_cpa_within_range() correctly adjusts between the 0-index array of
> CCWs and the count of CCWs starting at 1, this means it would look
> at a possible 257th CCW before ending the loop and (correctly)
> returning an error.
>=20
> Fix this by restructuring the loop to break as soon as 256 CCWs
> (thus indexes 0-255) are examined, without looking at memory
> outside the range.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D3

