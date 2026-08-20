Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5943FD3F;
	Thu, 20 Aug 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228857; cv=none; b=QxHalXsvTnFSn83p4YPr/k/bRycW7kOa9GFQKaOYGeuNp87rnNWqDC4MAjMApcU4BDuHal4QH+QFDHI7Kza4bMUrmr4c02/wW9IK5xeMFdQ40p3BIDJk+bQyalqiF/Cuh8HtZB9Q3vSH/G+Q+vAQ1EueWFzbfZODwi+RFycps5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228857; c=relaxed/simple;
	bh=x8mFiKn5SrOKZKQA0tziXeX+HB+4v2gZYWdBAyC9AF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TU3Tpswf50Gc+Y48S7OXQLv7cUbXgAANuP1GJeWArlnO6p5ECsY9d9pD3gxiI40czCVJxYuCP8a5yXHLvCN7NdRL6NLJMGy+EPSUtSPKVaryGOBgN1pwLB6s4gti8ZMeTK5F39GUZy36OVCRygMJDXNF0iYF0T8j0v9BEoyrRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HATXjeuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HATXjeuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7621F000E9;
	Thu, 20 Aug 2026 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787228856;
	bh=x8mFiKn5SrOKZKQA0tziXeX+HB+4v2gZYWdBAyC9AF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HATXjeuj5E9QDmhVjDqLrWphl7rU0Y6NY0pqv+43JHZaEfGhtQjGWPrJOFMdg5VD0
	 8sNbZ7EWTDMeitaDOXQK1kOZpvSa2b1CvgIThCEDZaA85GxoAmHu8MJuhxT/mntvd7
	 FqsftpxA7swqxM/V9d+/IuJkSKQ629TIsPom4hoYcEFpKEYKLW3sx7JQEzZDAUQhFI
	 kzj0lrPVEKI/sdaar2CSk8qMSo2zzEqTk7/NQ4LaA1DiXinDpoKojORfb8/OmGJ0oN
	 Edg26NQu57tsesLCDJaI3xAN02CSDJBd2FtZmvfD5HMUhfFaHcMQheT8AuAAykLAQ8
	 +wwad8N3U7buA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] KVM: s390: Add opportunistic floating IRQ
 injection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260820121546.24694-4-frankja@linux.ibm.com>
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:27:35 +0000
Message-Id: <20260820122735.8E7621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Try to distribute floating IRQs which haven't been taken by a VCPU yet
> to sleeping VCPUs. This lowers the risk of floating IRQs not being
> delivered.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820121546.2469=
4-1-frankja@linux.ibm.com?part=3D3

