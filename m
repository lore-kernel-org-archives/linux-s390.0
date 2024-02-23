Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6A5C615
	for <linux-s390@vger.kernel.org>; Fri, 23 Feb 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681324; cv=none; b=CYRc5cN7Zhbi+8en7F6xdyBqbCSrGd0/SD992MoaQ+kvNcB2jUtip6gLzp6XrPtIUl/oWO5c43lunrGR5ZEgFj+6pno0Kp7OgUUukYyQWTHu2uJImr+3EPMH6dJIYq72fRtFPeTyzctCLmEL6E7m4HV75dD1eW866WNgFHj4ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681324; c=relaxed/simple;
	bh=tiLrttMRwT8vCIurOXRIlRgXCqpHySp2xPh+CqveHMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U511xzX7tMDPcRl8mh0zaLyoewVUdBIZEBlVRAdn7+wg/DSkYjvMDqo5dTwzBoM6BzPA4/KaQpeLZ0aV31Ry7vMCpjvJj9MW0oQ8oUKsn98Ak+nXAC4/vNQUJpaxSlqDm8CtAusGdfZJun09SATCVrHkGViVPfkSzCYX9Up0SvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1XQKLyP; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1XQKLyP"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso359703241.2
        for <linux-s390@vger.kernel.org>; Fri, 23 Feb 2024 01:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708681322; x=1709286122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5vxAQbq8EgE/2JJwOSWCuGz+rEc2pK5AZO+RpGD7vjU=;
        b=q1XQKLyPND1mFgll0YXMTuz6IUu2RfUbTv+hFspHk6/xgoHg8SWpaIN+hfplcg1aMz
         AsVihFh1r3fg/lDmKx1Y7tnFmqhj7ljZQPwO6Isr9ByY8jKSG0CdetCDHtefD4eleZA8
         X5IZ8hvo1GC6SWidW2o5kyMvPTAwi6nIQJ+WRW1YgrQaC/UaX1YYubb5gqpF6+joz87s
         ZNPcLYAXH1MT+aFZ4q62ozYPfOsCwIVS6sjrKXjkZJKSGyB7HAC9A8IGNHNUgy9eLKCx
         iZXoCiOeOzsVu+Dn4K2DSnZZFEIelNeTyw3rMRXNsSOJbzSN5Jry2tiaoD+ZsUljnk13
         fx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681322; x=1709286122;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vxAQbq8EgE/2JJwOSWCuGz+rEc2pK5AZO+RpGD7vjU=;
        b=pBt/82kF+LXLGL0VkFVkF1F4QG0q7fRARInIBQQ5uVHxRq3+g8K9MFlFq+Q+j80ybz
         vZIOPVk/Fq6cxoIxUs5JzjfUUSRonJ4F6c8nfT3NWnP2ywtNoMt12jkUqoNejPUkVYIn
         oa+reNIN96E9PZgAFLZxO+X9CdbaK/sRnsZyFMcoMh1MrFWTFqXzdC6NtOJNA9Q9Wj1S
         Zcylo4VcoysixEBjKVcmH+2pePvz5hn/jf3xgIOeGNrbl4dy3mm7kVbD/F5Hfv7LUNzF
         orYvjszT2XPUInKY9Db4M9XH1ZZW5iETucTMBNTneJSJ+njBt9KLk53fR2yxiuj69M2E
         t5dw==
X-Forwarded-Encrypted: i=1; AJvYcCU18O/Jxxx3wocT9wx6Z9HN8d0KSS85NcnsVA/G/HAyiHkmKmCZj7VIFCRUaYe1aVsINktYMaIpAVlrc+ek20tO4w28cESJzMqbyA==
X-Gm-Message-State: AOJu0YznFDoLls7XTwkVIYl4Mo/ZUt/fFOxTftyBA+d1z4Es3KsK4fb6
	RkzHnO6EVzqfbAGaUXQBdan1LKhrY2CN5167haNsiBhGR5izMDI77Iv4uQT+0rnPAdVfaK8ljh9
	fKQri15Zy6ONg1dG0Mivd+JhV8RMMv27F+tVlfA==
X-Google-Smtp-Source: AGHT+IG0N4VJnp/KUVxYjf1fciYRrnpy+8/D6UbSyiGGRLADO/cLSUIw+vE0FGeULCCxFvRJYk7YJZeVVUtr0oRwwIs=
X-Received: by 2002:a1f:e681:0:b0:4c8:e834:6cf2 with SMTP id
 d123-20020a1fe681000000b004c8e8346cf2mr1288542vkh.3.1708681322074; Fri, 23
 Feb 2024 01:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 Feb 2024 15:11:50 +0530
Message-ID: <CA+G9fYvWp8TY-fMEvc3UhoVtoR_eM5VsfHj3+n+kexcfJJ+Cvw@mail.gmail.com>
Subject: s390: s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
To: open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, 
	lkft-triage@lists.linaro.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

[ Please ignore this email if it is already reported ]

The s390 gcc-8 builds failed on Linux next tag next-20240215..next-20240223.
First build failures noticed on tag next-20240215 for both gcc-13 and gcc-8.
But from the next tag next-20240216 gcc-13 passed but gcc-8 failed.

s390:
    - defconfig-fe40093d - gcc-8 - Failed
    - tinyconfig - gcc-8 - Failed
    - allnoconfig - gcc-8 - Failed

    - defconfig-fe40093d - gcc-13 - Pass from next-20240216
    - tinyconfig - gcc-13 - Pass from next-20240216
    - allnoconfig - gcc-13 - Pass from next-20240216

Build log:
---------
s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
make[3]: *** [/builds/linux/arch/s390/boot/Makefile:87:
arch/s390/boot/vmlinux.syms] Error 1
make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
 $ tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
--kconfig tinyconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22812529/suite/build/test/gcc-8-defconfig-fe40093d/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cl8pys1B3Vc4oOB2yXcaYkfnKw/

--
Linaro LKFT
https://lkft.linaro.org
