Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E056E070;
	Wed,  9 Sep 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962960; cv=none; b=N2KKhZL4eZZpDJlqxBVN7VbrzGatkBRbtBoRbZjZ72KdLoprHdb220OV3evoJ1fx1HB1l/a7IC0MQuo/3rrbOJnlujqf7KYiN374KtQ16WmyLqolQxwioDtlGGqg3ZC5kdb0LwBf9cm7zayXL6A2WmuFzdQ8+oEtMJulvUv6gP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962960; c=relaxed/simple;
	bh=UYl0oDkXo/O834y0le8l/SaNgp2VNh/d6jQw3dgbD28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5wL8CKbJkSaV+nU+qLRE+5IxJFZUUWv8+hwVpkSbOZ3XmCsXg+b4v4NDWeffelyHufh/PGE/IFn1+TzhIbjCfv+Gw9H5mq2bkqEYKFM4y/wjtPU9Vn2yTc0HCiVLQLdUbTfuxwrg6N3t1QrNJ+TPpVR2VhUeWq8K7ebkSnxt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpsxHwVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpsxHwVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE61F00AC4;
	Wed,  9 Sep 2026 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962958;
	bh=O1ST6aXUH4vLpGnMtkmVRunw3NWN0K0+mb6hBsdUCQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DpsxHwVyJX+mrQa6mAky5OHHf6TFNA21E6ZCddduSrSRcT71dXX+HYOrNVCiH02lh
	 0epweTWOEemt3L0dqdvgVp6qEO9xKlgTASLFi5+Ge5GqannAwBDJ6JIQgsnh9vmmX5
	 0LD/ql5NK8av7/oJ/DIG2iW7PTrztIVCyd1JyMeniKbr6LmCan8I7BsDAsTXiamNbi
	 vDx3BbpxlyFntwBuYSHr50Bdq12mThCO9ojnYQkFCPesgUNK9O1sYznv3WoboWSSxV
	 hbPbUeLOMHIuF1GDyZWbgY3rR9lv8C+aW40dmHgEN2w10T7hwE10LEVo9Pr2AD5x84
	 OvExso9usG7FA==
Date: Wed, 9 Sep 2026 16:09:15 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>, 
	Mark Rutland <mark.rutland@arm.com>, Saravana Kannan <saravanak@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 08/12] dma-buf: heaps: Add debugfs support
Message-ID: <aqFnTYSaVfNrDzLN@orome>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-8-79042cfa8de5@nvidia.com>
 <a77730b2-b5d6-49f9-a8ab-72eac4e241b6@amd.com>
 <2fd989b4-06ea-42e6-b18a-bc3ef2e069f5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xrykvyn4aewo5kb"
Content-Disposition: inline
In-Reply-To: <2fd989b4-06ea-42e6-b18a-bc3ef2e069f5@gmail.com>


--3xrykvyn4aewo5kb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 08/12] dma-buf: heaps: Add debugfs support
MIME-Version: 1.0

On Wed, Sep 09, 2026 at 01:04:03PM +0200, Christian K=C3=B6nig wrote:
> Since AMDs mail servers blocked me from sending this out, here once more =
=66rom my gmail account.
>=20
> Regards,
> Christian.
>=20
> On 9/4/26 15:00, Christian K=C3=B6nig wrote:
> > On 9/4/26 12:44, Thierry Reding wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Add a callback to struct dma_heap_ops that heap providers can implement
> >> to show information about the state of the heap in debugfs. A top-level
> >> directory named "dma_heap" is created in debugfs and individual files
> >> will be named after the heaps.
> >>
> >> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >=20
> > One minimal nit pick below, with that taken care of Reviewed-by: Christ=
ian K=C3=B6nig <christian.koenig@amd.com>.
> >=20
> >> ---
> >> Changes in v5:
> >> - fix failure handling during debugfs root directory creation
> >> - add more cleanup to the newly introduced dma_heap_exit()
> >> ---
> >>  drivers/dma-buf/dma-heap.c | 52 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/linux/dma-heap.h   |  2 ++
> >>  2 files changed, 54 insertions(+)
> >>
> >> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> >> index 8a6c2b6e0cc6..65c80dac6500 100644
> >> --- a/drivers/dma-buf/dma-heap.c
> >> +++ b/drivers/dma-buf/dma-heap.c
> >> @@ -7,6 +7,7 @@
> >>   */
> >> =20
> >>  #include <linux/cdev.h>
> >> +#include <linux/debugfs.h>
> >>  #include <linux/device.h>
> >>  #include <linux/dma-buf.h>
> >>  #include <linux/dma-heap.h>
> >> @@ -225,6 +226,40 @@ const char *dma_heap_get_name(struct dma_heap *he=
ap)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> >> =20
> >> +#ifdef CONFIG_DEBUG_FS
> >> +static int dma_heap_debug_show(struct seq_file *s, void *unused)
> >> +{
> >> +	struct dma_heap *heap =3D s->private;
> >> +	int err =3D 0;
> >> +
> >> +	if (heap->ops && heap->ops->show)
> >> +		err =3D heap->ops->show(s, heap);
> >> +
> >> +	return err;
> >> +}
> >> +DEFINE_SHOW_ATTRIBUTE(dma_heap_debug);
> >> +
> >> +static struct dentry *dma_heap_debugfs_dir;
> >> +
> >> +static void dma_heap_init_debugfs(void)
> >> +{
> >> +	dma_heap_debugfs_dir =3D debugfs_create_dir("dma_heap", NULL);
> >> +}
> >> +
> >> +static void dma_heap_exit_debugfs(void)
> >> +{
> >> +	debugfs_remove_recursive(dma_heap_debugfs_dir);
> >> +}
> >> +#else
> >> +static void dma_heap_init_debugfs(void)
> >> +{
> >> +}
> >> +
> >> +static void dma_heap_exit_debugfs(void)
> >> +{
> >> +}
> >> +#endif
> >> +
> >>  /**
> >>   * dma_heap_add - adds a heap to dmabuf heaps
> >>   * @exp_info: information needed to register this heap
> >> @@ -299,6 +334,13 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> >> =20
> >>  	/* Add heap to the list */
> >>  	list_add(&heap->list, &heap_list);
> >> +
> >> +#ifdef CONFIG_DEBUG_FS
> >> +	if (heap->ops && heap->ops->show)
> >> +		debugfs_create_file(heap->name, 0444, dma_heap_debugfs_dir,
> >> +				    heap, &dma_heap_debug_fops);
> >> +#endif
> >> +
> >>  	mutex_unlock(&heap_list_lock);
> >> =20
> >>  	return heap;
> >> @@ -335,6 +377,16 @@ static int dma_heap_init(void)
> >>  	}
> >>  	dma_heap_class->devnode =3D dma_heap_devnode;
> >> =20
> >> +	dma_heap_init_debugfs();
> >> +
> >>  	return 0;
> >>  }
> >>  subsys_initcall(dma_heap_init);
> >> +
> >> +static void __exit dma_heap_exit(void)
> >> +{
> >> +	dma_heap_exit_debugfs();
> >> +	class_destroy(dma_heap_class);
> >> +	unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> >> +}
> >> +__exitcall(dma_heap_exit);
> >> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> >> index 648328a64b27..1c9bed1f4dde 100644
> >> --- a/include/linux/dma-heap.h
> >> +++ b/include/linux/dma-heap.h
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/types.h>
> >> =20
> >>  struct dma_heap;
> >> +struct seq_file;
> >> =20
> >>  /**
> >>   * struct dma_heap_ops - ops to operate on a given heap
> >> @@ -24,6 +25,7 @@ struct dma_heap_ops {
> >>  				    unsigned long len,
> >>  				    u32 fd_flags,
> >>  				    u64 heap_flags);
> >> +	int (*show)(struct seq_file *s, struct dma_heap *heap);
> >=20
> > I found it good coding practice for objects ops pointer tables to have =
the object the function works with as first parameter.
> >=20
> > Absolutely not a must have, but just looks a little bit more consistent.

Agreed, I generally prefer that too. However, in this case I thought it
more important to model this after how pretty much every debugfs file
operation works, which is to take the seq_file as first parameter. It's
the same order as for the main dma_heap_debug_show() entry point that
this is called from, so it's consistent that way.

I guess an alternative way to think about it is that in this case the
object that we're really working with is the seq_file and the dma_heap
is what gets written to that seq_file.

Thierry

--3xrykvyn4aewo5kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqhaIgACgkQ3SOs138+
s6HunhAAiN37Dd+TG+BFBCdSRmV2hMHjWc+FdBQaTN44THpv2z6VMPtar+lpEOnj
ebQ25tBFfYNr5t1GcY62OjCbvi/nUicdtL8MDwLDFBlN7Klb2heTA6ahS/DbqzaM
g35ClGbknLWH/2yEe3Wff2iduod4n7FhE5HM19ScvUcISiIhCVlHuki/axbv+c94
jHwJA3xCbYyCA22i6ss9TBlxL6V0eerGlHSsnuXwsfV/f9/SHw3MoH3LrA1nlS08
csdw+ZNM3zf8cE0jJll9c9NgdvTDzn00bilN8r8tt4tnKofQRJ03VhlBCvOtdzYl
7LFnV+2C3V7Go2x8cInDtWmz0Uatp9H7gCsZ/AofL8i+HoiOpfsqoHWZaoNxLPGv
Th28zBw41Il1iqyN4qN39Xir+SpyZrI4ltGF2+CHMBK+3/czC/UUhh3wev+fVdnR
JL9BfJo1SbiPT8mk/uyZziU+wXJz0HQ/MNwX1fZjNHcOKn+hfHnSnV36uqcVFxJ3
DcXi/LFGMKZ6M5pXSprA26JBc3wJZwMWBIR1ouZZxJLef0sZARBlRNjobVJ+9z6r
7Wu/0KnLumcEpKcvleRPffm/phk+cjMESwnvx7gq6Blmo/8weR179dWKjb1NhNkb
GyYJGi/bcNybqbqfqrn5F0FLm+a/1qG78dywKqc/4yrX6HWPnFA=
=gj3n
-----END PGP SIGNATURE-----

--3xrykvyn4aewo5kb--
