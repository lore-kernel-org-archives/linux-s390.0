Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F5360ED0;
	Tue, 18 Aug 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065474; cv=none; b=GzefIyVmIO8dAI9VYmhlV9PLLKNC9ndukq3a5he/pXXW9jII92t2jfsse11LKicGyIwQ8VNdqRtOO+3JEPK2f/knFy1Zh3qs/kUmhnq7tTptm33h+1cMyLqzuvcwRJTGqgYC4NH80WzNVXmWPWuhSb7ADPO+VFf6vjjvNqFSwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065474; c=relaxed/simple;
	bh=nESoZrukwvdusVjl+4KsQrv0lHfbMnduPKxqpsNRT2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKu5oUfV4DYNP0gnrX58aCR28cBvAQPg7v+mi9ikVzfipNR7yy7QrODlnzi4Qagu2o9Cq7HIB2IDxDsDaFhQJPqRO4Sq2bPY+zH8fiyj3u0ZVJbASM6XgJ9q99zAsda0dctlh33/MEjy/uPEliHTTrxAVnIu7WbR/X7hP8hL4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHQNKrTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHQNKrTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CBC1F000E9;
	Tue, 18 Aug 2026 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065472;
	bh=KcjhzJ7sOPArtWHGdq8QdkbhhdfNGoMxsfYX7Yzs1lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHQNKrTqJUx6GlzHcK4SWnZRaj4ll4FhMBbb9j/dMjqay3+Fa+Py29glLEyH5/ERJ
	 coVD0CssN8KrLLJT15pKAqFPwcCEGXssdIdVznlQLrN+39H8+GoQ6x73tggQ77L6pV
	 VAI8ulor7LnwCUKuI65DhkUXOEeX5BoUTYhd9ZQbsjZX8McVW+o5Fk/5yFMyNRsGn6
	 WyPGVyNEruCU+m1fkZC80wxqlsQCJ/OlJU7X3lyzosg+vdvoKkZR+beryitoaHUmMn
	 qc63cmJIS7X7AyG4YKXXalj+3rRVzO/BYYiXJRqDig0GWeKSpWOeGVkyLvz502p3Nd
	 MgC/CXc0KhwMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 20/25] unwind_user/eh_frame/x86: Enable eh_frame
 unwinding on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818144954.2320378-21-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-21-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:04:31 +0000
Message-Id: <20260818150432.46CBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The x86-64 .eh_frame implementation works well with GCC and Clang
> generated code.  Enable it.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D20

