Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BE32AABA;
	Fri,  7 Aug 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142414; cv=none; b=T2AAL0kVvPdukpFf4HlEdAl3HcWCzpwt3jV+f/rEH7xwb6rtNwXsAdJKP8n33DLzV/R85GIwOAC5dUlwZawnIsFYQNQrUg0AncUvGcfIijSi7iwUztNfCPOkbj2pi2mneWuK24lCz08RVQXC6/6vQcaw/M8PrBCnQ0ASgnLWxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142414; c=relaxed/simple;
	bh=SOs0AAptK8Di7cLU4N6/zAAaHUjbeSlQpA88g+5AN44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VrdukWri3DwR6KcRDU50kFBdLDqy1wlwe3XK2+72gB6yjsq0zXwNfUuOHDpZB0sMpvvD/r31/rpKKEAjK094bd0xV53x6spCM19oPTyHnYmB3hTLFWp4QklyL/Yu9H9rX0vKIGuE49iRyBX1Rk6Bqa54JbHxVdcCC/OnJ2TSeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNkKRAys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNkKRAys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE971F000E9;
	Fri,  7 Aug 2026 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142412;
	bh=poS8soe0ZMp9phP2b5zyBzdpOJwp/oZxaj8w3PdiQcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNkKRAysSROmP2XDZE4k7WD8XacGZyiGmWzS1BD+bCSun1S0PBNsIAqZXuk4aTxk4
	 yKvuviw+WjtARKbWTL9OJoezDOFrRpY3FqMEKSJ4bU3fByvbV6jh0/7X2hqy+zyYmt
	 wx5n25x/d6VJUSMY5PTZxlT3gRz8z3G6mU3IRmjcrK/G4Ixm2DioGBvfuiOczQGCkV
	 woYEdI+oL2u3kFqWy/wHOLi3bHhJQsfroPFWbQqFsvY3YU0ibTksXS1rkHHZWpHGIT
	 Xd03VGwz6NjjigsioZCg/wu6Mi3GO30CkBFEg2i9g2f1YZrq7ass2SQBQ4fdlooqfM
	 Syz4cPS1NQU2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807221834.562851-10-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:40:11 +0000
Message-Id: <20260807224012.3DE971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Migration data and buffers can be freed by close_device() whil=
e vfio_ap_stop_copy_read() is reading them, resulting in multiple Use-After=
-Free vulnerabilities.
--

--- Patch [9]: [PATCH v7 09/15] s390/vfio-ap: Add method to set a new guest=
 AP configuration ---
commit 6fc20ee0bf1a514a8193425ef0cd6ee0f1b7529a
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add method to set a new guest AP configuration

Adds a new vfio_ap_set_new_config function to set a guest's AP
configuration. This is needed in order to set the state of the mdev when
it is migrated from a remote host system during the RESUMING phase.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index d05372b50d2fc..0f33f51891536 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

[Severity: Critical]
Can this result in a Use-After-Free during concurrent device close and read
operations?

Looking at vfio_ap_stop_copy_read() in drivers/s390/crypto/vfio_ap_migratio=
n.c,
if a concurrent close_device occurs while reading migration data:

    if (*pos >=3D mig_file->config_sz) {

mig_file caches a pointer into mig_data, which may have been freed during t=
he
lock drop in vfio_ap_get_config() if the device was concurrently closed and
reopened.

Furthermore, mdevs_lock is deliberately dropped before this line:

    if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))

allowing a concurrent close_device to free both mig_data (which mig_file po=
ints
into) and ap_config.

This happens because vfio_ap_mdev_close_device() in
drivers/s390/crypto/vfio_ap_ops.c unconditionally frees migration structures
even when migration FDs remain open:

    vfio_ap_release_migration_data(matrix_mdev);

A malicious userspace program could use userfaultfd to pause execution of
copy_to_user() in vfio_ap_stop_copy_read(). Concurrently, it could close the
device FD, invoking vfio_ap_mdev_close_device() and freeing the migration
structures. Once the userfaultfd is resolved, copy_to_user() would read fro=
m the
freed and potentially poisoned memory, copying it to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D9
