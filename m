Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828059;
	b=XhorAM4TgyobaNmhu76l/7PAsPS7VcUja6OSNW2iuw/PXeC47tltL2ewPOwacVAPslCi
	 Ht/2aeE6YgKbUgY+TXG5l3+Mnqe261Ep/cq9moMFmbevvIa0hIcHk/iV0uRtXRAs+rJah
	 wm2w9pB0Ziyu/qhq8qRT+/FgMF0JpsfoodvI2tC9re79q+Qe+HNzFLK8d4TUQCEX4PTyM
	 EkIClwS1kjwvVtweXdZbsVQZ0DXg1imDkd5Vj/AsUK+rfheqt5gpXdgEgDuOKxb7pW8pa
	 jDQFiJQPPrMAcM6DnCWyxTjLdJT1KZ27CyUA+XMmBCStFAoCdb4i1ePsUZWfdOz/FDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828059;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rGhDYIQQ4T33TKbeTn57y36KaVHIeWOhulXg4Tl0TXs=;
	b=nmk9T1a8AKM3jttLmT22RdLr2w9Eyho2PusMbQYyVeGpyUhoxIknLuNeZ6WfUzG2rATT
	 +YJCjTKxyz3qoNGKh23hqQzTfrAu9IETsfQEzZV+fTklQB+7uziVATalcLTFUqz3sshqh
	 ZUvPnWccW471qK9xqZa2WxxvDGdULEdaAgodmqxhQSeLDgjt18wLApDoGHvX/ZAyvOrx/
	 sPqi9TcyB2Oe3aIKYg7olMMGeslRNULxPb4UraAp70JQTzy+hqklLf9nSd7hJH/ZnZsAc
	 usfk+NAOb2I/GMgSifCNG7K2TXwfDXK/o4zzuVxUptqECQpDmCWlpHagJ4pkVA/Xt9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4hA+dbm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD646071803;
	Mon, 16 Nov 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4hA+dbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0841F000C9;
	Mon, 16 Nov 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828059;
	bh=rGhDYIQQ4T33TKbeTn57y36KaVHIeWOhulXg4Tl0TXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4hA+dbmMwnlH1W/WrrWQplQPMug/dT3uI2EVv4hs5O+p3dmDhUvvOfyjrNr0k8vy
	 T6wbmYMiSx+XL4wMJg24R49s6PmuLmIqE3xWlmdsjKY58MogBHPwzzpTZxeq59akn7
	 LRFDY/elw1RKIJh7GUvAij0y2lR4+P595drgNgifg3Op7fsgNRtoSicFYqjpH7O1My
	 MpLssTp3nrb58MrheTdNU8DSuFSY8AZktlS8gi6jQ6460W02mUjt4bz0P2k7cEn0Ww
	 BIupThs5YtGZxQZa8J537eerAtH7w8n4hTFKu7+vkupvmrJ9AAzTw90rFTnHZwOgaD
	 8U/k27m44jjUQ==
Message-ID: <sashiko-outbox-216900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 18/44] selinux: use fc_init_pseudo() for
 selinuxfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:58 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear SB_I_NODEV
> again in sel_fill_super().
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D18

