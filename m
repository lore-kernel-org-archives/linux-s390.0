Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECE443E58
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321631; cv=none; b=ufIiEaWYTmaJArQ2qDfcxo+L7FyitHnlbfv59h3QMgcDGlzjSuIRRatQv7dojvlUGy5mfW20v63JuxO4gg1JnGkZtuugtn5hEUVTqZWpqPN494MTBDPSnXwcZv5uIYOtytqYaHFh1DdyMrBlu+mx9xLQeRNTsjfCb+xu1LZTd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321631; c=relaxed/simple;
	bh=zAaaWpnJ+CwRjnw2NTaYVsP+zPc3ycpJ5r8J5sEA+Y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dkpsqa/R0zduApsWqtBTQsiwbI2r9x9YJvmbd9f0BGyO7TUPyrDchkbAXRL7THgebliwyI76jyUgxcP22h3I92EN5Lo82P1NKqEPEE8u37lMZ1J/8oYhG3w8VoqwFBEVVBSr27V20+NSdKNIgiXS9DTbrQj0ZbkNcR8Mhmx3Kw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVjD582H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVjD582H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DF11F000E9;
	Wed, 29 Jul 2026 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785321630;
	bh=iss/ajLrRshKNcLwjKRKm3uBoXL2N2MdoIYxo4B2Jqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVjD582HVMD/glLqCB7MwlN+KAiDvlP4f89Wi5I1aVhk8utBAbwFImpdIy6q14Fnt
	 SCFLYRpTo9GHKqlM5/ps2i67/sIRKGJtEZtqSQIxE+SKjZLRqtyhqepOP1cCfuzrwK
	 tqaE+yueOvjmYqGQ0/+mu37zesREQupMUfemPt+xne7Z/g75leo4HyqSxOERaA6Fx1
	 8di/VWHTPaNFBSFdKSwvRj5KvLDkPrb18+N9r9H5HJBAuNScrCSN2thUBdTH8S9TVH
	 D31jgN2qP+Rxc56Pi8Bc+kVJSBaa+cvtNTSm77GRhK0g3LdzGf4nxeYTssHmDlkTMj
	 wd1RJ1SdTXxFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729095318.184141-3-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
 <20260729095318.184141-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 10:40:29 +0000
Message-Id: <20260729104030.62DF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses integer overflow and uninitialized memory read=
 vulnerabilities in the CCA CPRB processing function (`xcrb_msg_to_type6cpr=
b_msgx`), but completely overlooks the sibling function `xcrb_msg_to_type6_=
ep11cprb_msgx` which suffers from identical flaws.
--

--- Patch [2]: [PATCH v7 2/5] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit 7ba0a2485f45508566e0f47333fa671569923db4
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks

The xcrb_msg_to_type6cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Integer overflow after CEIL4 alignment: Signed int variables could
   overflow during 4-byte boundary alignment, causing undersized
   buffer allocations or incorrect bounds checking.
2. Missing minimum size validation: The CPRBX structure is copied from
   userspace without verifying sufficient buffer length. Undersized
   buffers cause uninitialized memory access when reading structure
   fields like cprbx.cprb_len and cprbx.domain.
3. Arithmetic overflow in sum calculations: Adding control block and
   data block sizes could overflow, bypassing size checks and enabling
   buffer overflows.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, validating minimum control block size before
copying from userspace, and detecting sum calculation overflows.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..fb37e28c82424 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -437,10 +428,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
>  	}
> =20
>  	/* copy data block */
> -	if (xcrb->request_data_length &&
> -	    z_copy_from_user(userspace, req_data, xcrb->request_data_address,
> -			     xcrb->request_data_length))
> -		return -EFAULT;
> +	if (xcrb->request_data_length) {
> +		req_data =3D ap_msg->msg + sizeof(struct type6_hdr) + req_cblen;
> +		if (z_copy_from_user(userspace, req_data,
> +				     xcrb->request_data_address,
> +				     xcrb->request_data_length))
> +			return -EFAULT;
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the sibling function
xcrb_msg_to_type6_ep11cprb_msgx() in this same file appears to suffer from
the exact same vulnerabilities being fixed here.

For example, when req_len is smaller than the required struct size,
z_copy_from_user() can complete successfully but leave trailing buffer
bytes uninitialized:

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
...
	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {
		return -EFAULT;
	}

	if ((msg->pld_lenfmt & 0x80) =3D=3D 0x80) { /*ext.len.fmt 2 or 3*/
...
}

Because ap_msg->msg is allocated without zeroing, this reads uninitialized
kernel heap memory to perform routing and access control logic (like
domain, fcode, and whether the request requires admin or usage permission).
Additionally, CEIL4 can overflow for lengths near U64_MAX, bypassing
initial length checks.

Should xcrb_msg_to_type6_ep11cprb_msgx() also receive similar minimum
size validation and overflow checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729095318.1841=
41-1-freude@linux.ibm.com?part=3D2
