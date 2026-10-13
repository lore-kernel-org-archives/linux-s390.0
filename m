Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0493D8122
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907696; cv=none; b=hbfCG2MU/juWFpuspDJuaT9jTDHXzqHI8rFhv47K6RxKlu4YjpEXEvDCn9dOw6F/75ya40Dn8Be6ph1TyZzj3dwMoAgVEeQXfGhikV79uTmlt2mSMVk46S1KUjscP4+rILOM0ifC6SsRZvrKDE5Jk6iay6WeDuIG+MR9DC6q9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907696; c=relaxed/simple;
	bh=IC94WvpqH+KBwp5TMlXgTLPv2k/4q11jlVGeP0AZCtI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=duzEG4kwmOtfbxEPo8DBWJYlgJ/pDu2E/bphT4bliOPe9vKo+VCgADO9FXCF2Z1XE9OCKQ15Ee4OuvBkfsCiuQPK05lgLRTA24LNZDs7EpPW3vLiBL6MudLRYg6QHwBUTYNGTxCW5sDaI5fjGHHBPJfj4QS5fw99uR/LfQv1ido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAgSIUQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAgSIUQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF501F00893;
	Tue, 13 Oct 2026 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907695;
	bh=IC94WvpqH+KBwp5TMlXgTLPv2k/4q11jlVGeP0AZCtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAgSIUQpUfkbGvBRUw/4Adjf6pXfztrxf8rDU/KgaiCU4qFzTZmhoI6QzExBNR9OP
	 QImwergpRoc8EvrW6zYNqE0XDPBh5aylfcrlUqrNfr+00k73UJBPOwnjJeTgknGts7
	 VDmfu4oXWZf6ZYst/oW22EDCfNLUPLjeY9ezdx1HOwCyTvf8idlRSCPipF+Xl+gAqU
	 H7/SGjgkt3ih2vFdKMRFq47GSqciHmaD8/UGTRW621vLAE8N56xs9Y+PmM4yyZVGBI
	 AZchsCsd6m93Zy37rtaqSXk5V8JtmZKiSEaP626DWujluOAgfIzONvkBp8+1K+Tk0S
	 H0L5ucedm9iWw==
Message-ID: <sashiko-outbox-170090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/15] s390/vfio-ap: Transition device migration
 state to from/to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-13-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:08:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D12

