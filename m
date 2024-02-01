Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42555B669
	for <linux-s390@vger.kernel.org>; Thu,  1 Feb 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795734; cv=none; b=V01e6e/J2GMMZNWEieOE+iqphU+cLqiTM/gTsfCA+7pp8V9p/i3+42VqdlxePKAqbCXxqW0dK+15MrRWo5U8529U4MV0y3ybkG2CjeukcAlLB7OOYum7XFPCMTV/M9qqjyXm9omS6losGTW9YFF2U+I4X64RgDmF6WKzM+KoSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795734; c=relaxed/simple;
	bh=SYOy+g7q+1YndFJQ9Uv0uA1/3OsQ/oiq2VOhLkT4V9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjpEtFydMTKb44EEUbq6MeIhin1mRswszRYwjgbxXOrvtEdXmom5UNJ7V2xWJj+JJQqFYSsYiSsVJeELsRlRIrOWekFDlwuxCOgRppeczJ/I2Lm7cvcF3LDBOGL23OuKgXyl0pGY0Fc7wLG6jXcalDrGsHF+tlJ+VK+L3ykOoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PIB4LRTN; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PIB4LRTN"
Date: Thu, 1 Feb 2024 14:55:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706795729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r46UKD56thpyzvkZXJNRet2Zqxn1/ZnhQXdea5m8esY=;
	b=PIB4LRTNhws1Rv3cHFumW+SkqThjaXC2/ol2Zc10oTHktQ33f1n7zn8OUHBGBMY0weL73G
	oJ2moXfcMxe/YOMVMJ0opgUC5QZ4Yg5vb1Z7PyJdNcMXtKEgGo6wogRfcSkAtorrRtK+PQ
	E0kC3A/jRqQ0w1nCj5wOxvHyR8O4bek=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Thomas Huth <thuth@redhat.com>
Cc: Marc Hartmayer <mhartmay@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Nico Boehr <nrb@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: Re: [kvm-unit-tests PATCH] (arm|powerpc|s390x): Makefile: add
 `%.aux.o` target
Message-ID: <20240201-db36a9fc61dee1115ab5ccb1@orel>
References: <20240125151127.94798-1-mhartmay@linux.ibm.com>
 <db6ac7f8-5a1e-4119-a48c-6c4b4e05cb27@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6ac7f8-5a1e-4119-a48c-6c4b4e05cb27@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 01, 2024 at 01:09:10PM +0100, Thomas Huth wrote:
> On 25/01/2024 16.11, Marc Hartmayer wrote:
> > It's unusual to create multiple files in one target rule, therefore create an
> > extra target for `%.aux.o` and list it as prerequisite. As a side effect, this
> > change fixes the dependency tracking of the prerequisites of
> > `.aux.o` (`lib/auxinfo.c` was missing).
> > 
> > Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > ---
> >   arm/Makefile.common     | 23 ++++++++++++-----------
> >   powerpc/Makefile.common | 10 +++++-----
> >   s390x/Makefile          |  9 +++++----
> >   3 files changed, 22 insertions(+), 20 deletions(-)
> 
> Patch looks sane to me, so I went ahead and pushed it to the git repo. Thanks!

I'll update the riscv port to make the same changes before merging it.

Thanks,
drew

> 
> By the way, unrelated to your modifications, but while testing it, I noticed
> that "make distclean" leaves some files behind for the s390x build:
> 
>  ./configure --arch=s390x --cross-prefix=s390x-linux-gnu-
>  make -j$(nproc)
>  make distclean
>  git status --ignored
> 
> On branch master
> Your branch is up to date with 'origin/master'.
> 
> Ignored files:
>   (use "git add -f <file>..." to include in what will be committed)
> 	.mvpg-snippet.d
> 	.sie-dat.d
> 	.spec_ex.d
> 	lib/auxinfo.o
> 	s390x/snippets/c/.cstart.d
> 	s390x/snippets/c/.flat.d
> 
> ... in case someone wants to have a look ...
> 
>  Thomas
> 
