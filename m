Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453C42A179
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507765; cv=none; b=Zti+uO5+n919vGr/9TGpZbS80gOskhr3+eE6M4BEBqIikm66tBgMOxo5BLor1+Kj1k9cOL6+YgUmpNKAVAStTdkv5Jfpl+XxdHzsMArF1hgv4DccpeyPDBuS4JjKn5q20OyK2iZND+IG1JT/Loo6UIiG6mX9NB+IcutSXDSvH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507765; c=relaxed/simple;
	bh=vvsRF8xR8FCfvlOrBXBAGofwwq67q4glIEIlGIKnwDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idUZ6GIU0yM6sN+T+B6lSik0zwz1RRNKJH032iT9z2AYvcArZZLIlOwPJLpWs5ohxDrV4oJgov1U+IfZQQANWiq2V5XytniTCb8MVTbZwRBPN9JLWQsM4oAi+eAjE1EbDD3vxE6i1SVvQ4Fw26V+Kf1dZIr5wJpmBAFAb/W82+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkFxYS2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkFxYS2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FD11F000E9;
	Fri, 31 Jul 2026 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507763;
	bh=A3FBaSnzDktxcg/cSiEdH4GW9HH5QEocGOlmSSpCFxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkFxYS2A7P7ZZvIMgBPMg4YPQdxRRCG2bPghYkOTeox1F3b7zC7rZ0bUB7dRfmOip
	 MvYVWePf75cTG+N9hYmBeB/wswlLJAsbzGyryRnj15Lld6/23SPJZVd9pK7AMZVDvl
	 MPha0B2u1MeMjLNGm2U5FmApgzmP9tILKF+Zen3MhimDrx+l0gt4TzP52QPQPiyJQX
	 9GxkdNX8ZAQSJPan/DcnlEJgAyGhD686jfjvl56UuzuB6uSDGW/CmC/GGzwMmr6OGo
	 VtA2HkN33fKYfjp7CbRi4L/i0xEITVS/45PQI9kd6YKiDxjvfBREFMT3LFfPcShn1+
	 Puexkv9JBetbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/qeth: validate user buffer length in SNMP and
 ARP query ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730142216.218309-1-hidayath@linux.ibm.com>
References: <20260730142216.218309-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:22:42 +0000
Message-Id: <20260731142243.29FD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated length fields from hardware responses lead to kernel h=
eap out-of-bounds reads and memory disclosure.
--

--- Patch [1]: [PATCH net] s390/qeth: validate user buffer length in SNMP a=
nd ARP query ioctls ---
commit f9f8c7e047077e9dbc90a35127afc75e1690d27f
Author: Hidayath Khan <hidayath@linux.ibm.com>

s390/qeth: validate user buffer length in SNMP and ARP query ioctls

This commit validates the user-supplied length (udata_len) against a lower
bound (udata_offset) before allocating the buffer in SNMP and ARP query ioc=
tls.
This prevents underflow during callback bounds checking and fixes a
ZERO_SIZE_PTR allocation when udata_len is 0.

> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_co=
re_main.c
> index f18eed9df3c7a..c3257b213360c 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -4710,6 +4710,9 @@ static int qeth_snmp_command(struct qeth_card *card=
, char __user *udata)
>  	if (req_len > QETH_BUFSIZE)
>  		return -EINVAL;
> =20
> +	if (qinfo.udata_len < sizeof(struct qeth_snmp_ureq_hdr))
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does this expose the kernel to a heap
out-of-bounds read if the hardware returns an invalid length?

In qeth_snmp_command_cb(), the response length is calculated from the
firmware's header:

	data_len =3D adp_cmd->hdr.cmdlength - sizeof(adp_cmd->hdr);
    ...
	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
		return -ENOSPC;
	}
    ...
	memcpy(qinfo->udata + qinfo->udata_offset, snmp_data, data_len);

The check ensures data_len fits within the userspace buffer (qinfo->udata_l=
en),
but doesn't verify if data_len exceeds the actual hardware response buffer
length. If a compromised or malicious firmware returns a large cmdlength (a=
nd
userspace provided a large udata_len), could this memcpy() read past the en=
d of
the hardware response buffer and leak adjacent kernel memory back to usersp=
ace?

>  	iob =3D qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len=
);
>  	if (!iob)
>  		return -ENOMEM;
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_m=
ain.c
> index 1542bfc9f561b..f1ac9950dcb4e 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -1415,6 +1415,11 @@ static int qeth_l3_arp_query(struct qeth_card *car=
d, char __user *udata)
>  		rc =3D -EFAULT;
>  		goto out;
>  	}
> +
> +	if (qinfo.udata_len < QETH_QARP_ENTRIES_OFFSET) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but is there a similar out-of-bo=
unds
read issue when processing the ARP entries?

In qeth_l3_arp_query_cb(), the code trusts the firmware-provided
qdata->no_entries without checking if the entries actually fit within the
received hardware response buffer:

	for (e =3D 0; e < qdata->no_entries; ++e) {
        ...
		esize =3D get_arp_entry_size(card, qdata, etype, do_strip_entries);
        ...
		if ((qinfo->udata_len - qinfo->udata_offset) < esize) {
			return -ENOSPC;
		}

		memcpy(qinfo->udata + qinfo->udata_offset,
			&qdata->data + entrybytes_done + stripped_bytes,
			esize);
		entrybytes_done +=3D esize + stripped_bytes;

Like the SNMP issue above, the bounds check only verifies that there is eno=
ugh
space in the destination user buffer (qinfo->udata_len), but does not check=
 if
we are reading past the bounds of the hardware response buffer. Could a
malicious firmware response with a large no_entries cause a kernel heap
out-of-bounds read?

>  	qinfo.udata =3D kzalloc(qinfo.udata_len, GFP_KERNEL);
>  	if (!qinfo.udata) {
>  		rc =3D -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730142216.2183=
09-1-hidayath@linux.ibm.com?part=3D1
