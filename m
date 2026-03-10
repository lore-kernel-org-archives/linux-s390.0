Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E723B0AE1
	for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148932; cv=none; b=s6m0KoEDgI+lwS7k5miblk1NcSMyrmacdwrhDE8LYyUVB3UyTFD3tEdaq7H1+7nKyKoqU5AgQhQl0AzKoJGP9/wWrfNSRNNvoqS83sCGUvuI/7oMfPa/CLKBmChMjC+Y+cdnSVyH2tsOIYcbJ36CCYY2NHrnn11s2Tb6602hANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148932; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrfGPWZ4vt+pehsXSyeT6hv9iLuvUkrzAHelV93QNbdblLT02tfzcDcW1dJJp5DJZ4wS2JRR2f6eM/CVy1da3iHdCgLnpvNhhIkjBQee44DunehxcRHyYvwa4HjV+b848EOIKAPqYeygc7R/RcysgiloUzgbFriRIgbN0OJhfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E51kNjIN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLhvlaPb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E51kNjIN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLhvlaPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=E51kNjIN4UKbGW9DyZ5aBLaeo/X1fN08TYjWYCgYq8Q8qw25+tZQtb5W5ajU6MN7BBBW11
	0YDBivfD6ObYrVaZ07AfmguXniohVg3EyJDviAgsAuscNKdssFGgICyGTgh1yznjOgNpE3
	ekU6IHdwiHFWZVShb4nqu/2AD28lhx4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-lZsCtYt7Pe6z37rbDyE8PA-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: lZsCtYt7Pe6z37rbDyE8PA-1
X-Mimecast-MFC-AGG-ID: lZsCtYt7Pe6z37rbDyE8PA_1773148925
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd773dd39bso2180670285a.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773148925; x=1773753725; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=DLhvlaPbwaSFQKg/FmxemLJJZifDd7cIIhpxvIrZaWROKjgqKnQK81zS2r/WSu9mvZ
         1x4TVLhhO06glvOYJXTBYTQHe1C/lCEECiyKmpprEGkSpnbhT/+Xy+wfN5x6paEUKxsd
         eleVUcWebznHZRscghpqRSurxi7A6fJyr8+SC/oFm4tth2mVEOc19JKZit9S00HY03E/
         XNzQnAGkguTRFL3rrkTJWt1Ev4Xq7DVoDTHr6r9kNjeVPxV8v11X5FGr4E58NddnvLYv
         QUA4HTbgZjVMx4thX/P6FGMyY+HUc/G2+EnczacjtLqtmfpojjqt59bZxWNPmXy2pn5x
         ulpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=NnCvKXFS+UKGdMI1hirf5Xmdpfx2mIAhFe5gm5o9vh5fvd+95cjlnY0wDuALYUNN5k
         Za1mwP53d3XjqUgQ27fdytO0po/H6NTWxW5gbcQ6Mj4uLFf3+QFpq1rw6btv1PihSN5J
         xVat6zFxntDwk+JxMxuaHV+5w7Tc1KUuVLhaFkbnUZVHPqDklYwRLYLQQIN/bSqbxPKI
         QvRfybNr5QzRKNgcEihFNjx3UnG21qrysPtB9DZKl2fQTaQlGPp0r7CHepvXU1s82Cx1
         toqY6aIn/49Rw83/rR44ksF+2lMoJihI2BwKxiJAaIBhcBFWjKrZNtMzsegViACCRmvy
         Vidw==
X-Forwarded-Encrypted: i=1; AJvYcCUJGutiddf4qY+E7hygfV/k1xNgRt9GP3rHKUy440J2IBGV879+kFpjb6lMAQ5NHnl9TkMq7Ji1bOZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyHY9lSknfl2bzKf2AaCN3KOLNHN0uum7rx5m03igPKd0BQOKnp
	Ikt5x3qEyE9lNSF35l2nRDB3VrYKtfbMd8DP//OxHP4YjkgE+7HAC0vL+uZGmA6ioM9udx7zgdi
	0VQD+p1nX3pbQ4y7NjsF5xr4orzskRER8ef7XdqexFbXRPJYY452wyN9keOInPQs=
X-Gm-Gg: ATEYQzz4uBdIPK+dRCWNq2Yr/ORnFVngnKE5kXeM5XMIS+wMGRCVXTIBCSNB+QNKcrF
	3IAAr1kBriojrvRqWo36GxnNgneXfMcLAKHaIM9fA9wgeZb2hWB38+r+ghmSODSVAecfCYxTtJt
	RzOGLT7X8VjkWcy7E7ZnUcb+W9enADtiuiZn0oB5IqFgLX/eF7joRVKxYxdsxcw95EwMg6wh+Uf
	yGXKIYLQVbBplgRTHYxBDXgogf56xgkNBnR1BZAClhskyQ0Bbm/iQlZBU3Zk1lAMMaDyg8twt4X
	qxOhQFNnHJBrLu4X30ZS2fvk1RGInyfpFS/zKLUtrgrqZzSDG7cPGejUsMctFMXTlZunfjArzn2
	JUZjyJZUZF6XStbtPyiNB7MUdEW0E1G/6U9CRWu9+yx6NGtmiCjJ69tqq
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830788385a.45.1773148924747;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

