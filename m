Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8B41686A;
	Mon,  3 Aug 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776690; cv=none; b=mtl4FbMUaun9Ciunh4pGQC65wUxwAS3HfdNEKSPCoUHD7YhCoYb+9y4XGGWsfUyjvixygL/NiIrk+RTssIifNX73NlGyvvXZ9dQ3oRCeL5XZoosijwgBwsMdjPcwS/jbfuQKKT8kkryCoPgc3vaKr/Qmj5Juii00XB9HaZCQB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776690; c=relaxed/simple;
	bh=/wSM8r8WpLmhipNM2IjMMpvcZTjsDOL31622qoMvZ3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nVucgLRkX3A9hhf30rPQkbyFgdc5GfuuyydIcs25//PV6ekT792Co8sDu7V3/4qcPYeXAYDttKbWt+V3BMjcIaiZbPGhdZonbVcucAZjo9hDF9MWKpccVmCB6VmwW1obme9b9ljPGvPzV1PHLKX//JniHVE0ovpDo80wHgokmqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF5kTklF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF5kTklF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04CF1F000E9;
	Mon,  3 Aug 2026 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776689;
	bh=/wSM8r8WpLmhipNM2IjMMpvcZTjsDOL31622qoMvZ3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZF5kTklF90cDhd6rX3g3preN1vaJvksgA42hYWTso8RpkXVauqN704WKomWH+u3y/
	 DC76eFyoS7rpZc51BzSAso5MO0B7AOp5/2Mh3Qq/U0SDZIjI7pVK411QoRuvQ/SUCY
	 u1oHBTsmwPF7xk1pDjdRufb8tGjp6iBCXwz5Nh/qbZX5BAbA4IXTM9dUwWYi+gG6Oh
	 R8wILqSKS1vNQgv0nvRvUQb1uw2UfByegDhsnBBDPcQp+SC/j7lLVqbxOE1l+3fS0k
	 pjTpuzNU3KuaIgyKYURhAAVI1uWBs9/wxRM5x7kk7bo9VGPtKO8gp/rQ2uUpAi/Tow
	 x1wbrga/NJWkA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 17/23] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803160924.236807-18-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-18-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:04:48 +0000
Message-Id: <20260803170448.D04CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>=20
> Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D17

