Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2036997A;
	Mon,  3 Aug 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763203; cv=none; b=OcsTjBOaMkhQJzw6B/rpJxvqiBVgPynfma9PZeF8FjcuxXEbWbEzynExI+nnMQVL5C87ERXVLY5qrtAGM5DuSqgB/gH1Gf3dqArOgeSADS+GX6I48+uhVJlM2R1EwfZ1QlDyNlrhhRhoUPxjlxx/Fdzu8NEzBJQFaNi81i9DeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763203; c=relaxed/simple;
	bh=ioFihSCwJDZajZVpqAxfTkU4lQ9R1moAJeeR60hGx60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r79RPSaldCJ/T/vFpM8cQGuouAPQEy+UGa1etcPO+VCsycymxCjfcD688VVMeI8taXi0H/8ojyCTP7jgm4XAne7BE81t0aufy5/aOyfgoXHqhUzBv4lJKh+5rndxNN5hBdBkRDXDpD/gbPSnP1jEgNwzzBN2x6Bn6qhvTJzo9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFK2uZfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFK2uZfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CAF1F00A3A;
	Mon,  3 Aug 2026 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763194;
	bh=ioFihSCwJDZajZVpqAxfTkU4lQ9R1moAJeeR60hGx60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFK2uZfiDuJUHl2ig8Oy/ZGw6rtGzYHSFAGZuv0H7MX90ZvqnC79jvS4H0OXcf+7I
	 PdvysO/0uGn0YyQzIKkBQqcvDvyaqab59xg5FH6V/PfjKgGTwq5hDBMv1MVucp80K9
	 aHTDqPF+iXx9JrYwYydasCJxoUSWyld7hDB87Q8M7BVJ/7SZe7RAzhlpWoL7Bn6LNf
	 OaK4LPzZDtjBeFn6K4kWjGw67CGC2vFRVMFmDFMZ+/TfrC1gGxCjU1D20Q61AdRlUL
	 OIqOJvGUdkQaeJErJmTmShWjA2Wj8pcfDpFfOc6EYekUsjudWAMnSy4RjIMW7M5vXq
	 GAtzz3tlyeBHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/13] KVM: s390: Return -EINTR if a signal is
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803124040.126471-12-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:19:52 +0000
Message-Id: <20260803131953.C7CAF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a fatal signal is pending while trying to fault-in a page, return
> -EINTR instead of -EAGAIN.
>=20
> Also fix unpack_one() to handle -EINTR properly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D11

