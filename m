Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA423B6364;
	Mon, 20 Jul 2026 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579936; cv=none; b=nmgotRmNs/TdiI6xajY0IRprUlSxnrmL6BnrEiw2daLZU/XFME6MkBCWU3V+t5DpXdaElgddH+iBIqj+eN+mzHjEhqEbsfv6WS+nP3h2MhyxPRmNZGDcvqN+ZJ3YmXYkHg4RbmxPL8cG/76Mnu9eU+QzO6VkatkGLt5Nz1vMlD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579936; c=relaxed/simple;
	bh=tijJ8sEMKn3zjgU7pR1eaV+riRpBmLFb41i/HtTVEU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CeqZ5gM+z0xknO/INzalg28MsfHFH/VvR0bpsiqertKcKE8u9JxWTFFWKDUbkSKxBSmO8xsV2to7TEBpz7pa5e3YCBTyzO/f9LwXaSiThMO17st0ENRpuNdFlVftnsAqTmpVMm2EmQPzHpu+UY8YorKMFxrmWUahyh03Lk3mBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu+sKM3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu+sKM3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4661F000E9;
	Mon, 20 Jul 2026 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579934;
	bh=gxuBF2LuSJtze1Nun3SaqlEI+0WkYJHXDPy8HMGGxT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tu+sKM3BHS1Oo316Ze1nCt2L4LYi9wB51OvS2P0Kp1EmP37v+yMXDNs4NMHijNyGx
	 IERzhxnRq5vZGpGU1NJ5nUotyf9qfvvHmvgNTne+zPFKvOwMpvUX6ECS0twpYOapc4
	 b/C8rx6tu2nxIJKrzDMDyubLkoA5zF+2WEF4UHVAAnapbsE73DgVqo3Tu5Obei6DB2
	 HYC01sSIiIDL7nB2ACGuq2ZV7alB+S+K64Tgtxu76qu4yXv0XqcIx1qu+JrLdFvj+i
	 Ggi4Z0JoGOauHZCf8WlQfPjtrwV6vvqTqqyMwePGBYxA69ji+icYdc7WaKMDoUFZm3
	 ORPyRGf++uzyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720201931.976660-4-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:38:53 +0000
Message-Id: <20260720203854.5F4661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver does not explicitly cancel asynchronous background work=
s (io_work and crw_work) during device removal or release, which can lead t=
o a Use-After-Free if a work executes after the private device structure is=
 freed.
--

--- Patch [3]: [PATCH v2 3/7] s390/vfio_ccw: fix out of bounds check on CCW=
 array ---
commit c4537e2a2ac0b540c3111dbbbb37763f251c94df
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: fix out of bounds check on CCW array

This commit fixes an out-of-bounds check in ccwchain_calc_length() when
counting CCWs. It restructures the loop to break as soon as the maximum of
256 CCWs are examined, preventing memory reads outside the array range.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 7abdebd8f7c3d..ce61858c82eb6 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -393,11 +393,14 @@ static int ccwchain_calc_length(u64 iova, struct ch=
annel_program *cp)
>  		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
>  			break;
> =20
> -		ccw++;
> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
> +		/* Exit the loop when we reach the maximum */
> +		if (cnt >=3D CCWCHAIN_LEN_MAX) {
> +			cnt =3D -EINVAL;
> +			break;
> +		}
> =20
> -	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
> -		cnt =3D -EINVAL;
> +		ccw++;
> +	} while (1);
> =20
>  	return cnt;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
during device teardown in drivers/s390/cio/vfio_ccw_ops.c.

Looking at vfio_ccw_mdev_remove() and vfio_ccw_mdev_release_dev(), the
driver tears down the device and the VFIO core frees the private
structure without explicitly cancelling asynchronous background works
(io_work and crw_work).

While flush_workqueue() is called in vfio_ccw_sch_quiesce(), this only
flushes currently queued work and does not prevent concurrent queuing.

For instance, if vfio_ccw_chp_event() reads the private structure and
queues private->crw_work right before or during teardown, the work item
can remain on vfio_ccw_work_q and execute after private has been freed.

Does this teardown path need a cancel_work_sync() for these work items
to prevent them from accessing freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D3
