Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBA3B05BD;
	Wed, 29 Jul 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339787; cv=none; b=NexslTJk0HWua8YLl16qohSoqdmX0n+1BYPxae+a0pkCgDEDGb5Jl+J6sw2bXoe2ZcXDgB3RrYSlkw48rqmhAnodzGCVyTecKCY8Aaop/fLRtI1J0D5W4MfwEG2452txrlGVqynKEDZEoQIW2hGLYS6Ks5HWBGdE27Kvj7xBDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339787; c=relaxed/simple;
	bh=QYyTiTL3cmCaXqeN9lRvAW+m6isPuPbQh02g0mUJrFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=luaDR1iuFjhLZ8HYBEHs/1gH4hDeRtACt6LPCDP0U2ZRMS4DrjKyr5BoTLmgD+u0lOehSZc2miusM5PqTXK6x4fjJAenw4l/t2mKmdfNLn4jtbs4LwwXgwHVDoFjQCoygnCZGaQXWH+FrSAE2xGWATFHagPfaXEoCsxgFyDirso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQMoikoP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQMoikoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9424A1F000E9;
	Wed, 29 Jul 2026 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785339785;
	bh=QYyTiTL3cmCaXqeN9lRvAW+m6isPuPbQh02g0mUJrFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQMoikoP6HN7Jf5gBhTySv+59iIz0h61yf8ijSsr8urqIWXxGbA41WkUK2wo2xlsR
	 9+w89mL/PtblwBxag5LBg5t1DMUw4VoTGMA2PR3QHqNQX4T9tRymdxZ+ja0s9AqYwF
	 nN3uTzpCAieV79zq8fiEqUX3MM9q/Hqg1sCCAo+kjUWigM38zW2XBSlvcNgSFGLBlw
	 9CoOql4PALaooINXF1XJx2j51lVpuSng48Hhm4ofKYh5jl3w+vNKwsUYL7nHL8y87R
	 fcF1zjY6Kh/KAx7I2lvJEs4mr2W51TYBllHe4s5p3PY+DqyQHmx3jc7WPEY+wEhBfq
	 FOvNoGGhlxZUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260729152938.782383-2-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:43:04 +0000
Message-Id: <20260729154305.9424A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
> kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
> has been created. The new file descriptor has not been returned yet,
> but a malicious userspace program could try to guess it.
>=20
> If a malicious userspace program manages to start the newly created vCPU
> before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
> dereference vcpu->arch.gmap and trigger a NULL pointer dereference.
>=20
> Fix this by adding a new field to struct kvm_vcpu_arch to keep track of
> the initialization status of the vCPU. Refuse to run a vCPU that is not
> fully initialized.
>=20
> Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a la=
ter point")
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D1

