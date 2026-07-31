Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE013DEAFC;
	Fri, 31 Jul 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505370; cv=none; b=T52LLmy+D4/ooG2dDnFm5BoooFxyM/Q0r/v64R5T+CoU5cOXxFmald9X/iAVx1vVHsm2B9oTV78S6HXMsn2qLWIdakHp2mtpgFO676BluiSnjf+1AFYJTkl6/vC51boWrik/vf55OG79B/z9q1hD6UNB0ggwKpcPPZ9KqjN8yEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505370; c=relaxed/simple;
	bh=Wo/jCLLAUliQJ8m/T4M/XXVKW7ztigDY0D2JI9MmZec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UoOR7UPYZhrr8Wldr6wAlOQl5z2pOtkn2lqJ310r06II3jTqsv4RAAQtCUtb30WTsHe8tg7gB5NgzFGXv6atIadg6dxc7/G18AZyREKzYZHGikb0fMFWOy2AqmI8fBZUeSWqDlXHjJphaPtqst6qUa1OD59d0quDB2Dn+u4isTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiZDxodE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiZDxodE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22BC1F000E9;
	Fri, 31 Jul 2026 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505369;
	bh=Wo/jCLLAUliQJ8m/T4M/XXVKW7ztigDY0D2JI9MmZec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XiZDxodEnPojWzZsc9CtPe9xEsapmwl8uY5vwPv2O5sTtGIdY4k2oIgtwEHhEfjbS
	 vUJOPBN6pLt3raQQurjK++jYs76FZxcJjQYl9ZD0bpuUHEwkFYmEKTGjZK02VNj6Vn
	 BZCa8VN+bjy1KHCGB5ATBRCJvQmFhxFkpt4nwgvEJqtLdq0UyID2gajMRQWv+3Ngb3
	 2i4wiG4N2aGOy/3sp/8vxt0WPPUOO+G6GIxqjECpIb1MvWKnhAuGaJN5n5s8q/tTMa
	 CbhaOsab7IhZv4lf0fa3gO3iCKi5NDYrhRrpBUag1fbEP1ft4j+nB2kUDjxckW19ZT
	 diQkJXu6eNNXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/31] KVM: s390: Move PGM code definitions to
 asm/kvm_host.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260731130902.654679-17-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:42:48 +0000
Message-Id: <20260731134248.D22BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move the PGM definitions from kvm_host_s390.h (back) to kvm_host.h so
> they can be used by a second KVM implementation.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D16

