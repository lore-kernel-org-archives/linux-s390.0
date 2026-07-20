Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D283876D6;
	Mon, 20 Jul 2026 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587661; cv=none; b=HN4y+YstGdiDswZyO6yB/GdUu4BrFH3PSxf7q+2/+vVyLN0C7AoYLQAndP5/Ir/sEZeUO7oegn5kmX72KqPawE7PxDI4eePW6cMkkxrIMQxK0d4d5s7nmD9VGGHOjrq7IUbWXbrpG1Bqf34R0XdwPxL+2JxF1l0vTb5BJqpvOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587661; c=relaxed/simple;
	bh=Qxa1+ldklZoGLNmC/qHWuT6LDJ3BxHjS4Dv9RZRNXKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rnu1+7kxf6fzrsau0bvJqNdfAk7r3bxOwAKHzGkwt+DVx2IAs3oM8Wj3VKZRKc5VPxBVBfGuS5GFvZLhQzFH5ahUVqeJqRSD/UpoYrJtF3A/GhX3NQaXUwOwh0LvOV18qcnLJxl8QFPYgxGxm3qfhCFQITQoWMekUH/v6w5+dUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdfKxEqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdfKxEqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4EF1F000E9;
	Mon, 20 Jul 2026 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784587660;
	bh=MaPbZDG0DyDLxGcixhneyn4PwsN9GBynbLBg18wm2VE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdfKxEqgPvWvKoE9CrCk1fN0FWPplp//OG9n6eHL//WZpiuyLh0bN1x82qM6zoQWr
	 4AQBvHzvrWuUUjzQYTZwfhsFWgNP34QPcLx3TP1ibHR8TO3gsijH8Gy0xmhbPg9lcN
	 H7TQHIDq9xQzc/ZTt0sv87CZ5mj+J9zuP8QukirVOG/3syusWVTw9bNPhX0kUo4xiW
	 2OxSiDrYCd0SwZCQB3neCExFsh3MV8uzfyAoBgrs+VKdRTtGE76vJI7JcLRskZvH2o
	 rOIYlZTJfe/VbMVuaI75p2XlhXaLCwYOO5gg98YWQ/b9HjuRb59hMxf6O+PQuClEXy
	 QPFm9Ws6OnrcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaehoon Kim" <jhkim@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260720222238.1576-1-jhkim@linux.ibm.com>
References: <20260720222238.1576-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 22:47:39 +0000
Message-Id: <20260720224740.0A4EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] UAPI breakage: `kvm_s390_adapter_map` returns success for file-bac=
ked memory without recording the mapping, causing `kvm_s390_adapter_unmap` =
to fail with `-ENOENT`.
--

--- Patch [1]: [PATCH v1] KVM: s390: Fall back to short-term pinning in MAP=
 ioctl ---
commit a05b3db94a2a5dc18d9aa3a80842bcd850efd72d
Author: Jaehoon Kim <jhkim@linux.ibm.com>

KVM: s390: Fall back to short-term pinning in MAP ioctl

This commit adds a fallback to short-term pinning in kvm_s390_adapter_map()
when FOLL_LONGTERM pinning fails, such as for file-backed memory. If the
short-term pin succeeds, it unpins the page and returns success so the
non-atomic irqfd path can handle interrupt injection.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..4b68e0cb51f6e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2520,8 +2520,19 @@ static int kvm_s390_adapter_map(struct kvm *kvm, u=
nsigned int id, __u64 addr)
>  	map->addr =3D host_addr;
>  	map->page =3D pin_map_page(kvm, host_addr, FOLL_LONGTERM);
>  	if (!map->page) {
> -		ret =3D -EINVAL;
> -		goto out;
> +		/*
> +		 * Long-term pinning may fail for memory types such as file-backed
> +		 * memory. Check whether short-term pinning is possible so that the
> +		 * non-atomic irqfd path can handle interrupt injection.
> +		 */
> +		map->page =3D pin_map_page(kvm, host_addr, 0);
> +		if (!map->page) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		unpin_user_page(map->page);
> +		kfree(map);
> +		return 0;

[Severity: High]
Does returning 0 here break UAPI symmetry?

Since the function returns success without adding the mapping to the
adapter->maps list, a later call to kvm_s390_adapter_unmap() for this
successfully mapped address will fail to find it and return -ENOENT:

arch/s390/kvm/interrupt.c:kvm_s390_adapter_unmap() {
    ...
	spin_lock_irqsave(&adapter->maps_lock, flags);
	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
		if (map->guest_addr =3D=3D addr) {
			found =3D true;
			...
		}
	}
	spin_unlock_irqrestore(&adapter->maps_lock, flags);

	return found ? 0 : -ENOENT;
}

Could this cause userspace hypervisors like QEMU to abort or fail device
cleanup and migration when the unmap ioctl unexpectedly fails?

>  	}
>  	spin_lock_irqsave(&adapter->maps_lock, flags);
>  	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720222238.1576=
-1-jhkim@linux.ibm.com?part=3D1
