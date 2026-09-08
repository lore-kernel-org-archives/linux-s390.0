Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8ED388E66
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850220; cv=none; b=W+AtFjN+2NmEVmyZce2AVGYIjzcbHtANNOP1AhxxMX7zoOy/f3D4HwxICPfPeTRZEqxEwlYjCPxg03scB0w8xyXYHCRSHR5mHrTKv05tqF6lpS5RHCQsf5ln0Buz2tOK4MdfNWLuCeiGr8nmnkeNLi+t4e8ziezGMlsiDLfsNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850220; c=relaxed/simple;
	bh=ythyWzfrWL0fZIYNkbD72H80ehTjGjiPGSksiYq+7ZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7l7iUcdbaPuGh1bdIETILR8Y1OlomuBEBAOd4O7lsflCgICOR9rEaK7/1N8HEcLllBuN+2RcGckTgPPuLFkYvJ6H8p/WG1veWQi4EHmOie50mcegcaM9R3Nn1cCOhXWJ1hnHDyMwoEmvE+tlmUWHBCt8R7gviLmU6gexQGHA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyw+tSz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyw+tSz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458281F00A3A;
	Tue,  8 Sep 2026 06:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850218;
	bh=ythyWzfrWL0fZIYNkbD72H80ehTjGjiPGSksiYq+7ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jyw+tSz3O0ofaixFbn9KiskkTEl0KcJari9Q0C5YP3Lb4sFOn3D8V5WqaEky1hUw5
	 3nxVA7g0HxkFuo9LPpcr0A1BqtIxvd4U8HJi7GbXFFS05lqf9TiM+Z7qMR/I4ibfa9
	 NaC5mrgmxbmRhqVJ10/tRdYAag/ABsWlqQFyP94K2ADZ+I43svmxLF574DBsBUdvVL
	 WcQVjFd8H5ERs5rKTPpbzOR/miK7IU1Fb83kJ5sF2yJxfe/smkkwCb9w3xF67CLKkO
	 hDjMoSQudmO9j2mvOld61oJ3YvZgESnP/NiU5rMupyoZsTQjFcYHt7m2ymUju4e/MV
	 YjbaWGto+G1VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/24] s390/elf: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, ojeda@kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-8-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-8-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:50:17 +0000
Message-Id: <20260908065018.458281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>=20
> Move them from the kernel-private architecture-specific header to the UAP=
I.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D8

