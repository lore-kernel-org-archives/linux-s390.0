Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93132B132;
	Tue, 21 Jul 2026 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661993; cv=none; b=pkKEmGljDi5KNwsA/pa8qtOg2Npvj3A79rgDIKFpm/hEsIE+IWNVZkOfBEuEhdUKyvkqf8yYEPwTb/HIO6IVjkBPcsirLa9SfP17B4iWVXLsHEV1jTrKA+7f8WosvHjka8XBxSxoIFyZExjq261N9b42kcFz8FWEI8LvlX4ESGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661993; c=relaxed/simple;
	bh=rWVhiBZsXUMiVFCFwywlXIzDB3vvPdHqa/ujVJ5MOgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=orkYqDqH0/1Wsv8W3CkeyYcZDydRnG0Al4pjt8xTpUQzoJssiFSjiHISLv4fk23TKucE63jh5E+jhhwEkdLv2Fox7VfFCxTCn/MrgmIDC4XPpbhhiDALOvKY3PoQxKvzwRoCr3FKZc09sh3IoXq4nLWX9ffS8MVSjQO18ykJqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1HrD+wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1HrD+wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E42F1F00A3A;
	Tue, 21 Jul 2026 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661991;
	bh=x31rVBLuvsqZjkZXHvqDa5kI4uJVt9e3roo3ryzBeZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1HrD+wdOYB1ZTZiCfvbYV3TEqcGDGnkJHgAJCGZO2zBm8ZfzdivF6jXViYcVWwkg
	 Af3XZu6kzsUgEVgEGz1rgDioTlKT3rV3QcmXbXlCN9K5kjHgPH9EwcwM2roUPYdCRB
	 P+ZZ1hon/Z9HXZhpcqFSAU4/3nhUgoq41facMmsoss/F8sjgL3RRmGe0o9hzWOMn6o
	 dMNmhyvMEdv9HUIGOdQN2ryX/ord6xwgXlho3ayPKUDw410Okvf27p7YjrbIDRYPHl
	 EPO/g6ZmUZtAPkOEt9h7Kjh+bcyx/p8RkboN+4wSlnw/xSPGZ022Bl8KHzI0/szXEA
	 l9tThft64jNog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH/RFC] btrfs: fix folio lock leak in writepage_delalloc()
 for folios dirtied behind btrfs' back
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, dsterba@suse.cz, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260721191152.101118-2-borntraeger@linux.ibm.com>
References: <20260721191152.101118-1-borntraeger@linux.ibm.com>
 <20260721191152.101118-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:26:31 +0000
Message-Id: <20260721192631.6E42F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A folio can carry the folio-level dirty flag while its btrfs subpage
> dirty bitmap is empty: btrfs data mappings use filemap_dirty_folio(),
> so a generic folio_mark_dirty() call sets only the folio flag and the
> xarray tag, without setting any subpage dirty bit and without a
> delalloc reservation.  The typical source is set_page_dirty_lock() on
> a GUP pin, e.g. the s390 KVM irq adapter path
> (adapter_indicators_set()) which pins guest indicator pages living in
> a file-backed guest RAM file, sets a bit and marks the page dirty.
>=20
> When writeback then picks up such a folio, writepage_delalloc()
> copies the empty subpage dirty bitmap into
> bio_ctrl->submit_bitmap, sets up no range locks (nr_locked stays 0),
> finds no delalloc range, and finally hits
>=20
> 	if (bitmap_empty(bio_ctrl->submit_bitmap, blocks_per_folio)) {
> [ ... ]
> filesystem was not informed about.
>=20
> Fixes: bd610c0937aa ("btrfs: only unlock the to-be-submitted ranges insid=
e a folio")
> Assisted-by: Claude
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721191152.1011=
18-2-borntraeger@linux.ibm.com?part=3D1

