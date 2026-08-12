Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91038474258;
	Wed, 12 Aug 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550281; cv=none; b=rnhpJFUN7DfXHYEI9IgGE38pWyiRd0o1K2c10cOEDYOZF5BbzwcYxNElWO23wB1OMTjkpNPJPwWESaiF3Vb+adj97M72yuk1VmDvKGcB6Vr0WdCYmVqljf0wBFzn4uONRzGH8DeDQmhC/pSiou3gqGSICjO/p7H4LiWD0Fywj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550281; c=relaxed/simple;
	bh=FubhYhhKv9icnuKaJxbUEk5IFttoCNH/WsW+pNFw7XE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqvWjmf70DPhk78ZNLCNcewJZ7HRf093SwTyaaPm9WZELpVdRpXTZBO18jk/ct55wlCeSDf4jAejgTVqper8HM7I/6sEwQHohlEfm4i1JXKjvIihezp3Wr2pLi5ZEllu5ZUkxFnA8dCaabRO5xaDAiaxVd5dFwllUVS8bB/rdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQO9eqBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQO9eqBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B941C1F000E9;
	Wed, 12 Aug 2026 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550276;
	bh=FubhYhhKv9icnuKaJxbUEk5IFttoCNH/WsW+pNFw7XE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQO9eqBLQ/prSckTF5+zhxoTwf/ndJF3HYREz3/DL0ozQBMkW4aZgl+BtkoF7Kaga
	 KlNn6NPSClUBtkjBfcnREhtdu8Kzxr2nsUIeiH/IEbYeFrHHDBBmW8ld9jp/BloKHb
	 T4hwjTBubjLhLp+Do31PwJJPmdNJ4Pfk+0iszByEIF1UOp/IWtHi73Dp2/tC11Wgzr
	 WSxuO2MuDIco3vEd/WTGRNIE80J28qm0uKSLp8ohIMMRRlUTmyv9povwsr1Qg7ClnF
	 /aO2RgN3MAZXHPzJLtXtyPkSbJ27g/CeH61PX1uNxGdNjddqMhAmhj1+2T7yzner1B
	 7m5h8cD0TEmoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/33] KVM: s390: Extract gmap tracing to a separate
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-13-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:57:55 +0000
Message-Id: <20260812155755.B941C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move the kvm_s390_major_guest_pfault trace event from trace.h to a new
> trace_gmap.h header. This separates gmap-specific tracing from general
> KVM/s390 tracing, preparing for code sharing between multiple KVM
> implementations.
>=20
> The trace event definition is updated to use local defines for
> parameters so that they can be replaced later with ease for when another
> KVM implementation uses these traces.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D12

