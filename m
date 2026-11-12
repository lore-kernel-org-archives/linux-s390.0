Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479678;
	b=QXD8QyUT40IREq1CNJ3MWclg5HwT9TKLSWaAD1zDFSIujwGglcqVZ1gVmNDdMYaw77Gb
	 w987MN24800pCoRY887uJUHF2eIDrBXKAqcutPIPSZDWcSXAR8gHysI2DLhn+Loky7gsD
	 aAmmE9vX+sWFdXEItgu0EYxtNRLvwYTfOTIdo6jz416qMzwlgVOiCg0IA9hjYcFoe4o8O
	 S5DWYH1Koj6eoNMao7g/fEuHk4fC99ugY0X7qPdfrcB0OurJb+LZmfwOcDpIXb1DXrOzs
	 jM+KYqzqrgYrfWnh8t9RdWU75zPtQyiK7M1p7921V5a2aNFfzZr5QRk6Wg5/+dKXFDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=omMrYtfgn43QKeJuFmJvS7ABFQMYMkSdTo1cihBdQb0=;
	b=KKs7E8n2zYXCdAXO342m1aLxDmqXGNZb+d9q52SqqP0zpJOMhOYGh7OrB1gVkIfdJQjV
	 U0/SJvEk2NVQ8uM1hyrDq2c3fmtvu91L4g26Myedw0c7zK6eNlq9XHOAgtWe3IcrDjhlI
	 ZaTvMGJypfMUAI5PDIUBeP3B9McWmP7epqPHNHLWqaHGIA/GIBYIa7KElN9F1S5SQjRMV
	 KnFxDgqIcIHIBU4CJ7/hlRJ+jkfkjQ16mhDRtFRK0CDJI5aYjtMk5eFludB3PHSRWlmGU
	 MdPDHenNQj6DTzxsTP2AmVVtyEca159/CAZUfjJeMCginchzZZXr7pgoDd06kFay1VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRtHLpVg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C3F606A88B
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRtHLpVg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB361F00A0A;
	Thu, 12 Nov 2026 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479677;
	bh=omMrYtfgn43QKeJuFmJvS7ABFQMYMkSdTo1cihBdQb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRtHLpVgyjoA+y8b03rP4HAcZIc439rQgM/7/9VPDhCQ/6XSRAusLn2LfTrbjCehp
	 YmY3cmuMIlCR9ygyc9hlasmgA3+Fcd5U7hk5PvvcjEf2Mujc2OS1Q6XSl2k4uN2Trb
	 9ouIxHWo2D6ak+sUCXTgIvIqSF9hwczE3DIIUZsOHcluaTzFnB8vYkbI93DPBW3k8O
	 s3LjtOhp5ladPztjA+mnZYjQmjEr0RM49p/xZQrZaIp6ww00tephiSL8XUoyKmsP6A
	 yEe9Md1j9lDkzvA2lrVrSySchUzB82ZQjcz1Q6rFAzMbphkbqYIyYfca8knGbk5Khr
	 oMMbAXaLm8+uA==
Message-ID: <sashiko-outbox-210949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] s390/dasd: Don't trust userspace-supplied result
 field in format check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112102608.1057852-5-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
 <20261112102608.1057852-5-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:34:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> BIODASDCHECKFMT used to copy the entire format_check_t struct from
> userspace, including the result/unit/rec/num_records/blksize/
> key_length fields that are output fields only.
> dasd_eckd_format_evaluate_tracks() relies on cdata->result being zero
> to decide whether to apply an index correction (i--/pos--) after a
> successful check. A caller that pre-sets result to a non-zero value
> can suppress that correction, leaving pos advanced past the last valid
> entry; the (partially out-of-bounds) fmt_buffer[pos] fields are then
> copied back to userspace, leaking heap contents.
>=20
> Only expect is an Input field; copy just that member in and zero
> the rest of cdata.
>=20
> Fixes: 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260722103704.1709668-1-sth@linux=
.ibm.com
> Cc: stable@vger.kernel.org #4.7
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112102608.1057=
852-1-sth@linux.ibm.com?part=3D4

