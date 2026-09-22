Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB252FE35
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071745; cv=none; b=dpZ1Auoqc/d04wX4GFNyXkza1vz2XmtYK1smTzgAsScApbnSH3qWnsFQTvWdQQtfwtvnrEkpBT5Ybk6Ja6shWTH3t2wpLoidyN97fORgXGf4NQTcbAifQQoHvrrY2YtmgMIggwnPnomrA8twsWxuSwvmgO2tYdy3h91k1AQHcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071745; c=relaxed/simple;
	bh=5Kq2M/YmMFIBvAwgJrR246mgs/en7UAZ2AkegBNv5ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pl6FthKmhJPs78WhzE9pgLWtWCBpW6ucd6i4kAxNAtXj6CQXBMzD30BwACVNz04Y0hAZG4ZdlyKQONaYLew/2SHvwonsSJlPoT63r01AmehGrjJX21QdqWubagGPZ2xNsmzeg8TiA0mIW9WqOvQgpUVOqQ6hSvnbg2sc/O2JzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFE26DQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFE26DQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5471F000FF;
	Tue, 22 Sep 2026 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071733;
	bh=TvzL4YQLxtc/+gxZh/vrtxrGcoBiZzLC5r3SL1t3bEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFE26DQVnsB3Dj234r1pnch+q85qJ11QS7WEvvxFUByQT4XfSd2B0BPgu2g6gaxGK
	 GtJO62k+Zww03m5hkXaXezX4pbKrdIP3tH3kN3Wu0e+kHmaF0L713cGNBKENtV0mOM
	 Asr7hnvpqWk9aKSrZCm59JyM3mWt9VI98lUOSXySu650WaQC3AyoWJLWbqpQLpmGSZ
	 M9pfSBFAQgNSQqQhHwWeTkJpxpVxwYMgSCwy6F7zPF5TQsDpgS6fdz+NctHZW3p5K/
	 mxoL3BmbJPdAWJwezF1YKaEsPlZRapPJ2vesHGImHNzo8IstJM+bYx4NL8z/xIKMub
	 cRvmAcJkWj+1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/sclp: Implement resize for sclp-vt220
 console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922095903.1595794-3-maxbr@linux.ibm.com>
References: <20260922095903.1595794-1-maxbr@linux.ibm.com>
 <20260922095903.1595794-3-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:08:53 +0000
Message-Id: <20260922100853.6D5471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/sclp: lost terminal resize event due to TOCTOU race
--

commit 66ee01928776071bac37719344cd6f2a8ad2ae89
Author: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

s390/sclp: Implement resize for sclp-vt220 console

This commit adds support for sclp vt220 resize events to enable
host-initiated terminal resizing when using the sclp-vt220 console. This
allows QEMU to dynamically resize the console.

> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt22=
0.c
> index 7c168a66e4afe..a5a9ac1b1fe07 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c

[ ... ]

> @@ -552,12 +603,15 @@ static void sclp_vt220_receiver_fn(struct evbuf_hea=
der *evbuf)
>  static int
>  sclp_vt220_open(struct tty_struct *tty, struct file *filp)
>  {
> +	struct winsize ws;
> +
>  	if (tty->count =3D=3D 1) {
> +		spin_lock_irq(&sclp_vt220_lock);
> +		ws =3D sclp_vt220_winsize;
> +		spin_unlock_irq(&sclp_vt220_lock);
> +
>  		tty_port_tty_set(&sclp_vt220_port, tty);
> -		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
> -			tty->winsize.ws_row =3D 24;
> -			tty->winsize.ws_col =3D 80;
> -		}
> +		tty_do_resize(tty, &ws);

[Severity: Medium]
Could this sequence result in a lost terminal resize event due to a TOCTOU
race?

If a host resize event arrives exactly after sclp_vt220_open() has read the
cached window size into ws, but before it attaches the tty to the port:

sclp_vt220_open()
    ws =3D sclp_vt220_winsize;
    // Host resize event arrives here, updates sclp_vt220_winsize
    // and schedules sclp_vt220_resize_work

The resize worker could execute immediately:

sclp_vt220_resize()
    tty =3D tty_port_tty_get(&sclp_vt220_port);
    if (!tty)
        return; // Worker aborts silently because tty is not set yet

Then sclp_vt220_open() continues:

sclp_vt220_open()
    tty_port_tty_set(&sclp_vt220_port, tty);
    tty_do_resize(tty, &ws);

Would this cause the terminal to be unconditionally overwritten with the st=
ale
cached size, permanently desynchronizing it from the emulator's size until
manually resized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922095903.1595=
794-1-maxbr@linux.ibm.com?part=3D2
