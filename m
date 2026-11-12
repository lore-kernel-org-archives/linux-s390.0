Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457894;
	b=BI/snqguAAlB5Fq7l+E59PdAmr2qdFBeU2FjmvSQd87MOv5XzGaNxWAU2wF1b6yV+FiY
	 fvmOqWibQCrvNfluvltv8z9ZPnjLJYv1rr7KIdpsisVUSll3gDlmnBTDQ+kTep28cx9pI
	 rRj9aVkQ1lsgabm0jTY+qeD5ee7EiEC/SQWosKVjGI87ITN7FJBVu1XFFtJuws0xDZX8i
	 8PrqBdRJlPX+Gt6zNxXaBA0CkF0bMw5Pe3uMtIgdxOcMAsg1nmA8i0o1XBrBX8EZTNolN
	 aO2EUPDe1Z/SbhdoOzn+BLT2PACq0wsKkPRDpNQ/ClW3pLeQDuzLvcL9ljL6Sir7G3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=14YAVxNQVAKUcuQi+l1g3Ak+CcPBzwc7kESKAraR4cs=;
	b=ThIZBUg6X80QkOX0kYlD6bDxE5yK9b4JuaZBS9Tq8Ad15arNpERrQNWzdUQ/24SmQSNd
	 xnT0FgZnpuSjFDHcM3cN4kDPUb8xAYQKfxxEITpUuWO5Hj/H9QvHb/QVFzJC38nOQ/Qof
	 KQLIql9zM1hbK1mJvv1YT7glCHROnf5kWqW4y/60ok9W6AopA+oxqKlmCQM0iCpQ54zhF
	 72/tdsVKPEBDqVEbZo+UAPSqw/8QUj7TJwz1cGT3E3u06kTtp57whdx8jbJmd+R+Iw2jr
	 kmsyuCthKgIXv8Hu1k6oy+t8Lc9PtebmEBexPzkAeMSJuqo6JK9C2N5JaI8e1Gzj72w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmqkUEDS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA53606A327;
	Thu, 12 Nov 2026 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmqkUEDS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE35B1F00A05;
	Thu, 12 Nov 2026 04:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457894;
	bh=14YAVxNQVAKUcuQi+l1g3Ak+CcPBzwc7kESKAraR4cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DmqkUEDSLD9+sT9D87Btx89bupUK/Hml2rrPlpgtJpGYUO9VJXsf4Bv+d2KvjQW5w
	 muliBKNBWFjGdlyqoLtSUCJ77vCWAWdwlJrubvtBB8r5bDyAtZrhPyIWNA6w5ClLgm
	 YHZNTLF0IBMIwYOlgUNWCf6d7tXUYz+WWTpCJ5KBGSnBVaGIpx7FcWT658nQdWuqXN
	 hDYEnkczTPhEbglXj+j6iDSP2kckW6A5kGTdii5aXsl+ZsCe37+DvUHJ/OOOFYx2Iu
	 JtTQJzdTvFO25DXHqn/RlOrqCbqHFxqMrleJ6Vz1ZrIkWPCSq8cHxHRFDvcYhKvU1R
	 m6WhUke9RkybA==
Message-ID: <sashiko-outbox-210354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/13] KEYS: trusted: TEE: Disable sysfs bind
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-9-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Suppress sysfs bind and unbind attributes on trusted_key_driver so that
> userspace cannot unbind the driver and unregister key_type_trusted while
> the trusted module remains loaded.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D8

