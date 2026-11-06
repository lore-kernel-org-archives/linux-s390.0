Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997782;
	b=Io7MF9Me2FY2uCTrSIabtjHDo+CPPWqzPWzhVfHlbe9VvrikkNEFbCHH+TPB/0wa1RJj
	 DqQ/tjy+4mOv2lbshAEZKvF9KCs9pPs7cgXEGERGewoKF6AOyvrY3ycUyLf46n9PyoqI7
	 AVNTTE8L6Rl47hbq/Lpjs1/tNO3bW+a8WYaATvUPeUQw5g5K8Rjeu2BilHw1yqU5uz45R
	 2N7YhssGMvaYTbg0zlhKrGIkyOww2nclAiWoKMOxC/gValb9KGOZKJGnBOJE/PwXQPR3v
	 tdAjdY/pXeQI6kpgBrguGEgtrT5rbvc9a0Fu92nLCpfH6tT6qyUmNEVga9wSFu1smJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SY8C007ZM2/0l1e15k3MulpTIZhlyUJOcEqhwHK5GyU=;
	b=5ks+Ry3pDj7/UcX1QwSgZG/LUkKPW409+TrxXf6YW5o8tF+Yb9/PNwHVb71s4mjtYc28
	 U344pdTgvl4Ic2GLRovITNcT97vqX23V3fz2t4hxigDBlzR+BC78UvaSSOYi65ds0lrnu
	 EbnB6YdYdRLXhcweFZnOxOhNYUgg2QVUzG9llQSdqWU0Vnd4PpbIBMnIwzlz6edmtDrNP
	 wAPNulYtiyz1Y6bdSlXmXP3IMjRRoyT7W6lpGzA4xAeGIJZ5l8KOOGuHiIyqTi+tCvLWG
	 dZ0vXKhSDjHHSfWL7eYqscyl7q/bYGgUJTpYhAMKDH64iwhMVGSfylxNQO4YE19Y8qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3cL2Gpj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C61606A329;
	Fri,  6 Nov 2026 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3cL2Gpj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBA81F0089F;
	Fri,  6 Nov 2026 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997781;
	bh=SY8C007ZM2/0l1e15k3MulpTIZhlyUJOcEqhwHK5GyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3cL2Gpj8dy4kK5JUNwE2pHNE/14RMs2BYEzNONa8NFnDz+MzyhT6q9POJ+WfoNnJ
	 PWu75lJio28fuFMWsvi188ffMrQzjsZSFtg5nDzO8HaSBAV+ZqeboJ11Qe+ceWbveW
	 5Y7zjLdnpl5yCa+SbKMB6sr8NzDKPgjfMiPwX/aUrmgdfiTbUpNjSNEsQWuNQuFG61
	 N4a23X4bcHIc/tzmJxMGsFaU3d6lb2z9Y8IxhQ/k8Crvtta8lhM1yBQ+DALNpaPwfo
	 FIM5TLqZqHUs9F5i2vNrEQ+ojKVnKaesQbQXPRbl2w+OphcEP+69jefuZFyBLoB2Z0
	 t0uCd8+HjB4Mg==
Message-ID: <sashiko-outbox-202252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/23] s390: Report AEF features to sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-23-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-23-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:43:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] s390: missing static const on bin_attr_qmc and
  bin_attr_save_area
--

commit 2934d9947793e4c4621a99293c7dadc5c2b8442b
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Report AEF features to sysfs

This commit exposes Arm Execution Facility (AEF) capabilities, supported
formats, vCPU limits, and raw QAAF query blocks to userspace under
/sys/firmware/aef/ and documents the new sysfs ABI.

> diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
> index 31e18953d7b31..96a6d63b26950 100644
> --- a/arch/s390/kernel/aef.c
> +++ b/arch/s390/kernel/aef.c

[ ... ]

> @@ -38,6 +47,68 @@ bool aef_usable(void)

[ ... ]

> +static ssize_t qmc_read(struct file *filp, struct kobject *kobj,
> +			const struct bin_attribute *attr, char *buf, loff_t off,
> +			size_t count)
> +{
> +	return memory_read_from_buffer(buf, count, &off, &qmc, sizeof(qmc));
> +}
> +
> +BIN_ATTR_RO(qmc, sizeof(qmc));
> +
> +static ssize_t save_area_read(struct file *filp, struct kobject *kobj,
> +			      const struct bin_attribute *attr, char *buf,
> +			      loff_t off, size_t count)
> +{
> +	return memory_read_from_buffer(buf, count, &off, &save_area,
> +				       sizeof(save_area));
> +}
> +
> +BIN_ATTR_RO(save_area, sizeof(save_area));

[Severity: Low]
Should BIN_ATTR_RO(qmc, ...) and BIN_ATTR_RO(save_area, ...) be marked stat=
ic
const?  BIN_ATTR_RO() expands without storage qualifiers, so omitting static
const exports bin_attr_qmc and bin_attr_save_area as mutable global symbols
in .data and triggers sparse -Wdecl warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D23
