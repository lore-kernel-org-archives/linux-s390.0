Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3A3AF666;
	Fri, 18 Sep 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745546; cv=none; b=H43eTwPZzZzDucUyyvShwNI7iKejQaHVkbA+Ie12KGI61lRk49xHWkBM3qYhX57Bl+DFvvHrjLAfV8iHrfpjlYPYms7K1/5TRWj60sqtfDljay2yaVwSQfQaKs6F/iQLWshNic5iw54k+Cml6I7sVNlguNG3nerVC+92oQookvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745546; c=relaxed/simple;
	bh=uhtz4LI1xVUvngwW0qZbbE2Ym+L8aSeQ2z1tk6Fnkqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hMYVKtuLkEwyVcCBxPmPc4Cdr/oQ3FruJwLqxSAjIW/lLsEVbeag+1yn7gIdlKhmfXVgWRmQqLbd44B3ZQYfgOdg0HgOie0oP+HK0ERSMZsHIlFm7Wwqgl0HFPHt2i+NRSwj/VYoA1kPoApgGqjPyGFkPjgd059qd2MBtq1K3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWqouh8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWqouh8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC8A1F000FF;
	Fri, 18 Sep 2026 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745545;
	bh=uhtz4LI1xVUvngwW0qZbbE2Ym+L8aSeQ2z1tk6Fnkqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWqouh8RLSQukSuU7zT5hgeIhS8l2OdGJYoLUVa2r1PfHE1frO0C1pFQjKvJ1SyrZ
	 pFn3XXs8QTyB3nM1wRIsF3hIlphTsg88ji+0NTKBsrlflToqS7m4NVx8QtNqFv8EPJ
	 gkd2xd1LvPQ9vkNoY430gkDt0zKlb2u1PCF915eNyHoH+Ij88nWrCqbIAKxG5UMtI3
	 YbexLieAK3upbeFkmbkZy7xDErNXLdy8hEekuDNRSZ24UpJAoiXIKTX7CkTr+kzRe5
	 OjbzlkSodkTdR7WhVyebupSZA6EJfCyRQA4FecFN+3upx4q8/AiR4Fc+zjCELpbOuT
	 H9f8CBb3GypSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/29] KVM: arm64: Use accessor functions for core
 regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-15-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:32:24 +0000
Message-Id: <20260918153224.BDC8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of accessing the value directly use assessor function that
> abstract the actual location of the register values. Add a helper
> function to reset fpsimd registers. Enables other KVM implementations to
> reuse this code.
>=20
> No functional changes.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D14

