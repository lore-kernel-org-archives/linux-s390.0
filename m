Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98730FC21;
	Wed, 12 Aug 2026 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536362; cv=none; b=Vnf/i+pFj+3hr8iJ+saIGHzHwKnybjve4otgoy5CznUTzsmkDZniL7GYighFhxreIsf/nD9GL3lSeCiYQHcY2GtJOhewE2rgFCOa8ivdDWmdYAuM/pTRnnxne0oRm46WRT8GFsIREIF8YKVPyqKZ+P34f0ASElLiossFhf4MHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536362; c=relaxed/simple;
	bh=SHyb+IH8TlhWnztXKjqPJG4SloV4eZMvoLm47oSNvVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkXRrnT1T9Ve6yADpSQP1XXXleFQ4TEoCVeiBIVsO2AclXJ4yL2D8XQ6cu2OiIAlQJMYWk+w1bpLPt+2HkM7//Zobbqb4ddbYJoitdSI9uaIAeVOoYz5qMWbgW6H/nWMIYL4VOecKD2MgcBb8LtifVcQO8uu1W8Lii3rD4TF1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoyDEHc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoyDEHc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642781F000E9;
	Wed, 12 Aug 2026 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536360;
	bh=xA2WWLUuLlJmV+4KhAYwfjz+oC4oqQXV8kHuft8fK18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PoyDEHc9jF3UI5B5pIhl1rCSQK/EhObmctTlnWvjkJdayA/brKN044Qb2fJRjS4Yr
	 UN6i6425xaTIbpiO9aBrvH9PSgEI7nxqajhVex//cEZ4+RjVlce+dJrZ0Cyw5ebJ8g
	 4Bo6tE5mgVrWa5nMkdkip1kEyYM+9fsoilABf8txI7qdlj9NFzrVXN01myC3ma+Oka
	 avKq8t/yt+cm86/VV+t/InvCukvsLbQm7pFA2N3npSFW0QOIsn+Y+VD8FJUFCzxWXy
	 V3kKqTbJtuiBBhxeDY6zehlhzSWhrvP/CsQDRNiDXTd0hdCyAxkyNkpZLisGf2zOqc
	 X5OyahGeiRuTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] s390/vfio-ap: Fix missing lock required to
 access list of ap_matrix_mdev objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812115139.576303-4-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:05:59 +0000
Message-Id: <20260812120600.642781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing TOCTOU race condition in `vfio_ap_mdev_probe_queue` a=
llowing NULL pointer dereference in `status_show`.
--

--- Patch [3]: [PATCH v3 3/9] s390/vfio-ap: Fix missing lock required to ac=
cess list of ap_matrix_mdev objects ---
commit 431e0fcd6b2e0bbf72d273210e68aa6e049eacc3
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev ob=
jects

This commit fixes missing locks needed when traversing or modifying the
ap_matrix_mdev object list in the vfio_ap driver. It ensures guests_lock
is properly held during probe and status reads to prevent concurrent list
access issues.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index e382e5a1cb996..5c14ded4fd8ee 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2316,6 +2318,7 @@ static ssize_t status_show(struct device *dev,
>  	struct ap_matrix_mdev *matrix_mdev;
>  	struct ap_device *apdev =3D to_ap_dev(dev);
> =20
> +	mutex_lock(&matrix_dev->guests_lock);
>  	mutex_lock(&matrix_dev->mdevs_lock);
>  	q =3D dev_get_drvdata(&apdev->device);
>  	matrix_mdev =3D vfio_ap_mdev_for_queue(q);

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer
dereference if the sysfs file is read concurrently during probe?

Looking at vfio_ap_mdev_probe_queue(), the sysfs group is created before
the driver data is initialized and set:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_probe_queue() {
    ...
    ret =3D sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
    if (ret)
        return ret;

    q =3D kzalloc(sizeof(*q), GFP_KERNEL);
    ...
    dev_set_drvdata(&apdev->device, q);
}

If status_show() is called right after the sysfs group is created but
before dev_set_drvdata() is called, dev_get_drvdata() will return NULL.

The NULL pointer is then passed directly to vfio_ap_mdev_for_queue(), which
unconditionally dereferences it:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_for_queue() {
    ...
    unsigned long apid =3D AP_QID_CARD(q->apqn);
    ...
}

Should there be a check for q being NULL in status_show(), or should the
sysfs group creation be moved after the queue is fully initialized?

> =20
>  	/* If the queue is assigned to the matrix mediated device, then
>  	 * determine whether it is passed through to a guest; otherwise,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D3
