Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D95013CE;
	Fri, 18 Sep 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739782; cv=none; b=fo1lzNn/ALsyMlSRWTU9BDEstGj23PdrGPEeNDyf5FW6hcgZahavh2iA7xh6hRRO7Pl65RfsJEVzd9JAysZeqplrl+KVSp19CrfdEHSp7uNPKES0iiA4n1dyYG8pUhhVRLkbG9wwv9Uq0TMUfdZVHl/iFxi6hqSogf0sgKrfecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739782; c=relaxed/simple;
	bh=LF217VCeBbJeCEsFuNcrCHaItMR9zTAMp5fE2w+/lq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PvCcjkP7Jg1kirdUi63xBWwS/zKvx+76Z2sX+ZVkMsTy4XxJBkVJJ9dE0Ayfyv6dXIfHrNHLCMnmeDyznPN5Oa9v5RdITGE+3r6CND9Q+NiMX2ab4KrAeYlOoi1rXCD1nOokMWA5tyC+qdPPn8KtigpXRLfauicGoon7Iz4SsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c39yuBGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c39yuBGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FF51F00898;
	Fri, 18 Sep 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789739781;
	bh=LF217VCeBbJeCEsFuNcrCHaItMR9zTAMp5fE2w+/lq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c39yuBGO5eKnjPk02z0+ZFaQwfAzB7XG+VnS52R5ehRCWZSDZoi5sVF9kpJQq6M3t
	 6Zv98/xxs18bSYdlmYX5EVgMlX6PUn/om4S9/JUOmqlRMXb4PqvALTO0k9sewHNEQu
	 zYywR7WPai45Ns3wAAS8IaY7DKaeof/Yc0/kqBi6r93fxdAjDPzrPxRf7ENO0hAnIC
	 57VbTdMd3e6gF8wCfB5etIuc0tkBVs0bzGeI3vcTTr724rPEYQM/23GzoBHLz31KGG
	 8dd4W5YG4thpzSEVft7vNBxx7egttxBeEnOk8HKlvU6aCeMUaC97cCbQHfKBjkKUUr
	 uxCXARHqBGEPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/29] KVM: Add file back-pointer to struct kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260918133107.1042730-3-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:56:20 +0000
Message-Id: <20260918135620.91FF51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add kvm->file as a no-reference back-pointer to the VM file in struct
> kvm. The pointer is set at VM creation time and cleared under
> WRITE_ONCE() in kvm_vm_release() before the file is freed.
> Callers storing the file must take their own reference.
>=20
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D2

