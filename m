Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116921;
	b=FRJ6rNCbwKkA2506+WG/7IgY4IyzwutCxJz91rmBSDHFOKOSv3dHPlT+saz/s+toa7hv
	 jXmG/NhnWj5aZy0l6VXLN75fmGe0jKVDmttIRDU2Gj0J1h6XaPdbnYiCDZ7vWBlPSJIjK
	 A0XGecTr5gGIpyZBoG1lMsGkAl5VlakwcOJRrqNUByAudYYMqKtb5AxydY3zhsg30wEUc
	 KcvQ1XNbRzz6stv9H2dLvnO3Y1ublkqx3lu3hc8iEs57k/TZa9de+V3YxWzhRv3221N/B
	 /ouE/JGvYiIiwTvKQysbtO2ucmBLbohPYmP35ergRt3WNJ+EOx/fNLkx/2Y6LsTg1CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WkO0sCnxEFbGdExsIju+s6+1h09L7g+00PP00V2QmU4=;
	b=Hm0tF1MQU07bAairos/lk/W8VU3C+cfOHVS/utYJpenYeHY5/adFXIqXpFyX+iyp41Bx
	 L/8NDKJ9uk2QJTtUJGqz2MoccyL9vPf1LPBdJEKKxZIvfCiucgxHd91c3L8EuTOdWEIoJ
	 D4vVh7Rl16PA+lKQ/sXYQ91haL3kISxE15fu/02GxlmMBFDkQc7YBGQO+N1wBS9Ymj7p7
	 JM5Y32s10/byY5xoM28/uVA+npGDFwAA0ELqn+SlAITOpwiVGTxb/PBddgsuCpySzlY31
	 aS4C2VQkZyIYZ5QO5i3fJUxA/nAP3imjDMHwmnoIJdT7rR1SHE0vp57eZFw17FQPR/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=myLe98+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2E606A325
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=myLe98+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435811F000C5;
	Thu, 19 Nov 2026 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116920;
	bh=WkO0sCnxEFbGdExsIju+s6+1h09L7g+00PP00V2QmU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myLe98+ZBjNcRCOfQUfL8gG0X2IJbIFfAS6HxIJhBDNkjYx3LySxU5yoOWg3iXXgf
	 AmyXmuCK388IHwe7/CipmySsJ06iYhdJXWq2jMejKvDcHdl3U9XLuNsoBplllCt9sI
	 QGCSLhKMqVFUY86KTDIHNk42OAKpjYx6a4qm5GqCoeBdoeIGcyYVTVVp6qUT6pP/ta
	 zx6aktDUCj/R/cYOFfSUs36H3Iq0eE+k+/6LvYWXjV3XGQLlqUeNfoAdTq869Zk/vz
	 MQkMIM3rEpk4jksioTTCRN75mwAHNJReZ7kxtzEm0JfZvCAHe+EOvz/xz8uq8QGJhm
	 fnYc+CvkC+K8A==
Message-ID: <sashiko-outbox-223940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] dlm: Wait for kobject release before freeing
 dlm_ls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-6-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:35:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>=20
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>=20
> Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D5

