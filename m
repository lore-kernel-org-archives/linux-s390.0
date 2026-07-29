Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096C4DB57A
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340946; cv=none; b=FDpA/0uNaicV2H3kmxAorpXjmczFNR79bPGFwrL+Sqte+f4tyW3t/SA1zcz7t0lpHO0RKwmdQ2Pto+lcgvcDEftL+Qm2j6jgmNatNPpafczGXiIXvff2WFFw7DyEdcnKM/A49ZSdR4jxm7TZJbUr3B0/1yxDSttR0DaNbUXuka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340946; c=relaxed/simple;
	bh=7InHlSGK/Pa9dGGs5LCKPhLg3Dhn29PRxT49d00Rmg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1lj3VPsxklHQSwEvjJEtqqv3ueA//WF6K1Or4yvidSKNhafnGe8GC75xhwiZduj/XsTFHP20OfsbdsinOWX1onnWAGrsMdsAkgxQbQODxHLgp+RCE7ob2wa3wgOCIJig2rmraYs8e3hPQcQpRSdmehT+6UMnlTiJftuH6/YuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi6t6Z9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi6t6Z9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422111F00A3A;
	Wed, 29 Jul 2026 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340944;
	bh=46EswHke7HaP/QQmu4sxShUrd4UlQvas/gAjeTptySg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fi6t6Z9yN+Od/BH48V3C6Wu9BkpLqrj8jKKAFOGkG0Rv8T6waaWqA/BY8Ck1DM+H1
	 5lypKd0Jt/SBdni4hZv0UioQ49SkSikciO2kWQg/BHBrMv39AG1r1/EH4Mgv2KEt1m
	 AGBH8vmCFnNyR0jfbgybRPhQhgLM/Ulc2P8MJh4A176hG0LRUIx1/ewgvYNQ1J5w/1
	 7GazucpnfNTYtSnYoyVDBEth5xpE9sb5iWuO9CqZfWpiHJupbMVEU2pBWOuTBzHa8w
	 /vikoSDPTTmtSz8JnwATyJTzk3kmoFbezki0caWt65b0K6dAoQOfqRXxbzFsUGWXMV
	 yV+VwZo6LNaNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/5] s390/zcrypt: Fix CPRB memory allocation in
 zcrypt misc code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729154458.195135-2-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:02:23 +0000
Message-Id: <20260729160224.422111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel heap memory padding is leaked to the crypto h=
ardware via the AP bus message buffer.
--

--- Patch [1]: [PATCH v9 1/5] s390/zcrypt: Fix CPRB memory allocation in zc=
rypt misc code ---
commit bbdecb3add414a50e3e90e0021b88d5f9c7bf242
Author: Harald Freudenberger <freude@linux.ibm.com>

    s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
   =20
    Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
    did not round up the memory allocation to a multiple of 4 bytes as it
    is needed by the zcrypt layer to process the CPRBs.
   =20
    Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
    guarantee that the base CPRB struct and a possible parameter block are
    aligned to a 4-byte boundary and the backing memory allocation is
    rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
    updated and scrubs the rounded up amount of memory.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index 84936a795b956..6819acd67c49b 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing how CPRB
requests are padded and aligned, I noticed a pre-existing issue in
drivers/s390/crypto/zcrypt_msgtype6.c.

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6cprb_msgx() {
        ...
	/* prepare CPRB */
	if (z_copy_from_user(userspace, msg->userdata,
			     xcrb->request_control_blk_addr,
			     xcrb->request_control_blk_length))
		return -EFAULT;
        ...
}

Does this code leak uninitialized kernel heap memory padding to the crypto
hardware via the AP bus message buffer?

When a userspace application calls the zcrypt ioctl (e.g., ICARSAMODEXPO)
with an unaligned request_control_blk_length, the ap_msg->msg buffer is
allocated via kmalloc without __GFP_ZERO by ap_init_apmsg().

Since only the unaligned length is copied into the buffer, while the total
message length sent to the AP card uses the 4-byte aligned CEIL4() length,
could the unwritten padding bytes (up to 3 bytes) retain their previous
kernel heap contents and be transmitted to the hardware?


[Severity: High]
This is a pre-existing issue, but the same behavior appears in
xcrb_msg_to_type6_ep11cprb_msgx():

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
        ...
	/* Import CPRB data from the ioctl input parameter */
	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {
		return -EFAULT;
	}
        ...
}

Can the unaligned request length copied here also leave padding bytes
uninitialized before being sent to the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729154458.1951=
35-1-freude@linux.ibm.com?part=3D1
