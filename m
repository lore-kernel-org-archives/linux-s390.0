Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB428340A7D;
	Thu, 23 Jul 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845730; cv=none; b=JFVxrY2IlvfgkMjRC9gku5zpw5hw9v6Z2ko8P2ZRlK02BZnRaKSDTxNFG1Znapzrq/oJYK+daWoR8sAXKQVsYnQ2b1VxN+BmStKFo/GIz5h5cYOoPbAldnJBQ55YNaoC61BBiFonW8oniYRhWzjXkVkvy0Ape7VnlWYJIFmqgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845730; c=relaxed/simple;
	bh=M7aCJvJVdPJroKe/h32Do1U15tqUTX6vrHfHzw+qOOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UmzC42CiTcESBC+zpZ7tMWfgnrqqhE81f7DWaOiqas9PeUSBN8Q4WWYvzc4LXReMTxyYHxNJU1YVd9+b2s/VLO1mpIgVMnRkEDtzBgWiUyECNXVtkKnGStKIUhFZbNFUv27nlo/cZNEjz2WQu/M94sPxdnYs6adVOp0Ct0ZRImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjwn0B3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjwn0B3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B61F000E9;
	Thu, 23 Jul 2026 22:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845729;
	bh=M7aCJvJVdPJroKe/h32Do1U15tqUTX6vrHfHzw+qOOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjwn0B3NYn7WYP9ro/UouALTiqgTX06Q4DzMgFDaxymHppMRD5LFIhuq1p4Zi007k
	 IffpmHBaUkan0M/eQ0JG9sCUSd5DMH1uJ5OzGgem4EAOHJJYB7CplevBrZVQ6fVi/H
	 C0LNnxkNuURBFu8QU53p0yNGJ68GHVfk9G+QzEJpFWO8OAL9+nkM3F2rJoLoWkJpQt
	 wTbXMZ5e8jrggUlr2JTrElMeuKhIhlGxSm0AXXYAs63tXSxvwzCLlXTslVYei+UzMx
	 v73l6p0ByExp7/shsOAHVPozoUKkLhg/d7edfSX/6PPNHcj/FT/IrcSXPI+Bwd4i8z
	 u/it2V4miATrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723221409.5874-5-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:28:48 +0000
Message-Id: <20260723222849.161B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The airq_iv_create() can return NULL on failure, but the return value was
> never checked. If it fails, zdev->aibv will be NULL and fail when
> dereferenced in kvm_zpci_set_airq(). Add a NULL check and free the
> previously allocated AISB bit and zdev->aisb on failure.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723221409.5874=
-1-alifm@linux.ibm.com?part=3D4

