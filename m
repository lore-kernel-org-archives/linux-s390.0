Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAC430797;
	Wed, 12 Aug 2026 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532021; cv=none; b=V8fvX4GDPuXBZA+25NiTt6wKT4fjd5fpgZJodD10ZI/Yp88qhraQwSE9H9nN0uN+Hz979ryZH2bFYmm/UMCWo9m0wmXYqFs606PKVj3h6vRJqh4qXA9bjE+8YlrPfxjmIPPfGCJ7MH2QANKBoyVIpWQZL57ur9azVvXeNub7G4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532021; c=relaxed/simple;
	bh=8fEtzUAfF+QNZQ/9Lz0pKZnnFLfBz1dbXBIUqskHaGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qc9UxS6whHMmy2BfSV+hPohfv+ukjlHM+6wGeWgO01NlSbMjx0f4dxAxpuxgGuwqT+gIrdLN3GyZ6JBhHL5BOKRsImyUYmUNHS1dkaN+jfHu4RLTOSOkihe8PhHOKvmCBVwNXpu/JZ8Etf4To7B4x1xugRr04yysPOCXqc3lOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot0gt3QJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot0gt3QJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05141F000E9;
	Wed, 12 Aug 2026 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532020;
	bh=8fEtzUAfF+QNZQ/9Lz0pKZnnFLfBz1dbXBIUqskHaGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ot0gt3QJ+xMbj3OMmtOMGrj3zhhyyyCm4LfDJ0lcNh8+PJomkI3pYm2Ed8kk/b4kr
	 LnR1Z3XoGi6eJwjeVW4HlzP+c5OmSAizyf4/FvDXg1/lPF/Fqb7tWnN6x01XJMAstw
	 j3Ewk62rtrHV0LoV63jSes/8Qu45fVmtolUq7h6Q2tRQzw4iasDeIO5IoMUM4DslyQ
	 1yRdIKQKCxQlhKhryIZXKgu2cl10UglEyt0xmuXGSbLIY3GCeK3kiLXBpZ+59EHk8w
	 y9kDchRL1QAwG0C74EOXMjaDhXPcwVlI7fOFmV/ecM8diCpedDYYaZdAI5ZvWKYHfH
	 6h5ll8W9B3nPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] KVM: s390: Fix IRQ injection with SIGP Stop and
 Store Status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812104436.109741-7-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:53:39 +0000
Message-Id: <20260812105339.D05141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When __inject_sigp_stop() is called for a Stop and Store Status
> operation, if the vCPU is running, the interrupt is marked as pending
> and the status is stored by the thread performing the KVM_RUN IOCTL.
>=20
> If the vCPU is already stopped, the status is stored immediately.
>=20
> Storing the status means writing into userspace, which might fault, and
> __inject_sigp_stop() is called from do_inject_vcpu() which in turn is
> always called holding a spinlock, which is obviously an issue.
>=20
> Fix this by returning -EWOULDBLOCK from __inject_sigp_stop(), and
> adding a bool flag to indicate whether a store status is needed. The
> callers of do_inject_vcpu() are modified to pass the pointer to the
> bool flag; whenever a Store Status operation is needed, the callers can
> now perform it outside the spinlock.
>=20
> Opportunistically refactor kvm_s390_set_irq_state() to use
> scoped_guard() and __free().
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D6

