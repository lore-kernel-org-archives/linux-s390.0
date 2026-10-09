Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98854E01ED;
	Fri,  9 Oct 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546896; cv=none; b=kRQ4wqKsNcHYmexCbpzEqBo7O0RtrNHyI8HrNr+krFsLSA0nLIcdQEm8+cz50M9miTZQQ2Yhp5Ac+GQrh9Wn5J+bdKZKHFsCbPwvjNeAvkvlm/U+LIcU50dnaV154joYuIkZnfxnfbxRxn8nCjpoXkMEjhHABUkLb4KIOu08H6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546896; c=relaxed/simple;
	bh=UEFEwwDKNCZqwkCGpjxELP5uLm7DAI5cbP8hFgsRofg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aygj/F+Hgdj7GnM91yQqbwfMIKcL3aMqUK637RoL+QUiLKzofdeMwcoLYIl/zwyQct3w5R9+uz7EJLKaTxsruA1Hob2fR0oyyoijJyhZiYzkAJoudZuCBjV7BMH0FZEM8Qq8FkgXeT2PV4PlXsIKVS4Me8DIgQrb0VO8FK5q2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3TI+Q5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3TI+Q5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FAD1F000FF;
	Fri,  9 Oct 2026 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546884;
	bh=UEFEwwDKNCZqwkCGpjxELP5uLm7DAI5cbP8hFgsRofg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3TI+Q5/IbJJXqiArvhhXcGfApkXuiIWakLCtRqZ3rYf9XNozE5SVY21O9r89GOJn
	 S81bDmu+0IrfUZjxNuQkZxtozS94qvv0jAFRNcgEFsHi+OmrB6HlZXZzlz/yE8eB5q
	 rkhR70+2zdy7JXJcOJuYkyG7qZR99f7TUwImtZl7nllv4k8hHaewx5THMgNtfjjW6p
	 DG6zvCcwqZUqIiOjrNYBSXj7UFBDO2JJPA+yOoL8tzRbDNTnB8nmSdHrQp1HEnga5r
	 bB6uN/LjaJUWCrEdoYJPyFLem43VtEDf2GNVxvFl2FebGOuZadabU10HdOgAe119d/
	 FUvQiPXcXV8eA==
Message-ID: <sashiko-outbox-165446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-5-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:54:43 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases the migration files and frees the storage allocat=
ed
> for maintaining the migration state.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D4

