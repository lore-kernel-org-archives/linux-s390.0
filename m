Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9473175A60;
	Wed,  6 May 2026 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029054; cv=none; b=pMXQMMoFBpE+N4pCgMD1SXW78XboeU0v33jXb7ienjjbqAYu7P8mqWtfJXjfnduHN9nVArrHC+GAh4Lyg+72B2dJdap9BJ2ys3pBkYp6CTY5wMdb9epMc1jWpdIxBD0v4ipS0pQ0pkW1jHu1Zs9e6PHxLuyMokrveCxxPAES8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029054; c=relaxed/simple;
	bh=0Op78Ah5puy4U4angPPnUJIeqF1DFXq4ij+zA9WjIz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr5mAFnTAdNys5vjSdpzAGx5YIzZ3Po5mlmLfLRY+PISyrJZnAFJx56CuGnDFhItAVRL0hU8KCLA7bMq5Vfn7T/vioO2bx54HOqgKxccMDXc9baDDVTXRx49If78jl2XMgseHkfC4Ar6k7M6C2UIieGXgxUFUOaUQmh7JC/ejNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9YBMOzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9YBMOzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E47EC2BCC9;
	Wed,  6 May 2026 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029054;
	bh=0Op78Ah5puy4U4angPPnUJIeqF1DFXq4ij+zA9WjIz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9YBMOzlwL6e3AtVqHRLOgXNUuXXWoifsliF3f2DEkRJ9T8Sz3oq3ADb6ihkn4PXx
	 ii0qinty8vYFEkm2MBc3S9WrJq7NvX2w0RRjDlzelS8w8OLEcYPs0EMpyNUmW5Ksnn
	 p4HGxbiuqqmtAdUDV6YOEb7krVU1H3BnuKsxRRnrUYM2rHSSRtrXYmlKrDa6x6n7aM
	 6eVViKv2tVuC4geuFLxNDt7T++ovvE06B6FKFQ5Y3CGfpY5MLCauF1oJmPC56kpI5z
	 Yl3UAlcCbwVvJ/8UePMsw+HjceEhkUW6WRboqYx+kZ7NEXgqy6IZoNcw7OoWFsxK3E
	 NNVj1V5f5KyUQ==
Date: Tue, 5 May 2026 21:57:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
Message-ID: <afqR-mL5g26ar72N@x1>
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
 <aeemNo-8_RByiwvP@google.com>
 <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>
 <afLFGZcaEY2sW0ci@google.com>
 <56678675-cecd-4561-96d9-b1c0335dc841@linux.ibm.com>
 <afkwVAXmhApn5z_I@google.com>
 <79649f94-1ba5-44c7-a4c7-dcda8ae58b56@linux.ibm.com>
 <afnq38nWs-6wHinY@x1>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnq38nWs-6wHinY@x1>

On Tue, May 05, 2026 at 10:04:31AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 05, 2026 at 07:50:49AM +0200, Thomas Richter wrote:
> > On 5/5/26 01:48, Namhyung Kim wrote:
> > > On Mon, May 04, 2026 at 11:56:15AM +0200, Thomas Richter wrote:
> > >> On 4/30/26 04:57, Namhyung Kim wrote:
> > >>> On Wed, Apr 29, 2026 at 09:14:38AM +0200, Thomas Richter wrote:
 
> > >>>> is there something which needs to be done on my side to get this patch picked?
> > >>>> It still fails on s390.
 
> > >>>> Please adviseon how to proceed.
 
> > >>> Arnaldo will take care of 7.2 development cycle.
 
> > >> Today we are at v7.1-rc2. Does this mean the fix won't make it into v7.1 at all
> > >> and we have to wait roughly 2 month?
 
> > > Just out of curiousity, do you plan to use v7.1 for this feature
> > > specifically or just for test failures?  Probably better to use v7.2
> > > series (i.e. perf-tools-next) instead?
  
> > Right now I just care for failing test features. I am fine with 7.2
> > as long as it gets picked.
 
> I'll pick it soon.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
