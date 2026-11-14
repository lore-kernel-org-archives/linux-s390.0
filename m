Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662246;
	b=rorBuzCoq2C+9r5ja838vUaRRfN0h2Xc/AMrKzvMJlzf+bMUpTOyA/0iibzBgQDH3ysT
	 iO93H2IdCJWwI+AIlCoOWMHL3HXifUE3wQTR1d2ttUmidDOYdZlCKMYHx371pinDbXRZI
	 FIWjl0qAxsrthJucSxxp98KpUFZGJ2z6EIqf+0rPgJM9+MH0QJG8sji2Z+zOqyTNmZY+L
	 TOGy+8rMr+z8/s4KgF7NrlXs/tQ7qZlaSN4u3GCcM48otFpA6LI7jPS6HvpNAG1ub1hR3
	 vFpS8ggOgr2Q3pJfMaS9f4Lrp2MmvMElwNiMzXKHDHUcvuvv/5M0pOINKmUBsd15zOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/L89KUI6Owoh34wqurZm2BUaaEwu7t29tb8HXY59TYQ=;
	b=osmEmGtXf1ohyfQSVifyA3lvmshcTh9oSHgkIoHdQ9cqa0ifq4unRQR6Cw9DExZCl9UN
	 K3Uj1zIk0vuiEHpzF7NwoDZgoFB1fQlbBcwpt6QZPQIL+hP3JHjRlSnzSjKqnKPRWtQTY
	 0Bf6U+SMZdInc4+SfkBCGT/tHmjp8HnHBAoDYJuWhZPXl03relcQnUfM68MjD8Xr+K4RE
	 s+vGHvO2nI6b1mah7EyX0wLzAQ0N/aNPX6KxiJSqP4D+n90kuL3XKvnXisJih7w4n1Euj
	 m1Lt2wj91nT/ROx58IlD5zAF+sgARsadmU/fN2qAb6ngKA9eMbPaYbDuj2iKEvVkWUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOYS5IhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287B606D286;
	Sat, 14 Nov 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOYS5IhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE61A1F000C5;
	Sat, 14 Nov 2026 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662246;
	bh=/L89KUI6Owoh34wqurZm2BUaaEwu7t29tb8HXY59TYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOYS5IhFimOmSrTkIZjKCumnuqfgxyYvRiDNJo6B2F2fJZ9uTOAwMEQz/tMeFmONi
	 d4YkSOy2IWpIPHqjs6irj9jkkrILMsXF2gNabPfGTPjKTThF4lC3G7ZWLHkiWhP+Av
	 7WzMxjAwWzS6PaRbA7fAyf7pFABY5eA7ndp37F8glayKN3zeVfV8rqPFTrcmYbTlPX
	 GfPc4JSGhkIuN5KxU9rBRrqg0y1HsWMJxL/sMJah+QeoLhc0W+R9vLiK5g8d09ZfFr
	 H4DC5GXjxuRjzP4GMx43QsDkqeqjok7CK7vI0loRN9CZIQQD1Apl9uXjlfdsWJHp/V
	 P8FJQ2aHAkSyA==
Message-ID: <sashiko-outbox-214525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 11/42] failfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-11-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-11-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:17:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D11

