Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD24A090F;
	Tue,  6 Oct 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303955; cv=none; b=uadPYSy3mI0zUnMZq0H85E1ViVDL3KOjZW5f+Jll5SPXdLPVzuBg9FqjwlK/VOvO8WxT1ZYeBvMMGDDFCs9h66V18pBYFKas10MniFcTZiAFtMp9i/02Q+BV/gaWlPI8l449o2xXkz2SDzN/AQw1ALhacLzHUmd3vyYqfF56cRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303955; c=relaxed/simple;
	bh=lSnhXeQv3XQyRS6OBM+3d0fnTn0I93SC+kPChVKd8rU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kraSOj69KWw6aABbwXz4gITnohw8Pt6Kc6+l3LesLrr91BxVF3eKVnRti3u8l2zEJCXfvdEOKx1xyndVpSHBDPLlTfmQP5HFywjmC9ibKEL9hiKqfaj6Q8BMSnOD+elVusI8mUiLYdrNZ2DePjb0vw0or/reJZ0tG9thnz1XWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1t9W777; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1t9W777"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B61F0089B;
	Tue,  6 Oct 2026 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303950;
	bh=lSnhXeQv3XQyRS6OBM+3d0fnTn0I93SC+kPChVKd8rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1t9W777PXUCL9xbpOuvS2KVFqJVHOXy/PncySNvO+m7NQtOWWEQqymiydJxzyBLC
	 pncw/L4WsrWIEbjtgXcPvaKpS+Dt+qcLAO0AMBj7bmprq3uDPW6v2VIcrd93Tpnkqk
	 AWY4Bxt4cSl1tpAUMgz5ZMPK/yDgQ1RmRXCnXdtAWB6ZuVBu5PSGEFzLArkp7Af30b
	 wLZFBwm59VrfAIYO92mNIQfTJvEFjMU85o0pnSRC7pqyvFhw5PPFJcVddQC0NGRcql
	 0g3+dsZDTCVlrUAKvrZL5VTLe758XwUyqa8K3zVuW7ib0gnDEczQDigAEyGpzMQZmj
	 ox4yEot33yLYg==
Message-ID: <sashiko-outbox-162254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005154557.57801-3-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
 <20261005154557.57801-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:25:49 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Don't free the FMB buffer when disabling measurement in
> zpci_fmb_disable_device(). Instead, make the buffer persistent for the
> lifetime of the device and reuse it across enable/disable cycles. Defer
> freeing the buffer until teardown in zpci_release_device().
>=20
> To support the persistent buffers, add the fmb_enabled bool to struct
> zpci_dev to decouple whether FMB is enabled from whether the buffer has
> been allocated. Audit the only consumer of zdev->fmb as a liveness check
> and update it to reflect this change.
>=20
> Introduce the function zpci_fmb_reenable_device() to ensure that the FMB
> is enabled. If it was already enabled, disable it, zero the counters,
> and re-enable it. This allows the function to be used in both first-time
> enabling and re-enabling measurement. Call it in zpci_reenable_device()
> to preserve the FMB enablement if it had been implicitly disabled by
> firmware in zpci_disable_device().
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005154557.5780=
1-1-oelghoul@linux.ibm.com?part=3D2

