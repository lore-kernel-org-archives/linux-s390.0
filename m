Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1746D0B9
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194164; cv=none; b=qPxKZEvRkKHbIVhwNvA+VWgt6/iZmbI6jQQAZpFvt7gHNwHU5J+b0rc3Xk0o5t87qtqgsmh+8lQ19Jx+sNeXqDIygSEw7zxH1Q5wmfkLo5JF72diGQeyIdWgopVGf61/ZqThY92LriImY3fENDIIEyuFE5bF50BHDANchkzSnNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194164; c=relaxed/simple;
	bh=MQ3K0+0taRlcKCtI4e1QVJ8G39eP74lVf9X+BreffJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/aGM0rfK9OR/5pBKYxHM41AcjCTJbFXKoMdP+y/fcEmQ5XViHvXgHNOBjPjj9vwvMRFq9LeR/QnYbQZ6B0H2X85vQuJoV+ezsRBTG2G8JNwvrVhn5UW5ZH022vM9dfw3ymvIKb/OPzX9gj8UVFl0MrDJl2tyA74PdL4cD3x2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imf7czBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imf7czBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAED81F0089F;
	Mon,  5 Oct 2026 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194160;
	bh=MQ3K0+0taRlcKCtI4e1QVJ8G39eP74lVf9X+BreffJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imf7czBJ4blme5J8W1UyQcwMlNrMyLpmBuZi1+XWwbSjRlnnkRQmxSuC40LRfh92y
	 oWzPBia0Q8NGPb2gS/Jfi4ScQ1ur7YPXxpVMVTkaYcwanuEwr96VSKgb6/HfQbjoVE
	 3H2PTWgT5KvAPpt4ayGnAXg7BFx2RTrwsu4pUkJWRrZixlTG+3RRSTTXk+yzjSb7zl
	 FSFk15S+1jdWlPchVKxQfwsOQV71evZDIidBqo3nnK/P10myaT3B0aYUAciGZ8Er/L
	 0Blf85KOKV3j9m2dnlDscRilY0fedvCQBGOjNMFAUuRKHLDPQ/xO1sBh8i+Z/jWMvp
	 gT3uF+k2txf0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005094631.3361197-1-ajaykr@linux.ibm.com>
References: <20261005094631.3361197-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 09:55:59 +0000
Message-Id: <20261005095559.BAED81F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
> buffer. If srb->length is smaller than the fixed header size of
> struct fsf_status_read_buffer, subtracting the payload offset
> underflows and can lead to an out-of-bounds read.
>=20
> zfcp_dbf_san_in_els() has the same issue, where the underflowed value
> is used as the scatterlist payload length.
>=20
> Fix both cases by validating srb->length before subtracting the payload
> offset. If the reported buffer length does not reach the payload area,
> prevent payload access and treat the payload as empty.
>=20
> For SAN tracing, retain the original channel-reported SRB length in the
> trace record when no valid payload area exists. This preserves trace
> evidence of anomalous firmware-reported lengths for serviceability,
> while using a capture length of zero to ensure that no payload data is
> accessed beyond the reported buffer.
>=20
> For valid payloads, preserve the existing tracing behavior.
>=20
> Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA =
records.")
> Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN =
records.")
> Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005094631.3361=
197-1-ajaykr@linux.ibm.com?part=3D1

