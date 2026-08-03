Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DE33509B
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746967; cv=none; b=azokw+mWDGOITZrCy24aReFsGlw3hCQMW9GfBxR7cbZsRymugl7zRcJ651S+nRdwaa7GOGIu286I69VnSqZhCIXaAQG1ZNXfkzaXIDR6fDyHK1U9q7xTfqzAyH002ABeLPObYfpEuI42t3WrIxzQkt4oMfS+4VCeorxHnI8jcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746967; c=relaxed/simple;
	bh=HJ8+oD62c3V3zA14mnqkAVQpds/CcKBFh5KY1Kevszk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8R4++A39CcC+7A/VFhWcHWbS10qvKTIcQgi5f9D8xjk/lvUpUmf+vVmdNu4lL7U4CFqQAgwKsPtPKIL6i+0pQXKrwtx8RJuUpgncpqFNneP7d6IhDyBk1AEE1qUG3xtyn7YrfIuibjfvvdrI57zGaVztu0zF3VJ+JzVfQGEkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1nwvpO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1nwvpO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617881F000E9;
	Mon,  3 Aug 2026 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746965;
	bh=9hUnEIThD2NEXWR1rKfHpW0hteKXXDWvENgM7E4m2Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e1nwvpO/9xhoif3K9MqL2LOcuIABNFX5JACV/Y3pLVgXx8eyJhuxmMWZQTpCSqOxg
	 bg6mYjj9H5OrjLxPMlvBQ4rlpLkut1k63OS9mvApr+jYdOUHnpo8dxS/sy/Ju/YOvH
	 mKSKqeLjJq89Gu2rG6sonM6l/PT90kq9eaRYV+JdT5kUG/+eFeMZpmZeXVs+kbf89V
	 p9HykU96zFZd0kjiU5bgmzZ7F7I10T79IkjxF36Y4X3z0oX0VqoGFaeFq4lxai8fip
	 DgrhXPvGrAPCmqktMDn6aJ2dqSc8jorAk+GO/2wUZQhNccxGM0AmfW90wcVTlFXasp
	 VrJoPbS2vobIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803083339.212885-6-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:49:24 +0000
Message-Id: <20260803084925.617881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The function `zcrypt_type6_crt_key()` leaves up to 7 bytes of pa=
dding uninitialized before sending the key token to the crypto card, leakin=
g kernel memory.
--

--- Patch [5]: [PATCH v11 5/5] s390/zcrypt: Pad trailing CCA or EP11 messag=
e with zeros ---
commit a6bb8fce2d346e386b1306d838ac36f1853d13f8
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Pad trailing CCA or EP11 message with zeros

This commit pads the gap between the message copied from userspace and
the message buffer sent to the CCA/EP11 hardware. This prevents
uninitialized kernel memory from being forwarded to the crypto card.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index e79e68b4dd41d..3df1d676de5d8 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -398,6 +398,10 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace=
, struct ap_message *ap_msg,
>  			     xcrb->request_control_blk_addr,
>  			     xcrb->request_control_blk_length))
>  		return -EFAULT;
> +	/* pad tail with 0 up to req_cblen */
> +	if (xcrb->request_control_blk_length < req_cblen)
> +		memset(msg->userdata + xcrb->request_control_blk_length,
> +		       0, req_cblen - xcrb->request_control_blk_length);

[Severity: Medium]
This is a pre-existing issue, but while reviewing this fix for uninitialized
memory leaks, I noticed a similar issue in zcrypt_type6_crt_key() where
pad_len bytes appear to be left uninitialized:

drivers/s390/crypto/zcrypt_cca_key.h:zcrypt_type6_crt_key() {
    ...
    memset(key, 0, sizeof(*key));
    ...
    if (copy_from_user(key->key_parts, crt->np_prime, long_len) ||
        copy_from_user(key->key_parts + long_len,
                       crt->nq_prime, short_len) ||
        copy_from_user(key->key_parts + long_len + short_len,
                       crt->bp_key, long_len) ||
        copy_from_user(key->key_parts + 2 * long_len + short_len,
                       crt->bq_key, short_len) ||
        copy_from_user(key->key_parts + 2 * long_len + 2 * short_len,
                       crt->u_mult_inv, long_len))
        return -EFAULT;
    memset(key->key_parts + 3 * long_len + 2 * short_len + pad_len,
           0xff, crt->inputdatalength);
    ...
}

Because sizeof(*key) doesn't include the flexible array member key_parts[],
the memory inside key_parts is uninitialized before the copies.

Does the final memset() skip over pad_len bytes by adding it to the offset,
leaving those padding bytes uninitialized before being sent to the firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803083339.2128=
85-1-freude@linux.ibm.com?part=3D5
