Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE042EEA7
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896617; cv=none; b=XRdBGCYxHO3nXXEYF0ApXdJ7Tuzbt3bsjxlPc3i+206ufKiiMIW4mlYusa8EomRKh6i/oYuIHjNrrz9lhOUEkWbsxbChw/rP+DVad9hCIWWjbFIfIJ5saQitYjUHhxM0dSc3awpemnxrBBUS0nvqdcry6sXHZ7Ytvh76a/HWZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896617; c=relaxed/simple;
	bh=YGK5HNPW7zOoPtx2Y0HXik1ZHIRIL/dk25FLf+kf3Do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUqzKmLy/8MKVcR6iZSdIuB0U/X/M/Eb5UCwu6O0gfASxOQ/208Cf0ei9OU8K/0sQtg71mf5DoZex8j+tWFXxozrA5uD22DO6uNh4vn9gVMdlstjgMLZyw1OMUM5pSAgJoj4oPgfmeqAixx0wHtpnFmV+tkzXiqzFeklkliPbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA81b6N+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA81b6N+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2886C1F00A3D;
	Fri, 24 Jul 2026 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784896614;
	bh=Y5AH7pvWACI83NhcjL+gAS/m2k/jEP9Bc8eVhqu6UjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eA81b6N+45ECNA/WRnc7dhTqjJ7PKcxs2wAXEfz0qJ3rHMRVDm2msfZ44+OAj3zc/
	 qW85ORDX/Z/cdTf11qUxGvf49LlWZdKJRLfh4ysz5L0Du2kJCABK7P96WL6Xfs1mMp
	 c6UtiIQt8k6hpiH+JXiiiAXTpQKwcE1WTa+tu9SKHwy6sSw6Uu8vdsyUgOrUiS2V9R
	 PunMbz+Px9SFhIVtbnyCegY0tK8fY0JRAzCS/Y7BrJPXFqOupr6Yj4Mn8aQ8Ktc3S9
	 z9qhtqO9YCqt2ai9nziYd9qxmjqQuqAeNrxgl1PsXvudL1pevWIIOXA4CNsJOzIv2J
	 OYnsnYPLWzd7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/sclp: Allow SCLP Action Qualifiers for Spyre card
 status reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
References: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 12:36:53 +0000
Message-Id: <20260724123654.2886C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The sysfs `report_error` binary attribute does not verify that t=
he user-provided write buffer size (`count`) is large enough to cover the e=
mbedded payload length (`report->length`). This leads to reading uninitiali=
zed kernel heap memory which is then sent to the SCLP hardware.
--

--- Patch [1]: [PATCH] s390/sclp: Allow SCLP Action Qualifiers for Spyre ca=
rd status reporting ---
commit 320785563461e373b0db5b021ac2e04f40ee8406
Author: Niklas Schnelle <schnelle@linux.ibm.com>

s390/sclp: Allow SCLP Action Qualifiers for Spyre card status reporting

Add SCLP Action Qualifiers used by the Spyre stack for reporting of the
card's initialization status, recoverable errors, and telemetry data.

> diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
> index d61a7fc0dd610..b79ef7006e46f 100644
> --- a/drivers/s390/char/sclp_pci.c
> +++ b/drivers/s390/char/sclp_pci.c
> @@ -99,6 +99,9 @@ static int sclp_pci_check_report(struct zpci_report_err=
or_header *report)
>  	case SCLP_ERRNOTIFY_AQ_INFO_LOG:
>  	case SCLP_ERRNOTIFY_AQ_OPTICS_DATA:
>  	case SCLP_ERRNOTIFY_AQ_NVME_SMART_LOG:
> +	case SCLP_ERRNOTIFY_AQ_ADAPTER_INITIALIZED:
> +	case SCLP_ERRNOTIFY_AQ_RECOVERABLE_ERROR:
> +	case SCLP_ERRNOTIFY_AQ_TELEMETRY_DATA:

[Severity: Medium]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but could this code leak uninitialized kernel heap memory to the SCLP
hardware?

Looking at how report_error_write() handles the sysfs write, it verifies the
buffer is at least as large as the header struct:

arch/s390/pci/pci_sysfs.c:report_error_write() {
	if (off || (count < sizeof(*report)))
		return -EINVAL;
}

However, it does not check if the user-provided count is large enough to co=
ver
the embedded payload length (report->length).

Later, when sclp_pci_report() processes this report, it copies report->leng=
th
bytes:

drivers/s390/char/sclp_pci.c:sclp_pci_report() {
	memcpy(sccb->evbuf.data, report->data, report->length);
}

If a user writes a small payload length but specifies a large report->length
in the embedded header, will memcpy() read past the end of the sysfs buffer
and send uninitialized heap data?

>  		break;
>  	default:
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-sclp_allow=
_aqs_spyre-v1-1-569acfe11385@linux.ibm.com?part=3D1
