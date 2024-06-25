Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DA1474B8;
	Tue, 25 Jun 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303177; cv=none; b=Pe/XKc7WE6Dr6C5hthJDn8+Sv/9Tnk/YI6gcU740uWMBJBmatXRZsMOsj/dVXNbxTR5JKv8GkKaOHAm+3fBoegPhkzQLIULubetwGEEfuWmskgXMRpOiehKY4ZaXKwfZ/AwcPnUTFtODkT0TPf9Zx23/ArhkD4BF544BZrfWR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303177; c=relaxed/simple;
	bh=HY90n2rA/wsU3QJAr+EqQ9x58uvEWF+QC5zUmnvnZkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6dNQlDbn+oRKDdmxHkmCs0FfAI3STecH1shydrscGQ1h6H36VVbYyDXrtmJ91AX90bYlnGuW2XZ33vrGrgE2wHCIlai7MHZG518zkQFF8rcK7MLuFB+Umei7faAXa7ZxRZ8xM4mCa1t13uP5CQmh+85Tl0KsH6FMzjuRpasvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nmf1iQAk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nmf1iQAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719303164; x=1719907964; i=markus.elfring@web.de;
	bh=YNj4CkeeBkR72sAAMLPDwBxJf6xr+bB5YaKr3Nb1xIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nmf1iQAk4wNrIHThdrqOradqCZkqe0cFbythnTtfTIUcw8hnXA9EOaGbaHsxuzpD
	 XSevyl5+u8A3qP/NfnIIwl9C4jIKbIdf6kdiXL/WULQjBsKUb+h33a/HdzSu3v/7N
	 FdVRUf4owDcZdeK828J6y5fby9zs+ImWZyx9XD7o0vu2cu5up6BDrEU10lKzaQZyz
	 Oyta0ppMoppHPNtsvGGo+qiLfTtmy/OKTCNE4ob21Mrd7/CTibtcqLgp47suhBxYD
	 ymgLZ46H6I9cNkn0L/W4IUsbXwSgGxdFPSmrDm2ya0iX9lolbJTBtjZRbBorWCHFb
	 jgoGlXB+t2EqAKUxcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1sV7uf2Ge1-00tkIk; Tue, 25
 Jun 2024 10:12:44 +0200
Message-ID: <70139e84-478f-42cf-a94c-61266399b37f@web.de>
Date: Tue, 25 Jun 2024 10:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/raw3270: Handle memory allocation failures in
 raw3270_setup_console()
To: Yunseong Kim <yskelg@gmail.com>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MichelleJin <shjy180909@gmail.com>
References: <20240625013225.17076-2-yskelg@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240625013225.17076-2-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MuuM+gyeE9zulDfkpPbp8aj1hLSmPkNj2rvDUuiQ63kKVhTWvTW
 1oDGtTdsWGkrlPA5XljeBJqIvKNs99URQkLg5PpsEO6JtliUYEtbWvcsj6LorqV+98O4oKq
 VIfcCVEbG7ZSClNaUcOQ84ZohKit33AroxSGGkXrITYI46Kep/+zRblZKGtlUuW38SXQfMa
 uymqHfmWxXhxX4/Io8Mww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SdUk+5bHDK0=;c6joiXyHBH6BAB+0PIDbZWEIcVp
 tQsYFxg5dO2PA7SrnPQtkwZowDtk+Ed2HkuHLttwWdJAqYF+VitrwH/64pSzuA9rH4F2ObXwu
 J5Lk+Yjou6YOW5Zc9ACSABxGcdUCR9/gUTgNWrQ92v4HOpLZd1kY6twBhSdK+3AIDomM/5yVf
 tjB6+6DuIsgfuevwX0sHbIuspS7x+uTkR1fLzWl027fzxlCKA7Jg/me9gzN3ktoQFkU7JJnG5
 fcU8SCtVNCaLYTPxmmrvVOeBQ+HhhfBXvQlJ/MvLfqvICLDmjmDoJjjfdBpHiF0LDCqgnNZ/L
 4+QgeSSlwgjzH363xYfAbD/aUu08G+3Se5m4Ey+ztIMXbfz0rXyh/l9EBSK+14VPmm/q1ING7
 j8buo3FO6kO5dYotbFc/BpJ9cXmOTqrr6ccc/raNEl2EavpGQuLkuV9JWFzgUTiZoiKG+nMmX
 AWOi+0JPvpqU51yzZmRfjUauHZETFzztUasJunrREtL/5FMmZz4VCRwpdo4kWJyYSg+sMcJb0
 Q1qYbNA/I/6gliCgg/eyzrQidCOueikceih0cwJ96xsAqknuiyh636Qyzz5QXFTgpOTKhDo3a
 RTKhDYqqIop8E5O1DTnveGGfDH9cUSfE+ug/W21gX2oaRIk/OXJtqbwEvsSCcUaOrJad1+M8A
 SP7VeI5KOPIXIOrTq0zmW86UKb9jW9Q7Ye5t0r9rQ0Y02w23lsYEpQiJJHN2tM+1mqYGnuu+z
 /1bvLYe1r1py1++0bZWemYWmFXn6uDK7m6DSNrpT3Ob+yfgCk9LwmOZVHacoBuViEhdDYmBFf
 w429rpCeM1Ljb7XPigpww06GisuWoujEvvPBp9Z8Hp4SQ=

>               =E2=80=A6 Thus add corresponding return value checks.

I suggest to move this sentence into a subsequent text line.


> The allocated each memory areas are immediately overwritten by the calle=
d
> function zero-initialisation be omitted by calling the "kmalloc" instead=
.

It seems that you stumbled on wording difficulties according to my previou=
s
patch review suggestion.
I find the intended change more appropriate for another update step.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n168


> After "ccw_device_enable_console" succeeds, set the bit raw3270 flag to
> RAW3270_FLAGS_CONSOLE.

Why do you find such an adjustment relevant here?


> Fixes: 33403dcfcdfd ("[S390] 3270 console: convert from bootmem to slab"=
)
> Cc: linux-s390@vger.kernel.org

Would you like to specify a =E2=80=9Cstable tag=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.10-rc5#n34


> ---

I would appreciate a version description behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n713


=E2=80=A6
> +++ b/drivers/s390/char/raw3270.c
> @@ -811,18 +811,28 @@ struct raw3270 __init *raw3270_setup_console(void)
>  	if (IS_ERR(cdev))
>  		return ERR_CAST(cdev);
>
> -	rp =3D kzalloc(sizeof(*rp), GFP_KERNEL | GFP_DMA);
> -	ascebc =3D kzalloc(256, GFP_KERNEL);
> +	rp =3D kmalloc(sizeof(*rp), GFP_KERNEL | GFP_DMA);
> +	if (!rp)
> +		return ERR_PTR(-ENOMEM);
> +	ascebc =3D kmalloc(256, GFP_KERNEL);
> +	if (!ascebc) {
> +		kfree(rp);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  	rc =3D raw3270_setup_device(cdev, rp, ascebc);
> -	if (rc)
> +	if (rc) {
> +		kfree(ascebc);
> +		kfree(rp);
>  		return ERR_PTR(rc);
=E2=80=A6

Please take further software design options better into account.

A) goto chain
   https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a=
+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+reso=
urces

B) scope-based resource management
   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/slab.h#=
L282


Regards,
Markus
