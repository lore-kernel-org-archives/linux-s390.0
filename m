Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993D37646A;
	Fri, 18 Sep 2026 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739129; cv=none; b=DZXu25Fse/cVevGelOMVghV2Fax+3Yl1M9Pm2jh7+XrfFMpPp2BTglHOHMlsJaZi1lQ34XlTtj7NQr6T2LktVfuS50iKHu5OBUXq1EVNk8EMlySPPfll7HRxx6eIhtaw72+ygpbC9Da90fRQR73Y7RDvZpKxubjqgyivCwGpeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739129; c=relaxed/simple;
	bh=2q7qjCjn4K7YRj9cnqp3OMYoYYe8LYQERUncOGAnZB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G48ZzxI2bsexQCtZl5wYhXXh3S/0nAysObPrkabEi365fSbmOnld9qM2c+jLVnPuXZT/fkex+TWKhWApKrtAHmjY9z+W4mSyLirGSCWNbPDsJsgZk0rPVLFZSpg7MGZOPAgf+H9bSYmgt63CsA6ZJW95o4ZG/hHZOk6BzFBFOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPa3O+VN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPa3O+VN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EC91F000FF;
	Fri, 18 Sep 2026 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789739128;
	bh=zn0TQEO+d1WdlK6go0EXVsQG7fK5+guCK+zAIvoqgmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPa3O+VNG2Mrh1FaTxZtO2JhOtasS6GDxnDaMlcMZz5v90qdbya7Fug9YvTygLYxK
	 Ew9d2x7r6wLvnr8M1Cztky6hX1leiMtfvrjv0mnnfNRA6n1k+4K47ACYE0GPoX6R7V
	 xomeCjqh6xWpqYKb32NPTvobKWIfART/5ops4dBYfNsp1F7Ze894nk/VeDoW3332aN
	 s14irmzLTHft2qMdn1ZkFokh13Ni1HMdO+BRk0oeBD77luTOU7ynPeu/VMHCnRy2bw
	 XVB6Tlei6qenFrQ9khypN/9Df5Yn7CHJNCS9k652oaNZO6ooUr5HI8JuB803MLWDjg
	 0F/o0Jw0WAMfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/29] KVM: Introduce file_to_kvm_<arch>()
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-2-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:45:27 +0000
Message-Id: <20260918134527.91EC91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: comment incorrectly documents file_to_kvm_<arch> as static inl=
ine
--

commit 75f01ce5173332e48e8ba4fd2b83b6d3584388c4
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Introduce file_to_kvm_<arch>() infrastructure

Add a macro mechanism that generates an opt-in and arch-namespaced
file_to_kvm_<arch>() to convert a file reference to a kvm object if the
file handle represents a kvm handle.

[ ... ]

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92864b6e..a1bf6d4a8f460 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1082,6 +1082,18 @@ void kvm_get_kvm(struct kvm *kvm);
>  bool kvm_get_kvm_safe(struct kvm *kvm);
>  void kvm_put_kvm(struct kvm *kvm);
>  bool file_is_kvm(struct file *file);
> +
> +/*
> + * Architectures define kvm_file_to_kvm_arch to <arch>
> + * to get a typed, arch-namespaced helper:
> + *
> + *   static inline struct kvm *file_to_kvm_<arch>(struct file *file)
         ^^^^^^^^^^^^^

[Severity: Low]
Is this comment accurate in describing the generated function as static
inline?

The code below actually declares an out-of-line exported function rather
than a static inline helper. Could this be misleading to someone reading
the header file who might assume the function is inlined and doesn't incur
function call overhead?

> + */
> +#ifdef kvm_file_to_kvm_arch
> +#define kvm_file_to_kvm_fn CONCATENATE(file_to_kvm_, kvm_file_to_kvm_arc=
h)
> +struct kvm *kvm_file_to_kvm_fn(struct file *file);
> +#endif /* kvm_file_to_kvm_arch */
> +
>  void kvm_put_kvm_no_destroy(struct kvm *kvm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D1
