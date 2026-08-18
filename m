Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A52B9B7;
	Tue, 18 Aug 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065597; cv=none; b=Bl8vZOtU+v2wKn+fE8IdYgBzQU2M0uwvWYUWAbTHL04QTEDn4aoFWWAZ/NRFrP4dfD8uqaNrACS1aXR2qi+zJkACgY/Jffsl1RQ9X1z/o0JKV4GepUReP8gfskLrK5rI5yPVfWWx+QvGTaNKsz8lUg18/ucWLM/z+iuqkTQoeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065597; c=relaxed/simple;
	bh=acnR8SdTOLPtGJcOfUBWvfJaPIpmJJDRdzm0ytJZ9EI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hy5nOSqxZ/oNFAQEXB+vGmKR7WL2jOZzlHDoSe7lJ4Q7VpfZzKjNy8PJcSKdlQCOhxHbCD2BKx/A79gLZ7GST/knqhQvw8uamppcm9KjAHoSjhAD3acJrCZw33V/6oIbk4K8zDiYvB5kR9WGKf3b4qfy/bMEyplUDRwR9iB5rmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja+ADgu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja+ADgu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B421F000E9;
	Tue, 18 Aug 2026 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065596;
	bh=acnR8SdTOLPtGJcOfUBWvfJaPIpmJJDRdzm0ytJZ9EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ja+ADgu+fg8hrutK5xw/uCv20p0wI70O61kOdOF88/aFVw6IPzIS0AY22aT3bIWvs
	 bH5zY5c21LFUK79uo9lCsO79RIRyCEZ4hC6fCEsfZ0pYRuhD9aoxCogZoXVF/Hs4uW
	 AhBydd7JyqCESH2AGbIfRA1BxzPkspcKhM1/pvgvtomf7Q5+s97gkQOGdZPVMWmkSi
	 7JJp2K6/WWPzfFBbv5ltwmowWVPdfbpR9IYacd0pWvteD2zlSem8q2VvsbdlbJMMWN
	 Xy/Z8+0qCeTprbDrVy++oHXxF23xabp/rul0uqUoHXJNxpcaekUMaO7bL/pj/Q/wtE
	 aM5j/rpfvpFGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 23/25] s390/ptrace: Provide frame_pointer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818144954.2320378-24-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-24-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:06:35 +0000
Message-Id: <20260818150636.07B421F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D23

