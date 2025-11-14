Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39001243964
	for <linux-s390@vger.kernel.org>; Fri, 14 Nov 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125188; cv=none; b=dwNhbleGKOGKpMxdu5Wgr2crph1LpSlATEgnetKnsWKv7g+uTYs2vBp+phAK+YoI/LYzkl9t+8SE3F7cfhbJbIOFGso0QpR/v4sp5zH80yuSwjqvHHKORhS5uGtscK5/hW6Y7wduqsQlKy27KUasqNC9YdK81K4uefv2EJD5anE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125188; c=relaxed/simple;
	bh=OwXqaVYjP+AYjhrqdV/iUf65lNBgi6i65jcAVuzkims=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQd+XvAAn0Cz5i6vGb9Rq2EeTYa25pTrXN8uznBLdS5VoOYnI+SIFWwAe53eS9b56/G866JcD909VuVxqE9dkd7RBp3A9H3hKh0rv1MMBp97l/PRiqskgsBj8J632ku1fWfFWQvV46H4Ba2bUViJSoWfMo5FBjmQ8n/CTHgp9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BEEVeqKU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BEEVeqKU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b714b1290aeso292128966b.2
        for <linux-s390@vger.kernel.org>; Fri, 14 Nov 2025 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763125184; x=1763729984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIa30kEZfIOzXn6c2Ch+jzSexECrPYWXzGffwwy3r9Q=;
        b=BEEVeqKU0DaPcg3ffks4FVzqHARQy52xUis9U9HCXBvEnYbMo2F+8p+XGBwm6d4/SZ
         O50qx26SAnPb3tX4yamSnUGg3oI7/1HYSChJPYejELSZHffLHG3hrQX8RPYX6ORd96Bg
         uqfi+rN2aPopDhac6XJeevuFHjkKMIdfwhM2HG8FIA1b0lnLB+Y1Gj6Zjr9IKjiwBKsX
         yIjO480IUbE2354PVJxnrT53++hosP/I2JwAM4ZYW/+r0CRuxdTJip7Lr5nu5OHGv5o/
         1NiW6PtdA8j7L5K2378DtwW0M/mRZ+6Hk6FWKkpdTrB4HKr7MggREWlJ94VznlfctGik
         J9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125184; x=1763729984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIa30kEZfIOzXn6c2Ch+jzSexECrPYWXzGffwwy3r9Q=;
        b=xJhnZipeUgD2KVotw0rKCoWia8SceTYDGyPPfoQspahyecGkWMd9v3JZ/Uig6Si1wF
         wmPjGFwTK5nm7j0I/zCguF+sgDTdPre+t9HdBDsgd5kmp1d29jxiL8v1l4zIKty0i0Ge
         101C0NNV/I+0Yr9uco1otzr1TbCDteRSHYXtOi7OXDTkKYo/8FFTxNyZ3kSqVOYXlJuh
         bhCqJ8T6WZOcBJvc2mqQXSccwh/I6mCCL7Fc8338OJvZoiHpLpkHsGKWsqkKjwt18M+g
         kRR2ym0m0uBfRZ+pLJlLCVTjZjwdPrto6VU1Zavpq7XOgJqShamTURLyw4TEs2TT0lo9
         75hw==
X-Forwarded-Encrypted: i=1; AJvYcCWTSFfOddqFgMf9FYUZ/SQ8o5/U5CbHTHzoZvinfZmZ7Gu/BeBQNxdoQbx1Llj7yXzfD0xmZ4wk8y2M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0QLYW48/K3mgwDP+fZQcCSYEkIMFyiqGDAwpD10STldm4lnsY
	L/Nj8CJAr9QXs/eTf7W+Pow5zpKjqJMsPqIOTlSXBTHnwqs7v6c+V/Egu9XnNdQ7F4g=
X-Gm-Gg: ASbGnctOLEtkr/MlQCnoyHa4YTpwjmlGq8XU3RRenaaxL0/dRLH0gQwBob+6zJrU1HH
	BzvpcmIOQ61uuVfcaN/MYV24uhJR7c/utbfw7oEgqBBCu52RtGpl6yexj5D/B8LkT/PO/2cZ6P3
	7+M1l3iJoJ8JWG+2W1EIMIRWJXYedSI1SysXylVp/n+gdttG/uxWw1YWVwblZ3Ov9YMyVuHGiRM
	fD0bTBPP9uhyHTkY8Im4BchUoqVeCDUlnJrKP0yGMcCQDAfNaPP/6h8mbZNs9vO6+75Ew90nB24
	DfK6sRZH0aYmoy02z2UQT/PMwXB+TadnFv60IgmwfVChzW4TCmYoD4dNBnyi6R4Srk7InKTP9Bt
	mWlq9xW43IDRL2SguG3DBy1z2AANzJzKXQAJxVLMn14ZaUJoZW+0fLnLtc88vrjX9dV2j0LXH44
	sjZuU=
X-Google-Smtp-Source: AGHT+IH6H5eoyoDiGCawX8hcyfAIsFqjcgfKx5GqQ3M5ZUeRqB23EXgoQaPPEhXoJ1r2rQPfP0tLQA==
X-Received: by 2002:a17:906:f105:b0:b73:7652:ef9e with SMTP id a640c23a62f3a-b737652f76bmr38125366b.55.1763125183501;
        Fri, 14 Nov 2025 04:59:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm382714666b.37.2025.11.14.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:59:42 -0800 (PST)
Date: Fri, 14 Nov 2025 13:59:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
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
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 01/21] lib/vsprintf: Add specifier for printing struct
 timespec64
Message-ID: <aRcnug35DOZ3IGNi@pathway.suse.cz>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>

On Thu 2025-11-13 15:32:15, Andy Shevchenko wrote:
> A handful drivers want to print a content of the struct timespec64
> in a format of %lld:%09ld. In order to make their lives easier, add
> the respecting specifier directly to the printf() implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks goor to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I wonder how to move forward. I could take the whole patchset via
printk tree. There is no conflict with linux-next at the moment.

It seems that only 3 patches haven't got any ack yet. I am going
to wait for more feedback and push it later the following week
(Wednesday or so) unless anyone complains.

Best Regards,
Petr
