Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F093E1206
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296495; cv=none; b=rCLF2bftE0Pp91bLZIow0YC9ZPCQPqWGZdKE/SbJnBLa2iUKdImv40Ky9d9NP9pMyIJ+wGbSHFsftitTSWjmDqI0MXnulLYLe1xzzSbX3IQvCcdAus0+F7fLbF3NrqA10wKB2n8c2Du/yPlONV4Vv+ogQ791k1xbj1TTxOdfwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296495; c=relaxed/simple;
	bh=3x9O81VmyvkAmOknPTE67IsbDONvsM0u8u+OLmZWLFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rftzDHY+wvCyeqckq3YHFCdIkdcgqldxzTiZtPT9ZrjIkOS2r8uinCT+0kaxwacdjoKyDmNDK7ryczxOBvdC8/WF05PQIcD3e+OPhvklX73zmQiLwnQK6uqiZuZjDBNmGuKuo+UK283r12h1RnnimthMU0mgk0FFPt1SXR0r5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQZvEFBX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQZvEFBX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b9b1900bso2266212f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774296490; x=1774901290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTyDjzylHqeRX+dhDvxKEc8/YaDA7xCjfQl8LdFPYqo=;
        b=kQZvEFBXHi1VeuSU3kN9Q0VRzCCEMMrceNwxYPuLo0STZYyyGZoTpwLN8hEGpCf/SR
         gmA+LnNxU6WIwFmIGwh+tR97tpHJNELljqtzGplAg9NPrkA3ade3EIqXFmhUL53PaoBP
         kQR6LUBziXFYcmNKLziG1nkEh3OATsUJ7lPoPFgW/9P1GPAWOo+GaeQ7iWKzvz0fHHmI
         nKnBxaX0wUdoudzYywGoh0Ga2Jp/69UpUwZwq/kWImqdHfHue75fw8Ug6Y0O3/mBo2nf
         +Vci3vmuyPFxVV9GNziI9VOmJt920nbg7ski0bV4nh2tpGtUsh7EShkZEWJ4mcGpO1kp
         ABhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774296490; x=1774901290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTyDjzylHqeRX+dhDvxKEc8/YaDA7xCjfQl8LdFPYqo=;
        b=AP2EkrK7vLAFTJhYVrleXHu1HbhdbLbijPqGnOYIZnDxauxtwotI3ly9Ea9/8wVdsU
         fx2ny68Y9msM2dmMsXMv2hCuNO2WzHwCcr8MpIDPEfHdZTEF90locXJNDmoNdNCrusXh
         3R4RIt6eHsgcBmXQk2hzA3QBq4N1UxUILBfPjDSXOO+EumTmqK4030XUU5z7GoKvsy0I
         CNv4vz6xfZle83TO6xTGUzGNUioTqDoCsSykbs10m6LQw2lITPLHsddB0DVFeS2FZY2M
         nGCsku7lgZef9FNatDn9+apiCa0ujuyNzks+bvLxS3IzxBMGWMYtZbSTPct/W24PxC7g
         xC+w==
X-Forwarded-Encrypted: i=1; AJvYcCXsw0YHV67pXpU0pvCffaR4dv6GfFrRsevRRywXQ44WPExwhA0GKMakIQepPrrb0CIWeiqf5eiRkAt1@vger.kernel.org
X-Gm-Message-State: AOJu0YxHH23u1VW8wosnHJou4rrLEoMwOPW8cdjJy1la1RtJbIhxTDvi
	yWgxK6h6QYHbK+RFk5PScAg2Y2T9bf9yJ3/LZ/3Am/aaA3RyKpEAmwmBwjwKN7OO
X-Gm-Gg: ATEYQzwVWHibNmFYt6C3ZG41cL5bKXWYtndtqnI138zHWeqlaBdbCAO3+ZGaj4VE84W
	NxgzsC3RCf8ecMYXztLMRaHmVMzw4Eyb2wvmxnvdEYzHPmzB5VMJ4FjcSioI4htjMpEgVfSQ7iv
	wY+KBELBGGu/H3HuiKp5npi/0XLAYKxbIJ7J4KTY3PxXxhOQ5qC9Qusgt63Ix2bWDoP+BYWqtHS
	q9ZGO5FP64uapnTWMNTETL4Wq1LzGRl9Pfv5QKktD87DQi9Egx046B12PAKGJ7RSR5pXA29QX+c
	PlCHN6JZBxs/eR8kiub3GefMV59PMGlifhWhpGZ2WtPClghiHhgYokyhfmxG0OIYWnbB3dCH5m+
	bixaRQ/YIg8Xs08NHAPXgSW1DgzbFlYYtYOQ6D+3k3RWHc7xCnW5g1aBL1ZpDvRBZnBMiKCW/mO
	M/JCJsaBbNTsVl9mjq2ln//FyKYZTPeuCs5PGSVKRB8+SQrenH9H3iJFvpHXAY6j75
X-Received: by 2002:a05:6000:2203:b0:43b:46b6:87aa with SMTP id ffacd0b85a97d-43b64277e1amr20809765f8f.27.1774296490087;
        Mon, 23 Mar 2026 13:08:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm32309509f8f.2.2026.03.23.13.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:08:09 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:08:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Josh Law <objecting@objecting.org>, Jens
 Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>, Stefan
 Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Richard Russon (FlatCap)" <ldm@flatcap.org>, Thorsten Blum
 <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] block: partitions: Replace pp_buf with struct seq_buf
Message-ID: <20260323200807.71535b6c@pumpkin>
In-Reply-To: <acD_IIEXmhnVlO0C@ashevche-desk.local>
References: <20260321004840.work.670-kees@kernel.org>
	<acD_IIEXmhnVlO0C@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 10:51:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 20, 2026 at 05:48:44PM -0700, Kees Cook wrote:
> > In preparation for removing the strlcat API[1], replace the char *pp_buf
> > with a struct seq_buf, which tracks the current write position and
> > remaining space internally. This allows for:
> > 
> > - Direct use of seq_buf_printf() in place of snprintf()+strlcat()
> >   pairs, eliminating local tmp buffers throughout.
> > - Adjacent strlcat() calls that build strings piece-by-piece
> >   (e.g., strlcat("["); strlcat(name); strlcat("]")) to be collapsed
> >   into single seq_buf_printf() calls.
> > - Simpler call sites: seq_buf_puts() takes only the buffer and string,
> >   with no need to pass PAGE_SIZE at every call.
> > 
> > The backing buffer allocation is unchanged (__get_free_page), and the
> > output path uses seq_buf_str() to NUL-terminate before passing to
> > printk().  
> 
> Thanks a lot! A few comments below.
> Personally I'm in favour of this patch as it also removes a lot of ugly code
> (which is scoped string manipulations), FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Link: https://github.com/KSPP/linux/issues/370 [1]  
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Josh Law <objecting@objecting.org>  
> 
> While not long, this still can be placed...
> 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---  
> 
> ...somewhere here to reduce unneeded noise in the commit message.
> 
> > I couldn't help myself. Here's the full patch, as I suggested in
> > https://lore.kernel.org/lkml/202603201230.74BBFFABAD@keescook/
> > There are plenty more like this to do...  
> 
> Indeed, but thanks for the example on how to do that!
> 
...
> But probably okay as in the previous branch it needs more work to follow,
> something like
> 
> 			char dostype[8];
> 			...
> 			if (dostype[3] < ' ') {
> 				/* Escape control character */
> 				dostype[4] = dostype[3] + '@';
> 				dostype[3] = '^';
> 				seq_buf_printf(&state->pp_buf, " (%.5s)", dostype);

Or just:
				seq_buf_printf(&state->pp_buf, " (%.3s^%c)", dostype, dostype[3] + '@');

	David

> 			} else {
> 				seq_buf_printf(&state->pp_buf, " (%.4s)", dostype);
> 			}
> 
> Taking how invasive is this, it might be better to done separately.
> 
> > +			seq_buf_printf(&state->pp_buf, "(res %d spb %d)",
> > +				       be32_to_cpu(pb->pb_Environment[6]),
> > +				       be32_to_cpu(pb->pb_Environment[4]));
> >  		}
> >  		res = 1;  
> 

