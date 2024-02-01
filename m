Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54B5D460
	for <linux-s390@vger.kernel.org>; Thu,  1 Feb 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795202; cv=none; b=NclMCJEiYM3G07mxsg1PAjpv7Y8g+6lhE9uWB2OxxwAfEfpK6JmDrSnnelB4BWvvHDiN44dOSTsrwsJ94bk7TJS7JSkIcn6uF8Wn6mxyBwo7qtAQmlu7ItW6csX+KjxFAJcho/uxTEK5BDO/Dv9JXbiTpnldsK7FLeWOPvwJoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795202; c=relaxed/simple;
	bh=suoI7qvddasF6ze11GbOGjsGkZl9FBFquOHwW330phg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGBS2ivCa9C1rBeZHJJQv/xZ7Nw3p5CbaLBgGCnyMJZm3h8HfDdU+rCxWKqRdZ15tbqyEpMVVEZ6sSLEj6WDFAvBDTglGUknkT8bW77mH5sABvNN1UcVnUOhOpJIdQ2SINivszmUunLO1VmHjpFJMdkWwAkS6kjzeJ2yY07juSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJFdmqgP; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJFdmqgP"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4bfe6642220so343533e0c.2
        for <linux-s390@vger.kernel.org>; Thu, 01 Feb 2024 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706795199; x=1707399999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYWYexFtoJ2yHocou+INVoUtLbF8tOuPvQoRlZwm2yg=;
        b=LJFdmqgPnybJIumvPpfSejLkIEttxsn08suUHDAHBBpYlnfLY7vD/jAwsollH7N3F7
         /3cqzMeD9q0atz+INW14/C+UpgvO/tSxQ3fo6LkcKvgvw4f2O2tNhFpqec8Fur9gMv3v
         riRH9dgwwFJulRbu22STv/MYccrOLORyGL5QxMh/eUmOqx/CtxxU0kTQRX3Xlpy9U69n
         YitNBjDNPl2IwwKRgG0yobZ+WUWalQ/yECvaisqyoop6BsFZXarkvBv0ii1pE/W0beLw
         1xWK4Z/1h78PaQ7lFPIkIfmVGgl0xy/YC9sLuvBzw+MVlkobmg8Mtz/9WpmMqItaonPl
         hcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795199; x=1707399999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYWYexFtoJ2yHocou+INVoUtLbF8tOuPvQoRlZwm2yg=;
        b=mkq0I+LyuYBkdk3l+4FsgxX/t4g/jF80hnB+YTTxXclKLCu7CnkSh3GkooCn35wAqR
         WQPwtaebrYu7gxvEem3UyD9yjwa+buC39d00T5c1JUi3K/OjBVFDemVudMyDIe9Bcqk9
         D+gGILr1cK7rzjqbhi/h8AKkXrz9UZfpXwM3QZtjoKctzhDAzybNSZlrjU5vlosM9twq
         ibpzHJ3HK9+QpsHkEgq4RDGDivaQqtkJXwlHEgrfZ7gtp6kaix9vrvljsNA7Bbj07rNn
         CIUDvWS3NdWBCYn4MHOf2E54OZfyF88g6FLvmPq/fvb5hbpoyUK38hOUBfDDMeOICLKs
         pH9A==
X-Gm-Message-State: AOJu0YxEGFoE6o53Oq+PxkRlsKtOxBTiTf9/k3FEqB15BnU/XDaKqGG3
	uBjeN7JP+/g2yEfMQUZHtZwM7TG5m3q074+ZbtfkC4bb2ExS16FE/wW4ET44Tay8Zf78XTbTcXi
	goBGGJkPZFOtAmEHkLcgdDDpiwZ8HK5DP9u7F
X-Google-Smtp-Source: AGHT+IG80kHJI3o0nh9nc37cFYAZfNgIoolcnGet/bLjzO8FQfWUZqIqvqwlp1tA8htBaza2xRqZOec13j3l2wPN17s=
X-Received: by 2002:a05:6122:2a0d:b0:4b6:be94:acc6 with SMTP id
 fw13-20020a0561222a0d00b004b6be94acc6mr5599008vkb.10.1706795199311; Thu, 01
 Feb 2024 05:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com> <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
In-Reply-To: <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 1 Feb 2024 14:45:58 +0100
Message-ID: <CAG_fn=Wb81V+axD2eLLiE9SfdbJ8yncrkhuyw8b+6OBJJ_M9Sw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jiri Pirko <jiri@resnulli.us>, 
	Ido Schimmel <idosch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, 
	ntfs3@lists.linux.dev, linux-s390@vger.kernel.org, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Syed Nayyar Waris <syednwaris@gmail.com>, 
	William Breathitt Gray <william.gray@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
> > From: Syed Nayyar Waris <syednwaris@gmail.com>
> >
> > The two new functions allow reading/writing values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > The code was taken from "bitops: Introduce the for_each_set_clump macro=
"
> > by Syed Nayyar Waris with a number of changes and simplifications:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value());
> >  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
> >    and bitmap_write();
> >  - some redundant computations are omitted.
>
> These functions feel like they should not be inline but are
> better off in lib/bitmap.c given their length.
>
> As far as I can tell, the header ends up being included
> indirectly almost everywhere, so just parsing these functions
> likey adds not just dependencies but also compile time.
>
>      Arnd

Removing particular functions from a header to reduce compilation time
does not really scale.
Do we know this case has a noticeable impact on the compilation time?
If yes, maybe we need to tackle this problem in a different way (e.g.
reduce the number of dependencies on it)?
