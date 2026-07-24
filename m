Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30544C4EF;
	Fri, 24 Jul 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917647; cv=none; b=FfsYbJ2LlK5fvQsKNhhdoX47mquUUDX/C3BYjK1vu74Vi0p0OXohrETyjP29SYzwlaNQi5YaUnuTsiVNJMBh+KjjBqaXqaJLYqR6CWRj5uoRgm4RCt7LnNo35N4xoDVDq067dcvDrEgXjR+hsATPtP/P5zC0rdcowFbmPjfjHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917647; c=relaxed/simple;
	bh=0cORszB/JvpaJY8tLGNgLLdkzkSutnEWPU41UJg6bxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gbnC8HYitI7TlqGcRb35+0/Iu9Qgcw9nH63Ggnu5pbJ6kCKzo2sieaguP9CKZezldLBSOW31gzZRXjZ4uHzxMSnAQkO6MXA1+GpwoDL85ujNAAepXRafhecZVxDkcm9hkMMlgPfpDESH5WS0PG88m8m4EjmZeMD5rwhaDb2lELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5J+wAFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5J+wAFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A931F00A3A;
	Fri, 24 Jul 2026 18:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917645;
	bh=0cORszB/JvpaJY8tLGNgLLdkzkSutnEWPU41UJg6bxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d5J+wAFo9N/i+IlWoIXkUolwIUsIK2FDqYcOtn3Pnf4tpSvTMA7yFMgJq0/tA/Jxi
	 ngU2IU0DcaLM6nFe59PnYtSJpk+GnCXYM2Ohzsoi96adsxRcW/HKqrVqQLpy+RcrFd
	 bHLX2e2X3modu5NYbu2JQq7hTJGAhlY07o5tTZXdg5a0tHyH4KZtUwIQkw/NaQaL4H
	 Dd5Q9uzWyo7FIpWJlZjGOD6ERUIfJsrDkXTTNN2vpt6v9kO6QGpHhoqXelBmKl4RWT
	 gfwK54W7IHam9XlGIF8C61V0nj87cb+HADgjM7jF7tyxY48hUw0xKMark+PE1yp4nx
	 8lW9hfyZ2HKjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-14-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:27:25 +0000
Message-Id: <20260724182725.94A931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Callback to get the estimated data length of the data that will be requir=
ed
> to complete reading of the vfio device's internal state. It's mandatory f=
or
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
>=20
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D13

