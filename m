Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579961;
	b=XrHHe9sLvkH8DM3jrTUie9UHso6lmUiOT3nJEVEojG/GOAe3sXGf3PvMUdBJ0Dv4q+XS
	 XI0LRnSXwIBtb7dc8wVItU8d+zMlELpKnXcb0frdZKDYsAsqamy+jLauYfy4W1Tq1VurV
	 Cjtn2+5wuP/HtqrmpiONsCTW1uer5O/M93OsQBKkmFz9eUhEM7+olsgjZEMXdQCPge7nv
	 UzRaUzSLrBOXqDFIZKluDxqqyJ54BML9GuTDKgA48abw3MRPT0EPIURs3I/Sqy7llZOsa
	 Fj58AoLF/A7SD6OznNaasglYgiEyHQUSBfZuNAS2/MMfeb7Y/A2/rhmSKdg2DtxJtig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579961;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U75Q9KnAxsY+0Ri396WNXwbaQj02du5wTvRacxhkbHc=;
	b=xQ8O1+IgcpmVbQdCO+bZJu6x+XFeZ4U3pOTZ8UyKALqNNNcPVasmvgvGUJhcnBco/rRJ
	 4RfzQGYNdXeravjEWmqCvLwR1CFMkpl8s/1pELBr5V/adp+cxRMHPsLhGFjfkChTm7aIt
	 WNfRhu+eX+YBjXKdFY1/4W7ieT2iMavIpoMdB2WjDUC0qolRlVAFXh2eBdnnSbqG648kq
	 VTEBrfHgMYXC0D9HfVNCHykOduIPx4rLntbWVtY+lc/sSIcK5kfdabsw2C0j/j4Cd8f+n
	 yj87aMfnhAw3fe+fuFyj+Z16nMS/BQFRnIExk8CP87Zqsti5390zrVc6eJRjkd30jEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwPrwNMZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E241606A32D
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwPrwNMZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE22F1F000C4;
	Fri, 13 Nov 2026 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579961;
	bh=U75Q9KnAxsY+0Ri396WNXwbaQj02du5wTvRacxhkbHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwPrwNMZ563gEV+eGbGpUfIQpOPCpFuSdCpl6CJ+gQNDZMZZo0NVzAMWV//FkAdmG
	 rWE5uNRpsBik3ieGvCfJzR6ruaWlhhKJrjUINqXXgUhc+94QgSCQVNBTAgr3np6zVY
	 a/eWZfZUnnTRXUHk5OO8q9cj52PskRFs3RKOfpmAslOKb6R0+YB+6QYigtn9lU+AtD
	 8n9KADLEgImnBbxRufjwArdw2Z7o9T4Ey0i6f0/LxGq/TcmeIANIaKAfaUineqW3IP
	 5OK8r82rQBGqrYHaAy0ZyzG2BU2WzoLkVZKnPnA/wENK1Nn7k+z9pTtzc3RO/V3asa
	 Uyl6LuzrYcWmw==
Message-ID: <sashiko-outbox-212984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] KVM: s390: don't unmap the gmap on permission
 upgrade
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-11-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-11-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:26:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When an mmu_notifier invalidation only upgrades permissions
> (MMU_NOTIFIER_RANGE_PERM_UPGRADE), keep the existing gmap entries
> instead of unmapping them. The PFN is unchanged and no access is
> revoked, so an existing entry is no more permissive than the new host
> PTE.
>=20
> A write to an entry that is still read-only causes a protection
> exception, which kvm_s390_faultin_gfn() handles as a write fault. This
> applies to both s390 and arm64 guests.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D9

