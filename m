Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC0179955
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423440; cv=none; b=XANB1qPI3ptEviuUaSepgI1shW/bBIwWfe2npolS0+bSULeEvfvtW685CioWmgtWAskrI/FimRUv7u0P01JC/JMqhGUCenTXintVlP1YY+Sm0qm4WvmGBXi2kXMnrKIYK35lGAA4zzFdc9OGzDNWu/8zopPvtvjWnJRVYNXLy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423440; c=relaxed/simple;
	bh=DlJMFV/5TBkqj5Xgp0aq/ty+b2/P8lMPnJnVQ5Jw5rY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O9apKE0w/vs2tnXdo74ImQeu4YE2KS5EytgO0nd9jD9ephGxfSXO4Xuyzw+hLcwZlr7tIGDbeSJxnVf3jqo+/Rye1Mtsg6FkVIc5U86IkuoUzFb9Muc+ZbBP3+UC4f2Rt0aXXaZ1ij5vV187m5R0YNF6njtT6QJs5l+1ThpLQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVB7+WEP; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVB7+WEP"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4affeacaff9so1030924e0c.3
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714423437; x=1715028237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFLm7dyUtqCFeQ1Y3Oad/n2nmA3y2+DD3YB2hxxWLCM=;
        b=HVB7+WEPg71CIsMaiqAiANEz0jgJkmKVNob0zzxNdQK2+t1nZF+dCLrmBL2rsTfBHK
         W19GVRcmslOLu7TAkFz7YwlNzGohk4Sa+1aPHuI826V0yXsI5cTC0mAGOQAjmr0Ab/HH
         QcvfvWpsbIvEzWAUrltlIREHslThEjAuDDtyOjo3i9rwjq2IFmLpR2RbocYMyxvycE5t
         Dvc2EmmPzC0zmC9JHj4Eb5yWqIl0iQO7BCz3FEnp/s3Ri7m9b3YnrhM39UujdSNWhxCa
         enN3uo33/LmHMQaFdMt+jkMvaLl1fdqv//lE1uBoSKG1STiuuHBhNDWdQC9YYk0ubRg6
         wGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423437; x=1715028237;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFLm7dyUtqCFeQ1Y3Oad/n2nmA3y2+DD3YB2hxxWLCM=;
        b=G6xL0ILYvZwfS3NUG2Nma92jKQQZ4eJi8bhziYluf/goPooUp5ZTc7eBl7UNrhFqWU
         FkEBgbxX92WNYAX/Iu6TjiytCSSSvek2Nl1u1brFAcP10OBhCX6ZyU8MYGfUji1/uY6q
         6+wUtL1dZOh9sLREq01ymac95N2isaTxgBoGJ9yIsmgtyNEFNMReYqx7kWMS8bg+dpTA
         QYfqOipRwFLQjJ3LHtA8FzBgZ1jZbu5zQwdQLFI1rTz6GNat4w6vt8QHhg+EDTIm45I5
         HhAeT1b7GZzVagy3IkKX185ejp6MCG0kkUXX5nvlAVtRA2I/DtDvF2hj+6IwPpGPV/T7
         Ti9A==
X-Gm-Message-State: AOJu0YzXJZFYnTi6WUYWElCnbUl1KYYq1CMKJbCpH3KUOL/OXs/UxTLj
	Qq1IIVBvuorKzsJ20LtZygyT5CjtfS7yCr3rJRUy3+f8A32oBzRtWmRAXvjsGgxCeW48Qpup12C
	VCiaTq9NhETga4M8a7/FdZBuKC0Td9Kym3zF/7KzczNdSvSMuRl8=
X-Google-Smtp-Source: AGHT+IELY2zwLnQIzK1qbE3Sp9Z06BUgG4WlkmnHrcqV/8QmexyPMqSjZnChm2MVfRJ3gQJpaKv37A2s5enuif64LHI=
X-Received: by 2002:a05:6122:725:b0:4de:daa8:b8e2 with SMTP id
 37-20020a056122072500b004dedaa8b8e2mr9482653vki.3.1714423436022; Mon, 29 Apr
 2024 13:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Apr 2024 02:13:44 +0530
Message-ID: <CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com>
Subject: s390: clk-imx8mp-audiomix.c:363:12: error: 'clk_imx8mp_audiomix_runtime_resume'
 defined but not used
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, imx@lists.linux.dev
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Abel Vesa <abelvesa@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, peng.fan@nxp.com, 
	Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The s390 allmodconfig builds failed on Linux next master branch with gcc-13.

s390:
 allmodconfig - gcc-13 - fail

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
drivers/clk/imx/clk-imx8mp-audiomix.c:363:12: error:
'clk_imx8mp_audiomix_runtime_resume' defined but not used
[-Werror=unused-function]
  363 | static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: error:
'clk_imx8mp_audiomix_runtime_suspend' defined but not used
[-Werror=unused-function]
  356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

metadata:
----
  git_describe: next-20240429
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: b0a2c79c6f35 ("Add linux-next specific files for 20240429")
  arch: s390
  toolchain: gcc-13

Steps to reproduce:
---
 # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig allmodconfig


Links:
----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fmJ3qzFbmI2ACNTo81vzzgQaLS/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23715243/suite/build/test/gcc-13-allmodconfig/details/


--
Linaro LKFT
https://lkft.linaro.org
