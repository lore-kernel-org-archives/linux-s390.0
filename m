Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72D3DB322;
	Tue, 30 Jun 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839503; cv=none; b=WZQCzyxGzij3YFqTIf3vAqrRBnNzfEISKdZu0+v3nKGi4AC8wkfIHNd9UqVwzhBWEJWOCgohc9Vgqj09oexASkFKofx2/KiwQm41DxWxKcfAe4zzJtjANW5iLLsvqJFnCk8tUCeM3Sp/vZuVoyzxbcHOoZ9maN5o4sq71JPHzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839503; c=relaxed/simple;
	bh=R80k4gZ7GNKO2zCHQ2y1lNcYkBM/9tKFIFs28C6arWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nYS0o0siO/JciJ15rs/aA4p2KMqGJfkURf227CwIqYBI3stdJQj1egFZ5yRC4OW+WdB5aP12xpU6iOpPiQdCKrErVFuubhMjcuWwcMdveuBSQtovfV59LnvcKe6cxL2zOCK6KUmNaJUyp08a3vBjdIuH5ke3kh3XHMABqeU5rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFEPrBlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFEPrBlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08131F000E9;
	Tue, 30 Jun 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839502;
	bh=BJ9yAP4+ZitHC+Lq6dA1jUXBybjIRdhHhZFi/oc0FCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFEPrBlSBCbPEg6HyoOLMChHAUMEcUOU051pbayhbfe3PyB9o/ltaS9Ls+tGEMt1K
	 87C284ypOJst1okE/r/IHP1ZGnAI5LixpQTRVqoQCXTVW8ZyaeDOfQ6OP03MiF9XOc
	 p0B+VcXEX9E19ahTJ0+eQD60gWWv38BxIYydf2v9QMEifcmbLWxLjAsjev359pZvRm
	 NGialaeO+VXEyk+JtaOhBB3J9F3d5/Gprsy49S00OS1YpCpeZkLDFqvwhjTmcr3fWD
	 c68V5jgDTL/mvOpxesoqn5CBbkxIKiM5MztyfyIGXgaWIFrT5NKWUcLkVNLPM5S43S
	 Th4LNrUUgpMxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 1/3] s390/pci: Store PCI error information for
 passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260630165553.725-2-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:11:41 +0000
Message-Id: <20260630171141.F08131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
>=20
> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depe=
nd
> on struct kvm_zdev.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630165553.725-=
1-alifm@linux.ibm.com?part=3D1

