Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14637B032;
	Mon, 31 Aug 2026 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199595; cv=none; b=Q1j+Xy2Ki8rnW96eCBuhAUoT1GG4Mv1E5QmwRhhsgT2vZHclKohXXjRtcUOJUolVK/+maXCgsaPH+4FL9x1OXDrkUocyGQ5YdilqnQcTEO7p3aDDWwX5PtqCh1XrcKFp31bxv2arreSnoSnk9uCCz2kkM8X/HQxsVu1ChNqyet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199595; c=relaxed/simple;
	bh=AdfxzGAqokgeUrRnhRPa1dKTUeMqlFcf9DpRjKbbOpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l814UMyvoeWpb79jz27h4BBhBQ6IQc/qtTJvIfgeCd6BSlCHj4stZgHCe7vmcXXVHFyScoom4qe1cYfZSHnWCwehaCMk8ZkBC4bgr9RU31+wb1yOGha0CLE+Mtz5Y+hdrIELx68wuOWrqwrjurzPhg8fL9v4Qprp8EPnrMploUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SegB69Se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SegB69Se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34111F000E9;
	Mon, 31 Aug 2026 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199594;
	bh=AdfxzGAqokgeUrRnhRPa1dKTUeMqlFcf9DpRjKbbOpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SegB69Se8ettke/WhwzM4lPtKUZVvSQ5kwBlWLxKlWbL2AiMrw0qxqC0REDQmwSZ+
	 PAUdscT3GuTGotCqImXr3+xFM205B8hMhxPa3HAew18NgyJpCX7jmQRqTDHAo3pjDt
	 clpm2caFWjeqzSqV1hTGadokHQPvSaWIM2BoyxbuS3p4dhMrWh6uTsSnbXOfzO6Zvj
	 gkFv2xiAfJVy3URXb+UAM6YGW0a6bnxBfQDDOkXlWAUmZS9xWi9lCrHtWhTX6I+Qzk
	 qXZ8ov2JN1pVRVFQG0jMOZuhYRSXpiiWapvOQHST2P0PA7V8kA31XiHh9UrbJMmfV/
	 hlpHPGbvG4tHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/20] KVM: arm64: Refactor idreg caching into
 dedicated structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831145536.913567-2-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:06:32 +0000
Message-Id: <20260831180633.C34111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move VM-wide ID register emulation fields from struct kvm_arch into a
> new struct kvm_vm_id_regs to prepare future sharing of these fields and
> functions using them. Update all users to use the new structure. No
> functional changes.
>=20
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D1

