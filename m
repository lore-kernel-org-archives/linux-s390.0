Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52C13E029;
	Fri, 17 May 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967401; cv=none; b=T4IS1g3IRYuTzbdmrEufPJZuoJ5reX6Bv1lyJ4CHufe3+GV3xKNr17VnaEpQB9Rl1Ez7ntxYb+1yAJWlyRgE8e3Su02aoEMzjORWqOBmzvQUc8rFe2++D/2SVw9CWiAzm1Tl938CAe9E0ntgib1o6hx5sOhSZoUGRkw9ZuygL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967401; c=relaxed/simple;
	bh=l7K75G8hEZf6Nf3Gd+zb5LouEwarRLauIdJPMoFivlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHDU2a+DAWtPRcmt4C6PNdPbseXKcMelAX2wzvQMYCRqxHPakEdRVvQff3WPguwpodBLpV7fPbdCvZ94NfW0WSvQDuc0Gmbi/M37I2hQcmH6pFp7wlAmn5n+co7hQSDkGkpVMKwa0McBxDQvO/xYNevxFiLG7sf4OWnflrwmeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emn3CkST; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emn3CkST"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee954e0aa6so16680775ad.3;
        Fri, 17 May 2024 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715967399; x=1716572199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzMfxbAB8QJEcJdIySGROcUOqAKXWq8nqUdcExbi1Zk=;
        b=emn3CkSTmGwb7Ev6REZ9Z3U3XD4Y+jPjdTTKRrd1xunPWgI+cGM6iP3TELOI5V8ATa
         VbiGe+xcAirEDS5iorMu2B+VEBPivgYYBJAFyyk/dtcE+BdDAEcBR/OSDeMAia+M02aV
         JtJr53ZjOlMBaf51DPBBJSXIlVEj8/ta7pTQaBfTGVSwemtnu9tMYnJUuHNl2FkBsWa2
         RY29x4C0oql3h5xd/BScqyiM9KMAjCxcwhA5cszmGMdkeAyAQyWwOl4SEGtmK+Cfk17e
         ZUmUwjzXpEuOreMImVvNFBtQTMD0YnZzxGLGWYMvA88gK3n/MpOcCwIl6WzZ4yooz3JS
         JzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967399; x=1716572199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzMfxbAB8QJEcJdIySGROcUOqAKXWq8nqUdcExbi1Zk=;
        b=MrNdspnRzs6wswQasFHCGH1isVXgSh47AgAas1KOR1HJ37y7pyX+VhQOn5W/Sqc8r2
         sBwHZjWgIz2tKGiGBxzg0QIOpfRh78AHa19wX0DgouoyxInE4/jS8aL9WdOOUpUw5RI+
         Wazk5pIw7oaWUKFmiDU7zgiPTeBQ/mVAm1C+XUw6DxHiYVZB3tcBjTuWS0Vl2YS13jsF
         r9dSFnFKPMBQgHVWkNCMJN/eKvgeZfg+8HT6+ytZEaJh+rg7M1kz4LQwq8RLlsT9tKWz
         SF6OFaZB2LO6UjpmaYzZakTXpW1u8ZqWmOPvnxZ7QjRYW8+e9DYBwGX0XQ6/FrrIA2YH
         6Zaw==
X-Forwarded-Encrypted: i=1; AJvYcCUpY4pFWFoJyRNNd2rLbMD0AVElLJ3QJSligMRHlxWCsVZ8D1lOOShD7fdcOiz3RFwf67KuOqkW4pCvipNPIpeHB9GvSb+RRrr4CUsFcM5RHSUDLRohSTWA4VCpgT+agyK+c59f10w=
X-Gm-Message-State: AOJu0YyoRFukPdCLwqeLaH5ALk7mceSxAra78GKryXuEWNqhGetbjVGd
	xfxKazuxY7w2+NwfPj2W5xs58YDvV2FkTfvrcM/QTg0JzQUbXhkl
X-Google-Smtp-Source: AGHT+IHJ9PZtASiLb9HJkYrHy1DRhdQlVEuKbRr0NYIRv4Tx+av91BIA0wx1gBcIQQlm9sd2COIQnQ==
X-Received: by 2002:a17:90a:9606:b0:2b9:a299:928e with SMTP id 98e67ed59e1d1-2b9a29994c9mr10436893a91.24.1715967398710;
        Fri, 17 May 2024 10:36:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67105666csm15749258a91.8.2024.05.17.10.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:36:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 May 2024 10:36:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org, linux-pm@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	linux-usb@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-edac@vger.kernel.org, selinux@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-hwmon@vger.kernel.org,
	io-uring@vger.kernel.org, linux-sound@vger.kernel.org,
	bpf@vger.kernel.org, linux-wpan@vger.kernel.org,
	dev@openvswitch.org, linux-s390@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] tracing/treewide: Remove second parameter of
 __assign_str()
Message-ID: <5080f4c5-e0b3-4c2e-9732-f673d7e6ca66@roeck-us.net>
References: <20240516133454.681ba6a0@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516133454.681ba6a0@rorschach.local.home>

On Thu, May 16, 2024 at 01:34:54PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> [
>    This is a treewide change. I will likely re-create this patch again in
>    the second week of the merge window of v6.10 and submit it then. Hoping
>    to keep the conflicts that it will cause to a minimum.
> ]
> 
> With the rework of how the __string() handles dynamic strings where it
> saves off the source string in field in the helper structure[1], the
> assignment of that value to the trace event field is stored in the helper
> value and does not need to be passed in again.
> 
> This means that with:
> 
>   __string(field, mystring)
> 
> Which use to be assigned with __assign_str(field, mystring), no longer
> needs the second parameter and it is unused. With this, __assign_str()
> will now only get a single parameter.
> 
> There's over 700 users of __assign_str() and because coccinelle does not
> handle the TRACE_EVENT() macro I ended up using the following sed script:
> 
>   git grep -l __assign_str | while read a ; do
>       sed -e 's/\(__assign_str([^,]*[^ ,]\) *,[^;]*/\1)/' $a > /tmp/test-file;
>       mv /tmp/test-file $a;
>   done
> 
> I then searched for __assign_str() that did not end with ';' as those
> were multi line assignments that the sed script above would fail to catch.
> 

Building csky:allmodconfig (and others) ... failed
--------------
Error log:
In file included from include/trace/trace_events.h:419,
                 from include/trace/define_trace.h:102,
                 from drivers/cxl/core/trace.h:737,
                 from drivers/cxl/core/trace.c:8:
drivers/cxl/core/./trace.h:383:1: error: macro "__assign_str" passed 2 arguments, but takes just 1

This is with the patch applied on top of v6.9-8410-gff2632d7d08e.
So far that seems to be the only build failure.
Introduced with commit 6aec00139d3a8 ("cxl/core: Add region info to
cxl_general_media and cxl_dram events"). Guess we'll see more of those
towards the end of the commit window.

Guenter
