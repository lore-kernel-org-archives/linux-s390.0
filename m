Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755798632E
	for <linux-s390@vger.kernel.org>; Mon, 26 May 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271001; cv=none; b=lXe7S0/X6fs362SrpYI+t3OgE3UDHmhBBa3dKt6b+mKhVs0SmimwMsKLSnmXJd0Gkm8R9VionyCPyaACp3LYJ05BRTsWeU8LVBQdLBkLLb/zGWFBKngFJNKUSP/5ImLgBv5YEkUAyKP5SjmyQW4tsIiIKm45Oxqf1l9wfSDKqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271001; c=relaxed/simple;
	bh=zfitFxB7TLlYSZl2n8OvoUs1pS/YDRXYg4yZgpeEH24=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IqAy0SXaAZzQWkdPQ3XUNoegHs2BxBrrF9Baq5dVYpU71wzN5RFXW2o8hn1tre3h58nLGhZyIEvbwL7SfhTJO/NXq++3RUKIQD6gN437pZHikJtEQL4hozz8Zflu3PF1zfPRjgQvmXGFE1bxXtMFg1t8l7+JYDfmdCD5Pd0Kf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrAMw9hE; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrAMw9hE"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5242f137a1eso593086e0c.1
        for <linux-s390@vger.kernel.org>; Mon, 26 May 2025 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748270998; x=1748875798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FPt3TJeeSWlSX7gMhtUXG84+XDQKLnMOq5NBKVq0EzE=;
        b=rrAMw9hErUZzO9Ch4Ma/veu6UZ2pBbxq59BUKlBFNnWvpz6m00mh5djPczsb3Ubn7D
         wtYqVt68eg/osksGwK5McRv7yQ5M3enxz4Vcr/1Qi7iccmq0wE7QDlFCIWtzhgTQEGhm
         blZkgFuCCS2x6L2LyG2k5FXXPExDPxRdBkQLTa+KyLUUZJclnHQ07fNRZJ0kIY2ZkNhd
         JxVLoULeF8PVtbLkjyf9RcoU1XeXJ55akZHN3OOtH18EcnN8IEgcFLTjqBSQGmIhuWK/
         qpnd6VdLNoyS1dChDBAq6t97yjhVZea6b7FU662KqgG2d964bsEUOdihYj3A23TdDG2w
         zYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748270998; x=1748875798;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPt3TJeeSWlSX7gMhtUXG84+XDQKLnMOq5NBKVq0EzE=;
        b=U/c5f98mwBlwnRtKBgnG4C82TD/kbKXXfQKpjkBXnsqsY13ubG+qnTgRnMrVWBee6r
         jqkAbgLjC5H+JG+Re3HGMO6aKi2qktK8BG3T8lBUJnGVcG76L9htaZ/W2XCQ0eMAuNSl
         wzte6Th3MX9D2vZsNX48yFUG5CKgecmcJrNTlvX/OM9LY4F6G4qI7+pnJBwNv2dYQeoz
         H6rturOkerdbWUuJ5onZRJ3fAjXRxQYJxF1//b2yTO2HV1+qiwumq4hL/0IkYRaNj9Mw
         B6PuITXd/jHYt8lfrPjz3OYtFAqE7kK7gckaqJT2aQT9pQc0XD4DUuvljX3A4y/3Ggrt
         yhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu3Vxy26hrXUkQ1nPeXoQj0jQgilx+WmhA1dLA9TQXVFDftzFW83Y3wUCiphyGHVLVxgQ4xIHxsx6G@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP8TC+Gbx7fGupCO/vAljQVndEuk2jy7jMche6s29ViWEEk/a
	b2BaqXg0WEKlo1tcNDz4FhET1CT/0/uc02+Wu3boXOEf3gH/VzGSWLqluNf+LwJtsmnky7ABOYk
	AV5oQ7ABSIHSS40YgacPY5l+yhgQEOT3Ua+dEI0Y1LA==
X-Gm-Gg: ASbGncsKINxiRJpyaedXEj+lnbK6q6NMtwh1OZJ1F17KuIEIouo2L5g3yKHwaC5DoCT
	G/DODLy5M6PE57ndfmXJpp1viC5KfHajpmBjE8TrsSg9F2TJVR8VZRNhsSBeekTZUFS5ebvppBs
	xCaA+wUDOXGvidu6l7hjIcsptMm6GlPTw8Do9JbUpypNaRuWQntiPL5Tre0jhqlFVKeg==
X-Google-Smtp-Source: AGHT+IFAwHkN7yPij1DIkj7z46mEiXlTGAcwIz2YT+ZMH8oPDmB5X5hWuI846iTsf1oWgfSFkOzQJJJIW+9kBdiXyIc=
X-Received: by 2002:a05:6122:8c8:b0:528:f40f:347f with SMTP id
 71dfb90a1353d-52f2c4fb8efmr7658464e0c.2.1748270998229; Mon, 26 May 2025
 07:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 May 2025 20:19:46 +0530
X-Gm-Features: AX0GCFvxh27JNfDxKLaqsriHok2z-zPYobJmZed9nNW7mlvIzu0hQJg4gxzXv60
Message-ID: <CA+G9fYtSrmuXzvYbCrmT_4RHggpaYi__Qwr2SB2Y0=X3mB=byw@mail.gmail.com>
Subject: stable-rc/queue/6.14: S390: devres.h:111:16: error: implicit
 declaration of function 'IOMEM_ERR_PTR' [-Werror=implicit-function-declaration]
To: linux-stable <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, 
	lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Regressions on S390 tinyconfig builds failing with gcc-13, gcc-8 and
clang-20 and clang-nightly tool chains on the stable-rc/queue/6.14.

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: S390 tinyconfig devres.h 'devm_ioremap_resource'
implicit declaration of function 'IOMEM_ERR_PTR'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Build log:
---------
In file included from include/linux/device.h:31,
                 from include/linux/node.h:18,
                 from include/linux/cpu.h:17,
                 from arch/s390/kernel/traps.c:28:
include/linux/device/devres.h: In function 'devm_ioremap_resource':
include/linux/device/devres.h:111:16: error: implicit declaration of
function 'IOMEM_ERR_PTR' [-Werror=implicit-function-declaration]
  111 |         return IOMEM_ERR_PTR(-EINVAL);
      |                ^~~~~~~~~~~~~


## Source
* kernel version: 6.14.8
* git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git sha: 3413aa4d097e291186719c26f341c52f8550e22c
* git describe: v6.14.8-756-g3413aa4d097e
* project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.14/build/v6.14.8-756-g3413aa4d097e/
* architecture: S390
* toolchain: gcc-8, gcc-13, clang-20, clang-nightly
* config : tinyconfig
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xbEAey3MY3M8lp7doND4hPoZo3/config
* Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xbEAey3MY3M8lp7doND4hPoZo3/

## Boot log
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.14/build/v6.14.8-756-g3413aa4d097e/testrun/28546580/suite/build/test/gcc-13-tinyconfig/log
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.14/build/v6.14.8-756-g3413aa4d097e/testrun/28546580/suite/build/test/gcc-13-tinyconfig/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.14/build/v6.14.8-756-g3413aa4d097e/testrun/28546580/suite/build/test/gcc-13-tinyconfig/history/

## Steps to reproduce
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org
