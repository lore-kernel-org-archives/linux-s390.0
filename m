Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782D43846D;
	Fri, 24 Jul 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901253; cv=none; b=Fhabuca5IYkEbcjK326JGKAkA+W+OG6BPJ2zbp5ZYXBZ/owAcv5+bC4GX8CFbhPNSMSe0QSZmLqfAB8kNA/A/4/zHuAMbYRb01ORU2elfWOHygVDMwL68SMFO6eugWOTnIcA6TH3UZjslpw4yuInL/POZnbI7Ka/yUPdKP5oky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901253; c=relaxed/simple;
	bh=ubJ0PsHE52aO5JChqvOjs6jRdgyo/l2UTy1gtG0sGWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z7csCysCiCju311X2SDP+JGK2q6KLX0nbT3+GNDl5N1MnwwXlDWJs2rnAmxzGMe7ukDNltb19gr4N6z8GNfaLYm81R83j/ckElMANZrz0dABWBXFJCsM/0+IiQhwlkOo8qrl/3xBO96YNmy1Z2hhauVGX0unnh3hezwqPE36sZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZdr6e1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZdr6e1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937751F000E9;
	Fri, 24 Jul 2026 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901244;
	bh=g5UP9IuYS/FDM9ySbyJ2tXFrVO8cOk5tKhKS3xTCRGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZdr6e1tb6U1oporF7LF/byAB8jN7Qr+E/df3LjWRIDFJnEFnw/uU4l25haKC7ZeM
	 Sy+esu/jQ2oQjhVjtXDHOXRbD+JHMTxqDEo4Ndxch8NlYjUgQ5dAp1GuRUrvb2uZe/
	 SFdhRjXSEzgOZ/irRdnIurOgWD5DGhlfmquwQ8Mc2p1nSELeyBIAl98q9NRIOSE9+0
	 w81nPCcoqCmOgmvhSEvUf4K3cA7mL6G3NmUVCitEQ5oF0lYfPqM+3+RRlkorK4Vj5o
	 VgCMwQZbUGAuSv3v/vIMK8DYtEVNLGCDCG31flr6pQk7kYsx4USMLXbVHOoJTxfkEV
	 g+nP3JIEl2+BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaehoon Kim" <jhkim@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260724133943.1664961-1-jhkim@linux.ibm.com>
References: <20260724133943.1664961-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 13:54:03 +0000
Message-Id: <20260724135403.937751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-triggerable WARN_ON_ONCE in adapter_indicators_set leads to =
host DoS.
--

--- Patch [1]: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP=
 ioctl ---
commit 07b3642c0ab06a5f6b361f58b4393eb785c7021c
Author: Jaehoon Kim <jhkim@linux.ibm.com>

KVM: s390: Fall back to short-term pinning in MAP ioctl

This commit modifies the KVM s390 MAP ioctl to support memory types that ca=
nnot
be long-term pinned, such as file-backed memory. It falls back to verifying
access with a short-term pin, preserving a map entry with a new pinned flag
set to false. Accesses in the interrupt fast path are updated to skip these
unpinned entries, causing them to fall back to the non-atomic path.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -2929,8 +2954,11 @@ static struct s390_map_info *get_map_info(struct s=
390_io_adapter *adapter,
>  		return NULL;
> =20
>  	list_for_each_entry(map, &adapter->maps, list) {
> -		if (map->addr =3D=3D addr)
> +		if (map->addr =3D=3D addr) {
> +			if (!map->pinned)
> +				return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but returning NULL here forces
the caller to fall back to the non-atomic path in adapter_indicators_set().

If a malicious guest or untrusted userspace configures an IRQ routing entry
with an unmapped host virtual address for summary_addr, the short-term pin
will fail:

arch/s390/kvm/interrupt.c:adapter_indicators_set() {
    ...
    summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
    if (!summary_info) {
        ...
        summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
        if (WARN_ON_ONCE(!summary_page))
            return -1;
    ...
}

Could this guest-triggerable WARN_ON_ONCE lead to a host denial of service
if panic_on_warn is enabled on the host?

Should this WARN_ON_ONCE be downgraded to a normal error return so that it
safely handles unmapped addresses?

>  			return map;
> +		}
>  	}
>  	return NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724133943.1664=
961-1-jhkim@linux.ibm.com?part=3D1
