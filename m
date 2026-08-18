Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEF3B1BD;
	Tue, 18 Aug 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065118; cv=none; b=c3roX8OS/GDs8cxnKy3aHwBT/I2eaeGtc5i1a4DEzKYJCtpC7Xl2ehELc7P5yf2Tnq+aKK7a86vgF1L6/JXUMkkkL9vVUQsUnhM90dWhKJjlm9aM0VdfW9u1+7HbEOAkmpBhRqzOCALxiQHIgWscQaEeboSZs+YZNpVDMhVjkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065118; c=relaxed/simple;
	bh=4Vu+nZE9UEDyhecLkoSbC/EiCVJ+hdWwZn6hHPFOezk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LdpCn29uH7HdLCJcSc987q69u48SZoG9cBChU3ONyXB1bp3142N0BgS5PsDj5ziu4duWye6qIRgz4eoI9cZVIzxYeSNZPYxLFRpeidJ+ybm4/20OcdAgm8cp0tNsiUX+OyJKiyPkuM27FQcWHcezi1JxveKgQ6/R5+Tjqpfw+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atdo0q/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atdo0q/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272861F000E9;
	Tue, 18 Aug 2026 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065117;
	bh=5Gf5jNdflhUcRcIzTZb2ASCjaJU6U/sqJ8CISyarRio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Atdo0q/rbNnRPyga7OiwIJC+W4pw4d27V3L/o4alC+lEyY4oGg2rSVztgS1hhTjVr
	 WMDsFA8w9Bdka60F4J4cgkcMu9Sz7r4eK2axsjh2XGTTES69IU8GFP1JzS2rVjhKgr
	 6WjJCDD3KSJWF6ejV2riqy1het8wa2AvVGwT0DEkm1s5XYxxU0L3+n2jKsOxIdHbx1
	 uPxUhQqcV6RiCWlCmMkDCriV+K9aGBbQ+JF8f/j69xq6DxR4FsltC26PsV8kk8DTs6
	 9zz0lFcmf++r+g381HFXWKAF0HHzeAjxhpR/tTA2pGB2gjZrZ8ItMrv4q9z3pO+ugT
	 nBLnCHJ+TDl+Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 03/25] unwind_user: Enable archs that pass RA in
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818144954.2320378-4-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:58:36 +0000
Message-Id: <20260818145837.272861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Not all architectures/ABIs pass the return address (RA) on the stack on
> function entry, like x86-64 does due to its CALL instruction pushing
> the RA onto the stack.  Architectures/ABIs, such as s390, also do not
> require the RA to be saved on the stack in the function prologue.  In
> particular, the RA may never be saved to the stack at all, such as in
> leaf functions.  Unwinding must therefore not assume the presence of a
> RA saved on stack for the topmost frame.
>=20
> Treat a RA offset from CFA of zero as indication that the RA is not
> saved (on the stack).  For the topmost frame treat it as indication that
> the RA is in the link/RA register, such as on arm64 and s390, and obtain
> it from there.  For non-topmost frames treat it as error, as the RA must
> be saved.
>=20
> Additionally allow the SP to be unchanged in the topmost frame, for
> architectures where SP at function entry =3D=3D SP at call site, such as
> arm64 and s390.
>=20
> Note that treating a RA offset from CFA of zero as indication that
> the RA is not saved on the stack additionally allows for architectures,
> such as s390, where the frame pointer (FP) may be saved without the RA
> being saved as well.  Provided that such architectures represent this
> in SFrame by encoding the "missing" RA offset using a padding RA offset
> with a value of zero.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D3

