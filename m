Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601780;
	b=EhptRsvxnol/L/3OkYEtCaA+9ofiE56f7Ek4GyzhO3/hd3wwUJqfqF9wyYt5vsE2Ftjg
	 junuTwowC1UQTKKYHU+hBwB2AJrW22G/KCbz9uJxx4Yym6m5dueBAnMFj6RUF9t4x1SHu
	 uChawkmUCSrSGLAL4wgNKJpbjfeCbgNvnMigNkzWTsxZuTtHtsw5G//PxBWza27l3BSi7
	 DeHtr7S7BDRb9wcbF/5om9HzDLRRN9Y+lUV8Yx2etoptgRWnQkrWTq4el8S+8aduPKfTM
	 MB+JFOiFy1OTnFr5yfVogOsPMpmTPvgwPpelJPKG8e3KTIFUrsgmY9ikAuhxkMAfcmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0sohZZJQ3oEruwf2BelC6dptPJfzpr9NC1SWUom8mR0=;
	b=jHB+7Go9ozhvAtRohjTqF6l2yEzL3hQGMu7WmVFNFXxvn3fKeXt6xp9d16oUSYi+WiBS
	 0lYfrFCN3xIcGolq6iJFfv5BuaAg9oqusjnLdVl/T4eRObQ47Q9jt3b8SedUI5CQLPtXI
	 +V4129ho1nF1A/jsGsZcXKOGLXiq0pcGyq+x8NbQ+qvA34cdT1BtL9rBNH48Bg7C3WaEr
	 6h5kXyR2PUNvzcaxqKpj0j1V3iDjHYBlFVarX8q8oPHzlwZ2IuhjWG25AW9NXpFU0SBu5
	 PkwiZAR/CJLTYUpwxrUnD4szBazJ/qRI9YqADcgIMAyNjYWqxSN4rhGSGuYq+kUK8tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbVxYvNB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215F606A327
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbVxYvNB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C091F000C6;
	Wed, 25 Nov 2026 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601780;
	bh=0sohZZJQ3oEruwf2BelC6dptPJfzpr9NC1SWUom8mR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbVxYvNB3kXo/Sd0l/aQ3F9l6kdzVKSdfEzxnpsIPhVWkVI2oZ78Wwz7GttRLPexA
	 umIF1+U+7/YQCK/xoRcpCWbpIWGWnCJL8Ry02fo8WfGjh/rw/X8JxfIDwzFPL2V4ch
	 z+pgr09SRBPA4k2DO2bsV5rz2Tc4eN+R55a/FUuQexJPg7KpnaJPetkcUWTDMsWHH2
	 ik0uFB2XHiTTlqdqUNCrF2/O/Ir9ZHYlEU7ohdP7bPpZ80wI5p02w4XIE5dQEtFe5K
	 Xe7FwyQz0sEUfaRcgNkv5+CXcISGKOMjFSPgu1Jhq+LPRD0dr5yprvstbDwybmK4Fh
	 Kikv2JyTfPsdw==
Message-ID: <sashiko-outbox-233100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: arm64: Stub kvm_vgic_put/load to prepare for
 kvm_vcpu_wfi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Grapentin" <gra@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
References: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:16:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In order to be able to share kvm_vcpu_wfi with arm, we need definitions
> for kvm_vgic_put and kvm_vgic_load. Add these as empty stubs now to
> reduce baggage in future series.
>=20
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-kvm_vgic_s=
tubs-v1-1-c53ca2c5959a@linux.ibm.com?part=3D1
