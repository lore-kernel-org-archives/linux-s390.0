Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186487;
	b=MHQeMLvXqCGQc4WTIONCR7nTdP3xCHIq4rMGevdDrSFZt63c5+0+rshiXw5ngL9Z1T0n
	 m1wZAPP26VWxKxqYrvlpKVAl3kwGksFSNutnrAdF+194sVDRzsjxKuXhX94m75DulVJcC
	 mkcepS82rsofRYwttuhFtm48l5/JSIsh3jOhGVbFybIG2VUGZASTE9thmwgly1ZnmQLTL
	 lOVDVXD3Zpl1st1PhEwu6Y9+CnR4oeIk3zrGCflsc1ZaswxC6jAp3Za6bCP85UcpgXO/8
	 R/VJDy1spXzVCTzddUyp1RSmuFbwxJNf6DhKZhqieNyXtw+NFUV8iIRlZOif6Li17dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mp4qR9ZTxhEfNC7v3xdl5OrLKCwQLieKI3zeyxWvJeQ=;
	b=TKiO4MIubNBlLBKtUDcNYKU+bv6N7q6ZvwUzIZ2f3i3aeOk+YcGoDKiSfEwY6z8f4rJX
	 OVS+pAqkO7NySBBQObTrBFNd9bC0J5QzH9ants7zrt7xZJnPffKgltE1qq6JdxW3G0vZJ
	 2BZBlq7SUn3IjFE+y/ko2DaFZKx1kWQ3GTi0GgpxfoT7s2fFIwxavhlF9TBZqh4Rlf2pH
	 Vyi9e5/niuP/seI6ItksAHN4TBkucUBXGwl4r8NN2ZauC7+/6naUnFCl2H9Cpk4r5GJAK
	 8QS30o5VxYrpG2Cj7lOx0jNshPdPjhHEpJzHfc64q19vT2+o2KHlNQNofYe0k51Cg4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5o2vLX4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4B606A31F
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5o2vLX4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0816A1F01828;
	Wed, 28 Oct 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186486;
	bh=mp4qR9ZTxhEfNC7v3xdl5OrLKCwQLieKI3zeyxWvJeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5o2vLX4oUatORAeLU8YSodm0bY3M58sRKKKIDMgRNvDkV3rMc3IwSZ4mfxHytvdV
	 N9iU7TrSTOx+QpJgjPGYHlx5k+/qWQBcYt1KYdnlAASeLVK0Z6LduKQwISN0KObu94
	 EkNmiFt/OQPbm3rPe1ZohzmhSDIfeYD5Ok1fDdYR7bDGChBtG2dQL2Z5LK3cp16DGq
	 ParbrHJN5gcbI6VJQ58K3jeFvNFC9k3Cqdtf/63J0f+/gS6AkssEQfjGSyoRPvovwt
	 y1yqJ/qJDD43PNT7oQr/tQ4UUyOxw0hpL7MIysjGUi51caG27JHr+QUS1NdwHfE8lb
	 Rm+wD/f4Kfu/w==
Message-ID: <sashiko-outbox-187794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] KVM: s390: pv: remove misleading gaddr output from
 KVM_PV_DUMP_CONFIG_STOR_STATE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028111651.66917-1-ggala@linux.ibm.com>
References: <20261028111651.66917-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:21:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> A comment in kvm_s390_pv_dmp() suggested gaddr is an output parameter
> for KVM_PV_DUMP_CONFIG_STOR_STATE, and kvm_s390_pv_dump_stor_state()
> wrote back uvcb.gaddr through the pointer accordingly.
>=20
> However, api.rst does not document that KVM_PV_DUMP_CONFIG_STOR_STATE
> writes back dump.gaddr and QEMU does not use it. Furthermore, the
> write-back would not have reached userspace in any case: dmp was passed
> by value to kvm_s390_pv_dmp() so copy_to_user() in the caller always
> copied the unmodified input gaddr, not the updated one.
>=20
> Drop the write-back and the misleading comment, and change the gaddr
> parameter of kvm_s390_pv_dump_stor_state() to u64 to reflect its
> input-only role.
>=20
> Fixes: 0460eb35b443 ("KVM: s390: Add configuration dump functionality")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028111651.6691=
7-1-ggala@linux.ibm.com?part=3D1

