Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32F134CCF
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062867; cv=none; b=Vce/LqkrJ6/OuZg9ggBEY76Gev5Pdno+Zk2yKvB0z6BEWQZJIFDgLaT46WQEun6hBQ4MkSK3XYFPP2zAnrfRR5w2nlw6Y0YcPcCNy8E+TIx0XjUj+Wa7K0JkiUISGhUnukngn2jwJxTVmQFJ4ljXQos7DnV2PLyl/TGIM4kDmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062867; c=relaxed/simple;
	bh=g7kSV8LYQm6AYeOFVL0UiFnY39LFACwjNTof3bQbK7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pKf25QQh4Zqn2wd34r+2Q8vf3S0+T38wqKrS6OzBpEkKY/QR0STyWeDIihX8fwlfw+ssejpWJHCX0hIrKW+bEu/kgYNMiLfiuo2vDZj8vOk9tZTVHeO8+hcORdqN9vGM4XFKhUx8uxHPq4OxebipZDDp+q/xeS7kqyI5rfXAHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyWA5el0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyWA5el0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913E31F000FF;
	Tue, 22 Sep 2026 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062865;
	bh=g7kSV8LYQm6AYeOFVL0UiFnY39LFACwjNTof3bQbK7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyWA5el0m0Tg1BoZjiBjLN4L3Y9UZk5hGd3F1MfX2EfMvPyrE39M/UEJLt1wW5G6G
	 qNRMibvpv+Z7KAlsdItLVuhz/1IL+oVVAeLO7jAlyWjKHgH2KN5EJpUemRdG/NkJk9
	 4VAWWs8khNMrhOIKcAWL5mYeQqYsUYM/uSUhhEPbOUAcPdW3vIAG6r6I9XoBURRlar
	 Gp41pjAd2SJ8ArIwXDdTA6pO4P6lXdcor29rZauUPydGXAnxQyNE2HrmoRWNr1yzsB
	 nQ2XQPZ/oFLl8hi9SdO7rvdKwCsUsZ9Ijn2SoVjf3ASdtjfVKoEvpRiXPi9sd8Vm77
	 +E4r+WwFb6ohQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix UAF on lgr list traversal in
 smcr_port_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sidraya Jayagond" <sidraya@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260922073149.474762-1-sidraya@linux.ibm.com>
References: <20260922073149.474762-1-sidraya@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:41:05 +0000
Message-Id: <20260922074105.913E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> smcr_port_err() traverses smc_lgr_list.list without holding
> smc_lgr_list.lock, allowing a concurrent smc_lgr_terminate_sched()
> to free an lgr while it is still being dereferenced.
>=20
> Hold smc_lgr_list.lock across the traversal. Update
> smc_ib_gid_check() to call smcr_port_err() after releasing the lock.
>=20
> Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() p=
rocessing")
> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922073149.4747=
62-1-sidraya@linux.ibm.com?part=3D1

