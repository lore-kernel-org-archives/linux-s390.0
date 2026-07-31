Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB10463B87
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515235; cv=none; b=KYGYNpuibkACjVN8X4hCO9bhg7/Y8nFXreyl7tsElA+LT2KynBXyl0HkKJcbfgDm1JYzY1YC87VCSANBtMGe8HIPlgK2HT4oB7l+qv4mOJbRfwcexXYl1GuWhKOLHuuBWPtHNX91834gT9PHi6M1xBXduWsTgFs/BcN9yKOLPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515235; c=relaxed/simple;
	bh=ZMgDiHdKzADJrsJduvyRBR1T5YDFM4c8ZRZh1QQ7svw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFyumRNdhPTqI1OTOmTfaGUQA5tt95eGfvX5aR1uVtWjj6lfKtdsNtQuu2wPxe52etFAyMEZ+jPQ7E53IQxkXCzNHmR7jCrb83Sl/HFKzO+x+5IUD7DLLAV9C5g8RGs4pdXGJh9zm4jnFMvY6huDZYQ/U4LUwmJwi2RIDPNdclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB1jsLwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB1jsLwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113A71F00AC4;
	Fri, 31 Jul 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515233;
	bh=Kxu2bCY925+yUAG1bhlQmXraffWXwne99TFDR6w3Hos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jB1jsLwmLKorb55dd0uo91LY385k7vrHTDGUmA9/1Efpskn2Fh8bQcHfIrhEf3Te3
	 xNTUshqqGHLlryhZtM5xHhHGB+Xczx92GBGm0NAsDAc5veQx9+8NaRSD0lxsrdToky
	 3+65tI83w117scCK+TSlic9YUY2q1WHk3nz4m5Yg4w0f5MJpt6okpgutIP1TMjnJ4L
	 0Z4+kbAGlgOsMggzI37kMOaBRacOjUHeTx1Cjv9Hv9cA534OKQnZwl6tZ1PFby8emi
	 OFqAcfsThesZpu4Tk1XU/mU63z4nJjOnxQ4nkN3Rurg8VN4pCfVXmowFXbADKleBDt
	 +rg6OUATlmSUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] s390/dasd: Derive adaptive ESE fulltrack
 heuristic from ft_bias
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-13-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-13-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:27:12 +0000
Message-Id: <20260731162713.113A71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The adaptive heuristic parameters are never initialized during dev=
ice startup because `dasd_ft_bias_apply()` is called before the device's ES=
E capability is known, causing the heuristic to evaluate on every single I/=
O.
- [High] The NRF rate calculation can overflow a 32-bit signed integer, cau=
sing the heuristic to improperly remain in plain write mode during heavy un=
formatted I/O.
- [High] The lockless heuristic evaluation and sysfs updates fail to serial=
ize state machine transitions, leading to state divergence where the device=
 permanently sticks in fulltrack mode.
--

--- Patch [12]: [PATCH v5 12/17] s390/dasd: Derive adaptive ESE fulltrack h=
euristic from ft_bias ---
commit fc455715bb1f927b75206de59511e6f8a3abe72f
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias

This patch turns the middle of the ft_bias range into an adaptive heuristic
that switches between fulltrack write and plain write depending on device
sparseness. It measures the NRF rate in short probe windows to determine
when to flip back to fulltrack write mode.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index cc5a4791cb8f4..1df861f80c268 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -2160,6 +2160,7 @@ dasd_eckd_check_characteristics(struct dasd_device =
*device)
> =20
>  	/* default ESE fulltrack write aggressiveness from the module parameter=
 */
>  	device->ft_bias =3D min_t(unsigned int, full_track_bias, DASD_FT_BIAS_M=
AX);
> -	/* only the "always" endpoint forces fulltrack unconditionally here */
> -	device->fulltrack =3D (device->ft_bias >=3D DASD_FT_BIAS_MAX) ? 1 : 0;
> +	dasd_ft_bias_apply(device);

[Severity: High]
Does calling dasd_ft_bias_apply() here happen before the device's ESE
capability is known?

In dasd_eckd_check_characteristics(), dasd_ft_bias_apply() is called early.
This function relies on dasd_ese_adaptive(), which checks is_ese(). However,
is_ese() depends on private->vsq, which is populated later when
dasd_eckd_read_vol_info() is called.=20

Because vsq is empty at this point, dasd_ese_adaptive() returns false, and
the heuristic parameters (like ese_heu_start_interval and
ese_heu_probe_window) are left initialized to 0. Will this cause the
heuristic interval to pass immediately and the FSM to evaluate on every
single I/O?

[ ... ]

> @@ -3235,6 +3241,65 @@ static void clear_format_track(...)
> +static void dasd_ese_heuristic_tick(struct dasd_device *basedev)
> +{
[ ... ]
> +	case DASD_ESE_HEU_PROBING:
> +	case DASD_ESE_HEU_FT0_STABLE:
> +		nrf  =3D atomic_xchg(&basedev->ese_nrf_window, 0);
> +		rate =3D nrf * 1000 / ios;
> +		if (rate > (int)basedev->ese_heu_nrf_high) {

[Severity: High]
Can this rate calculation overflow a 32-bit signed integer?

During the FT0_STABLE state, the ios interval backs off up to max_interval
(500,000 IOs). If a workload performs large sequential writes into
unformatted space, an I/O can span multiple tracks, triggering multiple NRF
events.=20

If the number of formatted tracks reaches ~2,147,483 within the 500,000 IO
window, nrf * 1000 will exceed INT_MAX and overflow to a negative value.
Could this cause the check to evaluate to false and improperly keep the
device stuck in plain write mode during heavy unformatted I/O?

> +			/* NRF rate high: device still sparse, ft1 is better */
> +			basedev->fulltrack          =3D 1;
> +			basedev->ese_probe_state    =3D DASD_ESE_HEU_FT1_ACTIVE;
> +			basedev->ese_probe_interval =3D basedev->ese_heu_start_interval;
> +		} else if (basedev->ese_probe_state =3D=3D DASD_ESE_HEU_PROBING) {
> +			/*
> +			 * NRF rate low: device mostly formatted, ft0 is faster.
> +			 * Re-probe frequently at first, then back off below.
> +			 */
> +			basedev->ese_probe_state    =3D DASD_ESE_HEU_FT0_STABLE;
> +			basedev->ese_probe_interval =3D basedev->ese_heu_probe_window;

[Severity: High]
Can this lockless state transition race with a sysfs update and permanently
stick the device in fulltrack mode?

If a thread is transitioning from PROBING to FT0_STABLE (evaluating
basedev->ese_probe_state =3D=3D DASD_ESE_HEU_PROBING as true) but is preemp=
ted
before writing the state, a concurrent sysfs update via
full_track_bias_store() -> dasd_ft_bias_apply() could reset the FSM:

drivers/s390/block/dasd_int.h:dasd_ft_bias_apply() {
    ...
    device->ese_probe_state    =3D DASD_ESE_HEU_FT1_ACTIVE;
    device->fulltrack          =3D 1;
    ...
}

When the preempted thread resumes, it would set ese_probe_state to
DASD_ESE_HEU_FT0_STABLE but leave fulltrack as 1. Since fulltrack =3D 1
suppresses NRF events, the measured rate stays at 0 and the FSM interval
backs off without ever resetting fulltrack to 0, completely defeating the
adaptive heuristic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D12
