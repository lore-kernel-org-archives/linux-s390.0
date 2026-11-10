Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309839;
	b=2jp2h/pdWorHikppbXMaNPKbQ4Q0va/9Aa0vhzOT8KdsLAt5cP3IF42LHiDRqOE6gb65
	 uq5NvBys7sa8U1lkbrEAumX2+rsqYiOixHi2o3M881/fqEcOB6J867r7EojJW6o7jWM8Q
	 ia3+A9HQk36uQR8pcgjttOY4u3SD+n7KcegFfKm6HC15IH7H8ZscsrpL9JMWgf+jPsAqw
	 F+sM+MIqJwkT88YRthwbMfflKP5YwJBlvqnIUwr8hoV11ffkwC+OM8QUya8r8wh1CoTAC
	 qtFdfofKBdvVb0sCoOaOeuyRXW+K0wBzunrunKo8te0FLKqDPhpU1CHFCqBRD/6+gFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=awBU8cjJbjLo0N/OW/+ki0TCmFV1Iq71iMHN+7SB+KI=;
	b=HBREpZxO8tWIx+csQL43a1a9exgQG6S+Gl/ajJBW7vdt9KbyiSZsp2QMd0dDo4OZPgz1
	 3orsQ+UqmKnwBANgGr9X8TDxjFL5+MNi1wPR4Tky8DOwVydDK2SzoV2iumJjaHJijpPl9
	 vUQI3hfq3z8CYKfropuk4QfobvI4v9xUpb5N9vfIztHc9iTMDwUbAsqvTIsVmA7Z6pfNq
	 97MaYHnOQj80wPjfov5NGmdwVRM573hGZA7Iet/NX+OZF1n5tqduw8OSntpviN2HIS3vj
	 s5/gJ00zJ6OKy0ufF9MlyqNK0kPKDcYy9vGLeSpCI6AaOlbjgAndJ+9NGJzupvEJd8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJE1s6l5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D42606A321
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJE1s6l5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B211F0089F;
	Tue, 10 Nov 2026 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309839;
	bh=awBU8cjJbjLo0N/OW/+ki0TCmFV1Iq71iMHN+7SB+KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJE1s6l5bGAcCEa6qer8txQQrctyvrmjYFkIUfxstjAl3i166etKiIwNiP5Zd0LxL
	 yd08YF6LsHz8YkBbsxS9Z5VqpoGCurTb+spNaYpeEwopNylfRFHkSk9ZQbKgi6TCEz
	 FOkiidLKUqshCMGEF3SnXwxDwOR+7AL5i4J/W3oX77qDU08JlQ3EOanlATkysg+Dre
	 HnQRveXDpIIEtd/+5kjIBMKdQad3eswCW3RgGP8izr+f1wn6c+YDTau/Wrm7oXFjMz
	 zfjyqSztGBBPUnEURLfU+MBn5Y5DemAfTZFW0afA1XA7PPg71pKN1Xz5HsmuRuIXsO
	 RKO3/OMoCtMOw==
Message-ID: <sashiko-outbox-206931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] KVM: s390: selftests: Add clock comparator
 interrupt test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110111619.61760-7-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-7-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:23:58 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a test that injects a clock comparator interrupt into a ucontrol
> VM. The guest sets the clock comparator far in the future, sets the
> subclass mask, and waits with the external mask set.
>=20
> The first KVM_RUN exits with ICPT_WAIT. Inject KVM_S390_INT_CLOCK_COMP
> and run again. Check for ICPT_EXTREQ.
>=20
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111619.6176=
0-1-aaronmbr@linux.ibm.com?part=3D6

