Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7A463B7B;
	Thu, 24 Sep 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267895; cv=none; b=Amgmqee2QOGIqFq0aZ5XG+/R7CfMHXVZYXVvDi2Onm3PYaYFwp6N4NrFmbk2Z5FCVVNAjEvMBRQuU1JKt6tV8CcdfMv8kAkvyRUHIuukOtyVE7S0zB4khIq2eZOviosWME2JuR6Km8S0QG/zSEKHknQpJSf2bpg/ByeQNz4pCX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267895; c=relaxed/simple;
	bh=zAV4b2NLPjwkF5B6za3u4tEcG1TK+jhFiNhQk8awmkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iYCoafqQ7hVICDQaU/Goeq9ZRteM4rGIYAoEDhhFr9fy/XyRqeUDsDEFOwKTho/jLYbcUUinLpApHmZcIcsqxqrSTbu7fp7irVNau55QwSPsfLxZiz10rx9votYbGU6oaHiBDiLpQe70WwU+0g6r5/UOK2bJ2+BKsFoqfGpT2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoxW9pBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoxW9pBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499941F000FF;
	Thu, 24 Sep 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267893;
	bh=Qk0YUqpY7jMzq883A6bxQZmXyF0o8ltW+Gu9+k2z1kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoxW9pBelCxhBVceRK3Y7omN3PeUwUZxldt6cY2drsTTIs2cpkKLb5FP/ecD5/3z7
	 O9xCvNmTh0AEsOzzHNL+ZOaQTFoBDW4WAqb+yVvxp1CJYpz9P3XWB8A4z3EHtp4iOK
	 LobhjP10soBgWp2CKgbjRZ734VDETrOt7P1PB2uhRqNJ3KPxqTVI+WwkUl1MoIvZt9
	 HPjK5F9HPWPatJ8JdYFowDA92WjhbCFPVYHnWfK1YWCB3OOxKEy4iP/FOOdEGom/zM
	 5S7b90mP9yGq+z6P2nexJ5J6BKgyryypJwerqH555XUAn6pdQTI9f4poHsu5TIUwJh
	 KNDxvM5zKBNQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/5] PCI: Fix AB-BA deadlock between device_lock and
 pci_rescan_remove_lock in remove_store
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Block" <bblock@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, intel-xe@lists.freedesktop.org, linux-s390@vger.kernel.org
In-Reply-To: <1f58bc47da3e119a0c72e721455041c18db6f3ec.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
 <1f58bc47da3e119a0c72e721455041c18db6f3ec.1790267348.git.bblock@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:38:12 +0000
Message-Id: <20260924163813.499941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> remove_store() calls pci_stop_and_remove_bus_device_locked() which
> takes pci_rescan_remove_lock first, then device_lock during driver
> release.  Meanwhile, unbind_store() takes device_lock first (via
> device_driver_detach), and the driver's .remove() callback may call
> pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().
>=20
> This creates an AB-BA deadlock:
>=20
>   CPU0 (remove_store)               CPU1 (unbind_store)
>   --------------------              --------------------
>   pci_lock_rescan_remove()
>                                     device_lock()
>                                     driver .remove()
> [ ... ]
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Tested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790267348.gi=
t.bblock@linux.ibm.com?part=3D2

