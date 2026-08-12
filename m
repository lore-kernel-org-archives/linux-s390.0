Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E841A4FE;
	Wed, 12 Aug 2026 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532005; cv=none; b=HTdb8obO6dsv1qSo1YJhIHohUuUcLACs3R7G/BNOmv7VTepv4C4mq+s9skmoBLBsPAm4VOT5Xic2mag1X2oJnzu3y7AEWGsCCojd4XGwCxKTX1JlPUoWcl6/40g9bGiz2e9VLQ+QmAQ+gjsV8izjwj+0dY6UWVKK/fjdeRZGEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532005; c=relaxed/simple;
	bh=XA1YzY+XQVSuGe0wwkZKcvKzAxkFGNWPGaHWzmTXW7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ll4lhNpSGXNcRiHlM3Hd8zIj75f8tQsTs46PQq8/4a4KJiooPGKujtUzn52JBbIfhSj1zbq7jRZ/JCLb1BxMRM7JorkXLIKFXmjVgZmlu4PN0wtWlGbTA00iG+SHPHHBdBmjmB/TzrVf9PscKTlbGwzkMuXsRgsQkePepKHaYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhJaXYOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhJaXYOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC94B1F00A3D;
	Wed, 12 Aug 2026 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532004;
	bh=XA1YzY+XQVSuGe0wwkZKcvKzAxkFGNWPGaHWzmTXW7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BhJaXYOTCC0TnilEZpPi5Ef3ZlzGS8AgtHD2TLfvfFwSKkwYsW2okUiE2D1879gye
	 uinMCr/oFj75kamX40dDh/pLIUddU5ot5Pn32D3Nq5badaniIIVVzqlOpcLrODtWvb
	 3i6KterEfse6U08Nu4BSG/9Zhi6vZPmvJfm97a1L35joSB3URDHBANv7FOHLbNKpgX
	 JQafpYpmeHYRqlJZpoM09PlH4ZM1JWRidtxol3pD13CZQRotFtGVx1BIbRDpaO5PjW
	 72T2RdM1z7Oe+ydRsY72i2rTBp726iVV88Cqyg6y6KxIyQq0UDMNAnhYApx9eb4JXC
	 kjzun5rdizF4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] KVM: s390: Fix kvm_s390_clear_pv_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812104436.109741-8-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:53:23 +0000
Message-Id: <20260812105323.DC94B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> kvm_s390_clear_pv_state() needs to also clear the dumping flag, to
> allow the protected VM to be started again (as non-protected, with all
> protected state safely destroyed) after a forced reboot while a
> protected dump was ongoing and not completed.
>=20
> Fixes: e40df9efd68a ("KVM: s390: pv: clear the state without memset")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D7

