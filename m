Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80852349CC6;
	Fri, 11 Sep 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137866; cv=none; b=E8pwezhDj3PQPFVqZbqQOHYjIpHnEebc9RXmKkhJG7zGLbbPjENQPkIa1QHr0cmQwjA0ZjlId+e3KW/WCPlfHfz55FV6oxHhJ1HwFhSFl/Dt1TlbzSBZgueuPK65BYaaPTSyodEx/wV42fNSRC8DT71kOXya5ChlMdaxLtOymLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137866; c=relaxed/simple;
	bh=vnyYOBsCygink0zwHA/LgVDv9bm7n6e7viaT42tlObo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQSGex8P6a2s/4Pa8x21Wx9Kwq9WwKaZIXx+SW0quTrqOrkUzeHMXdGtrQ3DYhfOfX5XxI4zRPwbF34IaCCHs88ZQI9E1aLqIPB9y7RCAvgU2JAcDnxk+g4v00pMSbspQzZTui6o3C3Yi3o2uSUGumALidtlg0JsdqV6IvDRV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fafv0Glq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fafv0Glq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94D1F000FF;
	Fri, 11 Sep 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137864;
	bh=vnyYOBsCygink0zwHA/LgVDv9bm7n6e7viaT42tlObo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fafv0GlqpdMQXQMzbj6zRh0jXUeNLJaf8SthZ/7MVuXZIJOLgOPz9Zm2Meox7ehAx
	 DdFJ8lsRXJEcV1GQx2gOGPkbTlzWdWPBOHYtFI3MMtch0M0t3fiqp+oO3PDqVOqlTc
	 IXTTHoCVDgg706M6NumbL8hOjkHHXVKPkyEYrmNtpVZLTv6NmdCPvlIwb+yPVyR8il
	 i5p/pjchgFI8Axis97wW8QmowD1ndASeJK2+w80tUmHGQr+aYV2qRd/Oku88csQOjZ
	 OyScA1lKuBYVbZTDVA2iTUhkurrakjDdB71VvXI+VpILQC3fOhPVWlYV8FiBCLROKV
	 eIwTDUEyK5+PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] drivers: Include linux/slab.h for kmalloc()
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-modules@vger.kernel.org
In-Reply-To: <20260911-module-include-elf-v2-3-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-3-954c732975fb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:44:23 +0000
Message-Id: <20260911144423.AC94D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> drivers/char/tpm/tpm_crb_ffa.c and
> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c use kmalloc() functions,
> which are declared in linux/slab.h. They currently rely on this header
> being included indirectly through linux/module.h -> linux/elf.h.
>=20
> Add the missing includes in preparation for removing the linux/elf.h
> include from linux/module.h.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-elf-v2-0-954c732975fb@suse.com?part=3D3

