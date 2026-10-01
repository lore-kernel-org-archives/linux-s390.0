Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA23264C8
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851445; cv=none; b=F9IiplEDIv3k7XdXdD9jL6qgqcCmPfr4J1WHU3+0KGWTwHbhhJfPuk6jALPTjkIPwUC4moiWfKFP00l/P6y4y4bA5ilhs0vcYeqINAMOPamWSOwaPoPTHAvWrLPqDdZFrEj8a+wzlyAh3Ml6NWRU70CJbUcRJQQFPv4qCp7WWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851445; c=relaxed/simple;
	bh=th5TehJXUwRhioY1IPyu6kaVFGc+SWg9eIDmA5/FbXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ANnatl3OnWvByziTUuWJgbMAukZWVPCv0lsjIeEb4nXdK9jmH+b6ohajmecScjnat06xHLEUDEqSe+uMEyoyaPBbqiHnCKUklJGulCopYPFpYh26qQO0a0N0eWQNy+vztx4fV4wfz3ho4m6go599lJId5P0meNDFxDS4IVI1fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzrYpRSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzrYpRSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2A41F000FF;
	Thu,  1 Oct 2026 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851444;
	bh=th5TehJXUwRhioY1IPyu6kaVFGc+SWg9eIDmA5/FbXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzrYpRSpWtGtwTARDVuCKmg3xpZwSJooxaN4LuoeMo6SZ8qK5aGmfvu9qpbnNVchU
	 0xBwAag0B2omuqnT6Pl7qEDcImAwGQlLGFo6gbMz8Y3Vzto3Q0dXqsxVkxJVTVBzT7
	 7DE3scWXjZ4S/c2u4ZlXxn6cJ0K+ZGx5xhDMCP+0hR6j6eX3fRmWTbnYYu9GUj6gqv
	 KWaHgsbQG4QuyOQ47dpva8Gk4tuwoEEqEVlsKYpIPBbphaUJKd5JzlIhRD1xk8o1LP
	 6CxJp1yTH1gGyGl5E89EY8YRsxvWtkhK1BKHBwk9/elMk/sMEtj+tOsd+ICPbCUlDl
	 GNjTKCes47jQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/32] s390/dasd: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-29-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-29-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:44:03 +0000
Message-Id: <20261001104403.CA2A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the dasd_diag exception table entry to use EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D28

