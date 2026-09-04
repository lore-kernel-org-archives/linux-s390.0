Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480373803E9;
	Fri,  4 Sep 2026 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562167; cv=none; b=O7HMJj9pwYe9R2bOQLlo8RJVobbDrPCHAtZyimDidmmCMyXVkZM5DGkBdV3Q/1wpcshQ2UzbMeeI+bOoLzWox9bRhGyi2OhITLeGn4fO3N2T9B/Ek3qRjd9dShV6qNTdH7fdcm6zApqt7yKD6B152ISN33oibmO2lxAq2rVY9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562167; c=relaxed/simple;
	bh=cJs6coi5TcDUZZtSs08UxWsBjTL9Qz0OP34yjosBe84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s22p2LEbKCp9xgCat28mxKXe1evOO1CkOYLX3NMKkOjd+VyfjDHD7kncNEl+E1T+OxREGSkj5D9RffCwSa1D7WPF6WMFQ9ao1/pHg2WxQqGcjkFAtTLnlfDpv7yN5ItbQtpENcjjDubzjV7unZtDJV9e4wvmfzashxIG17nQ9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3R5EtRy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3R5EtRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816371F00A3D;
	Fri,  4 Sep 2026 22:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562165;
	bh=cJs6coi5TcDUZZtSs08UxWsBjTL9Qz0OP34yjosBe84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3R5EtRynhsUlxVBLbLEHMY2R40dktyKNjvAvucx2HtJVHLqCe6b0/E6zUBmiTORI
	 GVrGncKNJ4l2OJ4dS2sIT37j9YsYDlJ9Ugtcrdqz6+PgZ32WHassbIKkPeg6GipOS9
	 ZxLXmGp8KbhNyJTahXQsfFzsCEKA+FlJag/MQO48bPc45zkREn6qPZwSBpr1qiQ6Sv
	 jIblC/uVOCxpREWTW6i9Dy6Uf9oH3BYSBRax2bnXbGmGh3U3R2sHDjUyeSQc/pFalr
	 OVchaNRiWBE22g2qRbCjL2reOs3GrqVK36qo7rZ99PJcOFEsiDDyA9EapS92NX+7OV
	 A7t1PP1myXseA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260904223531.1611088-4-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:49:25 +0000
Message-Id: <20260904224925.816371F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>=20
> The apq_reset_check() worker polls ap_tapq() in a while(true)
> loop waiting for a queue reset to complete. When ap_tapq()
> returns AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
> apq_status_check() returns -EBUSY and the loop continues after
> sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on
> how many times the loop iterates, so if the hardware
> continuously returns a busy response the worker runs
> indefinitely.
>=20
> This is particularly harmful because several callers of
> vfio_ap_mdev_reset_queue() - such as vfio_ap_mdev_reset_queues(),
> vfio_ap_mdev_reset_qlist() and vfio_ap_mdev_remove_queue() -
> call flush_work() on the queue's reset_work while holding one
> [ ... ]
> status->async =3D=3D 0
>=20
> Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue =
reset to complete")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904223531.1611=
088-1-akrowiak@linux.ibm.com?part=3D3

