Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66F39478E;
	Tue,  7 Apr 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546980; cv=none; b=YNVD/PkzVVMNCsVTI+7dUvSiUImL0aIJCixWfMSrSi+RmpxdllZ44Q4K+iYUWWQSBn1j8u2DDO2SvoAjZeo1NEbWJDd8w7dhQPOUtdupB5Det86l+ECgAuNFm7ueGPXVL7k8wz0NbZm/akV/pw2iFrjA7XAVYwsxhz4n6C1c5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546980; c=relaxed/simple;
	bh=tZgubB/NiNlETAYYEz7DbUECetQo2Lcj2AOFiEGoQ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ6GMa2SdmCn0sYonSrniIIvF9+7/qrElg69ERrbdFIJoOPP+NDS5Qbefi7lCsMZZrBeUPL9PRJfFfpPXs+XfnD7+m/4wSFrHJp4JEGu5JSlA90LoVHLqGCY9IsSK5A6tDUwaOqQcHX+0BxFd5GGAZgWEihTebZjnIyD/9doxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzA3nZHC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzA3nZHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59592C116C6;
	Tue,  7 Apr 2026 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775546979;
	bh=tZgubB/NiNlETAYYEz7DbUECetQo2Lcj2AOFiEGoQ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzA3nZHC+Cx+3xaP4Xo62Wqo0NStyC0mbCh0LZmdi+YqdwyakparUE90HeUmpsERV
	 8uwS+j2gWrygNCHuEZCn/FDC3NKejCKPdvNScjiLdgAGVnBQVCxKiblKXfq5n+LByv
	 fDQH/iWVeSedWRb4unmP6IU0zaBeAjBoXT/MJsDQQpmLng9Hp2d+aPWWVpouYSo6vI
	 y+vQztG81wUffqt4trUH/QS+Rf5Gum3GYPBVNpz8+HcpIHJaxsH0y5F9JlnXOcb3Xy
	 YBpy4yLWnl0ul++llV4DQdTCfDwQItavEyn2rN7Z+XGWhmxTmn0/Ci5U6NS01AcMBC
	 lZiJVEJmDNbOA==
Date: Tue, 7 Apr 2026 00:29:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2 1/3] perf config: Rename
 symbol_conf::disable_add2line_warn
Message-ID: <adSyYSyWdIl4Y3lJ@z2>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-2-tmricht@linux.ibm.com>
 <ac8hBOjxhiX-VtCl@google.com>
 <2718d162-2c51-41ce-9830-81366a1034e2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2718d162-2c51-41ce-9830-81366a1034e2@linux.ibm.com>

On Tue, Apr 07, 2026 at 08:50:57AM +0200, Thomas Richter wrote:
> On 4/3/26 04:08, Namhyung Kim wrote:
> > On Thu, Apr 02, 2026 at 10:01:57AM +0200, Thomas Richter wrote:
> >> Rename member symbol_conf::disable_add2line_warn to
> >> symbol_conf::addr2line_disable_warn to make it consistent with other
> >> addr2line_xxx constants.
> >> No functional change.
> >>
> >> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
> > 
> > I'm not sure if we want it for typo fixes.
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> 
> ...snip...
> 
> Do you want me to drop the Fixes: line or the complete rename patch?

Oh.. I meant the Fixes: line.

Thanks,
Namhyung

