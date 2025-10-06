Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FC26C3A2
	for <linux-s390@vger.kernel.org>; Mon,  6 Oct 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749972; cv=none; b=eZBq5MWZTTXaPGoDVWK8xfcmajiHLR1b5Go/U+FrZbADDltMoqSf/Z0zooAkB8jNv9LGdWA7eNIhv7/wcl4X2GOLI9iOA+p3as37uYmQX7KZO3YgkssQ4UOfA+7SzFE6j5gDC6os7B0+0IkvTxBUa8xKd80qbZRuuQfsIQoeD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749972; c=relaxed/simple;
	bh=GeecThNQ93ggam84Jge/WQIwJ0tpZbNxDJpSZaYQFg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nyFgM9Jc1yOpOSiRqt8LV3z4L+7QidPN9dXauCzrd0a81tTVYP0Be54UneUO0mFFZ7z50r8rvR+n9H2wlzuNxiy6fvMC0zAKK6G9NHCUD1kRnpKzGUmWSnbA7wzdYKatp1hrQKvp5cjQa2jutcRfm2Q0gG9d3WgzvCMb/dReioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=viYMhk68; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viYMhk68"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so2704210a12.3
        for <linux-s390@vger.kernel.org>; Mon, 06 Oct 2025 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759749969; x=1760354769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDtmvvD2FXzwZvAyeoxJfV+MQOeVHERP3mbNxwWBmas=;
        b=viYMhk68jUzpcaVtAX5sdQTjSWRhaRkkFWA61qpsyK2YLP5q/QIIhvoqaoo+JC2oik
         IFfDlyDRXN65CsWpJMiWYiZEi81lIq1hs9I3fqjBRANgMC1c9mChr6Us7O03H2zoEhBF
         LebCz2VzNQh6sjWIVzHs3Fl/5rG40nb5FO+t98PO7yMHjIvhtR6eagWqSPqCb7lSH1Bh
         JNYp5fI9yDSZzScwP5nFjr+DZ80TjY/vWGp7mNLtmKrUTtkVpKLOeA0qpj7HpK0bUmaM
         iMDdkwDz53bcue3xj9vxWMvVbOd9bIkRk/86FbDfJYxMOctKwsrabGWoqXdvss2JlLVg
         AWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759749969; x=1760354769;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDtmvvD2FXzwZvAyeoxJfV+MQOeVHERP3mbNxwWBmas=;
        b=rSqgMjGu942nmcgN3YDKzxzwvpanMqx12Uumcz2D7OPOiVYxbpZ/kPB3Lajbzbg66l
         HyoeHpHkvoh5cbdWhRiaJcLdyxDTnRbK+hIEesMD1i8M5EopZD5InEPgFyt44FLPcNqi
         Vyg9bO7+ajTcZeTDbYuoiOn9EgKZ+JdBcgx0LgiPWdGla1qBHTXbVJcvTCjIMORrrxc2
         nR1TbiA3i4g41hX+k2XDLLakPipIU97/1wFECJTiD3qkGhxdiTd74Pk71qeDsIZwh7E9
         KKMz2K9wtbHnxFSeo4FeGYZrFOI0Aj+C++B9o+O+0G5uC+3kutX89T7rFr1OJeGC0CeN
         tanQ==
X-Gm-Message-State: AOJu0Yz7Put4CialXse1/+ZhEQ18Eo5GnT3d1clp7g6Hd2Ilfy8y0qg6
	PKJEoACnHVmkwKYwS8Am+5UgAvWyGgPN4fakig3Jk0SJnyhqBeOjwUax/wH54+uuMqepR2OvP4u
	MC1XYC6Jl37qJCY640fHTJiVxGqxz0+KW8s+FtJ+9Gv6arpuz9nsXP3+mKw==
X-Gm-Gg: ASbGnctsgxFRvEGT0rXThjdgRDFL2azdJ1NRRrr+xJY27/6DygbF0TkYlCrMQdFOQR5
	H9MHYS5i0Z2amghbvT+g+e+1hChHyh6UnGnpRrhgu8BzmBFA0OppiUEL8JKIku41/8DSblFhX/h
	4hxKtq1cimrCbd3QaqPZqsHlbsHO2KdeYR506q8wXiODhxUWPjTUc4MEMKHrKwzCB7xAk592RAq
	oD4Usyt0LCsnC5YE7sahSyJGSzgOPObgw8wctvAy9dxS1tZlsdytOZO3D19Exlo6MolEW4E8owi
	d/ibKuwEyK5G8WVXhUeXsycSb/b7+/PgBA==
X-Google-Smtp-Source: AGHT+IGTQs8jxKC++oU6C7/YISQ0AZ0FYt8ko5S/A8BiDUATldLpn8X/+jXVOkZW/HIc7ypJ3iFUxkMCCjEPr5Zxmk0=
X-Received: by 2002:a17:903:15c7:b0:25c:4b44:1f30 with SMTP id
 d9443c01a7336-28e9a6568dbmr128417825ad.45.1759749968905; Mon, 06 Oct 2025
 04:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 16:55:56 +0530
X-Gm-Features: AS18NWBff_p2Nu8Juw5fKubeZaQNxL-VRN3bmyXdcvgFsaNarPe272yd7yfV4Co
Message-ID: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
Subject: next-20251002: S390: gcc-8-defconfig: symbol `.modinfo' required but
 not present - no symbols
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The S390 defconfig builds failed on the Linux next-20251002 tag build due
to following build warnings / errors with gcc-8 toolchain.

* S390, build
  - gcc-8-defconfig

First seen on next-20251002
Good: next-20250929
Bad: next-20251002..next-20251003

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20251002: S390: gcc-8-defconfig: symbol
`.modinfo' required but not present - no symbols

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Build error log
s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: vmlinux: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: stM7JmYX: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: stM7JmYX: symbol `.modinfo' required but not present
s390x-linux-gnu-objcopy:stM7JmYX: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1


## Source
* Kernel version: 6.17.0
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
* Architectures: S390
* Toolchains: gcc-8
* Kconfigs: defconfig

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/config


## Steps to reproduce
  tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
--kconfig defconfig --kconfig-add CONFIG_DEBUG_INFO_BTF=n

--
Linaro LKFT
