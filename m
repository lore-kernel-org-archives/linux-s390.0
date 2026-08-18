Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8493DA5B6
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076510; cv=none; b=W+COH7kVPxlVkHIT2dfO7pk21h6/tJb5wr93S7eO6kqxGkS9wDdJSLNa31dPZEPiItQmiongg1SZeqWmg0p8TLZ9/RPDvNFy5Jm7mW4O4JGzELf4OCSGcqIO8W5UrRLL82Gzgdizz0XktX2LYkdZW7AGjkKx6WVxUxwCvs/mSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076510; c=relaxed/simple;
	bh=iMvSISeZGSN3/TONCym1vTt24tOn9UCDXDyiG98o4u4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o1aY9qm5omHi8/XlzgR65L4J8G6SpevrZ0phqHWfQdbFndcajxKgCI/eHzWL8Pl4USCSF4jZ3YRGknySLUK8Kb06CpG0YVmRO4f46qWA7N0E72FWjg/fw0r9jDHSNrjR0O1yfl6IcH0CZ0FynDOdwIRgtedLfXBO7Yfc59zGdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRJJod8o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRJJod8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F491F000E9;
	Tue, 18 Aug 2026 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787076509;
	bh=JhnRcpZS/emEcCV4IV7QDdB+HUVJIejg5YXwKhEBRUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRJJod8on26ipnLt6IWl6VuUvN0kxdXmMS+GbNV/Wr8hF7fqmqNf0yi42a+KNuIm2
	 eCFUyaOGztES45lWuGgNtGH1uF1ZH5zto88LOfvAFU337nDBbWkgg2S9XijFWoGWUP
	 MoF+ahrg/rkHE98poY7hPY0h9TksFVJ/FfL9W6v1xgqiSGxzA6A/ocnoEpg0wn1A1i
	 x2KWZeAHCe0K6VF2J5DmW66fGKnZpHOAgoWL5VrS2E1HqOMApctr7TNeCqRZPe+r4O
	 rnoxE4oG6zGAKNWbTyOGt1G3vtremIYCWxT81JCSIa85DLwjh0EFnD3Wq1tFXMocsN
	 TeAefFwXrLalw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] s390/iomem: register initrd as an iomem resource
 when retain_initrd is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Cathcart" <josephc@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818175755.3520-1-josephc@linux.ibm.com>
References: <20260818175755.3520-1-josephc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 18:08:28 +0000
Message-Id: <20260818180829.17F491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `strstr()` on `boot_command_line` loosely matches negated pa=
rameters like `retain_initrd=3D0`, creating a severe state desynchronizatio=
n between the `/proc/iomem` resource tree and actual memory.
--

--- Patch [1]: [PATCH v4] s390/iomem: register initrd as an iomem resource =
when retain_initrd is set ---
commit 7ecf2fd4332ea230894d369c93eebe76e303f37f
Author: Joseph Cathcart <josephc@linux.ibm.com>

s390/iomem: register initrd as an iomem resource when retain_initrd is set

This commit adds initrd to standard_resources[] and registers it as a child
of iomem_resources if the "retain_initrd" boot parameter is specified, maki=
ng
the retained initrd memory ranges visible in /proc/iomem.

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b60284328fe3d..373e54ed75198 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
[ ... ]
> @@ -501,6 +508,19 @@ static void __init setup_resources(void)
>  	bss_resource.start =3D __pa_symbol(__bss_start);
>  	bss_resource.end =3D __pa_symbol(__bss_stop) - 1;
> =20
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD)) {
> +		unsigned long initrd_addr, initrd_size;
> +=09
> +		if (strstr(boot_command_line, "retain_initrd"))
> +			retain_initrd =3D true;

[Severity: High]
Does this loose strstr() match create a state desynchronization between
/proc/iomem and actual memory if a user passes a negated parameter like
"retain_initrd=3D0" or "no_retain_initrd"?

The core kernel's exact parameter parsing in init/initramfs.c will correctly
drop the retain_initrd flag and later free the initrd memory. However, this
strstr() check in setup_resources() will falsely evaluate to true, causing
the physical memory of the initrd to be incorrectly registered as
IORESOURCE_BUSY in /proc/iomem.

Since the actual memory is freed by the general allocator, it will be
overwritten by other kernel structures while still being exported as an
intact initrd to userspace. Could this cause tools that rely on the
/proc/iomem tree, such as kexec-tools, to extract corrupted memory thinking
it is a valid initrd?

Even though the commit message notes that PowerPC uses the same pattern,
does copying this approach into s390 still propagate a concrete bug where
kexec might fail or boot with corrupted ramdisk data?

> +		if (retain_initrd && get_physmem_reserved(RR_INITRD, &initrd_addr, &in=
itrd_size)) {
> +			initrd_resource.start =3D initrd_addr;
> +			initrd_resource.end =3D initrd_resource.start + initrd_size - 1;
> +		} else {
> +			retain_initrd =3D false;
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818175755.3520=
-1-josephc@linux.ibm.com?part=3D1
