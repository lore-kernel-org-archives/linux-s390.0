Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C7378814
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814989; cv=none; b=MS2VNeg0pbK6tYrOaIjshMwEHti5FOzlLNd4a5TSmRSyxpPN3JsbEJhTwfPwjc/JtFuZxKWcZ1yQMKLP2vuBnZFzL0Dw2dELENuYZ+2HHAy4kjwNBwmT0sYMHOFKYW+keeOPjKKZDnk98pGIsWMBqoWDLCd/qTebWJA0ZXG7Cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814989; c=relaxed/simple;
	bh=rZqJMkH9by42sHp/LxIDYGb8bQ0zZj9ekZKSztuYLP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UlVd0xVcA9yjWXjDXDgJ4SfFQFNGMB4Prgkz2o8NgkUY7/hD7O6T6dWU1ll6qeJrWQ7Ibw/5ug79edPXnAR883XIhVWx56Wo4QB9aaL3/GTdB+iwv00ioUuWDp4rib4Ijjia1CxKcKr/M6HFZOvMjoKj4BhEvKkvRPE8W7A9L6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1Vy9g17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1Vy9g17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491651F000E9;
	Thu, 23 Jul 2026 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814976;
	bh=ZQ7RHoEMg75jzuGOTlNU3lAg0mpsjoyB0w2ajcIFHpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1Vy9g17Y+jGF1INzt4t88+ze5GbJDMwrZ3fDC0E8Jo86zKhcXg5+gYJAshs3uOY2
	 60wbJhAXB1LfHawhCmeztoUT4QoKR01Aavj36r/nR/C0kWChQBwCaykvnE3AtxPHME
	 I6kFQb8dfj3zI3iddXRjla6XkO/cW47rg6e8WRbDlersdlUgqUNtPsORojmyfh5GuS
	 MPFFGD73U4BYLpRotZHCGLth+68LDKPyRHJv0pYXT6O95VF1kE0I0O/0Vh/Mud7/rs
	 KeL/YMBJrlsSR24epIPPlOhZHfTixvlDz/2diDE04DrYC0kuWRlZlD7W/x8Aebb6V8
	 ccScYEyY/m0tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/smp: Reflect (de)configured CPUs to
 cpu_enabled_mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
References: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 13:56:15 +0000
Message-Id: <20260723135616.491651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Logical CPU ID fragmentation causes smp_get_base_cpu() to return i=
ncorrect siblings, leading to unsafe core deconfiguration.
--

--- Patch [1]: [PATCH] s390/smp: Reflect (de)configured CPUs to cpu_enabled=
_mask ---
commit d82385b96c4cbe6b55b4a0446d3eeb4e2c122fa2
Author: Mete Durlu <meted@linux.ibm.com>

s390/smp: Reflect (de)configured CPUs to cpu_enabled_mask

On s390, CPUs can be in a state where it is not possible to hotplug
them online before certain prequisite steps. This commit adds necessary
checks to smp_add_core() and userspace configure attribute handlers to
reflect the configured CPUs to cpu_enabled_mask.

> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 0ba7f89b81611..e0c9480c7bd24 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -1039,6 +1039,7 @@ static ssize_t cpu_configure_store(struct device *d=
ev,
>  			per_cpu(pcpu_devices, cpu + i).state =3D CPU_STATE_STANDBY;
>  			smp_cpu_set_polarization(cpu + i,
>  						 POLARIZATION_UNKNOWN);
> +			set_cpu_enabled(cpu + i, false);

[Severity: High]
This isn't a bug introduced by this patch, but does the base CPU calculation
safely handle logical CPU ID fragmentation?

If arch_register_cpu() previously failed (e.g., due to memory allocation)
for a thread during hotplug in smp_add_core(), cpu_present is cleared. Upon
the next CPU rescan, __smp_rescan_cpus() repopulates the avail mask with
this unaligned hole.

When a new core is added, it will consume this hole and subsequent bits for
its threads, resulting in unaligned logical CPU IDs. However,
smp_get_base_cpu() mathematically assumes rigid alignment:

arch/s390/include/asm/smp.h:smp_get_base_cpu() {
	return cpu - (cpu % (smp_cpu_mtid + 1));
}

If a fragmented core is configured or deconfigured via sysfs, this
misalignment causes cpu_configure_store() to compute the wrong base CPU.

Could this lead to checking cpu_online() on unrelated CPUs, deconfiguring
the wrong hardware address via sclp_core_deconfigure(), and corrupting the
state and cpu_enabled_mask for unrelated CPUs?

>  		}
>  		topology_expect_change();
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-enabled_cp=
us-v1-1-3a2cbdc374b0@linux.ibm.com?part=3D1
