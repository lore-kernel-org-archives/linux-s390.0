Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7D35839C;
	Sat,  5 Sep 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622512; cv=none; b=SYuhqnJAIosSfA+xPOljdi2ndJnQFEPt43Jph7apm4A8PUyqde1ztNt/O1nH5FVgMA/ihoSx/AGdwKqfcwBEaprVsQ5r3lGY42oe9OrgbPStXtQihJml8H2G2mFM1VKT72bq3gAe6Mga3Qv3TFc9pW2gZ/5USyZQN9+3+t0gX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622512; c=relaxed/simple;
	bh=geOz2iVGumaikNj8W5edRR5fKYnPxIJMAaA4c/yEGVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oeDgL7iVUSXxqPiMfUtgauGdZHFrGl6wNblFqVUmz+bkOPLPChsm35aLcdcbuAklii2AVjAqA4KmClz1O1cvy12E1LspsuZzwoBhd04cSuKl8pKv59cjONOnr91qR5HxOnm9AV1zFG64WigVtdXsryZgUgYSFFOsUFBP9PBd5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpmckGa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpmckGa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCB01F00A3A;
	Sat,  5 Sep 2026 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788622509;
	bh=geOz2iVGumaikNj8W5edRR5fKYnPxIJMAaA4c/yEGVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpmckGa8dS/0S6WkPcp7GV3k0lFksklmGkkVHJuJ8ENnv18xSQIzMO3WhKsHvWscS
	 ipQxCHCa+z/XI5AXBjYPIgJFJWVTmWNljoT+QIORz6L04lo08a7pncChvwNdGe3lC8
	 lbVRjdzrZeDPaYaahN7r6iIdB3sL/6A8pN4n95jejPQiCDisKbXEJ9fum1DXulS/zr
	 swJUwmN3dR3jdiFi4KJzvo+oBxoNi24ZNhgxF78s14d5iXvrYTDCT4jMmLcu2uJAcj
	 KcflKyw51x85d5pEMFCk+S6KyT0Fi9zemL0JLtKQvzbg+Zd5vQcTPcXAhRBTXN8zXb
	 U6Oo6a46ZaO9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] virtio: synchronize callbacks during device
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, linux-input@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dmitry.torokhov@gmail.com
In-Reply-To: <20260905152059.89560-2-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 15:35:08 +0000
Message-Id: <20260905153508.AFCB01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> virtio_reset_device() promises that vq callbacks have finished when it
> returns. virtio-pci waits in vp_reset(), but other transports can return
> with a callback still running.
>=20
> Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
> waits from both PCI reset methods. Add the wait to virtio_device_shutdown=
()
> too, since it calls config->reset() directly. Keep the pre-reset call und=
er
> CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.
>=20
> Always take irq_lock in the classic virtio-ccw interrupt handler so it
> pairs with synchronize_cbs even without notification hardening. Use
> is_thinint to choose the lock: airq_info can stay allocated after a
> fallback to classic interrupts.
>=20
> The transport reset must still stop new callbacks before this wait.
>=20
> Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905152059.8956=
0-1-kmehltretter@gmail.com?part=3D1

