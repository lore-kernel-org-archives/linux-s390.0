Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986450;
	b=L0+eiUPmMQuxzBcJ0n/QqmbgsRB/BOna3mlf6BE9kjTLhgxY2dZTku2ViVhmfjZVnxM3
	 zwl5hCg1GsG9yY8IqcriUNJ/uNFdaeB5BeVaLBwkdIivunfE6eYgXa7OGlYnt9MQYqA1y
	 np7sEu+zqpa12QdJkTT/uBEGl7QiVXab9wCD8b5L8DJjYTlBT2oHd0F2MeniznzA4GP0Z
	 dDnplr/GOJFZfeLMmk0PJGtHMK9O18RTXbPkr5W2uS6nI7ZbzQTs/+PabNeAZjqi2huCT
	 4d/OJkssAcUjxBnA2BX+REx1Uav0sqg2QZXkUJEOYiNPO/CpDR4JyO8AdJ5iIeLhAMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LBPKg21CwMGyB/4I0SCE/WrGQblxdUgIh/5dRLjT5K8=;
	b=l7HSerEq6JmFdSrXR9gvel6jkhlSQEqW4+SvGUdvj5Q6c9Pq47C9ykB8X32k1xWSJUZi
	 mVufZsRSu19ih8Zmnv/ESJpwubQXC7dd8tQzzW+Z0rvCCtWXSXTbNaYcAx93lWHgH5MzB
	 5VHdsP9WvJzYvFB/IImOHLMpdO+o9Lz1ngYIEOOZmH+rcIs5BBTqzZO/lbUFlwfIKAfVO
	 ie+hEfQlEwsw97h3uDNfp/6XrSoZejA5P+8afVrvKgqghJGJHtmRDowfoSsLN13sczjcP
	 kvs2lk9BcMb2cRxtT8KOS00hbTWVmLnrtpVzgGZN9o/TqdBTYeaKukGaQxQw4ljB2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rh/NKZBO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B901606A338;
	Fri,  6 Nov 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rh/NKZBO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5814A1F008A1;
	Fri,  6 Nov 2026 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986449;
	bh=LBPKg21CwMGyB/4I0SCE/WrGQblxdUgIh/5dRLjT5K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rh/NKZBOnux0cWcjXKWAmL9W1mm/BKw8Kv60X0sGvdywIX7CON3sK4fzCpQwvFRR4
	 frscFuvaU+r3ehnswVFvkTJiz8oF8k75yGrvHaIoNkS4DUaeaRA6MOr4qsNMGG/9w5
	 aJrcG7l18fS8qBsyaPLG5YwCctHIzp1aR/3HhDqcGb8mcm6Ky0p7JV4jAPtAs+ia7J
	 CMVUG7uKMLYd42IpE/EFQbcB7YYHPjMFsnV1QfjcsiZkg9q2bTgZqjd1TCAgUmbw1k
	 Tf8bU72qoe1sg+OSiIEL/+fU2sE03CZ6QmyixAMJeK8huAhBg4dW+IkQJ0cOZmOblh
	 CEt2FrGKwMNrw==
Message-ID: <sashiko-outbox-201943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 1/6] KVM: s390: fix ESSA addressing exception
 injection in migration mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261106164958.431978-2-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
 <20261106164958.431978-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:34:09 +0000
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
- [Low] KVM: s390: commit message states -PGM_ADDRESSING instead of
  PGM_ADDRESSING
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] KVM: s390: missing CMMA init and page table allocation in
  handle_essa() [1]
--

commit ee014980cbe371ebff00ee828f1f5961b34040ff
Author: Gautam Gala <ggala@linux.ibm.com>

KVM: s390: fix ESSA addressing exception injection in migration mode

This commit updates dat_perform_essa() to pass DAT_WALK_ANY to
dat_entry_walk() and return PGM_ADDRESSING on walk failure, so __do_essa()
injects an addressing exception instead of silently dropping it.

>     Return -PGM_ADDRESSING on a walk failure and inject the program
>     interrupt in __do_essa() for the -PGM_ADDRESSING return value.

[Severity: Low]
This isn't a bug, but the commit message says -PGM_ADDRESSING whereas the
code returns and checks positive PGM_ADDRESSING.

> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index 856939acf012f..b252c812dcbe7 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
> @@ -1169,6 +1169,8 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, =
const int orc)
>  	entries =3D (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
> =20
>  	nappended =3D dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state,=
 &dirtied);
> +	if (nappended =3D=3D PGM_ADDRESSING)
> +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>  	vcpu->run->s.regs.gprs[r1] =3D state.val;
>  	if (nappended < 0)
>  		return 0;

[Severity: High]
This problem wasn't introduced by this patch, but can an initial ESSA
intercept arriving after migration has already started reach __do_essa()
without GMAP_FLAG_USES_CMM set or guest page tables allocated [1]?

In handle_essa(), setting GMAP_FLAG_USES_CMM and calling
gmap_allocate_all_page_tables_best_effort() only happen in the
!migration_mode branch:

arch/s390/kvm/s390/priv.c:handle_essa() {
	...
	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
		...
		if (!uses_cmm(vcpu->arch.gmap)) {
			set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
			gmap_allocate_all_page_tables_best_effort(vcpu->arch.gmap);
		}
		...
	} else {
		scoped_guard(mutex, &vcpu->kvm->slots_arch_lock)
			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
				i =3D __do_essa(vcpu, orc);
	...
}

If the guest executes its first ESSA instruction while migration_mode is
already active, dat_perform_essa() walks the gmap without allocating missing
page tables, returning an exception state and dropping the PGSTE update for
any unallocated segment.  In addition, because GMAP_FLAG_USES_CMM remains
unset on kvm->arch.gmap, kvm_s390_get_cmma_bits() sees
!uses_cmm(kvm->arch.gmap) and returns zeroed data, losing dirtied guest CMMA
attributes during live migration.

[1] https://sashiko.dev/#/bug/linux-20a07467-1a8a-41bb-8117-0f046fed9112

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164958.4319=
78-2-borntraeger@linux.ibm.com?part=3D1
