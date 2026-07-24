Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CD433BB9
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901679; cv=none; b=Ndl/oEBHTAjBsaIXjMkLeBohaVFEYrurdMD5ufQDwPsPVU1qH8NouL081QslJqoImrqqOTA/gHqHMqRt9/1DPM/im9B1oXE83iXhxfSu8J8YTfanav44Vp6GoR85V6L104Jdn8ZkqGHidwu0tNY4hbugCGM7z48hfD7N5b/CVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901679; c=relaxed/simple;
	bh=PJs96jJ1sMpIGStsC8hbObiOXtj81hGbMCTs/Do0m64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gZZauQXQOZYdcyYktga9cX+pkAntVyv5l2QbC/so9tXC5LFwAuikSwjTQW/5fqZ6hCeLvMaztDczUFXvSJMupwuGKQjXZzPyrWQLylLrDgJ7FYsMJNCp4qUnaWKSLOkc9AdB/bgHfj25j2Few79jXQ2cn0fs2fuEp1+vWZ1BBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQywNnd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQywNnd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523F1F00A3D;
	Fri, 24 Jul 2026 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901675;
	bh=E2JV6E80CQMtsQah/aTatUfLpAVaINSlLgLNxlQ47lw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQywNnd39vKm3u370lUD78j4Gss+gajoFexPEOzfAjnEt6ieYTVkRIrRwLqX239pe
	 npPnKFXKaVYKYMTWFGR2isKeXVs+Z1UOR/O3xOYcw0XVSmOgG3IYLGgTgGi32fJVr3
	 wyoNstrEzSL2m8bKOZaWal6r0MrB267qJDnBuI0QyEGIggxAxhyThvD9AlTXOoh16E
	 iF6lXs6mdsU4AIok8DW/LyBfGCoyofdNO8RJHzaRI1k0JnVcSNR/V7khYY/wZkvXzv
	 TwpSW6oUO4UR6ngsYJjruZortw6CyIX/+PsXgy/nezVl9SNcm19EpiEq2+whIaQeAk
	 YDezdBTybKsRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/qeth: Check CAP_NET_ADMIN for private ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aswin Karuvally" <aswin@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723140050.762991-1-aswin@linux.ibm.com>
References: <20260723140050.762991-1-aswin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:01:14 +0000
Message-Id: <20260724140115.2523F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An integer underflow in the buffer size check allows privileged us=
ers to cause a kernel heap buffer overflow.
--

--- Patch [1]: [PATCH net] s390/qeth: Check CAP_NET_ADMIN for private ioctl=
s ---
commit 3ec90fe5fb86d5d8d0432c2487ad687ef4d3e227
Author: Aswin Karuvally <aswin@linux.ibm.com>

s390/qeth: Check CAP_NET_ADMIN for private ioctls

This commit adds a CAP_NET_ADMIN capability check to the
SIOC_QETH_ADP_SET_SNMP_CONTROL, SIOC_QETH_GET_CARD_TYPE, and
SIOC_QETH_QUERY_OAT private ioctls. This ensures that these commands cannot
be invoked by unprivileged users.

> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_co=
re_main.c
> index 20fb0d2e02a9a..f18eed9df3c7a 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -6525,6 +6525,9 @@ int qeth_siocdevprivate(struct net_device *dev, str=
uct ifreq *rq, void __user *d
>  	struct qeth_card *card =3D dev->ml_priv;
>  	int rc =3D 0;
> =20
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
>  	switch (cmd) {
>  	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
>  		rc =3D qeth_snmp_command(card, data);

[Severity: High]
This is a pre-existing issue, but does qeth_snmp_command() allow an integer
underflow that leads to a heap buffer overflow?

If a user provides a udata_len smaller than sizeof(struct qeth_snmp_ureq_hd=
r)
(16 bytes), the unsigned subtraction in the callback underflows:

drivers/s390/net/qeth_core_main.c:qeth_snmp_command() {
    ...
	if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
    ...
	qinfo.udata =3D kzalloc(qinfo.udata_len, GFP_KERNEL);
    ...
	qinfo.udata_offset =3D sizeof(struct qeth_snmp_ureq_hdr);
    ...
}

drivers/s390/net/qeth_core_main.c:qeth_snmp_command_cb() {
    ...
	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
    ...
}

The underflow would bypass the available space check, leading to an
out-of-bounds memcpy into the allocated heap buffer.

The same integer underflow pattern appears to exist in qeth_l3_arp_query_cb=
()
for the SIOC_QETH_ARP_QUERY_INFO ioctl.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723140050.7629=
91-1-aswin@linux.ibm.com?part=3D1
