Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984720;
	b=DBe3dN6wYBuUTo59VajoR0lirYKE3I4seJn5tm5cQgSOwphhd64vvFysSEUwyc+S92sz
	 wHGAc/jXYJcDieyWT1BGtvbr9wi7WmSz1/lvi8frDyibz4iMyYTcXDEYwreycT9szQ8RG
	 +IUVhRjrrBEVfwM0hKtBv1VG4p3wMvX8bj2JREWq8pAISfwoSFBfAwafAoY1IdDf2zRMM
	 YA4JC0awHR1JdFvCmqwFvpF/A48gVs850+8oKfVzbXAUhIZuH7NogHyrIk0sSdtrBVzT0
	 +RnygGjYmOJob3o1dvCvQ0FVY8VBOFighCy6EA0Ot/OQ/NhggX+X8rY+xJ1+dFNRSjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1tyGEiyXnOl/PRQPnRa4v57aHUp66yzSf311ZlTdCi4=;
	b=sUmusp1650BFpi4qbverWiUwGjxRqF75qQWzoda7THVYkA2YOGvrOV64qCh+b2fneK+g
	 q/Pq4IGWxbpIhNiswLi04Cp5SAdR5np9wxgsB3HXM7XHxESNBPVKRyuzgMNfOGL2Bnlex
	 bB3W5H98HupxnZH8CvHiWuG3VGTTZcgvmZ453vTJkQx0YJEQfMjjJTbTQhUsvSi5hq2Ru
	 ngqpBX9XANcy8cZ09Q8b4lv9DwG8Wi8risLxY317tT9xwBJvAoAYVgts9oVgYSx9HoU7Y
	 WvJR7OqzeT61mzT6dUICKMTF3ZRP3p7uxTaSnQn9vUue7QrQOkKstodiVriGOAo5sKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbbhWjbx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B45606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbbhWjbx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5233F1F0089F;
	Fri,  6 Nov 2026 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984719;
	bh=1tyGEiyXnOl/PRQPnRa4v57aHUp66yzSf311ZlTdCi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JbbhWjbxYLHRrcwtmzi/BZNXFeAdGOJ3cjTlXZfHDTG9WWLy4VFROSRVRkeG1NH6j
	 qeMDNCgwY2Gy3wlfdAW3/wvK7zdsgUgXhcFU/PmqvZToQjgGDF4viBE67fbwOuRpyH
	 iRjybhuiZzbSA2Srbx7Ntva18nHvvBmMPQVpfjZkgTeig8ian1bqSUoWmlJYlrmch+
	 McQprvX8OD2nLXdc1AhgAnFmwf9hpG/WjxWqRz3fFE3hSKrJUZRxFYqNv0Qr+sTY+j
	 IQOYxrYuVpDPAdhynyFnSl4GNNwyIa6tprpsrRj1nydkILcP7JruxJ+uEVLneSsy/s
	 CmwaYdxlJphlQ==
Message-ID: <sashiko-outbox-201894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/23] KVM: s390: arm64: Prepare for sharing arm64
 SVE and ftr-reg code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-6-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-6-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:05:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add required SVE and feature-register definitions to the arm64 on s390
> host code. The definitions are required to be able to build shared SVE
> related code.
>=20
> No functional changes.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D6

