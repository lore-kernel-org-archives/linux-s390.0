Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9654E4C4F;
	Fri,  9 Oct 2026 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546884; cv=none; b=lnZIeqCvz5Gko/udkP0+mfMxCx2SRhonzr40LjBhQFviHrhmTNKPFRXPbSry0ZXI0QIeJNFdONVczmhWpdWYpgGuPB+pYqhnPA0nOFwFbC1JEDSolo7ZgN4BF8s0atY24RmhsSpmED7AcnjT7M0ItMZgPkCdE56hnUM/jm3R4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546884; c=relaxed/simple;
	bh=SW4WqDxgyVtq4me65wgoQJx1jIn/+b5H/+zuuQnIxe4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ocXHvTJPOmidYiLWuBiht7jE+AxVylV+5tQxaONlm1OUfkRiRBOS8yQhlLWVYqLtN7qhGIaJ1D9ex97ZjyVl8RFcOehrvJnFy6jPOdqjRBr+0GTOISbrHUh3ksH6jx/M0c4BNkCgS0BJgciD2LV6Qcx55b4/bWjxJuRqLtJrjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5AhMAK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5AhMAK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55591F00899;
	Fri,  9 Oct 2026 11:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546873;
	bh=SW4WqDxgyVtq4me65wgoQJx1jIn/+b5H/+zuuQnIxe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5AhMAK4+QLNbtW+kxyLx+NORNOizJjj3gwH1vJ2Sj0nJHYWzzjU9IM0KzByHw7MK
	 eyqPBTjSE0HVsYF0rpJmhMo1R+kv0d6vQtVwVB8mlxS54ZCWjPCVAQo6q5iwF1TFRz
	 KK2T9lxSyYyTOLmcGqcBI0jjF6ebBkjY0YSQZnUGjHodMeGynxkSw7iucHEJVY2PVm
	 V+5aarqJep4jxEq7jwuTmjJXDc8HMisLyjNE66VbrQGbeun9ooApo8UuDebZQGukoN
	 818ZHH4vK+N2Bk6skypZKqaLcz1NMfm81vfLI59DKDeGQUgoJn3p+efVbeg8DD3470
	 rtG7t7fHwOKQA==
Message-ID: <sashiko-outbox-165445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-14-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:54:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D13

