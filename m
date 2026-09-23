Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FF442B2F
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149886; cv=none; b=BJ1uHX8Rjv1Ii9Zyox7RbOyIkQhjl9uXSZlAJgbRWKDpwrMZBfC5y2AwRUQ0+HnTd2dXA3s6i7DR+8boKNK7Z47X1mjw9IHGtpo1/MNK3NbZnvP1Hq44tomJ5VURRj2/th/HC/LbtrvODvoFexmkVOYexC5AfZ+IEYrPI4vOYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149886; c=relaxed/simple;
	bh=qkEuD4/Oao+ZP0iykUTLdnwtfo7JEdrFC+mmSdi6WYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r20CYH9WlQEymOCwszgIcU4x6V385y0F2ICH4dyCvrpJmXyHxlvtattmSKeWQwTEmk6Y+PE7cMsaDTxW8o7MIGTetdV30k/yNNF9rM0Y2TosdH5nIAf4wnXyk/Dm99gAvZuZ9Cs3dRjuYc82ljm0QNmgOQehG8FtBOpI9c+6up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvWAE3N5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvWAE3N5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A91F000FF;
	Wed, 23 Sep 2026 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149884;
	bh=qkEuD4/Oao+ZP0iykUTLdnwtfo7JEdrFC+mmSdi6WYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvWAE3N5vf0vpxOKGUrPULnp1YU1rDFtglZisnQrHhpvk74m7d9gvZ6+j/Um6zSdN
	 10c3PAOYm/2Ejgp9r/zVpEespELw/5bufxDo58gUjJGy10QBcEJ57L3RrjNV4oCoSF
	 mseYhhm2ldmBeToL7o31IccQ+Y5cTMU7CajsbAxQC51//5UR+9ERcWoK5QRvNz7WkG
	 Nqmjk5gFh4Qs550mHLt6WzRg4RW2zH8JRSqdpLviEP5wm87rIeqFxW9ofVE5CJ8HkY
	 n2K1ZwALnYaIqWqpelHQ8Bw5g3j8JqEBaJ4NOhRZmUjrnZbQOcObOATHF8XedFjsWu
	 QH2RtwYUA7pAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] s390/sclp: Ensure no callback gets called after
 sclp_unregister() returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260923074006.3962077-6-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
 <20260923074006.3962077-6-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:51:23 +0000
Message-Id: <20260923075124.388A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is a potential race condition between sclp_unregister()
> and sclp_dispatch_evbufs()/sclp_dispatch_state_change(). As a result,
> it is not guaranteed that the callbacks registered with sclp_register()
> will not get called one more time (and no more than one) after
> sclp_unregister() returns.
>=20
> The basic idea is to use a single global wait queue which is woken up
> when no SCLP WRITE_EVENT_MASK and no SCLP READ_EVENT_DATA request is
> outstanding. If both are true then it is guaranteed that no sclp_register
> callback could be in-flight. Once the struct sclp_register given to
> sclp_unregister() is removed from the list sclp_reg_list, no further
> callbacks can be scheduled for the given struct sclp_register and it only
> remains to wait until the SCLP driver becomes idle.
>=20
> With this change sclp_unregister() may no longer be invoked from atomic
> context or registered callbacks. But this represents no problem because
> this is no regular use case and no driver using sclp_unregister() requires
> this at the moment and likely should not require it in the future.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923074006.3962=
077-1-egorenar@linux.ibm.com?part=3D5

