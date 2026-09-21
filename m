Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1A255F2C
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993696; cv=none; b=UCPSPrOZXbN30JQ8R6w4gwHqWWvg1vpk0cMfbqJUXfAo6Uo7YtZnND5nsMqANN8b+jZsfkkbwkerOdw7KW64XgupFS8pNCabsU5oNG+oenQYBUFaYrTNSniurxIwPK4mZ5P54XwJyfiLHljtCBmOfF2C9mKQuCXnhJ7Oj6Bh3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993696; c=relaxed/simple;
	bh=hzxzD2fHySAOHih0afRtYKsoJYH507CBCxYKow934ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RqSbTNx840GU9yUtYo0/QPJOz9816XudNWJti/QHd2ia8FKsdliMrsnR7IOyv6I1DpN553MmQn8fG6wXrbGyAiM2NG5yOpjVp8bFuOhPy21Nd0mfK8EtACJ8yWTS339BUGPNKA4NSTjBrrsrLAWoEyBoOe0oySsHlTmcCxd+mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0zcSx3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0zcSx3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBAF1F00893;
	Mon, 21 Sep 2026 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993695;
	bh=3+opJHpkF3ZIOZOdTQmjxYTqmaCUP3/7WbRQT11/k4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0zcSx3/SsYtd27evV5W+Ds000rIX1fLKkZB4euju37Hb/o5iA4XakhnYokmQF4fB
	 LJG+OSGQYy3EPEZvygndTzOeoSulQ9gIMgNEGOEb5QDhwqx/IHkuYppMne9YuBtwz1
	 rUUuWL7FN51w71yZ7uSr373r+L2+SuBmtTMyPcLvKJua094C2KtZpIcqs+++qMpPet
	 x/CSJeRvolwUsPXPToT/ACYTEUw6xhX7F/wZEv43iawWnbiioKHvIwhdSHOU69F+3O
	 NTOu/N8uo+aoa7KsXkV8QOm/ndOEeAynmVyUPC5WN3sghQlo9vjVgX5wK7nQKIKuhu
	 7YBslqnWkmp7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/sclp: Implement resize for sclp-vt220 console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260921121619.1354611-3-maxbr@linux.ibm.com>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
 <20260921121619.1354611-3-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:28:14 +0000
Message-Id: <20260921122814.9DBAF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: UAPI breakage due to asynchronous winsize initialization in o=
pen()
- [High] s390/sclp: out-of-bounds read in SCLP_VT220_SESSION_RESIZE parsing
- [Medium] s390/sclp: data race when reading shared terminal dimensions
--

commit 13e18fecbfc8440743cc8dff7c08364db9a637bf
Author: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

s390/sclp: Implement resize for sclp-vt220 console

This patch adds support for sclp vt220 resize events to enable host-initiat=
ed
terminal resizing when using the sclp-vt220 console. This allows QEMU to
dynamically resize the console.

> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt22=
0.c
> index 7c168a66e4afe..d140617846a2d 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c

[ ... ]

> @@ -543,6 +588,9 @@ static void sclp_vt220_receiver_fn(struct evbuf_heade=
r *evbuf)
>  	case SCLP_VT220_SESSION_DATA:
>  		/* Send input to line discipline */
>  		sclp_vt220_handle_input(buffer->data, count);
>  		tty_flip_buffer_push(&sclp_vt220_port);
>  		break;
> +	case SCLP_VT220_SESSION_RESIZE:
> +		sclp_vt220_resize_sched(buffer->data);

[Severity: High]
If the hypervisor sends an SCLP_VT220_SESSION_RESIZE event with an
evbuf->length smaller than expected, is there a risk of reading out of boun=
ds
when the data is accessed?

This path delegates to sclp_vt220_resize_sched() without verifying if
evbuf->length is large enough to contain the 4-byte resize payload. Since t=
he
event length is controlled by the hypervisor, could this result in an
out-of-bounds memory read when sclp_vt220_resize_sched() reads the rows and
cols fields?

> +		break;
>  	}
>  }
> =20
> @@ -554,9 +602,9 @@ sclp_vt220_open(struct tty_struct *tty, struct file *=
filp)
>  {
>  	if (tty->count =3D=3D 1) {
>  		tty_port_tty_set(&sclp_vt220_port, tty);
> -		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
> -			tty->winsize.ws_row =3D 24;
> -			tty->winsize.ws_col =3D 80;
> +		if (tty->winsize.ws_row !=3D sclp_vt220_winsize.ws_row ||
> +		    tty->winsize.ws_col !=3D sclp_vt220_winsize.ws_col) {

[Severity: Medium]
Is it safe to read sclp_vt220_winsize here without synchronization?

The global sclp_vt220_winsize state is updated under sclp_vt220_lock in
sclp_vt220_resize_sched(). A concurrent resize interrupt could theoretically
result in a torn read here, mixing old and new terminal dimensions.

> +			schedule_work(&sclp_vt220_resize_work);

[Severity: High]
Does this replace a safe synchronous initialization with an asynchronous on=
e,
exposing uninitialized dimensions to userspace?

Because workqueues execute asynchronously, the open() syscall can return to
userspace before the worker thread executes tty_do_resize() to populate
tty->winsize. If an application immediately queries the terminal size with
ioctl(TIOCGWINSZ), wouldn't it read 0x0 instead of the actual dimensions?

>  		}
>  	}
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921121619.1354=
611-1-maxbr@linux.ibm.com?part=3D2
