Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979644;
	b=co6A7klZf4kneqFIRZESSGjYrKy8QNULorWK2WAIkUE4xztvV081McLQT1inkRqKtZNd
	 s83WxMXM8hxppnkyiQ1ia1I3daws/DObHKRi3PxVD2Uvt9o5/XvKacfHcCp8gZcdsccaJ
	 pTnxiloQ9dWdYZ6/C3CIGplhdxFwWCOLibkmC9XG4LkOJgBc3gPOyN9B9y0zlWKOCBZgO
	 lzHflUbe+2hjnQVRAWhdMb2NIvWLrcBbl3MDeZ2ezjX/5XhlFKYLw6DUIkdxYjQSVzRqD
	 jQfOlcCl6d/DD6O4fD5YY1jY0IelBTVBCeFcg0LfHXGA6anWnIrYTjx1oxOHE8sEsWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KDwimcbBwL/67DD3+MKwd4xHSssOPcKdJdvbFgsnWcs=;
	b=NVsk8gOx3pA0L4hEI9iSOxakbebgiCw3i6nKfOonYKSgL6dxQ6zVtC/KK4L6tSmDX7ir
	 ja93WFyeL/3AQlsS9ekPrzHaLgZdn0jF0bMP6LNbQOTmsNdSTYWSqFFRdV4sD7wt8dU5+
	 UCfQpHg8lCFBKyoXjrw4GCVnTwCGdJifkUH1JZKhZXqRg3o21PjYlIT50EVl75Ax7lblG
	 5MrK0imKLl2rOAfWcv1TXaMGaXumiQ24MoqG68VMjlfYz0j8vbRGM3oyQQvODOvvVKbgg
	 gTkREghkhHxhaxCfjzjBmhUVezdKIj7kMTT3WMw40Cehw0kVfLqvL1+EU1X00Ytvu6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="anEEP/En";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C02606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anEEP/En
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B21F0089F;
	Fri,  6 Nov 2026 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979644;
	bh=KDwimcbBwL/67DD3+MKwd4xHSssOPcKdJdvbFgsnWcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anEEP/EnHfk2rsb6NjHx6hsOWQNwD0GNwD4pqMQT6oxepiGezsHJsJTTTuSZDzMss
	 rq8Te+bDVDO4lDYm2R7eKUFaNJO81SEF0HbRTWCs/lfS7rX7tWQIZNW7kHH9vTbKzQ
	 7A4zblvAW0fVWuMi0T/SVMw/5gk3TTZg3eoN9YEYrXrpuYPZJMTdpIH/+qYva9CTIS
	 kfiXQ8MSuaZLSV/AJD2IbfBg7n8V8IgFPRlb7IIiRuwCAtO6mAKbr1HK82Id7MvFUm
	 hcOdkmftF3aDM/iWXIENvBnRZBBtlqpbR6szxVk4neJd1bKBT5y1Z41BPdNmgPMPuu
	 Amfqxglvco1CA==
Message-ID: <sashiko-outbox-201718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/14] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-9-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:40:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file
> stream to receive the guest's AP configuration saved when the device state
> on the source system transitioned from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the write operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D8

