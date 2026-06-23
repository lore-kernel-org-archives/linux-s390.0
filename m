Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1AA3909B5
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237337; cv=none; b=UJ3DRiBX31jGrumpiwFs8oTiKXhB7zFgOU0cxr8TpxAg4K3Ijxe5y8ba2GRPcrFbeLsCacxl0OqfGW89mWn8u8SrJrFoRFltrMZ/jDhX5qzmWHatAEgJ3YZ6GIv5O0m83Qflf0jbpRB6kKbsVe2mvnGEEChA5K8zC2eZxsuGB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237337; c=relaxed/simple;
	bh=bgUM23udWjb/ajW87cKNDXbXJIsEl0QbLezMBIeR074=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBlNRamIXl5AQ5B0LLOhdNrN97zK4RdNIpBQSl5HtPZMmni5x9htOvYIJu0GRKpNi9ys5gxTNHpMBN4JXpKCsFuFM/uvgcH5VcxKlpjT8GPVuFWSDoMHBlCHxcRfizuVjyAHssjQo6ef0lHE1SJa++V2/P+LMTJxO49YesNbT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ9a0Xny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ9a0Xny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB41F000E9;
	Tue, 23 Jun 2026 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782237336;
	bh=Ytwh57pCKjC1lFxgEalwrQWhoSPOVBaCsFlx9ftISUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ9a0XnyDfbjZ6jwMox0+KVfZp/4SAQ4SzwBLylns8hLS1iCzFlI2uoAjFD3RECQa
	 sgiGaSv/vKAV14uP3/qh+z4pYqng0TT9/OoVFwAxX5aHGKNtXFbD3dTxk0ebB9D5DO
	 FOrSOrAdcg57n4pY9x+dbu+sE2QrWehBp/9M+8NYKqkirNs7AKgDLP8ogHSvZJ3sr4
	 thzaYr1EslwqNDYQUPK8ZFEeRnNyMVtjGoqajFSj8AOR/beXWVVttoQx3DTIB9zOut
	 dzgkYG1UFJJjhZublwGrti7R1f4HwiDBTKewk+MD7T/szcjud7L6c8n9llBbU6fMa1
	 +5tUaR80EVweg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/monwriter: Reject buffer reuse with different
 data length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260623174406.189869-1-gerald.schaefer@linux.ibm.com>
References: <20260623174406.189869-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:55:35 +0000
Message-Id: <20260623175535.ECBB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stranded MONWRITE_GEN_EVENT buffers cause mon_buf_count to underfl=
ow on close, allowing unbounded kernel memory allocation.
- [High] The global variable mon_buf_count is updated concurrently without =
any synchronization, leading to a data race.
- [High] Asynchronous teardown failure in monwrite_diag leads to hypervisor=
 Use-After-Free/Information Leak.
--

commit eaf3c589ff6055b82f62fc5d169905bbb8fd5129
Author: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: s390/monwriter: Reject buffer reuse with different data length

This commit fixes an issue where reusing data buffers with different data
lengths could lead to an out-of-bounds user copy. It introduces a check in
monwrite_new_hdr() to reject interval sample records if the new data length
does not match the original buffer length.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
> index eaeb4a6384d1f..ecf121a87f88f 100644
> --- a/drivers/s390/char/monwriter.c
> +++ b/drivers/s390/char/monwriter.c
> @@ -122,6 +122,9 @@ static int monwrite_new_hdr(struct mon_private *monpr=
iv)
>  			kfree(monbuf->data);

[Severity: High]
This is a pre-existing issue, but does this code risk a hypervisor
use-after-free or information leak if monwrite_diag() fails?

If kmalloc() fails inside monwrite_diag() during the teardown phase, it
returns -ENOMEM without issuing the APPLDATA_STOP_REC instruction to the
hypervisor. Because the error is ignored here and the data buffer is freed
unconditionally, the hypervisor will continue reading the freed kernel
memory.

>  			kfree(monbuf);
>  			monbuf =3D NULL;
> +		} else if (monbuf->hdr.datalen !=3D monhdr->datalen) {
> +			/* Data with buffer reuse must not change its length */
> +			return -EINVAL;
>  		}
>  	} else if (monhdr->mon_function !=3D MONWRITE_STOP_INTERVAL) {
>  		if (mon_buf_count >=3D mon_max_bufs)

[Severity: High]
This is a pre-existing issue, but is there a data race on the global
mon_buf_count variable?

Multiple threads opening /dev/monwriter can concurrently execute
monwrite_write() or monwrite_close() using their own per-file-descriptor
thread_mutex. Because mon_buf_count is updated and checked without a
global lock, concurrent modifications can corrupt the counter and allow
the buffer limit to be bypassed.

[Severity: High]
This is a pre-existing issue, but can this logic lead to a mon_buf_count
underflow?

If a user writes a MONWRITE_GEN_EVENT header with a data length of 0,
monwrite_write() will skip calling monwrite_new_data(), leaving the buffer
permanently on the monpriv->list. Since mon_buf_count is not incremented
for MONWRITE_GEN_EVENT buffers:

drivers/s390/char/monwriter.c:monwrite_new_hdr() {
        ...
        if (monhdr->mon_function !=3D MONWRITE_GEN_EVENT)
                mon_buf_count++;
        ...
}

When the file descriptor is closed, monwrite_close() iterates the list
and unconditionally decrements mon_buf_count for every entry:

drivers/s390/char/monwriter.c:monwrite_close() {
        ...
        mon_buf_count--;
        list_del(&entry->list);
        ...
}

This underflows the global counter into negative values, effectively
disabling the mon_max_bufs limit check for future writes.

>  			return -ENOSPC;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623174406.1898=
69-1-gerald.schaefer@linux.ibm.com?part=3D1
