Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44548357CE9;
	Mon, 24 Aug 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609260; cv=none; b=L1KpKpjJqJ8gEXoN4003yKIe3WWhW0GbEKbHhVEEnyPNcvKK8yl8AP6+ROXjk23T7I0pHuqtgBUQDQkOHz6TD3xRWJEm+UZXn8wiSXF//3T0LVPyVNjH1QwPTv3uVWPbD6ixUWKzNCLmBroxIkb5FwKchabpzwq5lXHrA5/9Jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609260; c=relaxed/simple;
	bh=pxrVl5WNPfrOEQ9L4oYv84IgvJKVc2uJVPvms6+iaFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ivi1FzyxulnQLL7CxUsAgjAGdl6RagNCr7C74uhRWcswEdFMU4l5QSSXUDnNVtUV6XGj2Oxu9ctTrl1R1z27LavxsR8/3rUV4rr913yyoUNliOlYlG8jUX3X0B2X00XYS2ViFBlcqPpTJFFjla0tg2kVfLbFFKEIf/mYiS/bh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQLg4P3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQLg4P3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C7C1F00A3A;
	Mon, 24 Aug 2026 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609257;
	bh=g6IMV1WeXwNJWABzjZsbh3pN55rV7EbakbQvUjmIbKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQLg4P3uDfLAfnKdiNc3SqFAdSyCTY3u6IIlcw9tEwR1L1LWILppeNHdj6DiFqZz0
	 mMfPkVNRgO+ed66jdkjq+IhsQ91VnIzTqc2hxzKJxUgcIe9JouUpSMSlwjharGMwGv
	 u6RgWQv2GNajJA0Rby9O4EJGnJbhph8ely+nD5WTPfnT+aHyISqDtivtN6H7/C9nk+
	 tA8V4CgPRvVEMpWV7oJSY+QQMk64DqVEnKsEwIp1eRV8WdB61df3Hu5o3o/ZQU2KBL
	 UW5d8qu/yvZ+qAqCf+8VIpWqDh89XX57P9u181aWmQZ6cKmHkHDZt17ZB+s0avx9dq
	 eOD7DbL2NH2Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260824215603.819379-2-akrowiak@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
 <20260824215603.819379-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:07:37 +0000
Message-Id: <20260824220737.95C7C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Potential host memory corruption if `vfio_ap_irq_disable` time=
s out while the hardware queue is busy.
--

--- Patch [1]: [PATCH v2 1/4] s390/vfio-ap: Fix leak of pinned NIB and regi=
stered NISC in vfio_ap_irq_enable() ---
commit 85cfee5e61842e2a3b3b8993da6d14f25c2209a2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_ena=
ble()

This commit fixes a resource leak in vfio_ap_irq_enable() by explicitly
unregistering the NISC and unpinning the NIB in the default switch case,
rather than relying on vfio_ap_irq_disable().

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..22a6ceaa7b562 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -503,9 +503,12 @@ static struct ap_queue_status vfio_ap_irq_enable(str=
uct vfio_ap_queue *q,
>  		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>  		break;
>  	default:
> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> -			status.response_code);
> -		vfio_ap_irq_disable(q);

[Severity: Critical]
This isn't a bug introduced by this patch, but pre-exists in the
vfio_ap_irq_disable() function that was previously called here.

Can this lead to host memory corruption if vfio_ap_irq_disable() times out
while the hardware queue is busy?

If a guest repeatedly sends requests to keep the AP queue busy, then issues=
 a
PQAP(AQIC) instruction with the IR bit cleared (or unmaps memory),
vfio_ap_irq_disable() is invoked. If the queue remains busy, ap_aqic() retu=
rns
AP_RESPONSE_BUSY repeatedly.

After retries, vfio_ap_irq_disable() falls through to end_free:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_irq_disable() {
	...
	} while (retries--);

	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
		  status.response_code);
end_free:
	vfio_ap_free_aqic_resources(q);
}

By unconditionally unpinning the NIB (Notification Indicator Byte) page via
vfio_ap_free_aqic_resources() while the hardware still holds its address and
expects to write to it, the page may be reallocated to another process.

When the hardware eventually triggers an interrupt, wouldn't it perform a D=
MA
write to this freed page, causing host memory corruption?

> +		/* We could not modify IRQ settings: clear new configuration */
> +		ret =3D kvm_s390_gisc_unregister(kvm, isc);
> +		if (ret)
> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=3D%d isc=3D%d, apq=
n=3D%#04x\n",
> +					 __func__, ret, isc, q->apqn);
> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824215603.8193=
79-1-akrowiak@linux.ibm.com?part=3D1
