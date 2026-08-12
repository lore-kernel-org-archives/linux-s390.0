Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8732B111;
	Wed, 12 Aug 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566139; cv=none; b=HWbM3+nJDkXNv5C8IINZL8ph4cwyIBEspa4n4HyxBS4hEZY9Ku4M7gxh4dxDfj1GYcGgFZU2MBbLn06z2M0pOPTkpA95Dei02grBLXz2vwok7CxrqRwAmGM7pcw54MLp8MyJUvj/xwTC/bs4Uyn/PfdYYFtIjT2zZCq0Gz45N0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566139; c=relaxed/simple;
	bh=UAeg2OtWZHH6zGW55wZUbeG5KmLWO15/MDn4n5pNV8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QiUJdlB5ixejTnyuEMIC6yyFeSrzCtt0ApEp2W7X/QMEi6ihQHT7bguhIgQzPExdMCPPjMMjvWGyy/DGUcp/mdq7Dwt08gajA8weFg1PxFwbqhJtwGfXrDozxM5AQUWa59mzDZ/BpNTCj24NRX4PPyGbKwT9AKGSwc0RvnAOkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUaLqd8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUaLqd8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50B1F000E9;
	Wed, 12 Aug 2026 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566138;
	bh=FIZJ8/bxbbvVpII6P10sNdpC+l1i2JIJ8B3j6y/zClA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RUaLqd8n4bNgNZulcJ6p87O8e8INXc5JFJletLnHcQAwVi0edCUUBsmHvtrGf1bTM
	 YCpCpNaQKQY/CxUS/eDJjwTkHLS0OHVoeOpbXLI2f1Oxm3lhfoCrAhi2OvJxLTSuMe
	 PPfvIuyi1b3CCIr02nZnYTVj2UlLn1ef10NYsSdLcrvy8lNz0xtl9yHStIg6bG8dFN
	 dr3XQHCr2HY9hza0riEHKaFS8AvE9hcg07nY3J0eU8AvLYWYxY+lfnD/sH3ZBIegnY
	 zBsmcAhF73dBBRqrnjrvY+hEgsnQQxATimj5n+gv8LYulzGfVLHOngzfLl6wXCuKjg
	 BAB/Vts1nivsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812200240.818004-9-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:22:17 +0000
Message-Id: <20260812202217.ED50B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronization for asynchronous reset work during device =
removal leads to Use-After-Free.
--

--- Patch [8]: [PATCH v5 8/9] s390/vfio-ap: Fix NULL deref in status_show()=
 during queue probe ---
commit 0bb399a6ce7f9a2aea3f2f595acfac62183158ba
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix NULL deref in status_show() during queue probe

This commit fixes a null pointer dereference in status_show() by checking
if the driver data has been set before proceeding. It also adjusts lock
acquisition during queue probe and simplifies the apqn assignment.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 16779cfc64e87..1edd0b7a3cce7 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2472,8 +2492,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apd=
ev)
>  	return ret;
> =20
>  err_remove_group:
> +	release_update_locks_for_mdev(matrix_mdev);
>  	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
>  	return ret;
> +
> +err_release_locks:
> +	release_update_locks_for_mdev(matrix_mdev);
> +	return ret;
>  }
> =20
>  void vfio_ap_mdev_remove_queue(struct ap_device *apdev)

[Severity: High]
This is a pre-existing issue, but looking at the rest of=20
vfio_ap_mdev_remove_queue() below this signature, is there a potential
use-after-free if the queue is removed from the host config?

Further down in vfio_ap_mdev_remove_queue():

	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
		vfio_ap_mdev_reset_queue(q);
		flush_work(&q->reset_work);
	} else {
		vfio_ap_free_aqic_resources(q);
	}

done:
	if (matrix_mdev)
		vfio_ap_unlink_queue_fr_mdev(q);

	dev_set_drvdata(&apdev->device, NULL);
	kfree(q);

If an administrator hot-unplugs the ap adapter concurrently with a guest
triggering a reset, the queue is no longer in the host's configuration.

Because flush_work(&q->reset_work) is inside the conditional block, it is
skipped in this scenario. The function then proceeds directly to kfree(q).

Could the asynchronous reset worker thread (apq_reset_check) then execute
and dereference the freed q object, resulting in a use-after-free?

Should flush_work(&q->reset_work) be moved outside the condition to ensure
any pending reset work completes before the queue memory is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D8
