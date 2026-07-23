Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C538E5C8
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802890; cv=none; b=Z1WQYF1WnAxPJILgqkgxMIShhAv0NAv08H6WeByekGn/89dadt3XC4qSaFzblMHqTRvv9QdEsQQZy7fq8n+gGE2A16/3wTqe7JY6yaI4CQRrKL0k6mxwjNBgwl01J8zR3FtlfYu5VT2hBDjM3uxeTajfcI5eL2eGvdruk6D4y9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802890; c=relaxed/simple;
	bh=JE4bbCEulP+AaPpCnokdovtCMh0husOxSuDOugSPehg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fd0lUk9gy4CVm8563piIxGMoM7Raqzr/Y2Pqa9+zwQcKWpOxI1//IIhCOGq5Gtg990zFMb6aywlfyedT6KmSOaXPwH4uz/jYVvP6ZNKLucD0nY8iWPHV66d3c6zDCLR29RTv4IQAdG9ngOqVunQDNbZjRaBgctNTGnaUbr7maTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878ED1F000E9;
	Thu, 23 Jul 2026 10:34:48 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/zcrypt: Close speculative mem read
 possibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723095453.127322-3-freude@linux.ibm.com>
References: <20260723095453.127322-1-freude@linux.ibm.com>
 <20260723095453.127322-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:34:48 +0000
Message-Id: <20260723103448.878ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Authorization bypass for administrative CPRB requests via domain a=
uto-selection.
- [Medium] Incomplete Spectre v1 mitigation for the user-controlled domain =
value.
--

--- Patch [2]: [PATCH v3 2/2] s390/zcrypt: Close speculative mem read possi=
bility ---
commit 231c807d810ac3d48184d28be474dabc8e020aa9
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Close speculative mem read possibility

This commit attempts to fix a speculative execution vulnerability in the
s390 zcrypt driver. It adds an array_index_nospec() barrier for the domain
value during administrative CPRB processing to prevent potential
side-channel attacks.

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcryp=
t_api.c
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -879,12 +879,13 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap=
_perms *perms,
> =20
>  	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {

[Severity: High]
This is a pre-existing issue, but does this check allow an authorization by=
pass
for administrative requests if the user specifies AUTOSEL_DOM (0xFFFF) as t=
he
domain?

If an administrative CPRB request uses AUTOSEL_DOM, the condition
`domain < AP_DOMAINS` evaluates to false, causing the code to skip the
`test_bit_inv(domain, perms->adm)` administrative permission validation
entirely.

Later in _zcrypt_send_cprb(), the queue selection logic autoselects a queue=
 and
only validates the user's usage permissions via zcrypt_check_queue(). Does =
this
allow unprivileged users with access to a restricted custom device node to
execute administrative commands on a queue where they only have usage right=
s?

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> +			domain =3D array_index_nospec(domain, AP_DOMAINS);
>  			if (!test_bit_inv(domain, perms->adm)) {
>  				rc =3D -ENODEV;
>  				goto out;
>  			}
>  		} else if ((ap_msg.flags & AP_MSG_FLAG_USAGE) =3D=3D 0) {
>  			rc =3D -EOPNOTSUPP;
>  			goto out;
>  		}
>  	}
>  	/*
>  	 * If a valid target domain is set and this domain is NOT a usage
>  	 * domain but a control only domain, autoselect target domain.
>  	 */
>  	if (domain < AP_DOMAINS &&
>  	    !ap_test_config_usage_domain(domain) &&

[Severity: Medium]
This isn't a bug introduced by this patch, but does the un-sanitized domain
value remain vulnerable to speculative out-of-bounds reads here?

The patch adds array_index_nospec() inside the AP_MSG_FLAG_ADMIN check, but
for non-administrative requests, the domain variable is used unmitigated in
ap_test_config_usage_domain() and ap_test_config_ctrl_domain().

Both functions call into ap_test_config(), which uses the domain as an array
index. Since the `domain < AP_DOMAINS` bounds check can be speculatively
bypassed, does this leave a Prime+Probe side-channel attack gadget open for
non-administrative requests?

>  	    ap_test_config_ctrl_domain(domain))
>  		domain =3D AUTOSEL_DOM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723095453.1273=
22-1-freude@linux.ibm.com?part=3D2
