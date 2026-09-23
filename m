Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6164248CE;
	Wed, 23 Sep 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177451; cv=none; b=F2aKEmqUCDA0H4Cu1jf1Kp71YlUnM0MmJojNMKsSE8UDUGLvUKwDp+eDv02w7jNrbjKg41FHfxbxXJ7jjFjsh0HNV86xFePIUPliZ23qZufdWi/zdUMZrf6hOHiGS5mWyCEqKnpQu8LmZUDHJ1wVSB0myhGhCrA6cVlC66376Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177451; c=relaxed/simple;
	bh=76qIoiJ9AZt1kqssk93YufvL+bSlfiHU1704o9JGqMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H122bLt8f2ri1cjCvLyeXfUu2grqOBGd54nl073v7zQpLhcBQQjnUQcfGH+1OBV25MU4/G3vz+BWzmMXjWjb/eM0hr0uuVQdA469trJqQVc6lTGtOMoJIZ8nRsflZpU1BIPpOYqL207jsCOx0WpNda+JQw2eK8RLFzhqxZAVMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFIYKGDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFIYKGDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EA01F000FF;
	Wed, 23 Sep 2026 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177442;
	bh=76qIoiJ9AZt1kqssk93YufvL+bSlfiHU1704o9JGqMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFIYKGDz1qBXCBJmCUyIhl+j++6AlyoMr776NQ8/xfiRyr1aJFvcN7fVi8OwB8Fnu
	 D2XXtHHSJGfNcTr3BDkmZ0mYCFp8J8Icgz9DS474z4apph55jM/ClcwdeCmOJnTUyn
	 H99kgm2pfB3EuHKcp2kT4BxovPVW9njGalM/fL8Op/W4xuXq4uMsuh2wt4ZNIcwDDO
	 MbzBO4PM9kPNwyC+wUppgufDpAgUfN4h2lUk5qXAxywyD/2N/MLRPL/6bpB5JMPZgX
	 Sp8w4hcLo0UkDr9+ekuy1jFHS2SsPp3JxHyvwKScKjq49SuO2y+khHmsNnKojYAUCb
	 HJUpTvcbkIlhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] KVM: selftests: Add option for different
 backing in pre-fault tests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260923-kvm-arm-prefault-v4-13-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-13-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:30:41 +0000
Message-Id: <20260923153041.C3EA01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Jack Thomson <jackabt@amazon.com>
>=20
> Add a -s option to specify different memory backing types for the
> pre-fault tests (e.g. anonymous, hugetlb), allowing testing of the
> pre-fault functionality across different memory configurations.
>=20
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D13

