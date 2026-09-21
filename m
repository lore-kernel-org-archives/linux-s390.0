Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0F457E4A
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980322; cv=none; b=SPNq0RhL4BCCm/ANq0k5hORA0L10AxgOw+znIS96tw0JGgUkwhGm6bUeJ8y4rp3Iv8QzsgHhXuVfEzdGCbES4iJoPXwpuFsvB5SWYO8ScUy1XFoTb5ad9GaOej13FbpYZ/o/TMMwuPfmkOb7XmAfWFmlbXBxW7sFN/o4qha8dP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980322; c=relaxed/simple;
	bh=EjPeG2FS58ZkA/DKSvzIF3huYJ4VHJrL88cpNog/ipg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C+7up0BW8kaw2U1dS89PEvhlttTfuYja4q9cdrALStRVA3M6geMeClnPsjYpwZ8ZLVZ9Egm8ZiXbrduSMHUQPDlpZ8qQyCHiNh1ks7v+j8J5hhok0QLM23o8+qHopeG89JQWe6BDTJm24flhoEmmLU+cBM0x88JlWGx5/3qJq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPG/ivcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPG/ivcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6856C1F000FF;
	Mon, 21 Sep 2026 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980320;
	bh=EjPeG2FS58ZkA/DKSvzIF3huYJ4VHJrL88cpNog/ipg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPG/ivcPZSQa/z6MnrQg2IUYk+0FRMyr+f7zuVyErXIjg2FgvQq7izKrGo8KUQgHf
	 /dsTmbvuxsgAzJZakbPhMTYp/F6lTwunmsIOE256O2lBhy6+ARynpig654spK4GPJi
	 tqddwh3IIqiPw7T4uocWQDaVMipoLtufDKmwg1ObD66BWqjl9JC7bi1kfTP7plXk5h
	 XKi9CwNmpyMUdhQOHHw59JhZpm4jvoR759OkbmUmspvRoz8EtarzxmZVz86hdFMdaG
	 STkUwBAsW7HSlvb9n8J53t+IWa4XmJU+hR2Mp1MJq0J5tN14DSf+WXSUXuKZwQqsND
	 ndM0l37WN+SIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] s390/percpu: Use __PCPU_BEGIN() and
 __PCPU_END() for inline assemblies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-8-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:45:20 +0000
Message-Id: <20260921084520.6856C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the use of MVIY_PERCPU(), AG_ALT(), and MVIY_ALT() within all
> percpu inline assemblies with __PCPU_BEGIN() and __PCPU_END(), since
> the begin and end of each inline assembly is the same.
>=20
> Also use consistent names: e.g. __PCPU_MVIY() and __PCPU_AG() instead of
> the previous MVIY_PERCPU() and AG_ALT().
>=20
> Furthermore extract DEFINE_GR_NUM and UNDEF_GR_NUM which are used to
> convert register strings to register numbers.
>=20
> All of this should make the code more readable. No functional change.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D7

