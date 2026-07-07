Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AA420883;
	Tue,  7 Jul 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416434; cv=none; b=YW/AQQFALpNK/4Gcti7bp88P/3QKz7c8XxbNa7c+CviSxd3Y90Hi1S54jJMhmj7ck7pQ3ihovuZPnUoxOsQUVu8SHTp9XlDYOC7Cg6MHyTwUcRed+grtrYV7OuaX6wfSb+iLCzaM/r8Fa9b1bHf9r98A1ZV+qjg2Yz7xWvrQ280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416434; c=relaxed/simple;
	bh=UaSFtB48N+ufUOAHbNrAGclYffohN00lkPS2Z7SiNxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cK3N3YXh2oy4l4g2rleNmJZJY5reqAyzIAz6caj7ia24jnwwzYWs/JlaCqaDrY8XxM3NKu0qvHpB2lqym+RTApzBs+1m6FGkYSs3cKFxWshZSm92oeDdjBG9PMA81DPVmshWexCQgLbONdiUrt40pcgksZCrPnVbWXKbIKhUAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2BxhF7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2BxhF7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C81F00A3D;
	Tue,  7 Jul 2026 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416433;
	bh=Ky+eaI23aauwVYnwA69SMHeW3bC74igKB3eEyOCtgmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2BxhF7pvnlwaCuod3HThOB8LMMjKYCBHJAT562sVYzGE+NN8BjVoKS8tuNeimg8y
	 YDra6oWSTTC8zcO+dRy9Awxo20pOXrdzOygpHcSR5araq54LkVmuN0/TAX36EpDZQU
	 V0QvbLmJttRRn/a0xKKA42QegrL6cNKZqouwnpLwALIatd2w1EuvsEGAnvlSPIz/69
	 gax4u9z04J2IpNNMiMjWkoJmICRDVIQ6/BMm19a/5p037EvMrxWO/GCgwnyey13zSl
	 3xyBqdEb6KGwAiVfJOCVvzxofTHhKJvZZNHGXik6ZH67lNKu2oLRtg2bYWTsqkza92
	 lqAdOl9+S2WRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-16-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:27:12 +0000
Message-Id: <20260707092712.A48C81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added documentation for live guest migration contains mul=
tiple typos, grammatical issues, factual errors, and ReST formatting proble=
ms.
--

--- Patch [15]: [PATCH v4 15/15] s390/vfio-ap: Add live guest migration cha=
pter to vfio-ap.rst ---
commit e1db7dba8604c95334563aa2130ba1fa4ead1210
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

Add a 'Live Guest Migration' chapter to the
Documentation/arch/s390/vfio-ap.rst document to describe the details for
initiating live guest migration for a guest to which AP adapters, domains
and control domains have been passed through.

> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s39=
0/vfio-ap.rst
> index ac0c07f76ddd7..fc0707c0dffd6 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst
[ ... ]
> +  * Display the AP configuration of the destination host:
> +
> +    .. code-block:: bash
> +
> +       lszcrypt -V
> +       cat /sys/bus/ap/ap_control_domain_mask
> +
> +    Note that each bit in the ap_control_domain_mask corresponds to
> +    correspond to domain numbers 0-255. If a bit is set to one, then
> +    the control domain is available on the destination host. For
> +    example:
> +
> +    .. code-block:: bash
> +
> +       0x0000000000001020000000000000000000000000000000000000000000000000
> +
> +       This mask indicates that AP adapters 51 (0x33) and 58 (0x58) are
> +       available on the host system.

[Severity: Low]
This isn't a bug, but there are a couple of inaccuracies in this sentence.

Since we are examining `ap_control_domain_mask`, shouldn't this refer to
"AP control domains" rather than "AP adapters"?

Also, the hexadecimal value for 58 is 0x3a, not 0x58.

[ ... ]
> +  * Verify the hardware capabilities for each AP adapter device on the s=
ource
> +    and destination host are compatible. The ``ap_functions`` attribute =
is a
> +    bitmask. The bits in the mask read from left to right starting with =
bit 0.
> +    Each bit that is set to one indicates the corresponding hardware cap=
ability
> +    is installed:
> +
> +    * Bits 0-3 are the facilities bits. Each bit value must match for th=
e AP
> +      devices on the source and destination systems. The values indicate=
 the
> +      following:
> +      * bit-0: APSC is installed
> +      * bit-1: AP4KM is installed
> +      * bit-2: AP4KC is installed

[Severity: Low]
This isn't a bug, but there is a missing blank line before this nested list
that might cause incorrect Sphinx rendering.

Should there be a blank line after "The values indicate the following:"?

> +
> +    * Bits 3-5 specify the adapter Modes. Only one of these bits will be=
 set to

[Severity: Low]
This isn't a bug, but there is an overlap in the bit ranges described here.

The facilities bits are described as Bits 0-3, but the adapter modes start
at Bit 3.

Should the facilities bits be 0-2?

> +      one and must be the same for both the source and destination adapt=
er
> +      devices:
> +      * bit-3: CCA-mode
> +      * bit-4: Accelerator-mode
> +      * bit-5: XCP-mode (EP11)
> +
> +    * Bit 6 specifies whether APXA is installed and must be the same for=
 both
> +      the source and destination adapter devices.
> +
> +    * Bit 7 specifies command whether command filtering is installed

[Severity: Low]
This isn't a bug, but there is a grammatical error here.

Could this be updated to remove the extra "command" ("specifies whether
command filtering")?

> +      and must be the same for both the source and destination adapter d=
evices.
[ ... ]
> +Reserve adapters and domains for the vfio_ap device driver's use
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Reserve the same adapters and domains passed through to the source guest
> +for the vfio_ap device driver on the destination host by clearing the
> +adapter numbers from the ``/sys/bus/ap/ap_mask`` and/or the domain numbe=
rs

[Severity: Low]
This isn't a bug, but the sysfs path here seems incorrect.

Should this be `/sys/bus/ap/apmask` instead of `/sys/bus/ap/ap_mask` to
match the actual sysfs entry?

> +from the ``/sys/bus/ap/aqmask`` files.
[ ... ]
> +**Destinaton host**

[Severity: Low]
This isn't a bug, but there is a typo here ("Destinaton" instead of
"Destination").

[ ... ]
> +The AP configurations of the source guest and destination host not incom=
patible
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~

[Severity: Low]
This isn't a bug, but the section heading might be confusing.

Should it read "are incompatible" instead of "not incompatible"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D15
