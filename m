Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA151BC075
	for <linux-s390@vger.kernel.org>; Wed, 14 Aug 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656919; cv=none; b=IYGTiqqxt8YxTwClytExpsiFMLY+OGZ3VVkLNW0wBNLDND1kvqSsyb+twspXZsSpuAE4U3Gf7hwdl8eV/1MZZP8c9y/HRGRLQ2OvwM6zCd2YEJDaNbEzDEICCkGHun2WHZjvG9tgzi33BXw2YW8UPEqXy6VJDVbCqK7IWTQYEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656919; c=relaxed/simple;
	bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPBdrN46JJbLUVJvuLN3I+qjkZo81S4b30h7zMjBmMvcY9vDXX2RovxE7PWAi7RGnSXIZZgZ1hguLUfhkSql0i1UVaq9j/gSpWkE5B49rmpFSu/wlwWJFG0/aw8NGKBryJ7xeeCENkSS7PAw3DhIr1074hAvNhYcSsJzwZD+Q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/tNz8Ht; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/tNz8Ht"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so125037e87.1
        for <linux-s390@vger.kernel.org>; Wed, 14 Aug 2024 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723656915; x=1724261715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
        b=H/tNz8HtkGiGMKcPN+qSt5RnpqVA9WH2BkwImL0krz6Fua4FH9X/Ppt1QilJ9B4Ql7
         M4b5j91OMzPo9u/ZJdJgBY9XQBnQr5PhsHYl1z29hVnt/hvSGsfiXUxW8uWwIpmeJUb8
         rImxKi1pjrV7IxFX4WW6zW+Sn6XyNFTUitj6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656915; x=1724261715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
        b=os1SLYdMVbUCk4QIiJPOhWJJIj3HMP0Zii+GeYtXVTwQQMW9WI8217mMwh56BVwsI/
         TYAdhNur550lsYNmNXxf/HtoWdjQI9yZbiQD7KiQDc3SW8Z4lBhOf3h8sYF5CDbaTn7S
         zWYuYi3ft7IpUs5jGdD2VfEgGtODXec88wWfXcRpSJl/f04IPPsO5GEnLFvLQHVE5Vt4
         SGPlTQ59iTr2nab9xB+erx2RJoG9bjiHWG+0WG7TXcXJY7sqylLg60kUg4OaNj6EQ2DP
         S/veyS9GNKSnWpBzVdM9dddzBkZDdHzpCei9DCwwoDDwQmDNxYhW1ZSmSu/VN9XkXGgW
         IMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB5DMTRqNpg1Iht7SIPQkSfnpm46hEdoHmIppbnhtfjoQ1Gpp+qQf9Tvi0weRCy9Bf0mkJBiT8cMJaRqlSpfp0HT/obToBgUzwrA==
X-Gm-Message-State: AOJu0Yw8wWo+X2cUZzgq1HIvg/rn3oZJotiW0IqsWkSs4OZmMaUcB13K
	cuLLoGGduuaAmPsgIWxZBuBTjgw85BjWdApuPT63uPWtIXulMF6+ke0A3ukuXt8gr6/0D1RzFrI
	=
X-Google-Smtp-Source: AGHT+IGyUDCdIDEmDo2LAs2XNCWOQfyb4+VL4QbJ4NwiD7KoMLqPswbyBakFvws4KK0ULDnJQEvJqA==
X-Received: by 2002:a05:6512:350f:b0:532:f4b0:3822 with SMTP id 2adb3069b0e04-532f4b08886mr1939726e87.25.1723656914806;
        Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f1b36asm1332470e87.208.2024.08.14.10.35.14
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so124995e87.1
        for <linux-s390@vger.kernel.org>; Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF3Z9z/BWV5QP1hCp47IV30wQWk5SxxrBgOt4275lHCw8t1SZOeu/UKO2uxgvnx8pc8w6N+3HXNJJw1Z03ypOmbj55CXeSm8lqXw==
X-Received: by 2002:a05:6512:10c6:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-532edba89e2mr2666679e87.40.1723656913739; Wed, 14 Aug 2024
 10:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814173021.3726785-1-agordeev@linux.ibm.com>
In-Reply-To: <20240814173021.3726785-1-agordeev@linux.ibm.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 14 Aug 2024 10:35:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Message-ID: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Subject: Re: [PATCH] tools build: Provide consistent build options for fixdep
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 10:30=E2=80=AFAM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> The fixdep binary is being compiled and linked in one step since commit
> ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues").
> While the host linker flags are passed to the compiler the host compiler
> flags are missed.
>
> That might lead to failures as result of the compiler vs linker flags
> inconsistency. For example, during RPM package build redhat-hardened-ld
> script is provided to gcc, while redhat-hardened-cc1 script is missed.
> That leads to an error on s390:
>
> /usr/bin/ld: /tmp/ccUT8Rdm.o: `stderr@@GLIBC_2.2' non-PLT reloc for
> symbol defined in shared library and accessed from executable (rebuild
> file with -fPIC ?)
>
> Provide both KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS to avoid that.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

FWIW, I already fielded some reports about this, and proposed a very
similar (but not identical) fix:

https://lore.kernel.org/lkml/20240814030436.2022155-1-briannorris@chromium.=
org/

Frankly, I wasn't sure about HOSTxxFLAGS vs KBUILD_HOSTxxFLAGS -- and
that's the difference between yours and mine. If yours works, that
looks like the cleaner solution. So:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Either way, it might be good to also include some of these tags if
this is committed:

Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@l=
eemhuis.info/
Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")

Brian
