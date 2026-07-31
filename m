Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594B34AB01
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513058; cv=none; b=AgwPwtdFJukk9BWF5ntnLnWDAeXzfZuqPNG8rAIbkHfxT7Fnf/t5NTcISPGX4ktSH1rtNEPKLHCNYSPKU+LNHxDVSKgLsYwMfnQeQtRZsGmIqeqggLEGIFPDKjMCdkfOiwpdKwAUnFauSyq+AQKRNGGurD4Nd+3T4G3RXAlHlWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513058; c=relaxed/simple;
	bh=4fADXhpAlTyoC/mY2S7n8f8zDtPTnroraTa6iuy/zTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuH/6zJVZq4KWlhxTEzSUr4hznOtCT3reNkFscpETNCmAKyVd6f4Jtv7421R3+sFEclucG6/octqxN2quPC4NBYNJlSm2IPCcU4nqEIdU+11QYUNXf/n/hV/zMhl5iWSj58cc6uXSG2jCERs+VGZ1/uHF+/qRO/ksvVurSKgGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgXCYhYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgXCYhYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C511F000E9;
	Fri, 31 Jul 2026 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513057;
	bh=96RCBz415FAIFnffZY+NxYRwkbCDXt689G0mUtj12t8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgXCYhYWtBj9M8DgX4VoYrvabL0hB1SUyDglontubQBCD0p2yODi3bkTsWV7HZ2ci
	 0Pp9GxOqwH5OovApCfYRC0Ro2vOHAa5V2VqQtSAGCK/js8lfrHwP8g1BJvQaISecdP
	 UvfFuBrfXaV4I0Dxop/uE6mDuVkdYdWlkvOj4ainnsgNAdPx1XGXFuOBtSbYnG3rpI
	 2zzKiVDyirYNxAqbNKfY8oTbi/fVqVGCT79M5bBIwQGQZyFwEg6kVDZMwFhMkonEC7
	 /1VRaHtBbkSx7I7QX9LdJAi4YJ2CtiUSCpm12khtY9Cno83FFr28xid+g/pAHm1txH
	 GsIN7eHrUv92g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] s390/dasd: Propagate partial completion length
 across ERP recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-2-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:50:56 +0000
Message-Id: <20260731155056.A5C511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `ese_read()` is completely ignored, leading to=
 silent data corruption on read failures.
--

--- Patch [1]: [PATCH v5 01/17] s390/dasd: Propagate partial completion len=
gth across ERP recovery ---
commit 804bfccaf59e282c990c294a7564d63b4f3b75a4
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Propagate partial completion length across ERP recovery

This patch updates dasd_default_erp_postaction() to copy the proc_bytes
field from the finished ERP request back to the original request. This
prevents partially completed requests from losing their completion length
during ERP recovery, avoiding silent data corruption for thin provisioned
devices.

> diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
> index 89d7516b9ec86..468f0b2cc3423 100644
> --- a/drivers/s390/block/dasd_erp.c
> +++ b/drivers/s390/block/dasd_erp.c
[ ... ]
> @@ -147,6 +149,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(stru=
ct dasd_ccw_req *cqr)
>  	cqr->startclk =3D startclk;
>  	cqr->stopclk =3D stopclk;
>  	cqr->startdev =3D startdev;
> +	cqr->proc_bytes =3D proc_bytes;
>  	if (success)
>  		cqr->status =3D DASD_CQR_DONE;

While reviewing this fix for thin provisioned devices, I noticed the follow=
ing
in dasd_int_handler():

drivers/s390/block/dasd.c:dasd_int_handler() {
    ...
		if (rq_data_dir(req) =3D=3D READ) {
			device->discipline->ese_read(cqr, irb);
			cqr->status =3D DASD_CQR_SUCCESS;
			cqr->stopclk =3D now;
			dasd_device_clear_timer(device);
			dasd_schedule_device_bh(device);
			return;
		}
    ...
}

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does this code ignore the return value of ese_read()?

If ese_read() encounters an error and fails to zero out the block buffer, t=
he
request still unconditionally completes with DASD_CQR_SUCCESS.

Could this result in the block layer being handed uninitialized memory or
previous page contents instead of zeroed data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D1
