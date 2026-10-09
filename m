Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9D4E56E3;
	Fri,  9 Oct 2026 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546907; cv=none; b=gj1SlTyd46ft9adhF7H3DeBhmhtTgnOk0NhgBgeRdCUQxWanywLzydWdVEiGHcCn21D33R25JlDD3TeMF9C/REARQ2kanbG18hEDTWArZoGvQ81NTi/HFQ7pKoCUgwTkv+/03Y2WuwmYlyuPP74X1YQnhN/IMBEroPCZfmpZSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546907; c=relaxed/simple;
	bh=icjRZfCW89laGxifTNH4PNCZXPaXG41xl0vzXtxQ3mw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MpeWMrSX6vPIeb5O1f0AFd53rY28997iqiERIev1N9dJUZS4uImYeV5Pt8MpGbAGxqYQBAJHaHdejp6o9psxmQp+kKllveAIUUyclzu8vP0SsPawmR5jpwNMMVKcpjWY9CCEBT4QYwPpmJG+/Fo7fVTHuGo6XKbgw15omYzqvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM907bsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM907bsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B21F000FF;
	Fri,  9 Oct 2026 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546900;
	bh=icjRZfCW89laGxifTNH4PNCZXPaXG41xl0vzXtxQ3mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UM907bsdXtH3gNV1t4/Lj2AnI5FyYdvh9X/xvE61AoaX5fMDyxvYQmPXiBCOHLdLn
	 eCwV0dhHNS4XqtDOxSZFu8yy2XrfIvfZeZ8BQdRk7naVEot1V0bfEf4PwWyjoGAL2+
	 LRwSx3d/HESq4Ppk9nCpSynBXiFXFC4kE+OjUT/iYqzOESKPHxhPt640fmiGeQdOon
	 vwrKJmteQcI0CNMiPNsghNb71vW2etQEIDzIkO7nlZSQltB61MmQ1alt0IxNrxGo3d
	 3PZq0rw9Tmi72ylOPMbTTkt85dNzWo/eNEMMAW8bFTgGU8vuVuEXWt+9mZSMD1Hxj1
	 kPLCf8yQh8x7g==
Message-ID: <sashiko-outbox-165447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/15] s390/vfio-ap: Transition device migration
 state to from/to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20261009114244.1213173-13-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:54:59 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> VFIO_DEVICE_STATE_RESUMING to VFIO_DEVICE_STATE_STOP
> VFIO_DEVICE_STATE_STOP_COPY to VFIO_DEVICE_STATE_STOP
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Terminates the data transfer session of the vfio-ap device state
> between the source and target hosts. Release the migration file
> state (ap_config buffers and file pointers) so that a subsequent
> migration captures a fresh AP configuration rather than serving
> stale data. Since the vfio-ap device does not virtualize a DMA
> device, there is no internal device state to incorporate into the
> vfio-ap device on the target, so return NULL since no file stream
> is needed in the STOP state.
>=20
> VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Migration has been cancelled. Release the migration file state so
> that a subsequent migration captures a fresh AP configuration
> rather than serving stale data.
>=20
> VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Migration has not yet been initiated. No migration file state
> exists to release, so just return NULL.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D12

