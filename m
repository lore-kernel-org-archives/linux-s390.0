Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179213;
	b=aTeN3/A5YPweawJxnXokMgMmAiedSouQ/YS78DRkuyIDbtKQUjNqui5gOJh4+blajYF9
	 E+4oEnW4fDGxYMLvdK847jfh1lZIXYaG4g9wcW6V92dgmegqKxp9xSkaZOkXVC/8xWirt
	 GJVCtg+UAPHH6DKBYCXJJkzymyLyQT31Yrr3A90h32IhopRn6D6iTiE6ZDfyE44z8h7p3
	 eW75YkUJpUoJbMetmfHzEMG0EVpAU506GqSlTzC9KrLmHD5wwctLNc/y79R6Q0Qk7d6B1
	 eSntlkCdpBtOEvv8V/q0ZdjXlQuHVSgZqLIoL3GYJu3gVQRDb+wf6p7jPY1edplENjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+hmt8D//cWlFZIK2gd8XAWnqPSRmuN+AV7WN05g2ZKM=;
	b=rwN0MUGSyHj+RldWNhDj6Py/92wRDH3jjEVMDw1NMUQwwOTehClXuO1IZLFfXiAI3gBv
	 RXdcOgfVLqrRIsIa+MDpLHSCB24OLkB7LsFsFOxAaVPIYRyYA0DKfXaIS/NbcpBYzxZH/
	 MwzYc8CE8s5vSjiEGGh77lG/cWM0ugZFBtk+t1i5z7VjQTTxhj5vFTUzFalKINMEVxznl
	 VkvUZv01xw69nFkcoQDabz5H6ivnXO/OJfCa2MVeMynbH2vPdBCsi2fqnmoYOOXdFr2Gi
	 VfkacUKCebRp4xjlBtwAs4dKhRu1neZGVW7vfAY8QaMZZrkkzDIjBrqaDmD541pmpQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uk3vcV63;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED3606A322
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uk3vcV63
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F47C1F0089F;
	Sun,  8 Nov 2026 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794179212;
	bh=+hmt8D//cWlFZIK2gd8XAWnqPSRmuN+AV7WN05g2ZKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uk3vcV63rJrfwcgVsOd67WdpIIzLM6aI1T6mxDWcVeAp89KEIrK1qs1Jo/0CXbfVr
	 fcB5OfUYm6A1ofkxHDIimthku5D6up2AwfJclwou/xfssTEksmoTFCPh6qRYO822DJ
	 EhRnEjLYzoTsnLBGoMmRlIqxXhO3J0qU3a9xkOUBKZ62/7E7gXpM0Y1/YVI0vshtSY
	 52prOE5oxeqq+KikhS0twOVm/jLDvQ4iNuV2r0zebHqOHd4g3oUQfCNUivQzCX6XdT
	 UZFL6joCHzaV6LEr0rX1ZFk73a5tAndxwCDhfrV5IIcrXvBmWzHu1pyVC9JiNPnJot
	 j+Mjz2sYtcMPA==
Message-ID: <sashiko-outbox-204150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] dlm: Free dlm_ls in kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook" <kees@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Srish Srinivasan" <ssrish@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Zhongqiu
 Han" <zhongqiu.han@oss.qualcomm.com>, "Alexander Aring" <aahringo@redhat.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Sumanth Korikkar" <sumanthk@linux.ibm.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-6-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:06:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dlm: wrong Fixes commit and misleading subject for
  dlm_ls_release()
--

commit cebf1bf6f5d4b67423eada980e5a294abe491cc6
Author: Ian Rogers <irogers@google.com>

> dlm: Free dlm_ls in kobject release callback
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
3514faca19a6 ("kobject: remove struct kobj_type from struct kset") only
removed the .ktype pointer from dlm_kset while leaving dlm_ktype.release
set to lockspace_kobj_release().  The commit that dropped the release
callback from dlm_ktype and started calling kfree(ls) directly after
kobject_put(&ls->ls_kobj) is 8a4cf500f1dd ("dlm: drop kobject release
callback handling").  Should the Fixes: tag point to that commit instead:

  Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")

Also, the subject line says dlm_ls is freed in the kobject release
callback, whereas dlm_ls_release() only signals ls_kobj_done and kfree(ls)
Still happens in free_lockspace() and new_lockspace().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D5
