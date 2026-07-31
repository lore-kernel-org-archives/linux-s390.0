Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5C366052;
	Fri, 31 Jul 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504004; cv=none; b=WmuiAI7pxx3MSJkVROhMtXqc1/4A3o+dV6Tz2+Fza1yIpFij3Fi1gxKN4BEE2QAZlju+o8lCyZnSyvk7UKTNmeSfV6gRZYbl8UDILfWgC5/tvc/C3t2f5KYwRGuqFN2HB8duZYq3dd/ljPCQE70iLJegP3r/FIxUjd/CFiDrLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504004; c=relaxed/simple;
	bh=n/5tyKjvc5v7+C8BzuQ1cC7H2HBg8YdZvnwMIZHluCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bcnAyeqCZGJ17E21+YlFFOqmrxLIY3DUti+0hmMRbqHg+CvJAOJ6tzDCNlZ4YLLbPBuH27/zVEEn5Bjv3cvQnb+Di6R5+wwdE7dThoFGvmzHzWffCPb10CGRlEY8znjGC62amHyO6GiNVV2apnsgpM+UFU6r/kGoCPtlG6GonsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH4Baoud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH4Baoud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173CC1F000E9;
	Fri, 31 Jul 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504003;
	bh=n/5tyKjvc5v7+C8BzuQ1cC7H2HBg8YdZvnwMIZHluCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fH4BaoudVYjjQMPxrePQ9aYiM9EM3PjDlxbBZGPK38cfjaEI4H4uFlqUdC6m79nEW
	 b3LEcPDxh2rqZlsF+7QK+v089UgVhUai1jql8Jpt0JHS/sYDj8GFJ9VR/mAtwTmfO4
	 GmLU4Eq0FDMXddLEkD3HcJwouyWQ4J0ApqenPgbb2pjLV/jlKA+uRPcePmg9S5QXVD
	 Am4ZSJYhHI5z6J5og0gO59lrxi98ppHE05d/SCrO7AD11Sc09vakAHMFrA4/QUzVAw
	 zJRyEokzulksvUU/+bP52LB+TohJBgULyZs3VS4Sn6RtiPIiTsvW8CxbqxI2S6EBG6
	 ZEQekli3cDN3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/14] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130138.173983-2-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:20:02 +0000
Message-Id: <20260731132003.173CC1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D1

