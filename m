Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D941687A;
	Thu, 24 Sep 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268061; cv=none; b=DDxpUSXcuRQsTPLoomYBXGj7XJEt4VKM6u5RRvuBW6p2LL5mPJzSf1yuPfQwPteq5n7f1F5GQ0rNbGNYGaF/tgCZTKiv724iVi246hb5J/B4b0BnQyPKA6hwKahGY796zWv4p7/GxQWC4QsREB3xvd9gQZuqfgaxQluubTLN8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268061; c=relaxed/simple;
	bh=qfF9U5geyHMr0VROb6aAzOOnRVN16xKEm+3qUcSikVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JbUK/aOkLP0p63MB5iIqFumj3W6Lf/a6icq3vUUdmmkBAx7j6tqZKgNlMSvo+U25u8I1ajOLLPosb6NcOduseYQIbUX0eCLPu9SNLPWWsjuGThrv2e4X9ZS7AzbFxGBEYkBhNjUrAUtAW0l/FHeN4x/B8m3KuMeEH+IVqowMiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agyAoFWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agyAoFWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6169F1F000FF;
	Thu, 24 Sep 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268059;
	bh=qfF9U5geyHMr0VROb6aAzOOnRVN16xKEm+3qUcSikVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=agyAoFWvPpqRsgoYZ8PdisaDd4LjyLEqAa24qzhPKvwDuGzghvkuov30TnX2gmgMA
	 ZGS/+1HlaqXV6odPXFH5375M/FkpWsqqHc3ABWPpqLbm5M3HimBBOOnn4vd3jDSjdB
	 U8LJNyb5Kt4eoRd+mGW2YTpCCjgt54w9DEz4Ggut3/DW1ppIMEe/jrZkXRXNpV8EWu
	 ZE/kyNwNLtS4aATK5WF7BNI64YtzndasQVyfwTBfdCNsKL/N9dw6K/6TRXQcKA/8hc
	 lMEOYqc/rX/KjouVCdCjT/Fn5qkHYCGI7lJDMR812s2FdiJLqKvTKUkTpCHHC2+PgU
	 M8uPY/nEOMYZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/5] PCI/IOV: Make pci_lock_rescan_remove()
 reentrant and protect sriov_add_vfs/sriov_del_vfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Block" <bblock@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, intel-xe@lists.freedesktop.org, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <3e3bfc04a89459de57c4783734ff56e4ec979db0.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
 <3e3bfc04a89459de57c4783734ff56e4ec979db0.1790267348.git.bblock@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:40:58 +0000
Message-Id: <20260924164059.6169F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") and moving the lock to
> sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> or manual unbind) that calls pci_disable_sriov() directly remains
> unprotected against concurrent hotplug events. This affects any SR-IOV
> capable driver that calls pci_disable_sriov() from its .remove()
> callback (i40e, ice, mlx5, bnxt, etc.).
>=20
> On s390, platform-generated hot-unplug events for VFs can race with
> sriov_del_vfs() when a PF driver is being unloaded. The platform event
> handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> leading to double removal and list corruption.
>=20
> [ ... ]
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> [bblock@linux.ibm.com: rebase on v7.3, READ_/WRITE_ONCE changes, comments]
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790267348.gi=
t.bblock@linux.ibm.com?part=3D1

