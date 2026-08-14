Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA12441B8;
	Fri, 14 Aug 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719050; cv=none; b=cBGk/V2Oeq4tUg9veWIkc/oUSPl75bKQxS/RwKLI/1BY571KETi3+P3IVWBJa8vx7GsmusoIPg5Zoy81xlSNHCHMHgFzInA/2AnDuFd6ZCxKJaxrmVKU8aygL/zY2MM/6VQDKh593EYEF5EmcWEPWF66ccmpzoLqJfTE1kSAtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719050; c=relaxed/simple;
	bh=eyp3Am8HMrvCYiMpc/aSLFZ1hdQJpLcfx8IMa3TtoOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pjszd6ECKTms672mesMpPOlYbUwUOMcMy1OT+i90dzsLO2nO1J44cg/BxzbwcsxLWj8enajsOVE1XpxvxbqPdEtF2CDCq2UGgT/LrMqS4rNWLGWOSbTrhCEtJfjmOUMLNonQDICt8gSt9KLFSXdP/5Z0LIhedhVFpBkPTZzyV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJeqfJzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJeqfJzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BA81F000E9;
	Fri, 14 Aug 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719043;
	bh=eyp3Am8HMrvCYiMpc/aSLFZ1hdQJpLcfx8IMa3TtoOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJeqfJzq1DKz8j9teK4hIubZd77tJJNC3JNhjqF0Dn7B7P0R0lNtfBlPWlOE7TlTQ
	 m2BEj4l2jfejbDgotR86Yk8SXHYnLugPgXxWFAnZtS5yyu9yCSmQCCxGweN8ZBJn3U
	 pL88bxEzyV3F8lb7GHB42dOb3M/XEIwoMCyl1wULm0AgEqgIXCKOK2/ZhYZtJw+aoU
	 /x2r2mGzxPXFPDe6cfsltSWJqTFyU3IfvT7W2IbwNGYrarWojgJSM+LpGqj/Vpn00j
	 aCL0ztm+Vt0OcWmxKh0bGHY9UGTjNDv6378OUj8MSVjWUT8Cxhiuny5dtPFKWpDmQw
	 wT7SCCJ5Q3lbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] KVM: s390: Move all code into
 kvm_arch_prepare_memory_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260814144041.169025-5-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
 <20260814144041.169025-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:50:42 +0000
Message-Id: <20260814145043.14BA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move all code from kvm_arch_commit_memory_region() into
> kvm_arch_prepare_memory_region(). This allows the function to fail
> gracefully if needed. The previous behaviour was to print a warning and
> continue execution with page tables incosistent with the memslots.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144041.1690=
25-1-imbrenda@linux.ibm.com?part=3D4

