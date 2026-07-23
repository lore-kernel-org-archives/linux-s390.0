Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420139FCE;
	Thu, 23 Jul 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832209; cv=none; b=KVXmJEWlCI1HR6pqz+gcvOe8ZlIVwy5JJzXna08BaQvkIwttC1Z74g8TqhOUYAl77brIt9rkHCBR6ji1TNgm/PMBoz06NVuUnqsGUd6RnJ/ZHi35qh3npg0CZsDyGduYx7MngyLgcx537R/Qs9aSEZBES6scLKM9eZLqqp8Qx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832209; c=relaxed/simple;
	bh=YSJeqfKUfgjokDQlInAbhaPcAGL0Z1Us258OXuU9XBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cErDUbuNEac9ibF3cLF0Fkdj1wKaMXQVhk11dVo8bAEjMfKVgBSb5qe9wClHJ10lw7BelrbabAeDP7HD8ctP+ubOvvUpTiRW6lcNUU/C8J2n9Q9w0fNxX7agjjUSpqFexRvVncwCfWi0Ooju09rdurfDI1++ajlx1JYS6jN8nQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnUrWd6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnUrWd6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142A21F000E9;
	Thu, 23 Jul 2026 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832200;
	bh=YSJeqfKUfgjokDQlInAbhaPcAGL0Z1Us258OXuU9XBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnUrWd6I9ZJTd3/DEipsROA7xeMJgPBbb/+uo4EzeN+W1AIUSEHwrrphDlyH8DrS+
	 U6dLjgPsAc5YuXBwyub+lOA5cLjRLEXeafk2W5+71X+kshvTI9B4okVvtVfqZHRpOB
	 4vVH+C5EvhiRHBOrETcXaOPAZpyDT1A2Plv/3km3bV287JC+CZij0MWaw3WRourEMX
	 WeQwyKN21t1KMzGN5nDdDjXE6czrWL12u3TmzqlCrr1T62eCcmMssafABGjqR09u5s
	 nsi2CbGRkhpJa0PSLvpCPit1Hiuzb2Ypc0xzviyZC5rjS72/5ak4OGO4ESuHVuw1mL
	 s+ahc+TwkKFAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] KVM: s390: pci: Fix missing error codes and
 memory unaccounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723183440.3271-4-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:43:19 +0000
Message-Id: <20260723184320.142A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
> causing the function to return 0 on failure. It also failed to rollback
> memory accounting on failure. Fix both by propagating an error code on
> failure and calling unaccount_mem() in the cleanup path.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723183440.3271=
-1-alifm@linux.ibm.com?part=3D3

