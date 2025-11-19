Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF287358D37
	for <linux-s390@vger.kernel.org>; Wed, 19 Nov 2025 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557882; cv=none; b=thaTqNEMvdEgVdeFqEY6qVvgJL1MXhHGsUlSL1Kp3g4gDA4rVAo3RLkoOHwKJO+XHm+BeY2H2ZgA0IMz6hI8SqpmcS9KtF5OrlroDO2o7C58oWz/ahlMRWryPZFrIvTW6gjettyAyhVFfwcfUyxcLyMBAKAV4EjMCVqyFDW5aJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557882; c=relaxed/simple;
	bh=sJLZgI9vl/ePXAMiM1HFoKkY761fjwT9P7fNtQPrjMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5hqt9yxKXrwE8qNZHS99MPimba+VzMML6GPP6I+nS/w6ATMeKWc+1ZjA2OmJXppelbOYHyqepr0RstfE0+S8Ay47HpgOHwnEnokZiIp9pdpmKCO/fqRzjUpqWg6B189cqqw6Mh7D9b0vAd1HD29Yw/VapK4tNHPmZVCpBs4eLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DQJFkS9T; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DQJFkS9T"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so11173577a12.3
        for <linux-s390@vger.kernel.org>; Wed, 19 Nov 2025 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763557878; x=1764162678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hIjgqXWXn3Sbfto+9OWapsp1QwhUBtS+kZIjBq+Tlw=;
        b=DQJFkS9TfIkIw04m01xXMLNrkosYb3FSrkUd1Mfnq3DmFPVYW5BQAF/kJ7qBH/fiSm
         pVnVkcfKZlPcHTsyEwqHQR67eAr7CHq57OGD53huuAi4hSCw/ct6edPOGR+fsY5nGz/N
         Yw1ooyFk/+rMnBQZngJcf6t2sX9N66HB8FZQS71x9KKl/6xkzHkV8uFKm2Iy/9fAm8Ag
         I22CiD+iqPZDy+W/I0Ox3Jki6uwZV0vfVWc6IvJTegJWTzKaS6FEi0EnBDDhgSnIfI+y
         k4OP4x8AdsPKrFrvmXhICnjEUtirKTXsrSbTk6Wz8fF+OXFqP7Hrg3yvNq2+bPjQ4kUM
         Gqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763557878; x=1764162678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hIjgqXWXn3Sbfto+9OWapsp1QwhUBtS+kZIjBq+Tlw=;
        b=ADUylXevHwLzx979z/cfEbojvXdvGWJG3FmGaK/DM50oP+4f7w74YZqMJuB/i1thJg
         PXIOkZM/IAh7ZsoKRPb1xeav97p7JXuBzywIO+uwY963IUeG0Jhe13o3/sFOeukYskAT
         3/CL6fSLsRjmrbntQHg+NWFI0UX4YeuJiu5CSG1FPgYKdP3JYW564NTi/3g4ubxHABmH
         pQZdzNUSoibDjM8AZhUvbySnyBLS1qhOiJ1GCchs8W7X8Sok337PjZH4IAsOBj3brFSy
         mudlMv7t7bp+OaEY7f5ZS05T4v6/KmowWWF3IsTG0RWWjGnD6rga2qmiIkKzNCqUkxJQ
         uaFg==
X-Forwarded-Encrypted: i=1; AJvYcCWdOEEtYtUmhLS5JDBl2cqxA7qVGXHsBiMApdxDMMgPZrjYzV19rYsurWbnEVRLnXFPsnkjEdwyGKeh@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXWmIUKHAa4NujlJWxrft2ZqlXoMVc3ep+0qKXN/YPFBWdAh9
	367Eesd2DAQQeXaFSOoHY5h+xX1gpSS2WLnurgg2M26xULHz7Ds6mFlKLiJ22rwuL5E=
X-Gm-Gg: ASbGncu3UQqNDE3XtTj/jXJBNG6kIKN2wXJ4kHiehL3dcvXYTHKPz4fp25s1aLrcyAg
	HlcL2651bX2LQdcwjwXY6aPGIu1w2hNB17nBH4nTEWTzkcZHVKP1h7V1iM7UZv34mhCcsqsvR/Z
	VGIdL13KQunqR4eZRdjxxFou517V4z6U4tsuDeEvoYuIDdNq0jQfEb7EaeDNtFEV9/B2jtMEpbU
	XOFeKZUZnVWJrWwXEL6JGW6lJpGj9myxyJkP/iIlgKv04KCnk6H2q+isH145eXSbSe7b1INrCj0
	NhhczszMXRhegnO8nWjlGjDfjPonO9B9UfkIfPki6zXt05p6cWb/xsrWynVCqe7Y6BuSTs1dhou
	Umcqcrkr9SP2FhMPa9U5LUk+fCVk1OkWtt9SeLAwx6zYQ9PBoBgspscOiik0arNm7VyuKsc1MnA
	/JjvXYgz0ym4+rpg==
X-Google-Smtp-Source: AGHT+IHh/9HSY9QxYY7JWRlsHkQE77dEey/TQadLHho4kIFH9l0Cnuj5X98H1aD+vZkw9c2t87Tcgg==
X-Received: by 2002:a17:907:96a7:b0:b6d:50f7:a805 with SMTP id a640c23a62f3a-b7367c02586mr2099815666b.59.1763557878059;
        Wed, 19 Nov 2025 05:11:18 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d8775sm15093392a12.5.2025.11.19.05.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:11:17 -0800 (PST)
Date: Wed, 19 Nov 2025 14:11:12 +0100
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
Subject: Re: [PATCH v3 00/21] treewide: Introduce %ptS for struct timespec64
 and convert users
Message-ID: <aR3B8ECx9W6F0BV_@pathway.suse.cz>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>

On Thu 2025-11-13 15:32:14, Andy Shevchenko wrote:
> Here is the third part of the unification time printing in the kernel.
> This time for struct timespec64. The first patch brings a support
> into printf() implementation (test cases and documentation update
> included) followed by the treewide conversion of the current users.
> 
> Petr, we got like more than a half being Acked, I think if you are okay
> with this, the patches that have been tagged can be applied.
> 
> Note, not everything was compile-tested. Kunit test has been passed, though.

JFYI, the patchset has been committed into printk/linux.git,
branch for-6.19-vsprintf-timespec64.

Note, that I have:

   + fixed the 19th patch as proposed, see
     https://lore.kernel.org/all/aR2XAYWTEgMZu_Mx@pathway.suse.cz/

   + reviewed all patches but I triple checked 7th patch which
     did not have any ack yet. And I added my Reviewed-by tag
     there. ;-)

   + I tried build with allyesconfig. It succeeded. I am not 100%
     sure that it built all modified sources but...

Best Regards,
Petr
