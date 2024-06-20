Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEC14387F
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926460; cv=none; b=N1qDCQJdj3mAHKb/UHVgYMnTPFxEC6cyYOAaODx9KeaqyQvKLWuDNwTQa9NBxhUmVoh8hJsYMw19jRnKfWLe44x8cPpiPky8UUG3cWq03G8udPBgtcZoOm22dyKVcmy2jPGFP8nk/qyJykF4Y6mmE42cA/lW4iuuDrhGGsO7ER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926460; c=relaxed/simple;
	bh=sM0wDBCUvzFW6IKmAWX5aMLcRpg1A5LDTG15Z5q384E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ojhZLdrC68kJ02UtK+ebdpuzfYoXA3YlcBYXoTtcINFd3w6fA7RKXXUs69KSrgW3ElnKWOfL2XF5q4ZDEyqg46pqNVOxel+D+TaTTjacu7wouJpHwAkhnO98m5lLIXwc9YzxoIi9hGM0CP/J4uzDkUzk4Rf48WVAwUs/+fR6QaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=0j6Yq+0Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="0j6Yq+0Q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9e5fb4845so46335ad.0
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 16:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718926458; x=1719531258; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D82mbCQ1hFRo0hz6PNhbEMszTiXYVNT0XyGJhGQyIO8=;
        b=0j6Yq+0Q9AfR89+BtbvknfZCCBac8DTYIXO9FBKOlh8aXgtv4J84oLPLAL6RiuwVrK
         TDYFRlz8VE/CxPpoL4ZdZtVsnm0bE/uLxgxl7HfECGLeaJMqQumM3DP/Vc1IEXLoanJO
         eAK7Arl452VRsYpizqC+lvOpDZW/A+I7vbS8VGE/MHgWiMGuBbht71BhnzZ1f/fGNPnR
         LjRRCmoqNUrlGRBs94IbHRKsx3bHDe+jayAkG8A1g+POzr1xK2Xqas3ACg6gsqxyXugT
         lRhGaQlAe31wrz1+PVkr3+oQ0xZ+MEFVXe7wtJG/euVxOoLRnMCM+b6sQGU6JhD4Z2jt
         6HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718926458; x=1719531258;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D82mbCQ1hFRo0hz6PNhbEMszTiXYVNT0XyGJhGQyIO8=;
        b=LFMlDUCZCU6NeJQyVYrW+81nrsVrNc59Utj6Yin+Wjg/2NhEI02IuaVuWd1EZ//5ej
         PoofM7b1rWPlcRSXX8LC+oLQ4OHJxZMsOHpjFttyq6aO8dTi7FAzHu55uor+lHKq3L3f
         RW1retv2z7MoEs5stId4FfF7bLgeGAU/hDHVTeq5rx0c6gm4DXuh8AUlc8J8ReSHrrZk
         18pm1LIAPWTH895F2B7wTuUNnyQkkHXEsfS1JPUtrKplwOjmkdL/FaaVayGdmfZMW2zg
         GtUaQYU9W2M0/hErVvmayx43nVgFgfulz2mI1z0ggTDbLy0cE3AQHCfLp07/IzZNcaf/
         r3lw==
X-Gm-Message-State: AOJu0YzeJl+EsOycuvi1bUa2hq9uOkndOj/64ZeNb0j2d4ATUlL8WVDw
	Nar9D/zTi7dI0P/Rc8xxQq/vVqf9JKYrpvZJEBAw+luSVO4QaejpmQtEwEw+mEw=
X-Google-Smtp-Source: AGHT+IFYE8udYTsdUs/CYZbmfGTH1vYJWVb2BSRDHy77cnmwp15gQEA40iJRHfm6QOtynyXzbnzLpQ==
X-Received: by 2002:a17:902:ce05:b0:1f9:b19c:2e3b with SMTP id d9443c01a7336-1f9b19c2f2fmr91153975ad.15.1718926457795;
        Thu, 20 Jun 2024 16:34:17 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::4:ecba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f134bsm1761765ad.34.2024.06.20.16.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:34:17 -0700 (PDT)
Date: Thu, 20 Jun 2024 16:34:15 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, Alexander and Sven,

I just got around to testing drgn on s390x on 6.10-rc4, and it appears
to be broken. I bisected it to commit 56b1069c40c7 ("s390/boot: Rework
deployment of the kernel image") and narrowed it down to an issue with
the KERNELOFFSET value reported in vmcoreinfo.

On my test kernel, the ELF symbol for init_task is 0xc96f00:

  $ eu-readelf -s build/vmtest/s390x/kernel-6.10.0-rc4-vmtest30.1default/build/vmlinux | grep ' init_task$'
  72273: 0000000000c96f00   4352 OBJECT  GLOBAL DEFAULT       18 init_task

And the address in the loaded kernel is 0x3ffffeaaf00:

  # grep ' init_task$' /proc/kallsyms
  000003ffffeaaf00 D init_task

0x3ffffeaaf00 - 0xc96f00 is 0x3ffff214000

However, this doesn't match the value of KERNELOFFSET in vmcoreinfo:

  # eu-readelf -n /proc/kcore | grep KERNELOFFSET
    KERNELOFFSET=3ffff314000

It's off by 0x100000. This causes drgn to compute the wrong addresses
for all global variables.

For context, I'm testing using QEMU emulation on an x86-64 host. Note
that it logs "KASLR disabled: CPU has no PRNG" early during boot. My
exact setup is:

  $ git clone https://github.com/osandov/drgn.git
  $ cd drgn
  $ python3 -m vmtest.rootfsbuild -a s390x --build-drgn
  $ python3 -m vmtest.vm -k 's390x:6.10.*' bash -i
  # python3 -m drgn
  >>> prog['init_task'].comm
  (char [16])""

That should be printing "swapper/0".

Any ideas what's going on here?

Thanks!
Omar
