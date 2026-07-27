Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B83D1A97;
	Mon, 27 Jul 2026 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182025; cv=none; b=nIOZVI9wayOhqiRdMp38ISRCJkBBvJBIi1InnylcWzCK/rg+nMLjqGtFfZCBkFOsFgmyqHA+S7VFfJeFOFA0mVzMqJli7aMM3GJ/BXc2YJZsLjauCC+XMT3yVjrvwyRqjAGNWYMq1MQOhhFFEFDYE3YTAcOFlTa1S+Y0s+08kXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182025; c=relaxed/simple;
	bh=oCSn6/QJV7FIBakEA9hgSV9etfGtMh0GvUPYdJWevKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/aNkFwxfhPqKX9WrRSwYbX5wg6cauP7HnmIU0HdNOcxERZnHU379Mt1068ZfM3axKQblrykQ7SKhAVjy7PsRzjufiJA+JK1/HFSfVyj/dwXBl3xVvFiyD33vxDOmAA/KaU7TgxNFTcXVtVnMqOSZ0wjR5vCGyXUWUAV3n9uoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl0SuiTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl0SuiTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FCF1F000E9;
	Mon, 27 Jul 2026 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182024;
	bh=oCSn6/QJV7FIBakEA9hgSV9etfGtMh0GvUPYdJWevKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wl0SuiTsRmq7svscBtr0f5jLEB6L6Q0SnQieHkbffDcA8QxFhvekCP4nX4jm94Q0F
	 eP4NA7Tn745B07gFxxoqHzHjbcF5tCIWbvy27jM1Oqi2Rv6fEuOT7Hk3O3Ow2Z/D/H
	 iwElYaxHiHhp5f8H2/6i/EfDENFKpk+k11FpXHtyg8hCWepHra/zyz7nzSEoCx6m7q
	 gLeipXK2v/KSK89WsBAzjdkyDOrsRRjcnYq0g+/LVRLBJfS2H+mzXqWdKDudCKQkxR
	 yJUqAFy7R1SjAOp59eztWv2QUgX5zhcdcUdBKCWXuyZE5DxFmIgeFRM+U6Tg9CUnE8
	 Wp9WKaekXGyzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260727192230.2715207-4-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:53:43 +0000
Message-Id: <20260727195343.A5FCF1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D3

