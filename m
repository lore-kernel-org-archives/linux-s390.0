Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE41455171;
	Wed, 16 Sep 2026 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594976; cv=none; b=R8Q/t+AkBXSedbeCyVKsbBHNfftsFn/CkRNBDeneARR5PvrQNYP98pZ5VkJ/7uRetEwP4u6ZAdA8rRZnYymWmJGgIlXirs7EwAJmVVyZ6DfdDqhTWqRzgaV19kEnc+oP3FTWNdNluAg6L0W3oeBofcs9yGkziFwNi/s/ED2S3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594976; c=relaxed/simple;
	bh=pnUrmQjUYe1uYSt2VHTDwcSWqq4JFyMwMsTQ1r/A95w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xl25mpfvC+v527wBePRVGVNcIWtpb4sH+SR+8OMZomM44QvihrQvRZxb6Kayue4dZb+umhnTHxZJLQ6LnD4KVw7ZdfRitEFfpGiDGc7D2rmQKP61/XeqPR8Lhx7d2fhqNERhjSTLE7gZ5d8akGhN78eUJn5H9A8Vqs+ieuA9bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF2frp/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF2frp/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796531F000FF;
	Wed, 16 Sep 2026 21:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594963;
	bh=pnUrmQjUYe1uYSt2VHTDwcSWqq4JFyMwMsTQ1r/A95w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OF2frp/opvZCanOlg9Vx5NNxApfsXZ2cmanCzXGlFAeURUJ/pwywjtBYQWxWeJ2FC
	 eK/4XH+QrV+PgBBZkAdL8zSMt7n9NNF7BrfAWsj68O3LFqVFUkmNzoxoueMbApjS+v
	 p+J5pIS3EuQPwi2kyDSjCevfbSuWQKefPDuvpyh4KwuNE5srS38K8PatGWFajE+b3I
	 ueH9YcI/DWbHynSOLK1GJYOelOJSbHE75PxDShi92biWGFjuoygmC8N3XR3D+kUDL8
	 u25GZobHVmZduyGlBM/s8fcYYVLCvPbJuHVsunuplfv/d2n9jnBf3PxLfUd0a6VyqD
	 e94ueBhVlTosA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916213222.233-4-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:42:43 +0000
Message-Id: <20260916214243.796531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213222.233-=
1-oelghoul@linux.ibm.com?part=3D3

