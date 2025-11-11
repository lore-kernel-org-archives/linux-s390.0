Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882602F744C
	for <linux-s390@vger.kernel.org>; Tue, 11 Nov 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871852; cv=none; b=mxl6WxZF50kMC9/O0/+KSk1vF6fw+/ncgmPOeE5P6b9VH3qfVwOzIjtoz21TUqkisb/12BSq8MNIJpPLRG9KbcxADjdCcL6ipLuLJ2Dc/r2SbR6S1Hf67YlyE/QN8fFK+XenQfz2Sn1zURJwEh1VT90C+5wmTu7CORk70tqAvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871852; c=relaxed/simple;
	bh=4vsDOO5vSHCFgZxshezv4v4YKIlkh5M/Jf9eZEgWohI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHdAW0PZGXNh61VaFA/dC97mF3O3iUEwoBPvxwa9Pu9dR6sBXOSYAkd/ssn0BAh0/GttraEPcBASEwkcjzYNkIslZTSKmzV5fuounWrlZmcj7SHd6RP/o49AgmZI5oC/eicwcNsV7MXTpa59TuL0L8Pft8yGSMvPoIcaplVutmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=nf5ZZwQg; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="nf5ZZwQg"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-3e2fc677775so3397686fac.3
        for <linux-s390@vger.kernel.org>; Tue, 11 Nov 2025 06:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1762871850; x=1763476650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI/Bx88S/ljGSNn+PL5Rjkz6jNPZ9Ne5hLvzfkx+saI=;
        b=nf5ZZwQgaY1zLdL4pBWkWIkCxgeavzFny7z9nCd+70x0/+edfWo547ejcgVwd+AjVk
         Nm/N2bIMZIPzvuJpykEtRNRNYYTpzq/8+zvvZrGCutQwZHYJGBwUEdFys6shKFJP2PlJ
         MXRxtr3p9X8mXtAgiwSC9Xkf7CWGj/WrLr42e7vTQhsiHTz9mQyAFngTtw4IMu/YpVaG
         X06HrUQYw92Z/2BkwIHClLKwXkgVZZoUI10xP2vIQDFnbDL2oDLEuJ1TrEjfkL9p9DyG
         GkiYjWTJcF96L5sJv1jpo46p9JoR3G6Jteg+NUHurHMbVf4OGUPeIwNteBGmsJ+3gL27
         pWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871850; x=1763476650;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sI/Bx88S/ljGSNn+PL5Rjkz6jNPZ9Ne5hLvzfkx+saI=;
        b=L7pUh0IVW2WKY5cicMsxojSLBTRF2K81B8xehI+eK73NO8SNbXZQfIZEoE1Nybioyg
         urzgt1lPCkZfsGn3hJp7Eq1evDDUwLSS88xKofGzzBBqXm8jmKCTrfHE2F9VjCwPNWyi
         vFzVm+Ock0ZrzORvWY3TqX8L0XdUmsf1sWqGRq/fqrICLMQioYvHRoIsSucyU8D+O1kI
         E0Te9L3HEQF5PTycncW7ewuqKBcJqdV/BEbfFdJWolk5jvWTCJRpZPut2vzUChsfQsc+
         vgaeXQ9FdwmgiqGJHQeXrLBAAXhgYWiKQbGHS3iD4XFAfJafAVdEcQy9RV2bzvOHt3AF
         Tx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvkke0TsVM1TFbG8EEi7+4+Pl63d/EuDAvLTxYb8BAQbUI9Cl9bzs8WEco3RuZHkjEyOIAwceYSV/0@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd5smVjgEkB1Jc7Rjnh7onat/O1mWDuf9eJOBXOzz3B5EINTP
	wXTWTAvK8aLIxpYEWq3jxmSCxrMMVLslgwvWQuyiKKA/rZ9vsw3DvYbkycbs0L2LFIc=
X-Gm-Gg: ASbGnctaxfWByYsYn2ghGUc7vjkBCXN3d+y5G3VOsdc8b+SMOz3QhiLoUAa+AhAksVh
	vCGCyl3xWEvJF+/AHkQE29QdqAjN8TvWo9TTZRod3m9neHnJ4yYrnsI9ToCQnqUriDwXG3GM3MI
	1BGySyKbeabgWsbT98/fsIOseuhXKz5FCkQ4hxj/hUDUZ/8EHxdvYDT2tLFwVAA55Nub6wPwT4B
	I0W9rNEITWcXFKyafCrNrf00VskkVSVvANeu5RzWOq+ozf6Ctx0jJsqxEy2w5heqdYF09EiZCsa
	rhDi4TfDcAHLAzQynR6Fvvi41b6gr7T9mNVmxVBIIkeym8Nz7lJeFLRfBEoLwGp8yZ7DJ+lHc/j
	pOlAV/G2zVV4ab5yXkn3CbUYKC9GcvBw2CGTNHljFjgqWhQng1i434QLN0UqVUhXfF+LWbJr+lx
	Sd4Dk=
X-Google-Smtp-Source: AGHT+IFusuA/Ax3anjd0HIltuToxJUS02/udclYoHdoDI29Kk3VNxq4/rhyMyYWudQr5f0WcO3jkBQ==
X-Received: by 2002:a05:6870:4792:b0:3e7:f4a9:588b with SMTP id 586e51a60fabf-3e7f4a9b0bcmr4110818fac.15.1762871849590;
        Tue, 11 Nov 2025 06:37:29 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:b4e9:19a3:cdaf:7174])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e7d6f7a27dsm4861066fac.0.2025.11.11.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:37:29 -0800 (PST)
Date: Tue, 11 Nov 2025 08:37:24 -0600
From: Corey Minyard <corey@minyard.net>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian K??nig <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Takashi Iwai <tiwai@suse.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
	Thomas Hellstr??m <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 12/23] ipmi: Switch to use %ptSp
Message-ID: <aRNKJIyk2ne39ScE@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
 <20251110184727.666591-13-andriy.shevchenko@linux.intel.com>
 <pvjnjwm25ogu7khrpg5ttxylwnxazwxxb4jpvxhw7ysvqzkkpa@ucekjrrppaqm>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pvjnjwm25ogu7khrpg5ttxylwnxazwxxb4jpvxhw7ysvqzkkpa@ucekjrrppaqm>

On Tue, Nov 11, 2025 at 05:08:25PM +0900, Sergey Senozhatsky wrote:
> On (25/11/10 19:40), Andy Shevchenko wrote:
> [..]
> > +	dev_dbg(smi_info->io.dev, "**%s: %ptSp\n", msg, &t);
> 
> Strictly speaking, this is not exactly equivalent to %lld.%9.9ld
> or %lld.%6.6ld but I don't know if that's of any importance.
> 

Dang it, I'm traveling and used the wrong way to send the previous response.
Sorry.

Anyway, yes, it's not equivalent, but it's not important.  It's better
to use a standard output format.  Thanks for pointing this out.

Thanks,

-corey
