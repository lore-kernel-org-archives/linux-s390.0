Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F99306765
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731999; cv=none; b=g/xyfIYVlzFH9R0qHO4TuvUXr6GuipRqr/qr320pVIkvf56KXjVgwsH5O7NF9iWh1LXnOZCc6HC/SzA/q7tB3Ty6TBmhNuQZSU/Iq7FwxpoQt/Uc+1gXRyjsX+AZBefcwlJoULtL9y77UTBo/Vm0NtIW9pxwA4iQs4gF8uWjbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731999; c=relaxed/simple;
	bh=Xg65Pf/Nr1Vblps4pYqu2/c0QF3GmMoVU6CiHt8i7SE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KL8SxOwgWyS6XdvbmMrKJquu6rZVa+YMKZCXJLi29Zj0uvjvmL1Si1ChUw1dQkIl+tmKdJzfjG2PUNWWMPEAvY8cTt+8LB0qELjeJHasWSCsw4Bm0PG+wsH+JFt5TQJJiwuOyaH/sRJaCh1mz3yNuB0mx+wvZi8olCPeG1ubwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/Dh06KX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/Dh06KX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F70D1F000E9;
	Wed, 22 Jul 2026 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731997;
	bh=l2riv4yKcYuGC2iu1n3zSHbkuPSj8yybfJbyFNUVNLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/Dh06KXhuq+2ObSBbXqUMY0yAsk7XxokOti2lb7/ZPXGYm9tlU5gZp2/mGk8Lb7d
	 J21/Zpn6oSfd4eskme0iJQ7PUoA1tc2GHfd1KgdaMSLzaEkdyUqk/obPG0LUhCFVyT
	 hr/TLTcPvTgdjofekmAz3tnlkfI3rDhLr1D6IWgpPYVwV1tH6c5bG3PIDldERUGSiW
	 3EecoofwrAssvvCC7JLia7j30GWX6Jx6xSuZy4xgqMn1IrmAKABt20WnxFnh/ATUBZ
	 5vTi8e0BogdHNoN3rFXMlk2AzUuxS+Cp73A89uFRUpx7ofm3L6A3g3+R+gaPKuVXmm
	 gmc1O1FCvH1mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Fix wrong domain value verification
 with EP11 CPRBs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722143831.109929-2-freude@linux.ibm.com>
References: <20260722143831.109929-1-freude@linux.ibm.com>
 <20260722143831.109929-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:53:16 +0000
Message-Id: <20260722145317.6F70D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The administrative permission (`perms->adm`) check can be comp=
letely bypassed by supplying a domain >=3D AP_DOMAINS (such as AUTOSEL_DOM)=
, allowing unauthorized administrative commands to be executed on queues wh=
ere the user only has usage access.
--

--- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Fix wrong domain value verificat=
ion with EP11 CPRBs ---
commit bde27d2c3d10843f1570c9d533dc3ccd2e17bf0f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs

There is a wrong upper limit check for the domain value when an EP11
CPRB is processed for sending to a crypto card. This check is only
active on custom device nodes but may lead to access heap memory
behind perms->adm when an administrative CPRB is sent.

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcryp=
t_api.c
> index f57189c2b839e..81eefdeae2485 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -1077,7 +1077,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, stru=
ct ap_perms *perms,
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
> =20
> -	if (perms !=3D &ap_perms && domain < AUTOSEL_DOM) {
> +	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {

[Severity: Critical]
This is a pre-existing issue, but does this logic allow an unauthorized
administrative command to bypass the perms->adm check entirely if a user
supplies a domain value greater than or equal to AP_DOMAINS, such as
AUTOSEL_DOM (0xFFFF)?

If domain >=3D AP_DOMAINS, this condition evaluates to false, completely
skipping the administrative permissions check. The driver then proceeds to
autoselect a queue using zcrypt_check_queue(), which only verifies the usage
mask (perms->aqm), ignoring whether the queue is being targeted by an
administrative command.

For example, if a user issues an ioctl with an admin command and sets the
domain field to AUTOSEL_DOM, the driver bypasses the perms->adm verificatio=
n.
Then, as seen in paths like zcrypt_msgtype6_send_cprb() for CCA, the
AUTOSEL_DOM value is overwritten with the selected queue's real domain ID
before dispatch, converting the bypassed command into an executable hardware
command. The same bypass exists here in the EP11 request path.

Can a user with only usage permission on a custom zcrypt device node use th=
is
to execute arbitrary hardware administrative commands?

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
>  			if (!test_bit_inv(domain, perms->adm)) {
>  				rc =3D -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722143831.1099=
29-2-freude@linux.ibm.com?part=3D1
