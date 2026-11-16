Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828323;
	b=a5z1i3rah++R+kh+7jHkNTPxrkf6IMUP/1KF50uEqz0DDd7ePvAjMNc2ZQjX0dhpOi1Y
	 +Z6jVbX+Au9w3hEhnrf+SLUo1ZRXvvshTcAocXRpQ/fIoaMavRfgWH1Vaqg7i4PNA1VOA
	 pubbRf2Eewm1ooREq5D+LYuGITY7Q584IrzvFjJhywPL5n3bEtQ4VKyY74I/2gI8aW/GN
	 dlBLpiSmLMutEHxPz3nEJSwqYg8IrhS3pM08HeBAC8mTjmRZlV+//quTradS/fJggIxLq
	 SSQ+hhTY6jZ3zomgOznGoP5bkwe84XfJ4wnk//QbcQAx7uzp5VsUJosPceqcZ24bKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7q6ER3XRr3KeWNqz/5sPNjRnWKgsTeRduvyN4f/MpG4=;
	b=lcLHiBIKewA7pbrlbhyxSft7ScoYCnW54WHFgqvTNS0hamdzSip8T3xAYEI0E5lwCxiN
	 BSspndTNbsHhzJLXBerFG0xMIPw699dtwzlQ41ch9QPtiIjMYagOSfCWxohjJo/bK6Kvr
	 PaCQxIvPEgyW89PRHK9o9BArGOrInSyXGkSlbKihj0+lonm7OJwcqpb2Z3zUN0MoSTVm3
	 xM8HzMWX3ysezGOuUj+PbiZwtIT3DJNIYxyEDaJShTCvNPWwsc4NAlkH9IXUq9tbXfCu/
	 qqM6KcsttNG90vYkjVhBOsUBOMhIWtEbKGZEs53oRoUszYUIKfdI9UXLJuVJ9L7ACXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Be3EHr9d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5E606A323;
	Mon, 16 Nov 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Be3EHr9d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC3D1F000C4;
	Mon, 16 Nov 2026 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828322;
	bh=7q6ER3XRr3KeWNqz/5sPNjRnWKgsTeRduvyN4f/MpG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Be3EHr9d/q4ZdbemLYKa2ELiixKiT9SwsDmusrknJrkSL+YelPUPZ4ziiKttX+P4m
	 KWXLcnaI6YuU9YFxMw0OMehRJ5NA5hLLNs2+igXeVEpmXYh95xzJZ/WFt3YoME3NTH
	 gd1dVXAIld88/EHi+Gd/vI7f7fLgZZq6qoHK2KII1zC/4EEMHIqzyUNNVbpxvoQgQh
	 jH/URbSBfGdptAjSPIG43wKbfC8BB/3RKVNwZjoio7aC7Za2RBdipEjb1P8FuWbizl
	 5SuRJYx4UM1KwgqoTIa8iskaCBvFekQUgamcvVfKeJRC4z1coAohP9tWeSh4MBu8hN
	 PBVzVV1bwtV5A==
Message-ID: <sashiko-outbox-216915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 42/44] erofs: refuse files on pseudo filesystems
 as backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-42-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-42-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:25:21 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> File-backed mounts take any regular file as the image and the same goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> file_check_backing() also checks that the file is open for reading. So
> a source file descriptor that erofs can't read from fails the mount
> right away instead of on the first read.
>=20
> Reviewed-by: Gao Xiang <xiang@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D42

