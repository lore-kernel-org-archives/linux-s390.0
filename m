Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D503254B8;
	Thu, 24 Sep 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271667; cv=none; b=BQvomBsH9VRyBgRVgOn0mMjwdjmt9+1YJKRcDa1e3xfvgoMLL8DKeVR1Ry71NPN0p93C5zgPEDniUE0KBZ3haF1Bas3o/LhPa0A9Oup9Qz9yGPD1M4aMRTJVsnmsUQcPqxrkhhgpP8cKJHpHXMHWaFHBhk2RX95thvpp4BUwGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271667; c=relaxed/simple;
	bh=/P1NKi3khGcefSBIlWc4XAPrIBjMtR0WNL5+c6Wlq4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGqoUhGbgE5JmzPzvavOCxh2pi5sjCDqw7nirWm16e22DPcVCyhFU7rB8xJvgOB72RXVT7Qv6uFmqzU7KuaA7cMCEDGmrOOUrxDzUP1grt3mxx4prPCt4+VMtT388161o8FSwtKD1gTWm4HJ+pqPr/Czw/plrIn6zzbxcylxfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnsY865b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnsY865b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887921F000FF;
	Thu, 24 Sep 2026 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271666;
	bh=EYCIvHg8/lq0ByXIuBmYv9z2jqhplm90klgKW5c2/nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VnsY865bvqw/GV3PViUQTw/bjan1HvNlnREu6ByyJ/9uJGNbz8vJYuV4GBx125iVE
	 PMz5rVQRhMmoSVXUNpwRVBuQon2DllTW8nxO4wzeIxh/QICI1whg2AycGcrvM6a00p
	 rJ99a/9llyBOpc4TljUYTYdhRYuHiB+fzIx34TeKn0uq4c8yJBKEzYKJbPm2yKqXJh
	 tuLuy4AyqPL3T1rER8y/aE1zoA6vpFesr6DPXfga5qZHyq32jy2lFvateoQRi6+ci4
	 lBK5oNGxf8jL7Zj8s+eFhKCK1JpxfHm4kBCnKGK9IBtsk7o7LdBearnz736oQYXG2M
	 nynM//727O9Fw==
Date: Thu, 24 Sep 2026 19:41:03 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Jens Remus <jremus@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Improve callchain warning for s390
Message-ID: <arVgr9ex8aBRcy0-@x2>
References: <20260922144300.1217524-1-jremus@linux.ibm.com>
 <CAP-5=fUM6gb9MY9Sm=QhC+Tc4AFt2=fdLbr4tES++AMQcxryUQ@mail.gmail.com>
 <a79daeb6-394c-434a-8896-a1bd48337f8d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a79daeb6-394c-434a-8896-a1bd48337f8d@linux.ibm.com>

On Thu, Sep 24, 2026 at 11:40:11AM +0200, Thomas Richter wrote:
> On 9/23/26 18:37, Ian Rogers wrote:
> > On Tue, Sep 22, 2026 at 7:43 AM Jens Remus <jremus@linux.ibm.com> wrote:
> >> On s390 the kernel uses s390 back chain instead of frame pointers for
> >> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
> >> USER_STACKTRACE support").  This is because frame pointers on s390
> >> cannot be used for stack tracing. [1]
<SNIP>
> >> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> >> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

> > Acked-by: Ian Rogers <irogers@google.com>

> Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
