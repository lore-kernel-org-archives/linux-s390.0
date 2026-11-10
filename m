Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309954;
	b=x3u8hffknRuEueiPTU9whd7+1+zI6SdXTmZlPYdwpNMfxatkEYHOYtOq5uk/oS+LoCbC
	 LIVfoc59zJp3w3ABhniRY7NsmxlCSxUFMAID3HP+4au7z4SDMqx/jwq97MwTd1ampyn40
	 HupBG7nBq9kdKIWPw2Gn3No9jVQKemJnRKdVgje+xt3IgU/QIhqXGxMrt4wndezLvfa7k
	 qEV+s41Mev6PEN4rgZH+t4hz4zwYBVKtUR0xQS50czqPnTPGJbVYsuMPPpy/D39LKb+29
	 MMYjbca6D6Fz0tA1XfSHyUd2kDDA2mJaZ+865M6VJcHutwbgKmA8xviLiu1eTNLNecw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sGnWgw/cZWbXXFi8O5qXa90WnFwI7pnxsD88IMJrqlU=;
	b=j/vu7u4di46zSC/SEZuwZQanxTRi+SZRINfkwZwUhTRzJTfdkHGaghzoQFvmxtxrad9Y
	 z6cIvIgM1KfQ3U/G+08jtwD9E1NhqKpHN56s83V3lLqBA9xXKyagkHj0B4LxF4aofQy76
	 r8/y7gWCiWoW5kWcry5DE1HzHn9Q3z5DioA5ldXm/F18f+UYqduVDZMz2IwcuzXmOiyXn
	 JwYtNFB6MvDXG/Xsil81lz/8c0sRNC2gy8o6e4tHO8ftWG9O12Zd9v1d4OK/NAVqkjd13
	 M2iBOdn053g72Zxf2yofdICoNe5sIBvvQ+oYLL+5qflM+QlgCbOr25bGaEgXQ8XpXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLIKLtAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52D606A33D
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLIKLtAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D735C1F008A3;
	Tue, 10 Nov 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309954;
	bh=sGnWgw/cZWbXXFi8O5qXa90WnFwI7pnxsD88IMJrqlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLIKLtAaSnDCzj9lWAj3VLJI6JKtH0NrN1GoYEHwnYiUkiALbC6u7AK+RHz1nwJKn
	 hn+jX3SF7nbNRcFRPQndaVVET7LWBrcPELYduT9go8vwMciQ2Lbp88ZjUMOQKt4DDW
	 6DLCcx5oZ+pEXHzRZi108tMqETkL1UXfMuwe1hezHKCPeugAL3yJ53dIZTszpW8vdO
	 jzQlf8Rx5MisRh9ZcP1QHcUtzcKg0ItLLYWgUNUI5GDBJ8cOhy1M3JUO/G7ka2P/Is
	 PIxyCeQJLzjTKbdOuHeu1RiXwOdVi42ctKCtbiKpYkyzJJpdrcj01sEpXbtZoY+dqt
	 yFEVJ530JHRpA==
Message-ID: <sashiko-outbox-206936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] KVM: s390: selftests: Add ucontrol storage key and
 immediate exit tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110111619.61760-6-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-6-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:25:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add two more ucontrol tests:
>=20
> - Storage key: the guest executes SSKE. Check for ICPT_KSS and the key
>   in the guest register. Skip if CPUSTAT_KSS is not set, as the
>   intercept is not generated then.
> - Immediate exit: set immediate_exit and a marker register before
>   KVM_RUN. Check for EINTR, exit_reason KVM_EXIT_UNKNOWN, and that the
>   marker is unchanged.
>=20
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111619.6176=
0-1-aaronmbr@linux.ibm.com?part=3D5

