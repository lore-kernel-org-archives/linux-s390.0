Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336682E03E3
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491832; cv=none; b=cz/QD48jOZVVe6IawfR2X575JXOw6tbnOqH99/GK4abGOdJ/ROnJKvCglY6fezRFXbA3jSE3Ev7K42DjWYuE8X5OdjAYfus7hBL0wAgY1s8ZRUhFOjxh/dl5/SlVMgZ4XlpoxSStmEb2voh48VO6PuJGj3tyz310UJq4QFBRuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491832; c=relaxed/simple;
	bh=FHR1vghh3/Ry94P21SXhw8smish6xFij+qwri1zqTjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V06RT2flijgOQ33wSUMNqxTU3HQnjETKvKUl3wYxykg242nHeUk0voXxUv4jzuaHGa401Li11gHxPTJXs+zdhuYCT8LU3JLEW9nSoPDapD1VSdbcBtBDWW7lVpC/QPKJVT4RocFEnVb7eywuwSclp4XvIrK2si7v71S0EKortnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIQ0xxrX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIQ0xxrX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cd413b4so2400435e9.2
        for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491827; x=1764096627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xelqTh0MJxdYizhebw3VTy7C2C4gWnDlrkViLNdgoU=;
        b=LIQ0xxrXQWQtmEb6OWHzz4PyETg0i3Uw21zC8mPfIRT7zfrT9WATNk/f5o5HFWqSw3
         GHZa+BEy2LfmeNkJ6Ghqu9WoGVm3+cqnzv+jIoUiy1hpcCJnFST3f9SdFwCimVJWpYpO
         nOYdofIi5m0ZJyu8Ci9mPqxbTLduex4Qv1vT0z23xsPBY1XA1YsY/aECC1lvl86KDILB
         jMV8gXDK5dGx0puOyOuAnZWQAjt294/94HSjMWYlLvmnjNh4Q3Dg+0VLRyYc/oJB4J0P
         /qwVF8RrWsNLKDUzz6fYvmYz20m81WCCyCmtDqOcVpwLWSjIKGtM4jjJmqS1q+ZSJgRe
         aPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491827; x=1764096627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xelqTh0MJxdYizhebw3VTy7C2C4gWnDlrkViLNdgoU=;
        b=Bn5uODOMAxDhQukJ4Iu1zawXg1PjNqQaSN0MvbTCP1FaLkKQGE9ExgoPX5nd1HeJx4
         b+VKeHvEAgMSPQxS7X8p7JlOlrugMGwcdsdV4wLmz7Na5LyHHWubVM9aXGh2oFA+UCUw
         dK3r83vXPK/CiQsqG4scIjlTrwXnozA61JaYtFrKToAsarle3JzTCr0ovsV2xiyrZcas
         HJlnkRsCt3X9poruc2hvFOdhoHSzd4MqujtDG0Ke+oeUi7o2Q9v1eteparkW6ucrXQNQ
         pvgMmU7S76oqY1kiBLJ+BBC3KJpEPs21QOVLJ8wEtYSpfSXS+WmrJnFrsIQUzfhMHg3u
         gjsw==
X-Forwarded-Encrypted: i=1; AJvYcCWuLi84umwbGaXsoq/fR0nZE8Z5UzLmKLz/fTAdeKsrqeFUx/Zw1PMMw6q/kjsD2H5EPRp9U2SdZegi@vger.kernel.org
X-Gm-Message-State: AOJu0YyEg3Qi8ytsvfwgDy2Of7dRRMLbC8/T73eXAPytWl7iIxpR2h1j
	vnNlEhTMhZjYa1TKKhFOuvKL4QxKhw0VPTDA35o0Up9UDL+MIXmpx0zH
X-Gm-Gg: ASbGncsCxeIs0A5e0cQ7sbrBkJCyty28RpzNZ37YBboPhch+bAgtF4zoeLh/2444hsW
	ZcwJguTvSAiVzeA2HVccAtgA3HRRDkGwwwcBDH/NoXa87r6DKCor9MYJ0tVAyN/RIPFdjzaC1nu
	2LcO7F56D8kU3c5ZZPZpR849zVt4BxLJImCO4F5xNI9rJ0P+bzTsYBjYmf00go1cD+2yfe5WQCO
	CbjqP+peS+Egxu7yBDQNUmwRD6GG27QvmOz2cUsQgy/pLYMg6nUf777qU2qt+0cu+Lqs8Tx2eVu
	iAgXHJ9hiYc7ogZa92/rN8gwhRStT1ystch+260LKPpPrkU30XFGs3Nl9QZoCzNMT895FlnNSQ0
	YpQHdpQ8oThqIZj1aW8W4Zz3qp9bqT80HW9KB4GeU5CwJMFfo+kp2dJ/lygIlEXhyvxmF8mfhZi
	gZwVwULFFTjp4R
X-Google-Smtp-Source: AGHT+IHx6i4VYWR6pSTcXtSoFlN4Y9U/3Z/PI54PVyQA5JnsfbBaJwpdM3LzkIBKtiuh5JtXbYxanA==
X-Received: by 2002:a05:600c:1547:b0:477:5c70:e14e with SMTP id 5b1f17b1804b1-4778feabadamr87966605e9.5.1763491827278;
        Tue, 18 Nov 2025 10:50:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:9ac1:9a91:7d1:a813])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9df99d3sm22110705e9.12.2025.11.18.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:50:23 -0800 (PST)
Date: Tue, 18 Nov 2025 20:50:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 14/21] net: dsa: sja1105: Switch to use %ptSp
Message-ID: <20251118185017.kk7binsumhh27n7x@skbuf>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-15-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-15-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Nov 13, 2025 at 03:32:28PM +0100, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

Thanks!

This is a rarely modified portion of the SJA1105 driver, and it doesn't
conflict with other changes that I have planned, so from my PoV there is
no problem with the patch being picked up via other trees.
