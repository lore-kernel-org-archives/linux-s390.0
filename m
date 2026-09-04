Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032C422556;
	Fri,  4 Sep 2026 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502991; cv=none; b=AO0altnpw3HsWS0d3doV96+YKqlN/xphqw/wb3PPJIVm++Hja5efFP7h6/vy6Bmym7Afn6mSgnvO1nvBJAHqLf4WL36PAjoagaGjA4jON7BzRtIx32Vyk1but83IftEEpbCn8I0qSXPlKt+GlqWeBXLHuV2sNAJxyG3ki/SmwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502991; c=relaxed/simple;
	bh=RBhaHhn/FBdnfAJamfgeTWChnj93Sd2SYp5mohCYvfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEL+H6oeHSvcc6ZtuFsDqoXsbh46oTNNDM2Rph30fVQZ/Zd9uRMOH1TwxJudG4CiTp9q8BTEw+3V7deJXr/aG1ngt5DoH6jDCidhY9zn6RLucvAVyQ8m+LdLxP3+N270XJYS3gMXWf+f0nt0+FqkqdBecSsiyIA7BPGwuhkyhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsY2j3j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsY2j3j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30431F00A3E;
	Fri,  4 Sep 2026 06:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502990;
	bh=RBhaHhn/FBdnfAJamfgeTWChnj93Sd2SYp5mohCYvfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fsY2j3j7CtJIJxIc8FBKY2uwdyERCh4HDO+TSRoC7+Cu9RLLqWVlb5/ayOuHTiZU3
	 hDvshzSEWdjqx/LzGl5dQLH9Y/iaQMvuMNFJGLdHqMEgJV3kSeNNRZRpTCCx9ftZZV
	 tsE4WqIJzZ9wzVv0K3Qoi/ZUeAwK8jZ5AOuJm7C8J7PnP8MpG5RLsC0cUsfChZlIlE
	 RpqvwGDOC9AZqsZYZAbWieaEXJhP8AVWEoRdX3/7Ar4Z/51t4jPrwazwMQTPPNo99R
	 Y1HJLJOFwC7Ek6aza0bkhSAM8Z8BdQUDi+p+7YcBDurGDgLWm/To94zRDE5TTZ6vhQ
	 yTFoEHUhhuLRg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 04/11] KVM: s390: Refactor dat_set_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260904060647.562443-5-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:23:09 +0000
Message-Id: <20260904062309.A30431F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Refactor dat_set_slot(), _dat_slot_pte(), _dat_slot_crste(). Now they
> only take a struct kvm_s390_mmu_cache as priv. For dat_delete_slot(),
> mc is NULL, as no allocations should take place.
>=20
> This is needed as a prerequisite to move gmap DAT table setup from
> kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D4

