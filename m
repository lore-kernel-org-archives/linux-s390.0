Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944528B4E2;
	Mon, 28 Sep 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599533; cv=none; b=Cq5LCA6zxlTmwZzIglNljsexLq3kuM2cYjJ3Rr8DTUSdsJdH7tmi4c3iF16Mhm48EGoTHVir1nVFiUYLhQK++iWiIRdffdEYSPWtrmVPFNq5x7Uk0j3vpa7m341rLqcUPv6QHyuuRTdOOGTW1xV6rn946t3IOgkOcOVRRnrHE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599533; c=relaxed/simple;
	bh=HAuCRw7y8pU7eUeYF2NtJHcyv/3i8GpDCmwe9gSknIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovffMSMOgR8XBdxM8Fji/7fG/9sYuldiB3YhHvaXazSyLPiovimPLeA1vWf/9IXQ2Bq3+sWc3oREH5tyN+6pzEvezN82rNFTMMoqy5YsnodBrIWh8n6hglOWdpVLJ6estfKWxK/z3cE55X0hidX9IdrFgMDZoA8AhESXHUVVLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APEDECLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APEDECLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C1F1F000FF;
	Mon, 28 Sep 2026 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599531;
	bh=HAuCRw7y8pU7eUeYF2NtJHcyv/3i8GpDCmwe9gSknIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APEDECLknXKI1wsPPOvXXje1rZOOGGd94gc00zrbkHFnGiC1NvhmRIVcvFYu+oRVG
	 ifaF1Enu5CEd7vncjA2bFPta/C5QXcz0rJW7Tcplp3cgGAw59Fj4JhhlVRnFWJfH6M
	 GWWuVyy8Ua3jWpniCwY7eXehSmxBIxfRUIqEuj4tGW7ZEjoEkmneaxjH8WgIX4hCSO
	 4KI1PjnI7UkTCxr3mmq5rWJY6D0nlsZF6PmuluRHNqr/krh2gE1nssB3TNNcrrMaf8
	 ZHGHwRGSAt280KyV0Z6NcA5ODfR2QyK1v8nulxN0p6EG5kp7Uv+pyYyi1XRQIHHwU/
	 WY1d2vzahaE5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] KVM: s390: Improve floating IRQ injection
 behavior
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260928123639.34226-2-frankja@linux.ibm.com>
References: <20260928123639.34226-1-frankja@linux.ibm.com>
 <20260928123639.34226-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:45:31 +0000
Message-Id: <20260928124531.78C1F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Floating IRQs can be handled by any VCPU that opened its masks. The
> current design does not check if the mask is open when a floating IRQ
> is injected via the FLIC. It will wakeup the last VCPU that went
> sleeping hoping it's the correct one.
>=20
> Improve this by checking if the VCPU can deliver that partiqular IRQ
> and if not try to find another VCPU which can take the IRQ.
>=20
> This is not the final fix around this topic but we'll eventually
> inject a pending IRQ. The current code can easily deadlock a VM and
> with this fix we work around that.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928123639.3422=
6-1-frankja@linux.ibm.com?part=3D1

