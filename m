Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589793;
	b=oS2UFyZ3ULZQSrqREYcSj6Yu0+9m/nh9SJxuw4Pt+BPxZx8OdPqPU8TQfvxvGc/nHqKa
	 5YRLgbkIngzFB2XyCa4uk7rtY9bJ8xtLihjAuyzBBp8W7dD8HtDNZet22MQy68GmSgM5E
	 1zTRTqVLPtA6wJfP7WLEKalv8r6uejcFm/cqPojmiSi5x17mncLqMp2zPRuGP6ly99TPU
	 fW65nbzUMCtpjFZWRaQ01RlfWiBT+AqPN2hCsggcvoromMxKWW9/PqAhW6KA2dqNSocJs
	 /njpGNiZnEi+qwkU1J+I4uFRQ2X9HwkB3HhzrJlv4e4Nnv2MGDz3RCj57+xfZUaBOQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YX2HowanTt24Gf7wjOmC7k1ehSIVG4b8pTN0REQCGcM=;
	b=LcHUUzSx+kY0eecSGl52V2psyGPkMBYFLV/489qaAklp0gYQFyNnHHE1OQBvl6mSjwu5
	 XWeUiPHi96q4H4TBcbN6XTFqTGocOkB4+ZPkr5BiwmqnRKQYIh16gjSbZu1tkmWwnoL6Y
	 YI9lSOwOYAILKZSJRLJA+X46JOCGxo+NZ2aXUYeMpF4vwAVT3m8l/3QoQZXwf1xoAktMm
	 J62wLnOqUqJ0jSrMSAbwtC5x26Nx7GqPiaFlkH0fr80fJLNl0ljEZ+jLXEAVcAb0SZG5I
	 KM70npYjMCSzQ3UOuXYb1GH2a2C7a6DilXfcThESAAlN/u4mrcs9vQDb/wYjQZhVJVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDhTHVxS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE361606A330
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDhTHVxS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A181F000C4;
	Fri, 13 Nov 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589793;
	bh=YX2HowanTt24Gf7wjOmC7k1ehSIVG4b8pTN0REQCGcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GDhTHVxSam4C0Kz2OGXNQ5QfV3gihIg6ZYs0ZiL7mAd8Vpmy+XxD5A6l/9v1Xvl5e
	 BWyBCHxLKZhXcrvCE5Y5FcBpa2jB5jj3VuW3JX1gVCVrFIO3PnyBdmV04C3eXbK5Uw
	 E0dGmZUUjjq16jaf4csezwMV0QdeByVJy+wydF3IBTxVuuHpUQBHwMbsKi4Y3es2q8
	 zjGPStFaaMdKJmey8csStSKmzagr+fv7JQoM/e/qENkU1ILHyHj6eG8lNxmVwPM9y9
	 6LDzJACj/7h1zicBo8Ql617eMHBhqt+jleiS445j5mtoxkjy0vA4ltUUMo0ZEu2udX
	 30xxDTm6IjvyQ==
Message-ID: <sashiko-outbox-213279@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] seccomp: let the tracer skip a syscall
 independently of its number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113165509.229869-2-renzo@cs.unibo.it>
References: <20261113165509.229869-1-renzo@cs.unibo.it>
 <20261113165509.229869-2-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:09:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Davide Berardi <berardi.dav@gmail.com>
>=20
> At a PTRACE_EVENT_SECCOMP stop the tracer can only skip the system call
> by setting its number to -1, which seccomp reads back with
> syscall_get_nr().  This depends on how each architecture lays out the
> syscall number and the return value in the registers:
>=20
>  - on some architectures the syscall number shares a register with the
>    return value (e.g. v0 on MIPS), so setting the return value after the
>    number would overwrite the skip request, and each of them needs its
>    own way to keep it (MIPS keeps a copy of the number in thread_info);
>=20
>  - on s390 syscall_get_nr() returns the low 16 bits of int_code, so -1
>    is read back as 65535: seccomp does not skip the call but runs the
>    filters again on syscall 65535, which kills the task if the filter
> [ ... ]
> The next patch uses this in PTRACE_SET_SYSCALL_INFO.
>=20
> Suggested-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113165509.2298=
69-1-renzo@cs.unibo.it?part=3D1

