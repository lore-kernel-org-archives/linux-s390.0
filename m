Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478D480979
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713519; cv=none; b=MybSQV9qMoSOQeWMbh7vlGzh6qrPbAKNpG+8g748QqFEQhcSqhEjvJz6igCFAS6l4ox0M17Zj65F380jXKmX2/6cOMVit1Wye7zz3gpblpmScXeqiJkGHbodOU59iAUnv0wT/GSHqECwM+1LJI3MLqFO/BmzRuLa9lAdbTITcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713519; c=relaxed/simple;
	bh=/9NPWbMNzZXq+O3b6ASCEDQ+/f52t/hPpsflezqlgkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQNikyUzwIPfwESYCAutDzCMYlBegrlyUwpZamPzWSdnsCZe2Yd/QGqfTfiRpjnHuCCGMoYaglaQZnytVEGTGJyn1x4OF95mutewQ1TffTOLXaGiSY6V/WHnqZ44VW6kb1seMci8/zc8q3qdeFyqSQwnkLsw+pugbV6aAaaapmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Qsbec5d6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Qsbec5d6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4908b92904fso74188115e9.0
        for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781713510; x=1782318310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70RiYle3YxOXMcsIHWzatMalj2xZ5VUKc+rRMNWk5WQ=;
        b=Qsbec5d6kn+nlELz25aIjEK0sK+BVhqMvMRQg+ImOo/MDhCY0WSf0tEjylVZmbgVtw
         jCioTupMAhXqVrsk9i9pnW943toGOX/AbpWtTWBTf6XVWKDYBYUvh18f/Oh4Dnud2A80
         aIN1wQ6CRiVXH97HegjBU3mhRdOPZiC39VX9KOyuDTwE9wE09/nfObsJUs51eNnZIvrQ
         MgxIleiL05aX7UTMY5qVS/X2dGO9I6naqCLxM3EQgM1ua1K7+NUjIgnkAYRlBjT6wHih
         Z2v/2zbihAozbf5peVr+LlzADG9XO9YFvxaF8gUuRGiAW7l3AxD7Iz4aYWAUtsFkP8ui
         Ga+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713510; x=1782318310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70RiYle3YxOXMcsIHWzatMalj2xZ5VUKc+rRMNWk5WQ=;
        b=FsdZnDs8/8/oZHRoHaqqgcnuXPGxhh0dYDrWFAOkdGFxzVAxcoF5+hWnghPJC0rKNo
         IwO725kF1RKH+Cfv7OsH/rPcViPJpqYbbwZotJoRQol83aaR5EH3mcWSSEUVJbck/urA
         oqR5eHgqyhWqlh2usTu2ccZUv72zF9/15ZYvYY87ycJ7GJSuugZBJ6fJlSacyCdKcsww
         CX4lt4x1I8a77dZRbHj04vqADAYMKXoaVu2ReML1CG3MGWQZAuO3GksKWGb7SSPm2WpX
         I82S7Ho3PyFhNp/wYOzL8YswXrTp5wNdd/fpd82A1K7HLjFSZhNQ57r/UJm51V94iruL
         Sm7g==
X-Forwarded-Encrypted: i=1; AFNElJ/hyssZiMFUoY4U6G/zdRvwwrq914ruLFQiLzrstNqhCxVhzLqSTbqS4gdUXH5JxcaC43tPh4yAaifU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7l+sHCtMaZvMCX6ls9FKxrnTRAkHWgf3snpwC6DUg5anY11Tc
	Vp74iJpeE48i7qI+DNvwYMF7Vg4uZwJLAzfuXoSrzZ0By/AuZpIrUjuDljDeVBXWMl4=
X-Gm-Gg: Acq92OGVZSfNnKEpAvk79gociW0tn0Qm3dr0K/wAKl4nvbS6hNqS9Yf5UC8ku1dyA3j
	AeVOKQv4VFfzXRwxZGtRJ/RSvqNnH5NFeG9Lf2++dMxLDqrFBLODXKWFxVJ7qSiqWjVm6xNBJbJ
	sPEuPofpR+xnZbI0N48U5Cd21htFlmQr2i55YhWmyX187DJlvYahATElVPK2aPzh0fH80YD/fqN
	ZIDKofP2IGenSq8IajNAVOGesXMejZb9D6hwDrHSGRKVm9MnSlQrn8YsTdIc8mCdgUjhEJfrEAs
	c83EpQd2MM2i0VZcPb5IZX+EJAYL3aFntT/cPl9FRZY3wpZXNo/ojnDWSXfwHRtp3qWqdgFXpn6
	/XZ9a0p1HnoYo8sjEX74UcLMJDsAUAZcuLD5HpgbNTzn7Fs9OUabDjJBgq3iDMXxySKsVuEJLBA
	/+Fk3xDQ4+MGiwiLVpIR3/znc29/R0lI0II0wcoMXbAaIqBlKzRGWsObeFiNbZgNQsFKNCHlq81
	48g
X-Received: by 2002:a05:600c:8b52:b0:490:e281:287d with SMTP id 5b1f17b1804b1-492340ff916mr81518995e9.1.1781713509911;
        Wed, 17 Jun 2026 09:25:09 -0700 (PDT)
Received: from localhost (p200300f65f47db043b42891e8adbe9a5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3b42:891e:8adb:e9a5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923685fe90sm18982865e9.1.2026.06.17.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:25:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 18:25:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH -next] s390/idle: Add missing EXPORT_SYMBOL()
Message-ID: <ajLJhMC9SDjeSQtR@monoceros>
References: <20260617145313.3910957-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52b5dsi3hsppeau2"
Content-Disposition: inline
In-Reply-To: <20260617145313.3910957-1-hca@linux.ibm.com>


--52b5dsi3hsppeau2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] s390/idle: Add missing EXPORT_SYMBOL()
MIME-Version: 1.0

On Wed, Jun 17, 2026 at 04:53:13PM +0200, Heiko Carstens wrote:
> Uwe Kleine-K=F6nig reported this build breakage caused by a recent commit
> which provides arch specific kcpustat_field_idle()/kcpustat_field_iowait()
> functions:
>=20
> ERROR: modpost: "arch_kcpustat_field_idle" [drivers/leds/trigger/ledtrig-=
activity.ko] undefined!
> ERROR: modpost: "arch_kcpustat_field_iowait" [drivers/leds/trigger/ledtri=
g-activity.ko] undefined!
>=20
> Fix this by adding the missing EXPORT_SYMBOL().

Did you consider EXPORT_SYMBOL_GPL() which AFAIK is prefered over the
non-GPL one?

> Fixes: 670e057744e0 ("s390/idle: Provide arch specific kcpustat_field_idl=
e()/kcpustat_field_iowait()")
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Closes: https://lore.kernel.org/r/ajKsG0JP6qTssQBX@monoceros
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/idle.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index 7f7851c001e0..6da8ee22a1d5 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/cpu.h>
>  #include <trace/events/power.h>
> +#include <linux/export.h>
>  #include <asm/cpu_mf.h>
>  #include <asm/cputime.h>
>  #include <asm/idle.h>

When I fixed up the reported issue in my local tree, I didn't add that
include, so it seems to be included already implicitly. But I guess
adding that explicitly is a good idea.

> @@ -83,11 +84,13 @@ u64 arch_kcpustat_field_idle(int cpu)
>  {
>  	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
>  }
> +EXPORT_SYMBOL(arch_kcpustat_field_idle);
> =20
>  u64 arch_kcpustat_field_iowait(int cpu)
>  {
>  	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
>  }
> +EXPORT_SYMBOL(arch_kcpustat_field_iowait);
> =20
>  void account_idle_time_irq(void)
>  {

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--52b5dsi3hsppeau2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyymEACgkQj4D7WH0S
/k5KOgf/bZeIcTAY6mttkQVJXFhsJZzZL3MSFWHX5sqUkcqk0e9rIQIlyQBMWLf6
Ij9Xskp8Z7g31RAkE+ebiPDX4Ewr4Z43SP+LmZpYKyAwjWXPP42eulC6WSIm9WXK
mRTZjHutUb+jdlNHb8X2DcRf1Th2jUKJreeP009WCsanY7F8O84erkl841z13nNO
VUvdf+/pp5QozGII0Ey/74FkoTKz+i7rkyF0C/btXGAJ66grULa1Oj8O/tnwGcuV
TUCWL2pBD3o2sGlG4jCvyROT6bGD3EHGr6xGakg/oy0Zq+mHd4BJUzC35FAccWsV
KlJeHVnyYzStzD//ndZOqiWOIcZv8Q==
=XCYh
-----END PGP SIGNATURE-----

--52b5dsi3hsppeau2--
