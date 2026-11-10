Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302711;
	b=radXHkn1Zk3+Xq1fat5HXSVd239sutnbbZzfi4MzNfqt2Avpg/20qPtU0i3X2Roo8dDk
	 C3UCWy+E7mprr2YvG8mWMQ+Gs44vkjxPrxUw7AWdvTEHliaBFC1vJqtewOyVVkRLYf65P
	 OsQptWeYo2iYIupuL14nDD3bVoubue37k8POpClziWaQTvZ+AMNi7dJP3rcmPqWWGbAaG
	 d3PuPRfFj5hD+Bga2Ui2nXripEe1whiP0dQQsha9quHD8nxRVhYWpfmElWFp1ZZT8ypLy
	 VJ7GTabIE+biXQIN8XSNgNU81zsr43yafiv+yPL9AsdVDJVNlasgUeFgp/nLV0n/7wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ItPltuEasUxRCSxdy/d4+WY0vn/vStB5JTwUePiGPSI=;
	b=sN05R/2qsfj6V1kY0dHJm9YvUTwGwuoMw+siqRs6HuI//2FFjNR+oc4w/njm8KVocYT1
	 dnaA5iuPZzfWHYqZwPWc/hfYrByHVYpmQNdfb0oaBlvmKZynCSYHTrShamtPK8TAfMjDO
	 asL+S7eatdG2Rygw+0O4tiJsHCUfayJ6GaeRVIuXhHaD2EBx3blAdEYn+RgVjLfXyo/4k
	 U5BQsUpVxPDv8SidECAcYCoxj4VQsHKR9Zr1nYUFAscy5bf17Kk6r9Kh0E+gG9SuIzdz6
	 eMVpOhCJGEq7ZTmdlvfSIzagcoxkGsMh1srko9Y+M1VrkptOUm1AbLJLtFo38Ly5Gqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4pu3ih0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A0606B146;
	Tue, 10 Nov 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4pu3ih0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A11F008A1;
	Tue, 10 Nov 2026 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302711;
	bh=ItPltuEasUxRCSxdy/d4+WY0vn/vStB5JTwUePiGPSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4pu3ih00SagLGxYw0ZXYjBQYDYQ4YMl6YZZtM/br20cwCfLZ+H0PO2PsA2/pywH0
	 E+3zcRc9Snyy3zbsQVeARZ+I3kN6oYkgUglNiMb6XCkBNjCTOpmL2p2quB2VajaWcz
	 FGGVjtky14cc99S29m1BfDcIeGQ77W40OTg7QNCh+Qq0Q7IirHL2OHImYMQTSHc7QB
	 dn9L+TXUESrlzqG1WWh/cAKQytlrGY726NNYrbx+pePhrzQtBbxuK1u8/l7QDUeGoX
	 faorC1b5iNZYd9USghPwoNxqdVsxY3sTW+0S510ZDhp0lXhfvm3mM2ttlK61mDVaJE
	 p3EDrc4pTfwog==
Message-ID: <sashiko-outbox-206735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/41] proc: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D6

