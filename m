Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BD33EAEC;
	Tue,  5 May 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986275; cv=none; b=evAH3iK+d4N5s8aySrcXVqKKJL4J+spXt2X1NKE/+oBxf+TSsYXDvL9eiJqv6HDFUW0S5tHSkypMXSN2jz9vNnB7ajHJprH38FENtufUNEEHyWDx5uo2VbVj/sqQzOLRUw9+Vy/ZgNiBYw8mthz9d8a6Jpv/AbJLJ4V8HhLj0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986275; c=relaxed/simple;
	bh=5sCoqMx1Nd2osy9WxR0J8D9+Gycnnb9uutDAQeyQieQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqK2KlL+DIFoFvGeedHfNJFgLIdGFwhRu7ov4TOrZQmhnrkDamd/Q67m70xK1iM9IcMTSPk54CsaiJskD8WmHDGFGIMCJTrweBM0lBGRjNECQULm+858oOlw0hT4qlatwjbFRxqM7qWSnoT1WxExbakcAYza56LjmtEGnBVd0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipDn6Gj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipDn6Gj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0F5C2BCB9;
	Tue,  5 May 2026 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777986275;
	bh=5sCoqMx1Nd2osy9WxR0J8D9+Gycnnb9uutDAQeyQieQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipDn6Gj77cg3nVSwP4FRlBP0xUge4g9kC/sY35Z8dtToyoPqMjvANYbqsvxYzVQLH
	 bSVZJxtF0ksrFBYGI7gowAZ4xd6ysoyEG0k/PqoyfEKgnsWnwbtx4g7dtzJZ2meMPJ
	 Nhfxd90kqpRIQSjaupiibUqNI96LKlyjSohUBhAC/an/7JqYrx/qlzs2xwse2FuGiN
	 BnNWdQfAma5EavTwG1LCFy8/grYSleGntFZPfTzkk/qvVo8QH22uIjo6UGz3kPpCBp
	 uKcyWcBAuOgpjyIrJsSFq1TvZQeUOREFJ8uU1tslLj19KR0WUrIDjn/+G0YClQXq8i
	 Vm9xFF6i4TFpw==
Date: Tue, 5 May 2026 10:04:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
Message-ID: <afnq38nWs-6wHinY@x1>
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
 <aeemNo-8_RByiwvP@google.com>
 <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>
 <afLFGZcaEY2sW0ci@google.com>
 <56678675-cecd-4561-96d9-b1c0335dc841@linux.ibm.com>
 <afkwVAXmhApn5z_I@google.com>
 <79649f94-1ba5-44c7-a4c7-dcda8ae58b56@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79649f94-1ba5-44c7-a4c7-dcda8ae58b56@linux.ibm.com>

On Tue, May 05, 2026 at 07:50:49AM +0200, Thomas Richter wrote:
> On 5/5/26 01:48, Namhyung Kim wrote:
> > On Mon, May 04, 2026 at 11:56:15AM +0200, Thomas Richter wrote:
> >> On 4/30/26 04:57, Namhyung Kim wrote:
> >>> On Wed, Apr 29, 2026 at 09:14:38AM +0200, Thomas Richter wrote:
> >>>> Hi Namhyung,

> >>>> is there something which needs to be done on my side to get this patch picked?
> >>>> It still fails on s390.

> >>>> Please adviseon how to proceed.

> >>> Arnaldo will take care of 7.2 development cycle.

> >> Today we are at v7.1-rc2. Does this mean the fix won't make it into v7.1 at all
> >> and we have to wait roughly 2 month?

> > Just out of curiousity, do you plan to use v7.1 for this feature
> > specifically or just for test failures?  Probably better to use v7.2
> > series (i.e. perf-tools-next) instead?
 
> Right now I just care for failing test features. I am fine with 7.2
> as long as it gets picked.

I'll pick it soon.

- arnaldo
