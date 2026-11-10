Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302941;
	b=UXGVttjKgcUJUVxEl93iPOuQVRrfWqtrsuH1fDki15/UX8dIf1h3kF97PGYYhHFtfUBL
	 RCO6MCkCnN49ymGIsnQ922aNcFuBRfzvQlkDHkr9AOt8ot+xK1DEwEGI2skxiGrwx7YS8
	 vQjDYpQk9dfzafxcgmKOGv8zZAXp6ne95hSv8UknA1hVUwZ9V0X0sptIFUZOuJfJ4sCY/
	 3ZFSdqKao9iV9KE/y6XWmROlAxYgLztwsXVVr7R+yXE3Te2GZ06MhSn51xhazDVwAoMbO
	 6acOV8t1i0POOEsTEbJjlUQm306Zu7i8dsUMRks4X8HHnOk4XYG/VpBLjFgH17dY+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KKmGuSlAn+lqlss2ceYIndYwBRZ/WEBJEvEEb+2qViU=;
	b=g4apfUlfxvyd/2/EGqgTR/z2jSoht1HVjzUPjXKy06Y2JkGtTzDyfIzUaauO2Aq4/2UR
	 iGvCz35gjHo5JVgTExuRetHAopiNBBFN9IKbeoikbxf/pzrtn7fYYCiOBhu+TcL96HD7q
	 tEHcFXRXByXNHv7+j67eZPR0rHtK07BpKbu+C41SUyvA51DNiX5aOpBFIZYP2g8+kFBIP
	 zUwK1Rimt0Q2dW5xbt53CtU6i4veZSeK9/JEmZvDhCMmmDpf+GZAmBsykddGCZ0zFK3I8
	 ZwQIcn4M9B/5FoZEsOI6jBIcgMLRT4kUVB+SJihOpf6GqY395lz2ci28pi0sCbaPDeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hut93Aij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD72606B9CB;
	Tue, 10 Nov 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hut93Aij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90ED1F0089F;
	Tue, 10 Nov 2026 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302940;
	bh=KKmGuSlAn+lqlss2ceYIndYwBRZ/WEBJEvEEb+2qViU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hut93AijGXclzRyEIs1CDNPSeLYmCOcfH4rygM5OoKEfpOxuyGOUMPZ1uVoYKbhBc
	 lGnUA1cjP/pzue14xcn3YTJ+AV+KDOC0AbKu3hPy+iaeRTzJK8v46y5ZXkhrKsi+Ba
	 4qdSe/JCJl2kfdLsg8QZOAfGmfBu46Avmq6AZbQXqcL5CEsRQ2bm3gPtTgX2SrJ7rq
	 yPmcUMQU20yerILNM3IjVR06U/0/4cXCRiVZk3iNKLtW0POhE7EDCrRfDUqW5yixTw
	 uyyZSa2CUX7WAnXmEyvf8OWWLBa73wc7HTLL9Jpv+eKGEaDTBHweuU7lBzjhHQOIXK
	 A79Vl8+aQVxJA==
Message-ID: <sashiko-outbox-206758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:28:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> fsg_lun_open() takes any regular file as the backing file of a LUN. The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D39

