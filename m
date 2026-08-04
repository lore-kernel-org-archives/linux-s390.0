Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E924766BB;
	Tue,  4 Aug 2026 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861234; cv=none; b=j52yF0ynofmeUozm+Zk5rkRQC5TzHEY9U6usknfzKPT1VtTweK6+IhTTEDryiXwBtHQw4Y5LzjzxAcWVZtQAfQhCrubeqPKQrfIsZXE2I1xC6oI0j4XwSC4tL11rp3rh/0rf4sQqqdfs0S/w0/yoyrneBGjyroCao0ztCENOKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861234; c=relaxed/simple;
	bh=oV2WlieH84pex7yFr4IPHQnCiDw4nHrsc90TkJcj1i0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtwdUg0e4FfEUkyHHOT/XS1VofnTJ7mdq5cueBOAkwZt5SX7DRje95Xf8GGFOYog7u5GLWF0HuNwFBKJEn3kng2v7qk5XZn3c+0RiYmCivzdFN/70klfZGBp3dxz6WoTQbnJJMCEIdgVhx4A0dye8yn8r27MU/n7Gm9Y0lkCHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXkz7CSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXkz7CSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBED1F000E9;
	Tue,  4 Aug 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785861221;
	bh=oV2WlieH84pex7yFr4IPHQnCiDw4nHrsc90TkJcj1i0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXkz7CSAIg/dn/SYG6wZbgr+8YEM0cJ5OQjhZ/IBWzvawhjqVFTqMDZDoTspjPv58
	 vIjVUil5SghyFjCNuMUSBWrbFaeFKhU7o0Nx/YwcypD/IB0Il17jZ9IqIQ8Z9NKNiR
	 3kDWJNElV4OCW/Agyw6KPzR2IT1ycLfR9wa7XyT33erg8EjO58N4ULSODh7WY2KOJR
	 l4z3X8pHO2in9aJlORGeZd35TB6GS6yc/sB4Aq9YNaRiiU5WzPMXNNX/I25RK+sW8L
	 kbUiD6BOhRSBWDX09SD/TzL4S6L/dbduzcd4OuEPPRhPy+5Rcj8KdLItEMhgTV6syH
	 I2CuDlZKeGKdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] KVM: s390: Remove user triggerable WARN_ON
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260804162435.28617-2-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 16:33:40 +0000
Message-Id: <20260804163340.AEBED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> pin_map_page() fails legitimately whenever the userspace mapping behind
> the adapter route has gone away, e.g. when the VMM unmaps that memory.
> As this can happen without a kernel programming error, remove the
> WARN_ON.
>=20
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Cc: Douglas Freimuth <freimuth@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D1

