Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD444A725;
	Fri, 28 Aug 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918849; cv=none; b=fEtN6kJFg5ry6/+buOOVdhgldtpcBHHPULT5kvFfnv8zdoEL4FQl/tSCEhzWXHkKDSGrK+2Ct/oIZUG2TJjFD1cmp/zNpATEZEVcwB1hYw/HISE9A2RegCgD+6/JRAA414PC2KOnKwwRymy/YX/VduKZXuayu90kM0cQiLZmOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918849; c=relaxed/simple;
	bh=jcNdlW+gVtpY7P9dY/p8/Wx9RnFvgQKVPqwCJ4E7ccE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Friwqx/qyEeH/5Q3VG0UtN3gGvdtUHWkbU25QkGChZvHrczp+Tk2QoYpDTA0hWf7Kzm747eIhJ8WSK8Cp10dO4IKIDVsxik9YokJnidCuApdDpzmMc9C+tzx8MAG7cxjo5xwnU8P039XRYI6tTTOL93nPyB3tCiuvlFo3XPAxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+9XldLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+9XldLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07121F00A3A;
	Fri, 28 Aug 2026 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787918832;
	bh=jcNdlW+gVtpY7P9dY/p8/Wx9RnFvgQKVPqwCJ4E7ccE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+9XldLGrwUWgCuN+7tnHH6rBIf2TByNbQ4Mw8cIvYDrTnJn6PzSLIZ5DSrG9Oa4o
	 xESF7+UK5yn86hwHNSCfgV2ATghnPrT6TiWaYNkIyGepXwfzAqnfykC808ARwNfwI/
	 0gWj9HE8l1I1vwY7yN35KyinURWYRHFw+q1raigfdRCvM0fG4vGv5FsEE+Fj+7fx6n
	 o3vvZxFO7rIqx9RCdukR8BOTgwrzDtVUHNAe2+0EcZrjwOofNPXeXv7c8CvyVwfcQV
	 QaCylk/hIfuY+ZUQGErzEPW/H4TVLuGOYo5QgLkFgfgayOtk4jFyPIWYsw75zMLGcZ
	 kj4iP82mWkncg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] KVM: s390: Move all code into
 s390_kvm_mmu_prepare_memory_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828115439.145885-6-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:07:11 +0000
Message-Id: <20260828120711.D07121F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move all code from s390_kvm_mmu_commit_memory_region() into
> s390_kvm_mmu_prepare_memory_region(). This allows the function to fail
> gracefully if needed. The previous behaviour was to print a warning and
> continue execution with page tables inconsistent with the memslots.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D5

