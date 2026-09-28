Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDE4BB5C5;
	Mon, 28 Sep 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601537; cv=none; b=mzW3n9wr2V07jBrMjKP7liSNPH18OLHybikZaDndwrlMXxKKuQlcr57CXLYW5WluvFNevfDrrlRTHXFpjJdxBi5bWLnldkwN9G4Mp1VOzgGwc5ob/Kxj0rSjpAMuccHwS45RfcA1NXr4rtDfVLTg/m0DdRCDEZTrAuqgAKbYR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601537; c=relaxed/simple;
	bh=/LOZQxNqb5ntETP2pNwzX7wvvxo2M6NHMPIxvvvtuWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EkpVeNvgq0XvXdiXNP0syLN1J4r4ElzyNRQF/XHdufRez5Zetx7NNbuWrVJVvwBZNwI086htacbS0uAX+DJz5slr/L2yCTO3AIduoOzM5EH4s8ukoRAqZhkKqYpf9vAaqa1h3e4DCg4L9KLNrFMwb2r3PJdnLvzA9Im0nRyWUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9hFj3Lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9hFj3Lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268541F000FF;
	Mon, 28 Sep 2026 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601535;
	bh=/LOZQxNqb5ntETP2pNwzX7wvvxo2M6NHMPIxvvvtuWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9hFj3LjIxOIdrrGyQbP+9jJPEaaK3SlOXaD+DrvyRw2GMNADlBOrO0DAw5Ostetk
	 Ef1yjaVTujn85sXiVxycMn34yrUL/6nn0omfpDJpT31q+Gtdgc2Q1Qq7Gza0V5qwB7
	 KARhgnBp7lM+pru3iQJUqebDiLCQJhSF2IgDQJqol0/J4ASGjZoxInIplvHtg+0cF0
	 M3lDMgKmPTObbC4zUGAVL3XdtzGrLmfdWIsYvefJuCZ+0IuusNrdCY/gw8R3Kda0w1
	 20imPhAVry9sBoOSPkWEwZ/UeWlx1ZIDsAisBShfmLMhqgN8q+NhxSFMNuCyPFIIf/
	 /1jsnZg1jWX5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] KVM: Add file back-pointer to struct kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-2-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-2-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:18:54 +0000
Message-Id: <20260928131855.268541F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-vfio-v4-0-=
e32e226d5932@linux.ibm.com?part=3D2

