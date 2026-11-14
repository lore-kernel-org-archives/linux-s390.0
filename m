Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662373;
	b=P5RP6SVTK6Xb5SbnLTuJ8uVlg7bHPa4kHNglpXcGqAWiQ8Jukgoh8d+qvWSP42m6iV51
	 6zr8PnFQvifPqlIbGvwl4vYaeXkRACxU2ZpT8/IR2Ts76lAmY0b6d925IPgWrMZT1aod9
	 Wd+i8/Q/0x5DglMZtyBVygrCi7PLg2G7GkFilXWCpZCW+EfMBLJ0tR8rEuIAd2xiVq+Sk
	 Tt6bEFwHDxWcKsOENqwN9CpYjIBYHmtkKETMV/Q4MeorNAeSdgn6shilmRW4GeUaGt0Yc
	 KfqYWblHMDWkjsPznDUrPSxJ6l9Boo3LsMbpeSVpr+kW0c8yEZwsxK6Xw9kTfIPKctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TT60fPUL1L+lM0lqlafP5bmx/kHI8RTr+UbnpGvJaPY=;
	b=HXtqSz3HRbbVxq/xuknv5GyI9D7QdSJ21JiSlAsO3zkYI2br5W8Y33eHHDJsiYsbIONu
	 n6wVdqn9/48XXKdgzrNA7jkOzRTE5lKpxD3+hdEsBoBG09XP+6VHXp+3T4T7Narr7xSjV
	 MeoQzcaK9Jr4W+jFQ0OF6/VnZUtx66No/8IKSdlh+ZL+nIH2tyzPMiUL3c5MGDc9yCo/N
	 regyg5lJZ12Kpy8DjNUwyu04s4zu0OqmziMntgy0lyy+i8xQ3Y8dw72VQmAYXp3KcGvZF
	 yhWPSaNWcbiidGxo8w/hMtYjYnb7zaqroBWyY26wE9/pHz+ssKHwQbr+zQYYeGBMdJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkmkrXUv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D2606A32D;
	Sat, 14 Nov 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkmkrXUv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549C71F000C4;
	Sat, 14 Nov 2026 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662372;
	bh=TT60fPUL1L+lM0lqlafP5bmx/kHI8RTr+UbnpGvJaPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GkmkrXUvkG6nGz/8uShlEGKArGgZrfeC3oFeyLkUce2XTuP18NkTHOuDDDpatB2Kq
	 GYYbVjxpcwIk9ngfdbDXH99A5O4jp52VNBoiDa+kqTSVg3ltCmIPxzSd2NOi/3yAxn
	 NHmFrj/bu+QYkVZpa8cOn8jVUfpf33Z1LZIAdQasdvbwZCOF2XtTHLg7vv+AQONz+I
	 tNIzSRKQ+QK0TLfjGyLWoBxT8vOylet2N1HJCHxn0b1STSRZVoA9sN5Z8AMGtTeNyd
	 lv2zccM/gAeOchoeWVVGJenE0a7p+/Bp/Ty458SSmwTuUXqaQVT8dwmtrFYIOz05OG
	 ++zl7tP2DUd4g==
Message-ID: <sashiko-outbox-214541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 24/42] efivarfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-24-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-24-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D24

