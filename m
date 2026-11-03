Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743282;
	b=A+nlbbpxT7/y9grg2Gfk1xOl2VicU3NNJAdfFwZDvVh2bg84nhDa6xTD3ZhIdB/0FLsC
	 oZPU9I7grvvhKT9jH10MpE9hgQLJNm7tEtIkaRLNx62lHB4UO7ihOf2+AxdIQqEBTPtr5
	 7xuyQQUyos9jjL65gAB/fCkceDvVybN+7Nj2FIG/KLL5JuT+6xKAauAs591rY4c4WiSLU
	 5LOkPdenQO1kFO3rBtnUCvvxeDkCesj2NWtyjg0XoNO4vptQC1FjkKwaF3rOVMjOpsy3s
	 CB6jeoR2eqoC7IxlS7U55RyLcFlGglcx+M/01CYx7v7JBDokIKxBEcqkinv2APWiKCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743282;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=R6uA9hX7fD85rhN6sNXcNNPGP4g4K/KhTQ6rqqOfAX0=;
	b=rwUD/tZacd8iRjT5H5CHidT5B1xGKxAx5Y0Lu7y1rh37mH74CmQVVzNR+opJgYE1tBC1
	 Acmy1rI8xY0NE4uxYEl9gmbX5ICQEJ1PVIOKkodrbLddoHPRp+deQpr2+8lWXAk7m5W40
	 tL0+iJ8t0p+mW/1T/PPsKZJmyaVfFPPTgwztQpekHSWX8cMzPcTrSpUdvzBZykMkSu7wb
	 V5p7uilW2A/hk9/qBjJNJH1b2KK+NxwIOyDfyXW8x1sUlSPJLbb8kvFh6T+ilCZKf+m5B
	 cPcUoPbnxCnS0xztf0p1nRy2YQAnE4zCvBh5Zy2+uvpt9zqqFIY3t3CL07tQyg7ESRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuKAd+2p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B2606A31B;
	Tue,  3 Nov 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuKAd+2p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5C1F000C1;
	Tue,  3 Nov 2026 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743281;
	bh=R6uA9hX7fD85rhN6sNXcNNPGP4g4K/KhTQ6rqqOfAX0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=AuKAd+2pAiWxmodz6a5kLrzOGag2dQXGCvIWfiU2SqiHPwjnt+DZeZOIZzwDoeFgW
	 f5tvI82TTyJbTTJBeMupREcEqkEJOTnvm2tcg6rR6KzI977TOiUnB4XfJblBR0m8Ko
	 3on7l/RW87okd18TkMziqprxQ9KNwBaxunuTpwN+wdELBok8svqqglFYItI7OaAie9
	 SaIAxAjUUZc0FGMB/GEzff7Fem5FCCZW2y7K8Ha9aPGJ34HwNpxMac8F2DMTukXzX4
	 NMMYmaBoHXuYiAJmGYwn0YL5KCqaN+IzO8Fe7/dimMO7SXev4BOPXOSMGcMZiQPmb5
	 yEemvUz0AwJZg==
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 23:01:15 +0100
Message-Id: <DMLWX8NY1N1N.2OMQMQCIVRR18@kernel.org>
Subject: Re: [PATCH v2 0/9] Add __must_init and require explicit
 kobj_type::release
Cc: "Kees Cook" <kees@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Zhongqiu Han" <zhongqiu.han@oss.qualcomm.com>, "Sumanth Korikkar"
 <sumanthk@linux.ibm.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, <driver-core@lists.linux.dev>,
 <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <gfs2@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>, <linux-mtd@lists.infradead.org>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Ian Rogers" <irogers@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261027223847.652884-1-irogers@google.com>
In-Reply-To: <20261027223847.652884-1-irogers@google.com>

On Tue Oct 27, 2026 at 11:38 PM CET, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to enforce that the field is explicitly initialized when an
> aggregate object is constructed, emitting -Wuninitialized-explicit-init
> (enabled by default) if the field is omitted.
>
> Following discussion at the Linux Plumbers Conference [1], patch 1 adds
> the attribute to include/linux/compiler_attributes.h as __must_init. In
> v1 it was called __require_explicit_initialization. Kees picked up that
> patch with a first seq_file user [2], and in that thread Greg suggested
> the shorter __must_init spelling, which Kees and Miguel agreed to. As
> the attribute did not land in the v7.4 merge window, Kees asked that
> this series carry the renamed attribute. The Acked-by/Reviewed-by tags
> on patch 1 were given for the original spelling; the rename is
> mechanical.

This looks ready, and I plan to pick it up through the driver-core tree wit=
h the
minor commit message correction.

>   powerpc/secvar: Add missing kobject release callback to secvar_ktype
>   sh: sq: Add missing kobject release callback to ktype_percpu_entry
>   xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type

Some ACKs would be appreciated. :)

Thanks,
Danilo
