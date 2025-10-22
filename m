Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335034C12D
	for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142816; cv=none; b=NYhvHN7TH5pKCmaHw1AhQ/acTdvOc6YLHQlox68wtP94hXfDhzD0qdmOIeQBSoucvJsd2CGfyFT3QmUILIHj2XdXVsy0q0oberVNdRW24raGHMFFpFnOc1QynZuBixvzOEaJxCW+IfyImR5cP5AsHPpkxFWemdIkajNXE1PnDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142816; c=relaxed/simple;
	bh=NwZ3v2qm3tb7kvUbWrw6uW7qiocAFO8+8xoF6L5Hm88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdL/G1w/uSVyDRPz+YYmGCQ5oyXICmrO83dxm0VmhApC5IU/u7rBThlL2YAU0cyFZCsL8ibfHS5U3n1KS3pzvqSLcl1FmGrTfJPWEJirtlt1HS4bNcx69UrvVGZWgtJCudUdIK+XNHsyhgAvGjtl9BOpNP5/jdaPIDQOUWnpaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXUpJ+YD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXUpJ+YD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471075c0a18so73157245e9.1
        for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142809; x=1761747609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcGPa9BZoRh/cXSf6MM7skWFc5+sWNLhhAzz4IrXMW8=;
        b=QXUpJ+YDHO2hZydw3IoAUvS/ktOXG/rHqwXvAed/PpPEFgCzNNUKuHL57hSlEDJZxb
         eHzPanmF9Gx0TuvKil1Xu4JlopB9l8Bmz+mZMrmhExmOZUPftiCzM/8Otta8RjemGlC0
         3IUjcokvs3oiqXnrU0dKGu4uGUf+pILNAZfsTcjylULaKiHLcliJ1QcrsLWjGOPyKatA
         7o5fQAPYVmId7CK4hq0+9qcfMdR663/GG50DP0NVGputN+adrd68aEkV1Mh/VEzzGjym
         rKZZBrMfTJS8zLOZmYZY3RMD+Stqf0Ne60KdK191n25ok/mx0t6tQtGJe8ZRbQy9PqYX
         WV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142809; x=1761747609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcGPa9BZoRh/cXSf6MM7skWFc5+sWNLhhAzz4IrXMW8=;
        b=LGI39GQdPe7rARHpsgFvjHmhj3k5LblZHZBg2Im/5QMYtcbNU/CySSTR+pLqpgrgHh
         7PKTzDNxzG5WZHbYWDeGHhbcozAPzk/AaeLAGVqy9ZzJfHOU9mhDeQbbzpYk/1Smktr6
         JckgmnueeIDvAknnd6CgMqISvakfV8DbtL8CjqUcxbKingk0eVpmnlYzcMOTXe5p8sIc
         os+jfogSupdzbwnQrq/TJilRSlR2btL4kUn9vT756Da40AnZlR7RkQR+rj8nW9/c5QVH
         imn+p9620SZEunW9PvhH2ILNDbINeYQkXNtoumEFvGiNjGla6VTGd/6wGinUL6wh3IX0
         g2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8lNLlcV3ZCT2JrBcqIiG+mb0byPgI/xylHx7uOZhCodpgn7c2RkxpGndX3CrpG6ZwYFN/r4eYuGDL@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQXVLf69a5/HRRgRFYlodM8Si6o7ZLwKNm9XdtQgoOH1uc+vs
	48hHmKZ/9QZT786Z8vaD8qhIEHEiSDeggNyd0XSBvN66eSH/NLPR2aHW
X-Gm-Gg: ASbGncvYyRQ0LnY3CPzxBMpjZrxze2j3wtX76WaaMamC5EcAaJEhAYXcs8UnKOtYbx8
	VeFNbw/amSZc6+szaT6d7RUmUnx0Za12Bz+IWlZpyz5cG8VTEcGbjUf5bbesJCvH03njPPJapTr
	P6to8VpyEpKkEgYHkGItUHfcmGiLApkTyNFnVp4qga0GqxCNMwyt2kCefaCRogWKC5c7TAFklq4
	kURrW1NchHfBxTt8dPhsuZTAZ5HfuTEHtuHD0atXKWCH5f/yTZA8KIFFtrxxOHigQRQ5BCrjDDn
	JS6wwif25wQ6EkvoXAUeecjd2c/r44fpY1U3xvPH6+rcQHosgti7WWVCDEQAN0J8u0NRCoy4dhJ
	tCTrXXzVHor7CXjP0oIqdl2BC5M1tLKsDFcc7WYcQLd6nj7Znklu++tJM+JmZ7C553r6zTXn+aJ
	YfwNNr1fBG3PX9zA3AGyY9zpXU0OnlQMdxi3Yc/2oAmXbchmksVVai
X-Google-Smtp-Source: AGHT+IHX7Sum1LYsRGk4yzm8MqGMXKVdeHe0F7N67aNpUhUFJkxVcT5YpUlblTfJtsz2LXnINVBACA==
X-Received: by 2002:a05:600c:3e05:b0:471:16f3:e542 with SMTP id 5b1f17b1804b1-47117870720mr183174425e9.2.1761142809122;
        Wed, 22 Oct 2025 07:20:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428c62fsm48753105e9.8.2025.10.22.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:20:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:20:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 07/12] uaccess: Provide scoped user access regions
Message-ID: <20251022152006.4d461c8b@pumpkin>
In-Reply-To: <20251022103112.294959046@linutronix.de>
References: <20251022102427.400699796@linutronix.de>
	<20251022103112.294959046@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 14:49:10 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> User space access regions are tedious and require similar code patterns all
> over the place:
> 
>      	if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> This got worse with the recent addition of masked user access, which
> optimizes the speculation prevention:
> 
> 	if (can_do_masked_user_access())
> 		from = masked_user_read_access_begin((from));
> 	else if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> There have been issues with using the wrong user_*_access_end() variant in
> the error path and other typical Copy&Pasta problems, e.g. using the wrong
> fault label in the user accessor which ends up using the wrong accesss end
> variant. 
> 
> These patterns beg for scopes with automatic cleanup. The resulting outcome
> is:
>     	scoped_user_read_access(from, Efault)
> 		unsafe_get_user(val, from, Efault);
> 	return 0;
>   Efault:
> 	return -EFAULT;
> 
> The scope guarantees the proper cleanup for the access mode is invoked both
> in the success and the failure (fault) path.
> 
> The scoped_user_$MODE_access() macros are implemented as self terminating
> nested for() loops. Thanks to Andrew Cooper for pointing me at them. The
> scope can therefore be left with 'break', 'goto' and 'return'.  Even
> 'continue' "works" due to the self termination mechanism.

I think that 'feature' should be marked as a 'bug', consider code like:
	for (; len >= sizeof (*uaddr); uaddr++; len -= sizeof (*uaddr)) {
		scoped_user_read_access(uaddr, Efault) {
			int frag_len;
			unsafe_get_user(frag_len, &uaddr->len, Efault);
			if (!frag_len)
				break;
			...
		}
		...
	}

The expectation would be that the 'break' applies to the visible 'for' loop.
But you need a 'goto' to escape from the visible loop.

Someone who groks the static checkers might want to try to detect
continue/break in those loops.

	David

