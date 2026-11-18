Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036291;
	b=PPrJFp4PmzzVqlzajQ7JrP2q6Z5gK/tsrJWYJxIdVpgWpgBGeL6i9Qcw+Dd6bWOLMUPG
	 q0ELpA4yx+jy+MCFN/dWkcqs6joWjaS9vwyq3Vr5t7RHmcJqfR7F8pf1nQ8D0VKE85JEE
	 mNyICAKMCgUrrGqQ/+Ue3eW6NGx19tforoQdnJUr8JR6mc7R6MAGqN3lEGMG6QZdZnZ4V
	 aNV7PcT/x8OniEhVETwYN/Xec1EkXyCyGx5vE1llc+ks/aPZwNOV30uzwL8ihhsTBmow+
	 9GzQVtVUsQOfEpE6I5Y4q+z8IfYHYD0gYd8cofrz+5A2z1Qa297iHg0seO28SLyTzUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036291;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=fYW7C7ZSeq/hMphn21Jk8+ekBniTzrghgjy5BvzP2bc=;
	b=oicOzF982iduLj8rp6ItNpy+uzf6Cf0C31wGonA4chp+Xc8yYoh2OcQ7tWLdCZ1taD9Y
	 woW2dnxvKRXGXBLvvjrXYP23H4mKwQEVwRPzPG9iUlhpLBhq/9hJk58BRABpSpNJ610mp
	 dHjXIWAEo3GbyGPgWla3bxhz5lOuhd0x/paQGdvN13DOrbfI8XvDsupJYLRpdoSmCdG3/
	 n9FTiVUvJF1V9F9TcIxGcXdou+KfPzokhehxjGAWg12RLGbkDnhxEH8jnai/xDQwGFFOm
	 UYd2CYvpxrN/TnFR1L+lSTuz4O3uzqBDo5FtTbbE4hlvRmFEGMV+yo+iV524PdL9rQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuXqBQo9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42D606A336;
	Wed, 18 Nov 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuXqBQo9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4625B1F000C4;
	Wed, 18 Nov 2026 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036290;
	bh=fYW7C7ZSeq/hMphn21Jk8+ekBniTzrghgjy5BvzP2bc=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=kuXqBQo9E+h9GfS4TOHEmqgk/yUMmLyRthOV87kyoVvVOAzwMpnvqD7A1XkucwxwG
	 +Vl7bpZlxX0JE1vzCQVuNBvbZMaKuIBAvlXTPAUK/GTa7v0LsXaOQ5W64VpbC1VuJl
	 uqJ8OInlapAXmctcRxyW0008D6Xzwyp9lCFH5W/hdRpNqLETcSMRWepnBuLx7zwxxU
	 Sylw1ch5ITJRoQmWb3zw4zYMMrzwKyJn/UZhs2/85dIxkfhwlxjTdBpT9dCJJryN21
	 FmmGw4YgDxUh6xSvFjYiQgrHT7xeYbJw48awVnPj+qHidKGuRNABBugA/RDx9fw+YY
	 xy76njp+TsmiA==
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
Date: Wed, 18 Nov 2026 22:11:20 +0100
Message-Id: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook"
 <kees@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Nayna Jain"
 <nayna@linux.ibm.com>, "Srish Srinivasan" <ssrish@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Juergen Gross"
 <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Zhongqiu Han"
 <zhongqiu.han@oss.qualcomm.com>, "Alexander Aring" <aahringo@redhat.com>,
 "Felix Kuehling" <felix.kuehling@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Sumanth Korikkar" <sumanthk@linux.ibm.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 <driver-core@lists.linux.dev>, <llvm@lists.linux.dev>,
 <linux-hardening@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-sh@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <gfs2@lists.linux.dev>, <xen-devel@lists.xenproject.org>,
 <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Ian Rogers" <irogers@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of
 struct kobj_type::release
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-10-irogers@google.com>
In-Reply-To: <20261108223913.3624571-10-irogers@google.com>

On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
>  static const struct kobj_type cpuregs_kobj_type =3D {
> +	/*
> +	 * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> +	 * cpuid_cpu_offline() only calls kobject_del().
> +	 */

All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but t=
hat doesn=E2=80=99t
distinguish cases with broken lifetime management from those where the stor=
age
remains valid despite the API misuse.

For example:

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index ab14079d1c42..0847134a1391 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops =
=3D {
>  };
> =20
>  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> +	/*
> +	 * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> +	 * rather than freed individually by kobject_put().
> +	 */
> +	.release =3D NULL,

Being embedded in another structure doesn't explain what guarantees that th=
e
enclosing allocation outlives the kobject=E2=80=99s final cleanup.

Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make t=
hat distinction
explicit? For broken cases, describe the lifetime problem and mark it as ne=
eding
a follow-up fix. For cases where the lifetime is safe, explain what guarant=
ees
that safety, while acknowledging that omitting release() still violates the
documented API contract.

Also, do you plan to follow up on those cases?

Thanks,
Danilo
