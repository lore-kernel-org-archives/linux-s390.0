Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288BB1F12F8;
	Fri, 21 Aug 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342855; cv=none; b=B8lm6nYpXeVJVzbu11zfFwUgeI0ouxdEBPxIc9yB9YC/bcx5l/iCPS75OmoLa7wbmE71zcgMmP8zpPCIR8ambEtVBH8huhyAahbspGs2KP/1DI3cXknC/niVV6iFZJT4uXmrepOFVWdfKZz/4IVhtxnVoLsecG2RiDLxU6wk+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342855; c=relaxed/simple;
	bh=vint/htdK0Xa9Xh1LSWranVq1HyWJZaW/RI8emPN2+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mvsh8EWNLtXYetaT/qH5wy16+XZmeYcTPwRgbGdbShqJvqPFq/diZBeR/Asysbu734E6r7Phbah+05z6Pu5uLKL8VmUOgj4L/SiWoLeq7m9gyqi3WJWIjnDolg+kuysRnXeVSWgd7Mc/NtG39GSxDjNk8gfvil0IO+804Gi8cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYrjCrh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYrjCrh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749011F000E9;
	Fri, 21 Aug 2026 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342853;
	bh=vint/htdK0Xa9Xh1LSWranVq1HyWJZaW/RI8emPN2+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYrjCrh6tA7cycVtsS2dPq6v1WgmjTuFv8pfF0RjEVWnBH2nZAYQ5xIRMWi+6NaLq
	 X5jnQE00UW1O3QT/w8/31yBbLNAMEBs/UpArRnzHhA5PLInE75RCmoRaEkUWcnai5y
	 SLEHbzonLPIhovL/FO8rMlJEsH5aT7jzaspS1ZeYL62N7+YKxEfZBTQSrJAtdgPVa2
	 QNmwOXmyhHEo+ixIwwTtCeE7hy12CAyz/nfJkuF2MGQWRPhz+6bpkMEc1Eu2McG8VI
	 9NDAo3qybk3udxbNZQ8ObABc75XIHi1JoU6YHcciUe6KkjbkP2O2f3YRgv1G6W9pwo
	 GOGs0YGYld6SA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 22/24] s390/ptrace: Provide frame_pointer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-23-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-23-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:07:33 +0000
Message-Id: <20260821200733.749011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On s390 64-bit the s390x ELF ABI [1] designates register 11 as the
> "preferred" frame pointer (FP) register in user space.
>=20
> [1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D22

