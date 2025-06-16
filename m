Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0B2E4245
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075604; cv=none; b=GmJ9N5takz+v3AR33PDoNqhWcIf2j83kKDbXndVw8qT2dENrebsfGTcIK6VkP0/pHkACLiQs/pnHNn6zD/jGra/Hc3WqKsEZRXdADNWAU7NRcwC0vHUoZVsful0aIjuTMgV0ZJ7VzgTHYSFS1NuZ9Z0ArCFiqvW7TTS+78NqX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075604; c=relaxed/simple;
	bh=IbZZvF1YeIlcvUq/+fdnzFkqnxbyQDarbgl2bwQ6gi0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Rcnx9Tgg25XEZtcFkbMnixLTYKkG9dA72dpTH9KUhVEMpv6XWob/bfL5PnRS6NnQiGUHZsFoDVpWO7idbREocEPUhJKq5BP3gyulwgAL01YXsmdhB22eWCge22GRFh4ZZ8MrFvThp11Hl5H0bocSNeP/TaBIQ5Pasou537GFhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QabkmsMZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QabkmsMZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6faf66905adso23754306d6.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750075601; x=1750680401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TpU5wAMG3sQlhcsZQZqrmEByJp0SllVR0AKHGW2r9qE=;
        b=QabkmsMZGZGM7UgddHYe/E4Rf0XLN+OpoVp43UzJQbcPCZX1sYJqXP/7+APpyrcQPO
         h8icBlzTk1OClCCdvR+LlvUBMJk4EhIWnDjqLxpxgm2XKstO/tldaFNWkn0uGcycLrx6
         ai064qmkabXS/rR/6/k9uLwyqzpSBXk0IXMFNKbyNaz/NrpUnoZqPp3/XQzFK5lXpNEd
         HLrYWt53ripbyDSjBtkvEtHoaxrZqKdaErx9sqezsNxbbpUBwNyzXr4WxtWNCwE94jKj
         6CAB+cOxWL9ye54RESo2WjiDCy/mXcrgBH4tfsmvJbWYGv5zpM0i2jlblADRy0ri4Oxb
         /AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750075601; x=1750680401;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpU5wAMG3sQlhcsZQZqrmEByJp0SllVR0AKHGW2r9qE=;
        b=Yvon8dHEZRnnOYTUm588cpoTdNw+WyOzDcFIQCYG2t63/9chlU+9T6v1PDhiPZRa04
         1kO/QYqYo5fRxxzlYmlvt93M8OYmGQbA/nYeJD8Khuord5cAUSKJoVE8dudcef9ifJax
         hkNdesE81C2GMUIUBtrOPWG7rp1kw+eoT/mDFPW3ooobzZ3WST/T1ScEp0B8DrVIH/90
         IW6rKFjB1kqH9OFLonaAauAfiPTFel3uwlclSq4rt9tJY+M42yfeYaVVm+P/OVDlyNnw
         AfRoRd2PJcT/fVhhIBCICbIySPvbWLzRMVyS6p7s146DTlfJ9DuFnC2LDmSx/j0CixPd
         0Tfw==
X-Forwarded-Encrypted: i=1; AJvYcCXowUN7qYCNAkUCB7bhtors2RKYCyc/AZbhGxljoyoghR+QJsNJG4t1byoIvOCrrKGJtyk/I59f4NC5@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDSj55SXJhXLwJuDWhUBzsdsISLrx9+f+Y5NqB9e8Ew9EiJsl
	gLKEtCMFyu9SG6jG1PJrOdNPkTrHl/VoWSKd4S3Mc5WOjJVsi0laTKV1qvm/FvA6fRz8Hj2THvc
	5yj7enV714aP42crV2f6EajQoLD6Gv4vsa7VjV8F8wrXk/sTUDOT27ClsLw==
X-Gm-Gg: ASbGncvtwkHa+VTiZ+kjveUG46Q1nNs/Ykpybs2d5upPrtqpJQ39BN3jzIB5sRSD5RM
	U+6dXLSskqKT9RVHv9BqZvGk5vbHWVu5woJIYgre8y/YCR9y8kMcvBGoRRZaCmNGBnpW2Jjd3zC
	tEE/3zgmY4AiVX18/rt0R9WbIzMSI4ID9iNe8hxX3aKYdeW6CRfAbMATVkwwn6jQQ0DRLJRB9U6
	fOr
X-Google-Smtp-Source: AGHT+IFeUKnKrR3PiU9rxHEIRNQyrCJR8n4GoHXj1LshKjqrOlDxmNum5ASc/NWBGVeJbSNt1PqkzC0aodOI1wfeH5o=
X-Received: by 2002:a05:6214:500c:b0:6fa:c6ad:1618 with SMTP id
 6a1803df08f44-6fb4776e76cmr143231416d6.27.1750075601411; Mon, 16 Jun 2025
 05:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 16 Jun 2025 17:36:29 +0530
X-Gm-Features: AX0GCFs0r1nB19T1N_2PPwY-kXlE37v4o6Iuua4hbniHaojK4KFbc8YBvkBv6Uc
Message-ID: <CA+G9fYuDOnN6TrcVYcMZT5UPNc34mOHQZsfyFvpq+Ndhz8p48w@mail.gmail.com>
Subject: next-20250616: S390 gcc-8 allnoconfig mm mempool.c In function remove_element
To: open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regression while building S390 with the Linux next-20250616
with gcc-8 the following kernel warnings found.

Regressions found on S390
 -  build/gcc-8-lkftconfig-allnoconfig
 -  build/gcc-8-lkftconfig-hardening

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

First seen on the next-20250616
Good: next-20250613
Bad:  next-20250616

Build regression: S390 gcc-8 allnoconfig mm mempool.c In function remove_element

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build errors
mm/mempool.c: In function 'remove_element':
include/linux/compiler_types.h:497:20: warning: asm operand 0 probably
doesn't match constraints
 #define asm_inline asm __inline
                    ^~~
arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
  asm_inline volatile(     \
  ^~~~~~~~~~
arch/s390/include/asm/bug.h:43:2: note: in expansion of macro '__EMIT_BUG'
  __EMIT_BUG("", 0);    \
  ^~~~~~~~~~
include/asm-generic/bug.h:77:57: note: in expansion of macro 'BUG'
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                                         ^~~
mm/mempool.c:149:2: note: in expansion of macro 'BUG_ON'
  BUG_ON(pool->curr_nr < 0);
  ^~~~~~
include/linux/compiler_types.h:497:20: error: impossible constraint in 'asm'
 #define asm_inline asm __inline
                    ^~~

## Source
* Kernel version: 6.16.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 050f8ad7b58d9079455af171ac279c4b9b828c11
* Git describe: next-20250616
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250616/
* Architectures: S390
* Toolchains: gcc-8
* Kconfigs: allnoconfig

## Build S390
* Build log: https://qa-reports.linaro.org/api/testruns/28763376/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250616/build/gcc-8-allnoconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wQbvgatYAbcvC2OTZls5D91/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wQbvgatYAbcvC2OTZls5D91/config

## Steps to reproduce on S390
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
--kconfig allnoconfig

--
Linaro LKFT
https://lkft.linaro.org
