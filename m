Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025404CE1B
	for <linux-s390@vger.kernel.org>; Mon, 12 Feb 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775721; cv=none; b=JtkC9Ahs/TEFKGg5qD54LTAAunH8DXGxxLktvYoIgjxLwS9iHULVUx/dmkee40ahNGm0T3719B+L36O6PO7NykdGbjb7OGCx4Vtzs3d7iafCVfK2nitJC1/RSSt9+xB3OW63D14ogkvr2tFXK+rzT8rgJj6EvsuNwgHcYFp67r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775721; c=relaxed/simple;
	bh=gAbe+DaZz7ho9Xs/O1+sZUd+Q7Ss16k+L7gT59qsNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reojTTSPfh38viniNbr6GMJ10HoK14c0NoGgZTVvvGzygJspAtx7lRtd/r1u1CS048CUiDZO0ZHPV+USrKJ1fvXPq8pJNVSfbSgYFlY4WLID2fUPsEKEi/w53xENuckcCmlBkAiUg7buYiohXytEu8gLoW9wpoMFrALnzW+wP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OE7iw01m; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OE7iw01m"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ce44c5ac0so77984966b.1
        for <linux-s390@vger.kernel.org>; Mon, 12 Feb 2024 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707775718; x=1708380518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=OE7iw01mM+UNVKV7tPw26UzWk0GCOcI9L1/UHaBJtkPpexJ4S5anS1aBjkm4pudYyi
         +sPDGWxKwyfNp1UeRcyAq45PVGIJVZHoLv1/ls6bFHAMSodyYJSaKORpqLq0VKXIa3WR
         x+beghz/s2pUUz90ZxMrK0zXByVAY3e6tWlUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775718; x=1708380518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=KALFdkAsbNiAU1bGBZICwTQiPtYgz/QseffT4YUH10POVmX/8z9rECHHnp7X4Q3ja5
         gAsyjhu5LP/O/0sWWoFl5HDgp08Ekq8UCoap5XpZ//d+DDrwBF7m6BTaXFB0hhRwALiO
         J/bIemxVCux3tahNGmBtXIgBW4D/FB3CRrpqNb+6n5MUOBQfBCFcuOAS1uuUNMwVrOAU
         PcCFa4zeRZfl9uRvLZZhjTucaBulmXqIsI94lBPDVBaRzsZ8HNgLbBQKOx1dL8l/gTSX
         ohm65led/VW0e/dkwoqEYyvyNkaYsGGrACrdMvWxKezgFUy1LPGB6Ahx1Z19seHVxdJy
         NkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi00wvhAy1yfqwRBMDLTKYAFY9IwAaGNHR4X0926J5SBXg7fk+sW2mv7fsf6AXa+NwkNobfeFdZ544QNC8KnFu1XNFtp3hrY0MSA==
X-Gm-Message-State: AOJu0YxIDdPwIqweFbWALNhpB4ocHrYyCo5FcHsgryY/UivOZb4jlrQZ
	72j1nmKE3itdap7WrBwgYWgCJQMwmvau0bKCSCFhnIoh4qZ/AJj9Cau6RGvp7dEQGN6pEKGK+BJ
	g
X-Google-Smtp-Source: AGHT+IHQ2nqpPIp+vCPtLIt6kLwVtBd9XofHqVR8DbG10+bzjHPNzK0jxCEzpig5vUH4OeHPXs1y9Q==
X-Received: by 2002:a17:906:1d1b:b0:a3c:ea64:5559 with SMTP id n27-20020a1709061d1b00b00a3cea645559mr807489ejh.34.1707775718210;
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmWDOyJBoWkjdZN5siIiL7weFNdUBbeAm+w9Qiz+S1F5Wtmf4Xj1dV+WuCbutRYYp7GXSGz1esQTmSAw8nW0eKqOiPXPSYhHcC+A==
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id ps9-20020a170906bf4900b00a3cdd35688fsm557986ejb.80.2024.02.12.14.08.37
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-561519f8698so4073702a12.0
        for <linux-s390@vger.kernel.org>; Mon, 12 Feb 2024 14:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoFQGOdw60j5VXICJYOz2wRRDL+vls4m8v0TxVUded6iFlRSKLPhfb6qeeNUt/cCjajkhprL1LzXV8xUmLmYxiboLjX60anvWJIw==
X-Received: by 2002:aa7:cd66:0:b0:561:f173:6611 with SMTP id
 ca6-20020aa7cd66000000b00561f1736611mr60172edb.35.1707775717604; Mon, 12 Feb
 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com> <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2024 14:08:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:04, Dan Williams <dan.j.williams@intel.com> wrote:
>
> This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
> and put_dax()", know how to handle a NULL @dax_dev. It is still early
> days with the "cleanup" helpers, but I wonder if anyone else cares that
> the DEFINE_FREE() above does not check for NULL?

Well, the main reason for DEFINE_FREE() to check for NULL is not
correctness, but code generation. See the comment about kfree() in
<linux/cleanup.h>:

 * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
 * kfree() is fine to be called with a NULL value. This is on purpose. This way
 * the compiler sees the end of our alloc_obj() function as [...]

with the full explanation there.

Now, whether the code wants to actually use the cleanup() helpers for
a single use-case is debatable.

But yes, if it does, I suspect it should use !IS_ERR_OR_NULL(ptr).

            Linus
