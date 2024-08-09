Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A4155CBD;
	Fri,  9 Aug 2024 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232785; cv=none; b=tWXg8p54sKBToMZKOYhEZTeGwrj4PDkWwI/oSrP4PbITjhyR0+79VlKt3SO6z8fWXJD4smlMrQlUlBihzNiGxVkO3n2wPenyT77RrRkmV0QNZJv3+2U8HFb5mc4XQupyZVsumvyYACvI1gjwuVKEpmV0F5+fI04I+K7LhJSYcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232785; c=relaxed/simple;
	bh=Wa6+LVZK7GjpVSYimnip9I24ZVbOUyjzWEg/k0NIWGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFUZm/E5hZUmQ25uRKPRwng+HcUGkdMPJzsOVkNywcVkOFLWxej5AN00r7MgPG3AxxB3REmGcEyFo9YZ/JzDpmpMpzdiOXri1qHSiS+RJvNKvwM/bHvmlwaEWbgyzCQ/85xrPtQnP9Xa0iU00Ylkh6v8q/d5FQFm6qroemFG04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7163489149eso1689348a12.1;
        Fri, 09 Aug 2024 12:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232783; x=1723837583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqbAJAIrn+pMqAdKgl2l3QmF9/bwlYdotJYVuqNwgjc=;
        b=YxKlZpXi8NTt5vLbqx+6MUlXB1X1OtQikDtXT7xbagzTnAvhUrvsa2LtEF9mgi8pwD
         8Z0OXA/b/P4SNTcTnW369fmxz5Dpqmn3xRozB9saKwStRxToZODJG8i69LWPGRXifGD4
         V5MFh0S+2HHBoA51xTvqnfiEicaa/RBGFrTKNLwYP9rR9CSK9xBXrvEaFyHYv65ROQ07
         NrkXEuQvfc9AlgPpNCKwBjGltkbWeTXei55HqqzWdMlX2EnfPVQxjXpO1P4hnnCgllxq
         2CL8M4jzZYhvBhWsyGaXD+n/EHz3Uo5X7rovUcwS833xxb/cyq3/0KKYKWmXlWeZaZUi
         8RQg==
X-Forwarded-Encrypted: i=1; AJvYcCXj+NxZw0bQGjaAZdxLXoRrBxla5l7eC00Fr4OUghy4mQHUJZ86eElhJ3yuw3Fw3nwIop24CISFWLm3YZd8Knl+VVUxjNd3F2YCvsNuBy+weJnBFRWhmayoWNs0g9aHPhCGkonTXd1tcQRn9Jq4mhntEltEgWVNgXbtwIWnjo3wxrQ2JXmUNdLwiF0=
X-Gm-Message-State: AOJu0YxhBjDwScn2hVOngRkpuKvurLDwL3TrX91elCF95jGUmMB+KYa4
	22Dlvo2mXVAHYJChA+KWuwhgFUJ8Eu3TH/K46LLftMRVF4+vod1Oe6pY2m1tVnXkbresOi03Rab
	iOmVl/oqO4d7qL+hqAGRV+5IR3NE=
X-Google-Smtp-Source: AGHT+IGt8uePCJBxT0xWwJtwoNYeffh75W4vVoECy88I+CFcKDV41N3GU4beyjUcCmxO+1WYu5Rw/yh0rvC5AJP3gCY=
X-Received: by 2002:a17:90b:2390:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2d1e804a8famr2857954a91.33.1723232782867; Fri, 09 Aug 2024
 12:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806225013.126130-1-namhyung@kernel.org> <ZrO5HR9x2xyPKttx@google.com>
 <F3C6DE61-8E10-4814-A6C0-C7569B3FD613@linux.vnet.ibm.com> <ZrUSCFLWDg9iJ_23@google.com>
 <56008678-7B06-4E54-8447-1C0DCBC15521@linux.vnet.ibm.com>
In-Reply-To: <56008678-7B06-4E54-8447-1C0DCBC15521@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Aug 2024 12:46:11 -0700
Message-ID: <CAM9d7ch5U1SvgEKiDB4djR70eps_zhaBSWa2guW9NJj6T4ehog@mail.gmail.com>
Subject: Re: [PATCHSET 00/10] perf tools: Sync tools and kernel headers for v6.11
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:39=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 9 Aug 2024, at 12:14=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
> >
> > Hello,
> >
> > On Thu, Aug 08, 2024 at 12:14:12PM +0530, Athira Rajeev wrote:
> >>
> >>
> >>> On 7 Aug 2024, at 11:42=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org=
> wrote:
> >>>
> >>> Hello folks,
> >>>
> >>> On Tue, Aug 06, 2024 at 03:50:03PM -0700, Namhyung Kim wrote:
> >>>> Hello,
> >>>>
> >>>> This is the usual sync up in header files we keep in tools directory=
.
> >>>> I put a file to give the reason of this work and not to repeat it in
> >>>> every commit message.  The changes will be carried in the perf-tools
> >>>> tree.
> >>>
> >>> Could you please double check what's in the tmp.perf-tools branch at =
the
> >>> perf-tools tree so I don't break build and perf trace for arm64, powe=
rpc
> >>> and s390?  It has this patchset + arm64 unistd header revert (accordi=
ng
> >>> to the discussion on patch 6/10) on top of v6.11-rc2.
> >>>
> >>> Thanks,
> >>> Namhyung
> >> Hi Namhyung,
> >>
> >> Can you please point to the tree. I checked in https://git.kernel.org/=
pub/scm/linux/kernel/git/acme/linux.git as well as https://git.kernel.org/p=
ub/scm/linux/kernel/git/perf/perf-tools-next.git , but didn=E2=80=99t find =
the changes. May be I am missing something. I am trying to check the build =
in powerpc.
> >
> > Oh, sorry about that.  It's in:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
> >
> > (no -next at the end)
>
> Hi,
>
> I did compile test on powerpc and results are good.
>
> Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks for doing this!
Namhyung
