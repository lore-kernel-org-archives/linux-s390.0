Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2A3AEF51;
	Fri, 25 Sep 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341043; cv=none; b=XwB85PaklmwppBiItKo3VdmzGvgS1BZXPm2EVYtk28H7VFK0jZG6X3NK1UJTi1emZbVZs8ejj9VzIqdR7xOxiBYGYnMyzSLIi4jKz3BQtuUh/+3homooeLAqwYbv1Faz+CCUmxYsjCCqzAc0Pvrk+Z7jTPmEyo4xZE6l1+3IMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341043; c=relaxed/simple;
	bh=147WfADxFTPuYQQTXvSf+W4g6iJ4FbD7oDtSyqX8MB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXcTlcP5FjWekuDI7osGo+HRoL7PE2uBVTXSAbfdkd/uwruGlshlqKC2UIB/CKcL57fZNti++tg9uNeT/c2uLUIN62nY9Nw8rAxTGEpFSWnIpQDbmLWl0gm0F9KhKik5vAShlGjVzTXIFhgPklLtpU6qrxdezqUNU54PTcs9hOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzCKwAv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzCKwAv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C29C1F000FF;
	Fri, 25 Sep 2026 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341042;
	bh=M6kTzlTtA4bzlUK7Jgov/Z9PMNLjHrr+FTbVzJGHHIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzCKwAv4LkPWFxwETkyVJ9fF4Cli25PutsnwtrmsB9pvvRuXY4dNmAGF2Q5vU6hp7
	 2IYj11XcjKu5JMGl/jIAVSSZIFxY2EhGxpTvTR5KuoMQYekSbs2W6Aw964z+Q+/zIg
	 ARRYh0uXunXlM2D0a544uYFejfqfuyXK2MoDxq4zrokstWgCQ2MdtG9EqL8czxqFy4
	 lskfyIL91FNg2O3K+4ViRUlOO7WtEIj8dqiHLGvgiWRXgzyfPihwialW8VDOuhHnBF
	 G/liDaHDjo8yNoHtlwBMEa9crxCpvQBVunM+KHV/nvoCXNSnT/q1gnHWBqoWJ8I4nn
	 lYbs0mJoE3WGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260925124551.665448-2-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:57:20 +0000
Message-Id: <20260925125721.5C29C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/vfio-ap: wild DMA write due to unconditional NIB unpin in unm=
ap_iova
--

commit f138c70af93258555b6e1c1c1233b5d5dc8b82da
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix leaks of pinned NIB and registered GISC

This commit addresses resource leaks of pinned NIB pages and registered
GISCs across several paths. It introduces intentional leaks for cases where
hardware might still be able to write to the NIB, while freeing resources
when queues become unavailable.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1857,8 +2006,28 @@ static void unmap_iova(struct ap_matrix_mdev *matr=
ix_mdev, u64 iova, u64 length)
>  	int loop_cursor;
> =20
>  	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
> -		if (q->saved_iova >=3D iova && q->saved_iova < iova + length)
> +		if (q->saved_iova >=3D iova && q->saved_iova < iova + length) {
>  			vfio_ap_irq_disable(q);
> +			/*
> +			 * If IRQ disable failed or IR=3D0 could not be confirmed,
> +			 * vfio_ap_irq_disable() intentionally leaks the NIB to
> +			 * prevent a wild DMA write. But vfio core requires the
> +			 * page to be unpinned before dma_unmap returns, or it
> +			 * will BUG_ON after 10 re-notification rounds.
> +			 *
> +			 * Fall back to a bounded queue reset. The ZAPQ zeroizes
> +			 * the NIB pointer in hardware, eliminating the DMA risk
> +			 * that justified the leak. Once the worker finishes (or
> +			 * times out with a reset confirmed in-progress), the
> +			 * hardware no longer holds a reference to saved_iova and
> +			 * it is safe to unpin unconditionally.
> +			 */
> +			if (q->saved_iova) {
> +				vfio_ap_mdev_reset_queue(q);
> +				flush_work(&q->reset_work);
> +				vfio_ap_free_aqic_resources(q);

[Severity: High]
Does this unconditional call to vfio_ap_free_aqic_resources() risk allowing
a wild DMA write into host memory?

If vfio_ap_mdev_reset_queue() encounters a hardware fault and TAPQ returns
an invalid response code, it intentionally leaves the NIB pinned. The
comment in vfio_ap_mdev_reset_queue() notes:

"An invalid response code indicates a hardware or firmware bug. Since we
cannot determine whether the queue can still DMA-write to the NIB, the AQIC
resources are intentionally leaked lest the NIB page is reallocated to a new
owner."

However, calling vfio_ap_free_aqic_resources() in unmap_iova() forces the
NIB page to be unpinned regardless of the reset result. If the ZAPQ failed
to zeroize the NIB, unpinning it here overrides the intentional safety leak
and could expose the host to memory corruption.

> +			}
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925124551.6654=
48-1-akrowiak@linux.ibm.com?part=3D1
