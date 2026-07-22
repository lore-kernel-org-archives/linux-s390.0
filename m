Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A21411F90;
	Wed, 22 Jul 2026 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740902; cv=none; b=FOUc4gzNbt7K2r05bJ05bJPzyttKiIVymBvgpkiNxC/+j9+tD1rxrtxaA9dH1BepVxlS77chOxhcXoWm2fhkU5pk9/IjDn0VktCfMSx0193mQc/1XN742HgSJt4HV1cvnuO+i4/sPaQFyKJN0UEEVnhy4riG6iB8EnKdV0mQtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740902; c=relaxed/simple;
	bh=Cj+NBxrmeuClCVp5jngWXy6IQLXeZItwwwBOP8f3CLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M+M3ZUfT+JwEoUn6PLfW1f8yaq4Bw01alo9G1I146YsrYwe5UW3dcrkdKLlNm8X7zcxmENeQAK6SgpHZQ8wf3NcCjCFECcTvNcR7V4md5K4YdTXRXPCJX7zDPqgjwtFJ+zGcAGiA148EHIxJitgkkOtqnUSBQNfsR0PTCZxBxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrnXunLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrnXunLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B519C1F000E9;
	Wed, 22 Jul 2026 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740901;
	bh=XEBGSA3cqtU5L3sHr58yXKX23AZEijsXipGBsokGNMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrnXunLV7XwKclfgCrYhUWDToTw93RRXdxGAXyEZVxXyKDdXHh6H52Ls4CrLS10dl
	 UYU+61DjZufIWFtELS2Ks82FdGM2aI/uGRNAhV+ldG515kuFIbD2c9xflQiZe/SQ5x
	 0uacD7JRYLkECqI3htSMdNSv/1RBS2a/YIGstcqf61auVuL/CE+VHUJZ8cgnM7HrXF
	 ZHbixmgOUk78H9NAXuIGDBO6OyegN2GJEGqTo0moFEBihYKilwrA+W/Oj0Byjy7X6b
	 kST/31+CO/FocV/Y/xqnBR8cZcsZQjWlUudVOSVv6AtXZNsqd3f1CiXUocjIOOxhPu
	 EGq9g8Pz2UA1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722170621.1686-3-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:21:40 +0000
Message-Id: <20260722172140.B519C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between KVM_S390_ZPCI_OP ioctl and device hot-unplu=
g leads to Use-After-Free on `zdev`.
--

--- Patch [2]: [PATCH v4 2/6] KVM: s390: pci: Fix memory accounting for pin=
ned/unpinned pages ---
commit 2ef683f1261aa42729e17194a74f67aefe6f5d45
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
   =20
The account_mem() and unaccount_mem() functions call get_uid() which
increments the reference count of struct user_struct on every invocation.
This commit fixes this by storing the pinning process user_struct and
mm_struct when accounting for pinned pages, and subsequently freeing these
resources when the pages are unpinned.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d2a11cdf6941d..1b3114c7cfbb8 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but can a race condition between
the KVM_S390_ZPCI_OP ioctl and device hot-unplug lead to a use-after-free on
the zdev structure?

Looking at get_zdev_from_kvm_by_fh() in arch/s390/kvm/pci.c:

			zdev =3D kzdev->zdev;
			break;
		}
	}
	spin_unlock(&kvm->arch.kzdev_list_lock);

	return zdev;

The zdev pointer is returned without taking a reference, leaving it
vulnerable to being freed once the list lock is dropped.

Then in kvm_s390_pci_zpci_op():

	zdev =3D get_zdev_from_kvm_by_fh(kvm, args->fh);
	if (!zdev)
		return -ENODEV;

	mutex_lock(&zdev->kzdev_lock);

The ioctl thread dereferences the potentially freed zdev structure by
attempting to acquire its lock, outside of any RCU protection.

If a device hot-unplug is initiated on the host, and QEMU closes the VFIO
file descriptor after the ioctl thread drops the list lock but before it
acquires kzdev_lock, the device can be unregistered and freed.

Because the ioctl thread cannot be in an RCU read-side critical section
while it prepares to sleep on a mutex, the RCU grace period can elapse.
This could allow the ioctl thread to resume and attempt to call mutex_lock()
on the freed zdev structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170621.1686=
-1-alifm@linux.ibm.com?part=3D2
