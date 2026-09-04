Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3A41E6A3;
	Fri,  4 Sep 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502709; cv=none; b=DwB0IrRqQ17OcGCvgkz1K6rcAHM1w5mlztcLLuTZcFxP75CqfO6X+zbaMnlpZgbCqlLdj06txslVgO93OlCeFqZiQ8+u4UH1yRdTCX9Fy3+99zGsRDw0qUPymHofdxKQOynIJ9+1m01vTQ6EJKt51ViTGVoNPMMbZCNN/RcTMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502709; c=relaxed/simple;
	bh=8MwDz564E94l92x2NPlSPdShn0MQLOiPZXvjxHwq49s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YB3zArqbOsM4bDiZp5hz98FHZ208BePchhwd0vd9SqvzRFVl3hagVTjGDV5N1hRhUtQTO4lIPYdceubnsh5888rtkZncF8RozhsoPf/egMIiNjCmSlOn9cEQiOBZg9GuE/lAYzdPOxXTQGEO9rAQMlYlF8PPN6dZXhA8V14+uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbtukNSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbtukNSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B1B1F00A3E;
	Fri,  4 Sep 2026 06:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502708;
	bh=8MwDz564E94l92x2NPlSPdShn0MQLOiPZXvjxHwq49s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LbtukNSK6KiTVVDWMMI+tSJSrjicbQRKJhBw2erXH+MtwLPimabLKhltTRHkQkvqn
	 AXHhqXnXtPctWsJomBSnUKZ1EJ1JscW9ll5GUR0gkvnbb6C4yj2UVef/IZvcT/wOC/
	 LiRzz5duCKA5Ked7cz45f2XQ/iC/yjotazo2CYHGM9DjXcYuQGeI3Gl6JMHCdqLqHZ
	 Shn79chtPFam+qnxQkroaKu0b0AY2IqYVrhXsMpzoTv5hv+pEyZnUejO8TxFA4BnyF
	 eq6dAiz1wbJbAN9j2X0zBmhpKZGNlixv0gL4obNjggV61hQdM7OJ4gWq+ZSgxssXmx
	 Lbmh/3AgXkdoQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 03/11] KVM: s390: Fix _gaccess_shadow_fault()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904060647.562443-4-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:18:27 +0000
Message-Id: <20260904061828.17B1B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In some circumstances, it is possible that the page of nested guest
> memory that is being shadowed is not present at all in the parent guest
> gmap. dat_entry_walk() will not find any leaf entry and return with
> -ENOENT, which will erroneously be propagated all the way to userspace.
>=20
> Fix by manually calling gmap_link() on the memory of the nested guest
> that is being shadowed if the mapping was not already present.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D3

