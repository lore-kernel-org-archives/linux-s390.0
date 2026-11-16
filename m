Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828005;
	b=zuq9CKyaFxDOWcCZ0pzr4qKLcY8hGJYXnIMT2L3FFC6QTJZ8Lw0ttyCIgr80I1nOj2ZH
	 zy9Q1XITRtT1YOkdIW7l+6kdhTFUamUy4VknZW/xs/eRCe7+b9U7byaHsfDhsdsIMiiQ2
	 xSUAT5d9kDW0N65KIlPsXWEbYWgHwXMp0truNoDXeaH3uDQSYVTU7k/n117Vki33T5oMv
	 qCg8sWfPtuhd2/bGtJ0tEmJi2dq7lzDy4Uz5mTSPwm6LCU4STqFTZIrgNsDqtAgzgbCYg
	 wYjofLMUN9XmHyOn8fxu2Q7oUAxbMKDdiAY9MiAgNo20984BGIkxzdFjnoIXwNJTiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r7AIwSEMWRAxjZHBqEjI+LI0CyASgSm1yNFDlTa/Ugw=;
	b=3lFT7p5ICMvXIA/qxCLhFyppfoa7QA8M0Z+aVV42yTulmTZXuYZ2wL8UUiTjaw/kd4Om
	 uLb1jRlAg64kcJiRhkIYSNavUgWrKeFi80Yq4LY5J2e/CxHMj46Fs2KVZiNVxw/Jx+EL5
	 jDdsJnzwB3pKcEbt0tcKuVuRcR8OVmES436UYG/dc1jhAPIb2DCfDW6RfDKJDDyhATqkD
	 fOwwvdS7xxPQSP/3Eg6PttDklnpW08z663emTcDYCpTwD3N+y4kqbl5eckOrn/f3xmYaP
	 bFJqI6jDQ+rj/lwPWjDIjF1Pn9A3K9xGc/QGN5C2NjWkkFDghwuGURD7SjpU40zc4/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRKB1EsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D87606A883;
	Mon, 16 Nov 2026 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRKB1EsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EAD1F000C5;
	Mon, 16 Nov 2026 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828004;
	bh=r7AIwSEMWRAxjZHBqEjI+LI0CyASgSm1yNFDlTa/Ugw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRKB1EsDbwHucX6Yzd97S7MFc4h8D4Keaad8bZzhEVSD7LSIhlMinRhRYZS8le1Kh
	 nwLYiYQJa83MVs5iXqNAVg+K3n4b9gesDd4+y4shs4nqC/28i2OeZ3foQGNX4N7Mla
	 6zJaCFgKc/reCHWFODa26jDW9pHhJ8KkYwDceDYAHU0LNtkO+cc7IozSuuHUSCGOYJ
	 VDZx/pVZ6ZHlZdwHy/+GST/WAa0NViE7pewri5MVZElf6n29QQH5lB35Zvmkcd98XK
	 5tiZyKX2rC9sQa1q40zU/WKkJfAJ0lQwN2bGSlpdRWAyE0/KYlIJjxr5RlsRkcU3YW
	 bX9xZiJLy0MyA==
Message-ID: <sashiko-outbox-216891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 17/44] securityfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and SB_I_NOEXEC. securityfs never holds executables.
>=20
> But securityfs needs device nodes. AppArmor puts a .null device node
> into securityfs. On exec it replaces file descriptors the new profile
> isn't allowed to use with that node and opens it via dentry_open() which
> doesn't care about SB_I_NODEV. Such a file descriptor can still be
> reopened through /proc/<pid>/fd/<nr> though and that's what opening
> /dev/stderr does. The node itself can also be opened by path as
> /sys/kernel/security/apparmor/.null. Both go through may_open_dev()
> which refuses device nodes with SB_I_NODEV raised. So clear SB_I_NODEV
> again in securityfs_fill_super().
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D17

