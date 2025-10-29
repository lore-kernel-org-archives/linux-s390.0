Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F22ED869
	for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707037; cv=none; b=BFLSmuKpxAUwJ6k5awcDpaioRC7WL8zmTyUEMzcRl0Oby6d4myarjs4znNCAhMoiSpuKldZc8alTReFuqulAXN1IBPYCJTPEn9ytbk43epd8KlFUn3smQ1lypiAyIMXQrxJcN7T2dnm182u8FdhicJxUQsdjP5kwR78+kkmHAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707037; c=relaxed/simple;
	bh=/Qk8PMHP4+FapWuHqJbINkiDONl0t8szjkv4nlvTxXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYH3sq41KugOLFNm/a1LCSnFBY58ly8M/0BY35dBzdNrkJ9SOjQOKWiUyKp51/kL1uy2tOuIPdO7zaI1U0hTHASO9dg90CZQSjB0JwlR761HFEgxZQAq+8NTscB7YXj7cZ/6o94NqRo4I3L9r/EZQFkt/SGf5oEyI7Z2Nd3latg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2CN8BPn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2CN8BPn"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ecf2244f58so28279271cf.3
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761707034; x=1762311834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5IcEnHZoC7+7r2CTBEYXEkgFoGQnDrtNgYAFEBdR6Q=;
        b=k2CN8BPnZA5PIAhjCeAcHZI+JZM5bK5bv85xzYnF55BjdvTapbyFuVhnfr/vcUnd/X
         ZgUFH32QVt066a0thd8NpUgAAZMN1risuCUEJ5VsdbEDMp8TKIofZo4PPSH9QfixHd91
         BONbg8y1nPIpKmLY14sTes38+T4LAcT3RmRfT8hDDNGpk4j/MWGN/pzfEVp/Q5vHK/gP
         dNR32vCq+ZtyRG9uftR89Z8MMAQsPohK/iH0pQMTjvVSRmubff+f5+lVrQ/fHXQ6UQ8o
         OGuNwmxplbDUj4kapyK1G3FthOyyB+OySriAwUCT84r/fTOUXyAjcz+387TdqBQhid87
         qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761707034; x=1762311834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5IcEnHZoC7+7r2CTBEYXEkgFoGQnDrtNgYAFEBdR6Q=;
        b=KcArKi/v9JQi6OtwFj/UYTydOa2bcVijkj9cmQ0AB/drUIGiHJliropfJ8kwY/L2u5
         t8UZbuDJr9lR8ARO0MSpkJE/cdDN33XRx72wZiAhds7dHUzJreCujVcmVIoy4RDmFn0v
         MZCKFFl6EyB97psp8kwsMvUQVDnAxsPbmnEer2GiZhBeBaEwvIlsJm+ME6VSUBwZxoEu
         9FHNGZyDX2MaIV5+nPCLe99LiK6fP8D9p4MtoPiAcB3j+3xtDFxBq9ejNcb6s+22CIVX
         f8u9OQdXhUMybEz8uFKkdlaQHdci8CxqU7Rg+XNgVGMwNdXtFeDV0fdD4mHMAti7cWDN
         icyQ==
X-Gm-Message-State: AOJu0YxIgluqN/L7WDmQv56+BtwGs88IgCM2ul/VtIQvjMYYrRW1DCAM
	2xq01upGQNoCYd8n0Sj8o/iQDF5rlYtcl23XISPBB+dHdUhN+lhTI5WF
X-Gm-Gg: ASbGncu2hFWhs+ERWJqaXrlLJOkIjy8FswxK+tWA+nrwOgjpArTKufdqbo+sVxEbwLV
	PwnF+v96syIV1AYjSIG6AbcXgt3CjT6xqdoE8KkabkP4Pm2Ges9es3h4iXNrfY10oK45HDt9Lnu
	aE0xCWB9kJKDZoCnr/S8m/ZxXZ96yrnATswEsixQO62UGcXm8s87viz7/YVGVPN/0WanlOU/tYx
	u30JhHu2xH2WYpMqxIJQngF8ISLHm28bQbVg5cU3hLtAbTn6clRQzGVwZvbuiW3MbMOOpGm+ZaO
	0iVJijY/bGTmLUhY+eBN0VaKQNEUYSdNVT1XDv6+KBkPeKRX7vlFDDJH+2k35GVVMbCQRl+ND3/
	Me6yGQXRC4R8UxChS0otMONjgBMydmOW6lRpNjrUhK6mlnrdPr2cxZU4ZpaxAemt01N6SWgtvvE
	s=
X-Google-Smtp-Source: AGHT+IGn2yY7zgfs78ubfoXvJ06VhUkyVxJ/ldXNh2L/51YFEepFFBNff1jL42/SFQQHpekm3bsxHw==
X-Received: by 2002:a05:622a:1105:b0:4eb:7807:1816 with SMTP id d75a77b69052e-4ed15b5ab08mr18021921cf.35.1761707034388;
        Tue, 28 Oct 2025 20:03:54 -0700 (PDT)
Received: from sam-fedora ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a6461sm1001074485a.30.2025.10.28.20.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:03:53 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:03:50 -0400
From: Samuel Kayode <samkay014@gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Samuel Kayode <samkay014@gmail.com>,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Lee Jones <lee@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: next-20251027: s390: pf1550-onkey.c:154:12: error:
 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
Message-ID: <aQGEFr9aXB69_Eei@sam-fedora>
References: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>

Hi,

fix is at
https://lore.kernel.org/r/20251028-pf1550-v1-1-c50fae56b9b1@gmail.com

Thanks for reporting
Sam

On Mon, Oct 27, 2025 at 02:26:37PM +0530, Naresh Kamboju wrote:
> The following S390 allyesconfig build regressions noticed on the
> Linux next-20251027 tag with gcc-14.
> 
> * S390, build
>   - gcc-14-allyesconfig
> 
> First seen on next-20251027
> Good: next-20251024
> Bad: next-20251027
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Build regression: next-20251027: pf1550-onkey.c:154:12: error:
> 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build error
> drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume'
> defined but not used [-Werror=unused-function]
>   154 | static int pf1550_onkey_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
> drivers/input/misc/pf1550-onkey.c:133:12: error:
> 'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
>   133 | static int pf1550_onkey_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [/builds/linux/scripts/Makefile.build:287:
> drivers/input/misc/pf1550-onkey.o] Error 1
> 
> 
> ## Source
> * Kernel version: 6.18.0-rc2-next-20251027
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20251027
> * Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> * Architectures: S390
> * Toolchains: gcc-14
> * Kconfigs: allyesconfig
> 
> ## Build
> * Test log:  https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/build.log
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20251027/log-parser-build-kernel/gcc-compiler-_drivers_input_misc_pf-onkey_c_error_pf_onkey_resume_defined_but_not_used/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/config
> 
> --
> Linaro LKFT
