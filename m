Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214449;
	b=M5uSpT0aHpvE61tLPTo1AIdUqFZlmmfSSBjPTWXM/9wHvzHWbenrh5Pa2Y/5wvl24/fS
	 Wt7W11ycbxe7ySJTKKfdrOH9+F91FMPma18Z26I2YLRhJeyOGeyMNf+loHl0mcbcTBF1O
	 CbRjhOnzmatPC3Ifp1E3Ej3MO3saJ6uW34qGZubE4/ZUZH1IIU/tABA3hFu/qNwcjTQl6
	 ODyCzPOGA9lxyKKbJDJoxBIc7xIrF2gWglRita1d1bXFDqcA/SrJxVoICIgu22DwON64r
	 yBnVzbGOVMGtk6lZOMElLaSONd9wC/OTmZ10WrgN4vxOE/jht230Ugaw6uw5wVLDMcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iRY0hs3t1UIJHrMY7KhRUYSSk+YxXEfybfwdTdfJ8vM=;
	b=qMvHr1YBjsx4Z108vgsnV1ZgdHOTw/S6irVePbukV6pcL38+DkyRB3v93dYo3s/8SDEJ
	 yDMGzqAls0rz7o7XJip4bQnUcl88zeUHgLnp4IvjI3tRIe4/d1Sld/jyY00hj0qtuOiOK
	 H9UVn75lhFVsAl59hwWnUxGFbn8cASs7C45iBFWAulUUyGTmuNf9fKhLthz2z2kQ9tOel
	 Pv56pEW09yOxx5I5InQHvQiOF7TR3yh+RdqVmfaKKeAc7mzO0LE4xa3c0HUgJRbpRVwyQ
	 Tvafi1HTLNdcVAjqOBzcPoe1XoJipdBNTket05I8kx5n4cH0TF80QH1zqI3Nc1JTK8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq0uqR6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF675606D806;
	Mon,  9 Nov 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq0uqR6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD801F0089F;
	Mon,  9 Nov 2026 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214448;
	bh=iRY0hs3t1UIJHrMY7KhRUYSSk+YxXEfybfwdTdfJ8vM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hq0uqR6BElEaCwwSb+zjshC+xWB4fYkHuBrJhsj/MJrZYd+ijnbrh+ze9e0h6Titc
	 Py4r6UvR+e6QQzNz+TLdZ5z3hOvgGFh0QEliWHGSZAm0tKT5fcZKeLQFbjiq+lwWv2
	 /OValNsv6ATe/dw2KvU7A6U2fc3dx3wToMXYpbfc+HGdDxRULH//XsOCy9NFsSYq3A
	 VSf01Y4dG7LzTtn6mnAFUc/Q/HvkzoPbwIj0bu4bTUh4/BuiWLMmlSfC4MTfWKelzt
	 RtgXBqTOcrnnalfAUz5/NdLatUldL07jYYs+XTW7BrB0iUaIc35A0gz3Pa2zNaHA0V
	 acnnKkgguBY/w==
Message-ID: <sashiko-outbox-204633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] s390/hmcdrv: Replace page allocator calls with
 k[mz]alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Janosch
 Frank" <frankja@linux.ibm.com>, "Claudio Imbrenda" <imbrenda@linux.ibm.com>, "David
 Hildenbrand" <david@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:54:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] s390/hmcdrv: zero-length requests rejected with -ENOMEM in
  hmcdrv_ftp_cmd()
--

commit 64ed22d8db2caf381431154b54f669d68274ef30
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/hmcdrv: Replace page allocator calls with k[mz]alloc()

This commit replaces get_zeroed_page(), __get_free_pages(), and
free_page[s]() in the s390 hmcdrv driver with kzalloc(), kmalloc(), and
kfree(), rounding buffer sizes up to PAGE_SIZE.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/char/hmcdrv_ftp.c b/drivers/s390/char/hmcdrv_ft=
p.c
> index 3312b2ac00a9d..e22789b532de2 100644
> --- a/drivers/s390/char/hmcdrv_ftp.c
> +++ b/drivers/s390/char/hmcdrv_ftp.c

[ ... ]

> @@ -238,16 +238,16 @@ EXPORT_SYMBOL(hmcdrv_ftp_probe);
>  ssize_t hmcdrv_ftp_cmd(char __kernel *cmd, loff_t offset,
>  		       char __user *buf, size_t len)
>  {
> -	int order;
> -
>  	struct hmcdrv_ftp_cmdspec ftp =3D {.len =3D len, .ofs =3D offset};
>  	ssize_t retlen =3D hmcdrv_ftp_parse(cmd, &ftp);
> =20
>  	if (retlen)
>  		return retlen;
> =20
> -	order =3D get_order(ftp.len);
> -	ftp.buf =3D (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, order);
> +	if (!ftp.len || ftp.len > KMALLOC_MAX_SIZE)
> +		return -ENOMEM;

[Severity: Medium]
Does rejecting !ftp.len here break zero-length commands such as
HMCDRV_FTP_DELETE?

Previously, get_order(0) returned 0 and __get_free_pages() allocated one
page while leaving ftp.len set to 0, allowing a 0-byte read() or write()
on /dev/hmcdrv (via hmcdrv_dev_transfer() -> hmcdrv_ftp_cmd()) to execute
commands that carry no payload.  With this check, those requests fail with
-ENOMEM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-char-=
ready-v1-0-3db507722530@kernel.org?part=3D5
