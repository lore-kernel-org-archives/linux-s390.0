Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793274;
	b=zgMMZKCukb8/C8dSKkE2bg6T60+R0zpCOf6lk4ACOj5Mm/ZTq2CxiA5QsJJXmxDphUAD
	 Sa19QzSsx5PWrgAR+q1fC77Q8YgfNVlvtVBfyPNLcG3NDrxgd4YiHNC1JJWOS6jhf4Ya0
	 Ih5b8E6CpBnj9SCez7x2uJdnbgRD/3VJLA17br/tBYxo+2xUvVFEFz0QPhxUSXCTPE6fx
	 KjrO2yvJdT9lQ84Gn0Ki33lrwJLLtSn0GpbkhgZjoGrZHDgMkfX3S5Ta8N9zZ1nx6/lv1
	 D5It2u2Ejv79BCj4DLbu4BUfnPzplG/k2Q98ga+/k8lDDIiJ6FuicnbLjVkexDvVcYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KOxkGtpPyvn5eZ6cyuILkNUK1NuiJf7EY4GB1rhbs20=;
	b=C1sqVv0DrgDSWz+jAq1AMb4udBscSRAh1IrF00oDD6lwO7DD3cbcQmyapmVmbGPYlGaq
	 zeEsX/mcQHyTT2cMCb/VLVjaA+Iv7wYLghFINqiSfqJ8QfHZHXCv58RGu3GqJWMakw40O
	 TKIaHb61r+AI6cvScHtPo0/ErFKBEDSC7t7P8bzyKRw8kgxXz/i6eoR2bRhLTM7nQIEGU
	 n4BjrY8TKDZbVdsm2dNBkVjrZ8rvtOPDlg6HuBWTWU688mBMhB0lkOnx5CvFnIuC1jY7k
	 t72ijI4ngLS0C8ojONQfczTQRIO7Q2xFF3M/ief8sM2OPVhi3OK1BRDEWkeD+RWwRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP5C226f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C33606B768;
	Fri, 27 Nov 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP5C226f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFC41F00925;
	Fri, 27 Nov 2026 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793274;
	bh=KOxkGtpPyvn5eZ6cyuILkNUK1NuiJf7EY4GB1rhbs20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aP5C226fgAnYxlMkFVh+JRHQgVmUQH/f84DmjZ51GwFU6+y7h2BIo6WUlrnJwsNOF
	 ESvGIBEEABi7iMG5QDdKmQ6dc/FNAvgk5lhXKphy+Pmtc4oEXTw6aqU4ixkq2gcn3V
	 qLW+G2PMfAz9hE5rqLEvrqh1lJd3kLPhclp2U7cajt0Qu+BSKY+oKlNfDsRbhKjT5J
	 EB2SWHyG0pGhM/wYNx6oMNy0qLeew6bZbBoM9n//PUueAmxAx/ZsEkP2B5c1slwLTW
	 vvPcx0wwAkgRGslHKFrUUzTHcSBvAURH611A+eXP6yo1zrcxVqWgM1k9pWqnWBumpZ
	 9WiM19oG4FMcQ==
Message-ID: <sashiko-outbox-237731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/12] KVM: s390: Do not unnecessarily drop the
 soft-dirty bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127150411.221072-11-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
 <20261127150411.221072-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:27:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: s390: unresolvable commit SHA d56cd0c0d4df in Fixes trailer
--

commit c65dbb8fcb17b43130bab25f810a7051e6e82044
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

> KVM: s390: Do not unnecessarily drop the soft-dirty bit
>
> Properly preserve the soft-dirty bit when performing unmaps or other
> similar operations.
>
> The soft-dirty bit is only cleared by gmap_sync_dirty_log(), which also
> properly marks the dirty pages as such in the dirty bitmap.
>
> The previous behaviour could lose the soft-dirty bit in some
> circumstances.
>
> Fixes: d56cd0c0d4df ("KVM: s390: Improve unmapping of large ranges")
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

[Severity: Low]
Commit sha d56cd0c0d4df in the first Fixes: trailer cannot be resolved in
the repository.  In git history, the commit with that title that introduced
_gmap_unmap_pud_fast() and _gmap_unmap_pmd_fast() is d71e7918b459 ("KVM:
s390: Improve unmapping of large ranges").  Should the trailer be updated
to:

  Fixes: d71e7918b459 ("KVM: s390: Improve unmapping of large ranges")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127150411.2210=
72-1-imbrenda@linux.ibm.com?part=3D10
