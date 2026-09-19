Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1534A3BF
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779356; cv=none; b=j1r3oiTmGDDcceIdr2sFFVIcEMP4rAYGhxroOUuUNyrtbvVqo1AnT3giUFgEXp8r0ew8KtrsDXkUcmkq5KHSOpRhUP1748u8AHxFWITgIqEelXiTzyAe5Zur28k88FbThm9I1bRph+zWL5Mi3DLloGwntqHrkwuxDAUJJLxgXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779356; c=relaxed/simple;
	bh=T6CnDEK4IWoNKeP7zG8z0D5rEEGdoeCFfSEOTe1LXFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SVkQjH/+zu+DhFWtG/1pZMB+WMseVe+OqJ25yVquh75n2RwtMsQwAAj8oEq/PGhY5ygLJzvyYJi+sqHBmniLyvU2DCEJolliKPGXIy/UA7PMS/JW49Gqf3gaVb3/nfip4Lj97jveqRtrP6EviZtE2EZ4STlhNyUQBcUl1XeTMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPh6pL5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPh6pL5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE91F00898;
	Sat, 19 Sep 2026 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779348;
	bh=T6CnDEK4IWoNKeP7zG8z0D5rEEGdoeCFfSEOTe1LXFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPh6pL5lhg/yh9B2LflcasS5IVv8M2TzWHtaWaPX/nU25Gmz5vQmgSTnBIQQ6XzlT
	 xbMnfKywToAOs9jCdmjia7wqLmtM8NMNEigGL00mBJMAyFmWyVy2RU5KcxZtsL0bjr
	 y2UpLGxjLqHVDPOvOydz2OwUQQ5Ox6DXgUpzR9kXZrvtpFDYtLC83TyOY8qosjaHNr
	 ZB5AtWnr6R3RamnpRt5TDIyzDOsGKRwBL66i15bw+NRhyro8aaNyX3XxQ7ZMKGFB3I
	 iCdSnszs55Wx6msjAfDJ74oP6Fn8QB4FybmE/cvI0U4emuUP6pV66SjxHp+l3C2+Vh
	 DJbZi8Qc4a5uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/12] alpha: Define entry point for
 set_mempolicy_home_node syscall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-10-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-10-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:55:47 +0000
Message-Id: <20260919005547.E7BE91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall in
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>=20
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>=20
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D10

