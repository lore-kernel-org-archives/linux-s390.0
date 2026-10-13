Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910751D538
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932259; cv=none; b=C21VyJ8mKqzj23+dWS4x3vc6avTT6VNKyb1iE4m+Xxc1L0HqG6K2L57I2Ib+fv0Y5by3AaDPeREpWuJVP0DewqXUh7QPlFBBbeVy+h0PMfXzd+ReONH87pV68QG2CuKzqZ8dQFYlLiVPd8pKMHUkXlTfTfKeBOQk8DZGNaYanIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932259; c=relaxed/simple;
	bh=p/1r0cRiOqmNQHo59ZT6X4W3YiYVuRkcdQHsw/WWFVA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OIlQXFhhCqiY0BYR9hwsIwmoo+jtg3yAgcXXDPrnGZ547TgAb7SzrDa0dqPTEw0OqP3AtYLbe/RAEbQMqo53oUKm38cnlzsCR/EmpofG6CG9mez2WWr3ghi7BcwYiL27Fsz+5G5+5bbzckfOf75IxtQEYegbwkaUU30uXMAcQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgFLhfUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgFLhfUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184311F000FF;
	Tue, 13 Oct 2026 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932258;
	bh=/tsBWa/AeIHpWYnSfggb/tcEzc59MfiSDgJMKAguNHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgFLhfUM1TXGEfGMJsgcAb6Y1wRILjIj+J3R430oMlOvQtyf5Jv0IB+lzvt1e4uzL
	 67Q2NgzwDZcj0h0Gp+T4ZaD9fgQpqhU9WOBXb6JeIcXDiW/RmANUUDfYQ0h6pl/r4I
	 hsAFKKlxYOd3LPAKeNTyC54ujuxFojj1SrrMesYXyVNqoCUi6IKFL2xce+4dIemMTs
	 G6MjJFNmZLll7yoqdBaXLsVLdEvTrtoUCVBTfMvaHLChoNrsUz/e7sCt7ZqvxZmfgO
	 q+KVRFyMjefBCAo4ERPG6jZrtvjqAE5PcsoFqWN9Ygr1Yn5uKAyTcrdqfg2Tg5EKX0
	 R3ORV5tNZHeLQ==
Message-ID: <sashiko-outbox-170614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] drm/amdkfd: Free queue in procfs_queue_type
 kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "David Teigland" <teigland@redhat.com>, "Alexander
 Aring" <aahringo@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Richard Weinberger" <richard@nod.at>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Felix Kuehling" <Felix.Kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261013223946.1836757-11-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:57:36 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sysfs: WARNING in kernfs_remove_by_name_ns due to unconditionall=
y deleting uninitialized kobject
--

commit a813e5e5e38ff926a8859f22732d8fde3e0ed689
Author: Ian Rogers <irogers@google.com>

drm/amdkfd: Free queue in procfs_queue_type kobject release callback

This commit adds a release callback to free the struct queue from the kobje=
ct
release function to prevent a use-after-free, and adjusts the kobject_put()
locations accordingly.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
[ ... ]
> @@ -701,7 +708,6 @@ void kfd_procfs_del_queue(struct queue *q)
>  		return;
> =20
>  	kobject_del(&q->kobj);

[Severity: Medium]
Can this trigger a kernel warning if sysfs creation fails?

If kfd_procfs_add_queue() fails (for example, due to a memory allocation fa=
ilure
in sysfs), q->kobj.state_in_sysfs remains 0 and q->kobj.sd is null. However,
pqm_create_queue() may ignore this sysfs failure and keep the queue operati=
onal.

Later, when pqm_destroy_queue() calls kfd_procfs_del_queue(), kobject_del()=
 is
called unconditionally.

This results in a call chain to __kobject_del() which invokes
sysfs_remove_groups() with a null kobj->sd. This eventually propagates to
kernfs_remove_by_name_ns(), where a warning is triggered explicitly when
its parent argument is null:

fs/kernfs/dir.c:kernfs_remove_by_name_ns() {
    ...
    if (!parent) {
        WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",=
 name);
        return -ENOENT;
    }
    ...
}

Should we check if the kobject was successfully added to sysfs (such as che=
cking
q->kobj.state_in_sysfs) before calling kobject_del()?

> -	kobject_put(&q->kobj);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D10
