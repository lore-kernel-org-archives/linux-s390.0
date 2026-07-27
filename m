Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8B4248A0;
	Mon, 27 Jul 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173903; cv=none; b=AuXjel2HF3c3mFR4IfdJpxth0jxbITso89q1C2okT2RgEa32LQEaic3w35wHSte/gMw4Wx7F2V0aNulCcUBZElsznfAWSz6yK1lKlkRW+3B1oDWHAjWfHP97YSZJFL9evLqI+Onn/7n/cv1Lr6EWdtaineb/6d7bPeR6rGEhd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173903; c=relaxed/simple;
	bh=JdpIoVnRNFgCKdwVSRVJumAPOvm0E+Er2WucsLmz1tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GdW2SswWcd8LiI73c9qVdfIwlTx9DchWd217J8Uce77PZr5jrnkluJmuFpEdxib1qAaQ3wbTWq0JbG+rLf3M+SFh0FXMRCAPiIvudJiWZ9DuK0cCpCzBM73dBSxmEtaj/f0ZiVbYQ0tIOqlmgL2uuwuzi7nNNRtKZ2oJvulj5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmzh1NOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmzh1NOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9691F000E9;
	Mon, 27 Jul 2026 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785173902;
	bh=JdpIoVnRNFgCKdwVSRVJumAPOvm0E+Er2WucsLmz1tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jmzh1NOBWlMHH1ogw2jlFr2gmEFpIHkd5RI/iYW9WgdpSb6psa7mmY80V2eOU31BM
	 hkwLITRTRsRnG0WTx+FgoFWoOPTcoECn5hmzpLvRDM4GG9Xcz3Aq0kivq6VqGbBCD3
	 RTn03HQpAQ9xdtpkpFlXfOa6W+TivmfHxI2wyQ3A6TC/+q1WNwShj/Ui4pu1m7gDyt
	 W8aCiwGyfLkNDwFfuRuyFtrNNCAVD0JEFw8sJUS2bm/xNEC/0BqioqN4nHuwfxi90u
	 ldKFqpwLBSMH9wWos0xQVgidq9bYAjNgqouxLLNVvfVg4xVVJlQXPGDNy4a2wFOkvX
	 EbJcnaDW9gZWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/15] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727173239.2420754-2-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:38:21 +0000
Message-Id: <20260727173821.CC9691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D1

