Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51978462
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555412; cv=none; b=tUp6OQHOuWdNfqLJP04s0DTr5Sn2yZdsGoTdq2J7cqyBT2Qj1pQSOh5vFW5TdhiK9nEKon50KTb9T/bp8WSGeEp5bN1HKY3+Ti3Rfp8VAz/ttbBMJio0ymbdeL/0EB+fre1Q2pFW9RY0iHa2316OKS4MEkGt8gDAM6xDzpMUpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555412; c=relaxed/simple;
	bh=GfH5HSIKG5vJgzEj+X68rTPCf27ssZ6UVJw48ldkXy8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kXdI3kYGDuvy7xWGTs2wNUqmqWN6YZchQeRwSP257akw+kjL7YexAxCojiQlLWeaGXPz/ta1r2JtwCKkn+7SUudGrN9qVu1ktZru+Ab37JwPztQZSJMlE+/P8c2AqCfQi5VmVI6e84KIQr3WUOXJTE1ZAprJJE7Cay0uVY9Om1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLd+k9jD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLd+k9jD"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so4474623a12.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761555409; x=1762160209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KEKtCxt8nIo5AAXBRjH/5vryo/ZaVKRjuXDR6Hi5YuE=;
        b=YLd+k9jDPiOR4DzlenemRWEPjXu5rvR+N92/VxDysU48igMFAHnJVOuYMFIhgVwKIi
         JDkjact4QSihlJI4X+7+Fq69eSZ6A7eQvy/2e94VhCiUP7OpxuVjy9MsOhc4d5Vi8Vd/
         eIYq29In1UHG4OXTZrKvSN2nbLPremJVDlPbNoXc0mNbgRt2zR47fB+WcMPGreODHHP4
         5nDlUUt/kRRTizDXEXnOfyH6KU9vw+v8AjILFDb5lGkBOTWSLErxL07xnNYiCwjCfCRH
         GEOEMajWlhs2jelTiEPlh+24a59nqDVIM7vLSslsGSX0WXmjO2dBhImIs1U+yi8Pn3E1
         Jtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555409; x=1762160209;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEKtCxt8nIo5AAXBRjH/5vryo/ZaVKRjuXDR6Hi5YuE=;
        b=S+iDYeNl66RQiNQQ3O4VT/FFQ2TCyRXV2EILI5qLFBeV5ZFyBwCMZACUZveecZC6/Z
         U07J/p/jLc2olv9p5m1AYo1T+eT1w2L3BHYMnovdIJa168cRXR5kG7d7OW7RyV02gOa1
         1h/EKja5vGOh6bTY6gSwPV+wXQp/rasa3PRmTPQD9QAv11TYkgbJzbMjo04zyUKtytxF
         wmmwr2lNJ03vUADiuXELfW4p+oE/kZFV7DHAUfvdtAoeeE1SZ8wvEBiRjCdi1cqGQmgT
         lvsiVv6VKoXNUWXkjCzDWKtUI7l0rBx5eJGYiJN7xGyvFPeJS+KZqQhlhcDzb2S3cJ2V
         jy/g==
X-Gm-Message-State: AOJu0YwK9a0BfTtjOgw/nqDeIZe2t1fYhqwbk3VkVq4EdToChULM1W60
	5F+jTCBQ251ByIbY7Xc9G7CJ1Ii9BC8FrSZ2i+BxZYobc6OsTqDG9qiyBlp8WjobJADxLoOPT5B
	YQjcgrzJz3YLWLRuaN+1GjY8FXPNtx589niTeUVRRZATPTYEGv9THfvBcHA==
X-Gm-Gg: ASbGncuQ6FaPmHr18V02k78wV1LpzKT1/V8u4539XQMC366tRBSkpl1qGkCv0M1xsLC
	P5OSr04s4T3hZNSRHWJFAYLASsnkxxn8pf6BD1FhwbkMyAGWRiBKqHwLVjRpJZDLf+cPC+wbuei
	Kq9W4ETfI1qC5RR1aQdc9mGbECO1V2isP5NonuXiTBXT2EJ/IE+z702hEs1BKp5kTjT3nx+FpAT
	HIt8HoaRAizBn80n+3nXxv64dciG+TzBRw1wwHy90evwivwsJxs73VH2gy9ZJSKMNZMM6SpVK43
	CAsn6cdGOkJ9QAUOacienUjUhJ35cKPE6jFpAa52MUrO8MwXXnGb4h3j0KtRhg==
X-Google-Smtp-Source: AGHT+IHMTIIFLA5mgk1HP2tn5C+IZfCTCdQhL9lHvE1auNKQlgk4Tb9Ecb84rLUsDS+i/shyTUFa12dikG6jGXBHIh4=
X-Received: by 2002:a17:903:244c:b0:267:c1ae:8f04 with SMTP id
 d9443c01a7336-29489e15ea4mr133599525ad.20.1761555409385; Mon, 27 Oct 2025
 01:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Oct 2025 14:26:37 +0530
X-Gm-Features: AWmQ_blJuZ42rueT3RfdCwJIhx-741RLJJ31SSl37TaWRIG6sy6Xm1B0UeYV3a4
Message-ID: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>
Subject: next-20251027: s390: pf1550-onkey.c:154:12: error:
 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sean Nyekjaer <sean@geanix.com>, Lee Jones <lee@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The following S390 allyesconfig build regressions noticed on the
Linux next-20251027 tag with gcc-14.

* S390, build
  - gcc-14-allyesconfig

First seen on next-20251027
Good: next-20251024
Bad: next-20251027

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20251027: pf1550-onkey.c:154:12: error:
'pf1550_onkey_resume' defined but not used [-Werror=unused-function]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error
drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume'
defined but not used [-Werror=unused-function]
  154 | static int pf1550_onkey_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~
drivers/input/misc/pf1550-onkey.c:133:12: error:
'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
  133 | static int pf1550_onkey_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/builds/linux/scripts/Makefile.build:287:
drivers/input/misc/pf1550-onkey.o] Error 1


## Source
* Kernel version: 6.18.0-rc2-next-20251027
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20251027
* Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
* Architectures: S390
* Toolchains: gcc-14
* Kconfigs: allyesconfig

## Build
* Test log:  https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/build.log
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251027/log-parser-build-kernel/gcc-compiler-_drivers_input_misc_pf-onkey_c_error_pf_onkey_resume_defined_but_not_used/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/config

--
Linaro LKFT
