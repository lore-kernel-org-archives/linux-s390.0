Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662480;
	b=cEdv73HgkrECR2ts3tTtVv/1wUu9yVaHOilWTh+NfzGtVQ+hmjNj9NT3O6tMgS3KyDAT
	 86vQxSPlIHfJYY71dsztW4PpH1+ALHOBiHM76LReBv8vqtl59pw5SkvcCLXSAHCBeQqfa
	 PQ/EOmkFoOxtW1dK3rOSfRyNh3kZCV3bfFlOfqKq32cUK1V62cmXsVmQk235L3tKGNNge
	 hPH9u83DPdtVBl7hmyXAyN/p/OJkQ5awC9N6ZisB86HqSO99RV7dWTWzO/uXW87PjqHGc
	 oLLws5zq5hIzq3Vu1hQcxFXQiDIq5bLMy56nPpcU5vxIKbl2rrUMvqf7mO3IHwWRmjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xm3maFW+oMKNy+weeZrbl/H+YFEXCZUk3YE2LJJAPmA=;
	b=jy1tFyyE5oSNUU7Ep+/pkoptl246Mrj3Pw/h/7zqcFdNjWCzq1Bdy0a9ojGPYR0JwWwI
	 Kpzg+2/M77VoFQa5dJvZXlsvTNDvYiWGSEurF1Cyn4DNqkYAtI2lg/NELBQRvX50vFHue
	 yqbgJEE3XXF5oZXG5csIE+b07CjWWbiIp3KpF+i3ikweKmZpV2ciGNnoskA/6SUCgxEPj
	 T/0rxUkV47xIGCKkVEvRBeMNehUp/sLygGQ679WjKa96dNEgwRj+A6mpr+ImBSXCztFtx
	 TK/lFK+XIlDxDtlBOjP7I2dlhzVle8R/KIYg21cU7hltzmb2NGESsWxm3lthJ1UpjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajaQzgId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDC606A327;
	Sat, 14 Nov 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajaQzgId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F71F000C4;
	Sat, 14 Nov 2026 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662480;
	bh=xm3maFW+oMKNy+weeZrbl/H+YFEXCZUk3YE2LJJAPmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajaQzgIdkkm7BSuZG/5h38p+6Adw7f8VGMm6ZCFJbIL8wow6lBTJ55fJfkIM2Y70R
	 vd7kWeVSqsn6zK3ZkvgfvMiX4+DaU/MuhhjFXv4yOO0HK7Bbsz0HtDq40b8fp86b5U
	 y3b2Q77zvIbA0kpaZN542FPgXaL+FRQGAg3EvShYziToeGzYw6Jic3ceejLKTtu34c
	 aCSm8ziCuwq9Lso4ZwbpxlX2VCh3eiKQdIt2FzwEPElvOEJ5uXrBr/btSx1TiDWd7P
	 8K642+tKvgVdZcl0KtDtcEoijCvUqiN/p7PrsNGAagqxol0QTibygv2JZY8awCmIy/
	 sa6W5Nav3yHGA==
Message-ID: <sashiko-outbox-214555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 36/42] nvmet: refuse files on pseudo filesystems
 as namespace backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-36-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-36-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:21:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The file backend takes any file that can be opened for reading and
> writing. With buffered_io=3D1 that includes files on procfs or sysfs which
> then get read and written by a kernel worker on behalf of the host.
> Refuse files on pseudo filesystems just like loop does by switching to
> file_check_backing().
>=20
> Note that the helper only accepts regular files and block devices. A
> block device ends up in the file backend when buffered_io is set. But
> so far the file backend also took anything else with ->read_iter() and
> ->write_iter() such as character devices and FIFOs. The size of the
> namespace is the size of the inode which is zero for all of them. So
> such a namespace was unusable anyway. Refuse them.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D36

