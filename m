Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F93E51D2
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899344; cv=none; b=M6qRRgH3pHl5H2n8rwSEz3jdcLwc9SMa7LJT200zd4dAdZmG8CPv6TzBN+iP8izu07wVShJ5OizF6dijsB806ojvxx135QRIpm1XlK2D3pjh5218QSLY5Icb2lK63EKT+26jt9/+tZDSLccV4KR/vsI4M57VQAqS6fzPhn7oREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899344; c=relaxed/simple;
	bh=WwJUoZILdGDJKG5yaXiNJ+MJCjeRT8pAmEzg7OJZ5l0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K6aVobnPFYTkkiMQyNAYZiZ028wPfAxg/jnK9jPET9ftfmTCDEJahcPJ1wqboRK85mxlH58Z9/bRRQ3fykGpcZqMtUXII/ZnZcMRI9QsnkxlpwtmTRcyfY/R7oK9LJgfNpd2OUySOD0/ir9fc9w2n10B6Gd8M3cl6AEkXM4YQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2uOUJny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2uOUJny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A3A1F000FF;
	Tue, 13 Oct 2026 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899343;
	bh=WwJUoZILdGDJKG5yaXiNJ+MJCjeRT8pAmEzg7OJZ5l0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2uOUJnytZrGWflnudv81w+cu2fOv9QE1hp3rsaeECZc1A7xgXGIxe9zE7hr1wRrj
	 kVWtpvXrWQ8j1mQ1AL85QyGpDLLMWQhQzIB0zRRKIliqimYd/j9bsQ9ApZgat0eHjw
	 hQ2WZOMHQRcQfTOhzkrNg9abx1CK0WsrbNAWPqjuliaVoOby9YSbMlE4ROVqs1k+0a
	 hoPFSFjAMMIQoBZQZB6anqKJC8CCa2LjFVAf6XvIGVXcnB5d3ZgCFhcscGOlrmu3+/
	 78M6w4VZ9qvG9vVoWkAgZBzBhVxz4wLdj+6fnseWwq0GwyuJcgBmjUqj6vuHLHD6F4
	 mGCLiJQggP+yg==
Message-ID: <sashiko-outbox-169863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/signal: Cleanup coding style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013133453.2288894-3-hca@linux.ibm.com>
References: <20261013133453.2288894-1-hca@linux.ibm.com>
 <20261013133453.2288894-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:49:02 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Only whitespace, comment, indentation and other trivial changes to
> adopt signal.c to current coding style.
>=20
> No functional change.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013133453.2288=
894-1-hca@linux.ibm.com?part=3D2

