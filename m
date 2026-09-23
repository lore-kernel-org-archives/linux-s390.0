Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31F53D0D7;
	Wed, 23 Sep 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177006; cv=none; b=UkoPY1GCpMkuXbctrn+2Zdnif7ESIh62GvJ7sI4HAO1lwLXrxneHqX1xXQddbrKywRy2jUWZwPjgaBlN44gXZY8itF3ZJxmNFTaYjb9SEH84CJoZEzyDetGknFAThxkLkGbFm9+spFlu6dfHZZHkw92+EGh9OrRw2fpuDZT/eU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177006; c=relaxed/simple;
	bh=rD7AgYHCxulBYcg2MpFxB27SCU8NQ7Ik1+HZl359rd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uk5e1ygr2ZG+rH+5KODw6evD6YwjnQ/wWESpjLr75jlAfUxwoavG2igoLFCQAR6OKf8BL592VkldQq6zfk9qspoqeiSa0xIV/1Gt/GtZvej4albzYcqVf/hFHTybjFF94/n9nyu282lQ4ouMoYNYqkavO7Y4iBGtgINQ4w9YNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0C5Rct7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0C5Rct7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632AB1F00893;
	Wed, 23 Sep 2026 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177004;
	bh=rD7AgYHCxulBYcg2MpFxB27SCU8NQ7Ik1+HZl359rd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0C5Rct7y4Afdr6x7t4KCfV9hA+p4pEkiB0Ut/xLFa0YccfTtUCsvorUqbO5KUlCG
	 NCZzuJ4onWidQRwlueOrTa7UbuhQKCHpzi7y5t1htpA5fH6u07mTRkbRbBF/TO/ST6
	 rrn00TIgdUi4doiNtN0ZfmGfJw5VuzGr20EP7c09OUpV9WxgKmQPqpZaVPSWc/vGuf
	 +OcYAIsQenNLwMJ7K600LS8l1WxC9b1sQ5BnrWJaDPs7PPmzirIh2YOIiF9G++sulk
	 8CqsV5out+CVf8kgCnnUF7tReSzZ4p/2Y6GN7KsK0TQbpLF8w1cWd0KQFHyWH9xl4l
	 jY3vseUr2PXUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/14] KVM: arm64: Propagate EHWPOISON in
 kvm_s2_fault_pin_pfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260923-kvm-arm-prefault-v4-8-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-8-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:23:23 +0000
Message-Id: <20260923152324.632AB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently kvm_s2_fault_pin_pfn() handles a poisoned page directly by
> sending a SIGBUS signal itself.
>=20
> This is an odd place to do it, the caller should decide what to do with
> errors, so move the handling to the sole caller, user_mem_abort().
>=20
> This lays the foundation for stage 2 pre-faulting which, arising from a
> synthetic fault, should not send a signal.
>=20
> In order to do so, check to see if user_mem_abort()'s caller has set resu=
lt
> - i.e. whether it wants to be informed about the outcome of the fault
> handling.
>=20
> If it does, then it is implied that it should handle the -EHWPOISON error
> itself. This is the case for pre-faulting.
>=20
> Otherwise this is real hardware, so send the signal.
>=20
> No functional change intended.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D8

