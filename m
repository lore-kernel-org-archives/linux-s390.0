Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141158;
	b=KdqwqhnNwbjfz25SuX7cBFHpnhYyTlGaErbFvag52NDY/u42bg3ps85QJ+IW35L09icJ
	 6oHPYOja39GcLHVSXBftlrWkfM3GL2O5bWTUhA18983LPZYvLZZFp4Ko3jdUt4alRAjl9
	 A4q0xG+TQVLEqxSMJ3Y+VT3/orkvy/LmzgK/Wx837ur+w5vGGklhIP/BLN3shMeC2SVJH
	 LpgjYkfe52rIrybGrvk/9PfZKF78yvse21x07KM9X8fxf2tdn9PUrbwIjywmzDgiDdKE6
	 EL9YjC9fHNwARcHofNINBVVFHOmTy0VPsemnVpFm0LxAT1uJBEW4DkrpwdBKM6U7psQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141158;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TYW2PD3BGyeaZH6YMAFFVKfcPxZJvLBfN4S5TdOJvhk=;
	b=1+pm/JGag0aUKgs+WUAoyVqKCkGSbJ9mJOKfF+aczMofLRWUqavXHICLh4Oc1D3JmyqD
	 T70R4HRw4xJKPWnPmQwXHkRJs1gl7K7PR0iPGeoA41TYhP4IUv5WfYwcEXjY/uT4bhHHt
	 2rt7x1eOT1461MX8N8p/Qx6FlCX7sNFvKLWXhXP6mXWGhoQ4l7Tl4P9bSIGh7rcoAX5t/
	 dL9Lvb/wujLO8VPGEGWjIybAeH/E9KtbKSeVT2h2skHu+oEzxYKAhcGwCTuww1YY9Uyoa
	 7m3+Kg/jmXSNOC9naSKwzfgcl4kQJF+xSMOuBWyoPbBKbWfxDu1VHZQxUKXtX8yhUXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyTI9Zvj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F1606A323
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyTI9Zvj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D501F031E2;
	Tue, 27 Oct 2026 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141157;
	bh=TYW2PD3BGyeaZH6YMAFFVKfcPxZJvLBfN4S5TdOJvhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyTI9Zvjue4/B73ARuaUAUF0OooVCc8v91FnEBrgr+sItJhUyCNQklY2daOWbfX6b
	 pTB+2zpVAYqppnjdlXhcAGy47w+4lMjIZhooFsR/0vtWsIOtRUUpin1HVoMtgmhF6s
	 Fq6Bx5h1whStbCgIZ7RCKVgti12FvqemXaWNf8lB7hNMAJPEOM/2D2Qscwgh3IDymT
	 a7Qb2hkK9Savsf51OaGo3AtiM3vs80IqhYGnd6R6qkjMJWQc+M+7zyAnF9UNq66kIN
	 JBUygBaEiUQZOpwHcLJu202d+ErQHCcvadBpAENEcCKikHsvGGEmTuT1NQxFfI/rBS
	 F7gewpNRSs7ew==
Message-ID: <sashiko-outbox-187176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:45:56 +0000
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
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D5

