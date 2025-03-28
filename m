Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E24A35
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158317; cv=none; b=rfnfX6gLqikDtyaX0pmomFwC9DccQ6043N4YrF/PN3oXpy1dp6bnK3AkcOypAFjqfo17W0f3hHcyG86wvEXcPT5cK1gRbDPWNZal387MxID6Ol7UmjH3MznElNxSN9mUFKx3aIWGrHYkWzcN/TUveMG99vRzfJHJky//39Bl5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158317; c=relaxed/simple;
	bh=E9KF9VYf5rgIBhAdPjIGjpic8a0/cAy+P9SJgR3gjkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK4spkY3LalYUt9FGJ2awdOsnd3Z3n9gtalF7YyPoiUDrt+JXR8/imMTrCkn226BVjkNaIauHW805/L45vzY76YoaLkIx7fShh4dt+b9tNfGGPNypL8a4bde98RgrUqICyfR33UvJo9TSrzk8RSu212WRc+u1Awh+T0J3Ij3geY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ubL6rwRE; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ubL6rwRE"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZPH7D4YFjzW2y;
	Fri, 28 Mar 2025 11:38:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1743158312;
	bh=MyuTqVvTP1UPCrUbHlnkU12n+jkzkkYz1VOSQfsDbeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubL6rwRE1GKQDgpoFHHnqtWunMExgXmH9SIOevHevMNsSgJymrB8PqtT7RsLdLH6w
	 LH8BY2mtUo8hpXM7UsTfJgikKEEPrGDHXtD/YG1KBqXB9zjymaqJWWlh2+lJ2/0GBJ
	 hyNRO+Q8o5kFKLuA61PJ1bLsF5hhWu4A3JkuEPzU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZPH735RxtzKRX;
	Fri, 28 Mar 2025 11:38:23 +0100 (CET)
Date: Fri, 28 Mar 2025 11:38:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Maxime Ripard <mripard@kernel.org>
Cc: Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Guenter Roeck <linux@roeck-us.net>, Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-ID: <20250328.sah9oog5ahSh@digikod.net>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <202503131016.5DCEAEC945@keescook>
 <20250313-abiding-vivid-robin-159dfa@houat>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313-abiding-vivid-robin-159dfa@houat>
X-Infomaniak-Routing: alpha

On Thu, Mar 13, 2025 at 06:24:25PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Mar 13, 2025 at 10:17:49AM -0700, Kees Cook wrote:
> > On Thu, Mar 13, 2025 at 11:43:15AM +0000, Alessandro Carminati wrote:
> > > Some unit tests intentionally trigger warning backtraces by passing bad
> > > parameters to kernel API functions. Such unit tests typically check the
> > > return value from such calls, not the existence of the warning backtrace.
> > 
> > Thanks for picking this series back up! I honestly thought this had
> > already landed. :)
> > 
> > > With CONFIG_KUNIT enabled, image size increase with this series applied is
> > > approximately 1%. The image size increase (and with it the functionality
> > > introduced by this series) can be avoided by disabling
> > > CONFIG_KUNIT_SUPPRESS_BACKTRACE.
> > 
> > Yeah, as with my prior review, I'm a fan of this. It makes a bunch of my
> > very noisy tests much easier to deal with.
> 
> And for the record, we're also affected by this in DRM and would very
> much like to get it merged in one shape or another.

Here is another case:
https://lore.kernel.org/all/20250328.Ahc0thi6CaiJ@digikod.net/

It would be very useful to have this feature merged.  Without it, we may
need to remove useful tests.
