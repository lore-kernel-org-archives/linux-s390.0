Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B232AABA;
	Fri,  7 Aug 2026 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142280; cv=none; b=TY8E4sv/aruBZbn9ZNsvzRAHtK9d2xV8j6cVAcHtUoLHanwunRCJw8O9rgq33HGNr99/WhOvEGhJYl/DNPZYy1aUwATPQt4r7hhUzVZ3KHwpzOTXplh1u/et2+pSY/43AgU2Ziei005PmVWE+f1yaQlVWH/0051SFkhd6cFLg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142280; c=relaxed/simple;
	bh=fygEy7sQhyFNMU4G8DqZxQfH4e1BaJTW9oTn/qTskfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s1FaX5TmIU1DgeXt4QCUkr8TdQ8gzby2k7JkR/vDn840+8MM3DMSfHxe6gguGucaBso7rAlaDbspEh7LEQel24wDR92N61MPVAsiMXGSd6OEAu29L3ykR8Qs1mXk6ep3QUiy7ac2a8GHHse7psVhKWT9yVMGcpLNeTZRfaqHWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXo1MzYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXo1MzYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FDD1F000E9;
	Fri,  7 Aug 2026 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142279;
	bh=fygEy7sQhyFNMU4G8DqZxQfH4e1BaJTW9oTn/qTskfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXo1MzYM6txhu2KqnEvqGuUbaYnSbE2R/F/F51/5UwdR1QDQvwfKK4TqJE+qI2Gce
	 zbxVNTKbPXw7ktH8yXnPlvw5RaohX40liDij8ITuN7O+G65+udhmZ8Vvsr2bfyK1BI
	 oZ1NXH134uFW8a0Ebv7ywNnsGfRmAheXrA3VWmQOPn+J1K6+UGzexXFyQE98XeRGoO
	 6XwecYQ5y2yShHmA5sQbxIIDGUXQpr0TCrfvdouEcuW+JweO9lTPR/gB8bMMDiiMSc
	 fwDqiVmz9MvxAVtIawLbDpi233BNapCbWUesb3znqvmpTdnO5dYwgPsWEMTNLg3FHw
	 zFHqj7qrXVEFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260807221834.562851-14-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:37:57 +0000
Message-Id: <20260807223758.A2FDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Callback to get the estimated data length of the data that will be requir=
ed
> to complete reading of the vfio device's internal state. It's mandatory f=
or
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
>=20
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D13

