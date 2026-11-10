Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302594;
	b=5bWutOYetyyP5TSHPIn2eBtAfGpEOC80rUJRnZCT3HcfnWyEPF+4dvvRgdL3J6gkTvFp
	 DnVxMRzZPE1RjxqfoqObQuNp8kJGDHTfA9M7XSYLBnBCWS5bppTA1hC1KwnncLWasoPcN
	 h5+Azvh0YysWk3+HcnwOKgWEud+gEEsRsGPi0sRunu4ttJI0scHQOeAKZEIJq3LUEG7ak
	 m/qVWzazPFMKgSl7F6ArZ5XQTWOa5SC8sDlAzjaVOIRk7nwAFdqAr2FrVWPVh6TZWsSwJ
	 KRjCRfqJhviaBl+H2+ZB4SYwaXcCJo9eDmXuecG01XiJ4i144RD7mqcZFAXLWeMwwUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G2z074UsAFZxr+HfcAhYGOZfjon3rq52QlpGgeJnY/I=;
	b=iJjRCpAw+SpZojIekKNtfTwlDDHcH8kNfMM6B6mVHaV5Yy0396n7gmo4k+M4WsM9bCNM
	 WT/3GtNz07folL0Cm4jh7O1G/Djtsvw/3vKpR1bTG9We4Q+ko9VA6PC7sXqYBkVVfuCLp
	 OeZn9fPZkURq8HCJTGhAu/NAAVNShnWz8+8hAIqfDxLWLtFRLJIQMA57LBAEInupZX7sY
	 QvLolu1S/AFVLcsI9UX3NWF/xzjyav9XcVpqdXnxjUK7dpiPa/Q/TNmZyHuBI/0HWt/Ud
	 Wr7WizjkIj9ne9QTxKZTttKfX6Vi0uCzqYvUcdwfcezhBSvopNcp49c3UN1pzz+/f5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ea9Vcf9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F999606A904;
	Tue, 10 Nov 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ea9Vcf9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DE21F0089F;
	Tue, 10 Nov 2026 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302593;
	bh=G2z074UsAFZxr+HfcAhYGOZfjon3rq52QlpGgeJnY/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ea9Vcf9AKF2EW6lTcAGsexJBN7/FzoAU4GsH/dBHuvrhDlkXwjIVptcqoBuYF+uiv
	 xwc6zl0SRH5g9q3BMNth/ITVQCixeG9xSENKwXMrf8FVPT+BVtSW4+052n95V4mLqk
	 19aYw04GW8v7D5vzqkNv0vHhPfY4vGEBtc9WT1zDSPPvgbzhNSanY/3v64wSc+t2VW
	 Og/4Xc7IscbOXRt8UEp3EMCot2ZyL/lBNWFGsuPHT/pKGhUFJv6Z+7jSNUjW2HzHcB
	 MPJSTfKrfsZREtvK7blJgFZ+FbdQJLGhkipFHtApdtlv0fzeFiWNAgbSkr8xWR+jcY
	 vPvmrQTba4dGQ==
Message-ID: <sashiko-outbox-206722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/41] failfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-11-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-11-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:23:12 +0000
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
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D11

