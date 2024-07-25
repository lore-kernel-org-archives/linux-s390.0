Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6E61FE1
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938725; cv=none; b=WPXUKjnwucJ66g8dRt6rxyccgzBPVSlxDM+kD/i1tyF4f4sbcFqiz85UehLsWDK4PQCbVHnAGMPxgSdrwqRwoTwRqMFkWUBeSEIPOHgEFADYp/mDJXBZEX+b1AMRKKky7Of0YvGvrlPHr3ZsKKzVj0f5ABaBmCnLQ9t8oiPiK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938725; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvMvJhCJORP16+siE4MpIQJPvOD1FH5Q+h6R1YGSh9NCH6OE/32+gl4CCgajqJlHfq4MaGQZF/TOhRlWvxUcC9pEERZfIuwg3Jco3AqEHAdayx+prohJNGZmK4epsEmk2Mgc+73GJBhJeqvpAYluXbn39TWJW49ljqvJ2axlrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HX/Bz/QU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HX/Bz/QU"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a94aa5080so121257266b.3
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938722; x=1722543522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=HX/Bz/QUii+U+Hvml6qvkI2lxj/GM58e9mxwRT2RYQZuwzLuVCj1lDj2ydrIkY45/V
         bXZSm1q/RSJqcTXouag1K6hLMh1CSeQ68aDC4Vltna0USqYQXy1YNYWCeIxR8oYAJkXZ
         RywmTNbSzsqeB8hIWWWSMLUk9699MICk3i1qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938722; x=1722543522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=EXKGszN9NtmPWE/Oz+BwMoaHDEsDSC+ESVc9zfuPeYG7wBgFl3YfsoVu8CqDro2hRg
         f+kYNq4jDJ79VdA050LBVHN2OtVwsDBVfU5383YYnkTyZambt0U/1G1r0Dxe4THcGeQf
         /DKPp31DsJfJmR+5M4ZjQfkbzCfOjwpK73OA5O00MQHJQjA0jCumlDUnv89eJuWSU/vM
         bfBQN3YjaA+6PMI0w1WEhGhMas03j3p1ZMhsxG3tTagJO2xWMh1wINs5w7MhZehge9rq
         D25g4fdV3ePtCjljS8PMiNeaPWBEPkh4M/CQe12Kv7ezitvx5/nYkkVA3RHFCCcvj16b
         BTjg==
X-Forwarded-Encrypted: i=1; AJvYcCXa7kNNpmD/gpmqH1Mn5uP2HA62+1b21ZTugkfsj/BQVKtrujv3xMFXyKurfQ6RvluDkCuaL3gVG1Qxy/ZxD8upw87KJLpMgOzhyA==
X-Gm-Message-State: AOJu0YxnkmHPTAQExMrSHG9lKlU/gHqssSVIXjUN1PbU9hkYJrIZsV6S
	kNDxP1+mY/Vs1bSTRI0oPzq3tGPb8TEQAX2jkfk5Loj9MQCiHdnHto3pZGpeQ72xISjCuvamld0
	KClw=
X-Google-Smtp-Source: AGHT+IFPaaX6ugoV4CWKYEDsFmkG/UgfUIBJtO3yEqbVxgGMjTCBx9qOYGqamEdEjXK9e3LLlmtYvA==
X-Received: by 2002:a17:907:94c8:b0:a7a:8cfb:656b with SMTP id a640c23a62f3a-a7acb935798mr259610766b.60.1721938721766;
        Thu, 25 Jul 2024 13:18:41 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad411b1sm104040666b.125.2024.07.25.13.18.41
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:18:41 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1728157a12.3
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 13:18:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOXmKJT3QC5+lKoxlZ8lQEAAxWhXL2WW1wAix5rnXASfz/9Wt9WgEHUh/3rmpVaE+UkJkTNM0z+IptJrUWJiLWM5te9YlTb99xaA==
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus
