Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58607441027;
	Thu, 24 Sep 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240828; cv=none; b=ofXlvYR2p7LYHMQBjD+kY3nkm3YyIwwhZhgU+3KVuvG+1v0q+rCSlAisZz2T/yf/Pirc5bAp2RAQdTCz57atwhZOKSsb5GbyawPvYTr9eRvUkAOpATGxq5qWRrOsbGhXRVsQhZw/5nYBOh2FxvI6nUmPs9SjAE4MB3iTyXiGFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240828; c=relaxed/simple;
	bh=jg7V+B+j9I9SkLCsL4DNGJ5UpFov3dE66UTusRz3F1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cCfUbq6RGKgeJTdYJGFlXQqsGs31CeNEn5h+VycJMJbKAWMW3Z57oDGgNUvTaL6YRDCgGvBPJp5CcymyHsKkX5WqLTV7B2Gm3ye6J15Db3Ru051SiTZJH9ZQa84OZThdfiTb7UES8BkS1oU/gH9Nhize5otk15grS1Hl08rA+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBmeECAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBmeECAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEA81F000FF;
	Thu, 24 Sep 2026 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240827;
	bh=jg7V+B+j9I9SkLCsL4DNGJ5UpFov3dE66UTusRz3F1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBmeECAfxDaGtynXN03tn/79vxXEaUXjU7r0e281b0H6rr6d6uODiLfNrMB3j0J51
	 OnX26J+BkuRBXEpeCQbVn2KQIo1UKi9RbdDB+EVuSX1iVJSRbXeU2yDnsyhd4xCNEu
	 SQ9CiDafnmL6PYKsUBZEEMTdY1B+JkYHQdQZGkhNLeW1sXIfD4E68PanKIjrJj32JW
	 +GosKKGQ0AiCnD9t7/QDeQjGSuM5jJ8msfe7HBjQp9wVac2Zh5L5+FFM4F/bgiDum5
	 8qyxT69pjPIr90noqWLOpi6G2ezu2C0fH8uzfcsf9u80zmH/m+ZxG1Zg4JA1Rx5FaP
	 rB2qIpT6T3MXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KVM: Add file back-pointer to struct kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:07:06 +0000
Message-Id: <20260924090706.ACEA81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add kvm->file as a no-reference back-pointer to the VM file in struct
> kvm. The pointer is set at VM creation time and cleared under
> WRITE_ONCE() in kvm_vm_release() before the file is freed.
> Callers storing the file must take their own reference.
>=20
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-vfio-v3-0-=
4a294307797b@linux.ibm.com?part=3D2

