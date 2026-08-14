Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B250485506;
	Fri, 14 Aug 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722203; cv=none; b=lnDsUDoL0Q70vKP8KOKXzpuIgtKGB1/aywgNuzmh26yMDQ31rZ846G56/By5b5Z7QWTRRLCRF6DQ/DVGbUvxUFCsRk+QXFvhjnB3NiYtwcksCRqthdPFbbbspYP79kfSaMtupn51h8nEj5knAsqoKY0QmF/qPzDdEUPhbJmHH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722203; c=relaxed/simple;
	bh=/c/rPHwOFpgN7NaM0VxLZBmxRi7/lWEVe47b5TIrWmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CkIbIEDMF88wEnZb8wM4OzNpQeUyUcCz9BD+XFEBP9SvbXXOtOQEwknt+0zuMbQdA3vgnqFnUx1IJt9HFl5miLwAYTsWNANd7m7h5gd95ajoblFOsKKjXaOi9zYAYvH5QxzLFTW3eu0rZDuHfii26VWtNs6TFXm+VPXYd08FfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K35xhHbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K35xhHbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BF41F000E9;
	Fri, 14 Aug 2026 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722198;
	bh=YGFUvj+2BpzlIYpBdDSU2VS5zfAHrxueMysMFKJTK7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K35xhHbZ06CHWx4KvlG7T+pZQIBjCQTzrOFPR489ilscVEOQTERNK/ZdoXyZQyyVt
	 e7PYOyvvDZG60+O4M0gwCSYUXhtGYWaz35YwYcSkijkEUgfdj9fee31CjALwfE4KUp
	 BG6+SYAahYNJtrbNFEfX9LsP1rCF7YaFmHgNnQm4rL6qcVyRXLIgGKGx/9tkHgPyRQ
	 aLukgSrgElJvIrk3S7AL4R6M/YzpqAppec3Gt/WTwXk/TT5D2KQ76uO9NfrQXG/7oQ
	 f0Ovki18LUKVWEhX1gOAPEm2Ri6ft1pSyf3ZOAoDkkS5PHbBXgONmHrPil7/Ghaqob
	 BmrsvL2GOTYXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] dma-buf: heaps: Add debugfs support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, robh@kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, conor+dt@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-6-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-6-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:43:17 +0000
Message-Id: <20260814154318.03BF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition in `dma_heap_add()` allows userspace to trigger a=
n exploitable use-after-free by opening the character device before the ini=
tialization completes.
--

--- Patch [6]: [PATCH v5 06/10] dma-buf: heaps: Add debugfs support ---
commit f236972ccf6e5f7088156d7adcf0aed10121c6c6
Author: Thierry Reding <treding@nvidia.com>

dma-buf: heaps: Add debugfs support
   =20
Add a callback to struct dma_heap_ops that heap providers can implement
to show information about the state of the heap in debugfs. A top-level
directory named "dma_heap" is created in debugfs and individual files
will be named after the heaps.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3937dd41bb0f6..f279b8fdd3ce0 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c

[ ... ]

> @@ -299,6 +334,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
export_info *exp_info)
> =20
>  	/* Add heap to the list */
>  	list_add(&heap->list, &heap_list);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (heap->ops && heap->ops->show)
> +		debugfs_create_file(heap->name, 0444, dma_heap_debugfs_dir,
> +				    heap, &dma_heap_debug_fops);
> +#endif
> +

[Severity: High]
This is a pre-existing issue, but is there a race condition in this function
that could lead to a use-after-free?

In dma_heap_add(), cdev_add() is called earlier, making the device accessib=
le.
If the duplicate name check fails, it goes to the error path, destroying the
device and freeing the heap structure:

drivers/dma-buf/dma-heap.c:dma_heap_add() {
    ...
    ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
    ...
    list_for_each_entry(h, &heap_list, list) {
        if (!strcmp(h->name, exp_info->name)) {
            ...
            goto err3;
        }
    }
    ...
err3:
    device_destroy(dma_heap_class, heap->heap_devt);
    ...
err0:
    kfree(heap);
    return err_ret;
}

If a user concurrently opens the device between cdev_add() and the kfree()
on the error path, would the resulting file descriptor retain a dangling
pointer to the freed heap structure in file->private_data?

Could a subsequent ioctl() on this file descriptor then dereference the fre=
ed
heap, triggering a use-after-free?

>  	mutex_unlock(&heap_list_lock);
> =20
>  	return heap;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D6
