Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102741991D0;
	Mon, 17 Jun 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648576; cv=none; b=YcNTiNgOjxMqNi3+yja4BuJ1pRW+Q2RdRxosM5bAe9HuZLuoB2kaPZLofW6r74Nj8/JhCyOW/UyHKWxrIU9/eEJ3TUofio5Oa2sMwUPxcZphK6Rh4c+Vop+w8lhrHnUTlcg3Ne8y2enJAPTa40Dp6zMeUaurHetqmPCnXBjhXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648576; c=relaxed/simple;
	bh=NCfs8+3fHX5/tKNCnEGfSHtJp8L4wyAuoa/GOOiGtoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS4x1zx8KxvM5KP3JLTuYKFIgHrsJclflQf0QnnF2nHOllrmrx4ZenAwWmHjO+1PyOSJ3GI3/iI15wfygNJmeZpcM46Y46IL4dpoys5RQXtdJC4k6GeXBnUr10RqYiB6Wxq0e1j/tNikKzilSAdh97PCht7ucnwdM0qzdSky724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYTKNQDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYTKNQDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7838C2BD10;
	Mon, 17 Jun 2024 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648575;
	bh=NCfs8+3fHX5/tKNCnEGfSHtJp8L4wyAuoa/GOOiGtoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYTKNQDkBo4oTu9itBH1S+qnTg9b9i6GMOgnDPStEM6Pa/BynSfWqQ3mgzbBtNcZ1
	 bhHhT78ngG45kzg9IIAZESHxq+jnZwKuJC4lP1pYyMV0t1ilAraGndXeTiFEdnpsHH
	 vT/vRStrwMYfu9Zxn1IkG1tK4uU4Fvj4vmdS1PVOLLSOKDGKi+laFMAMs1iqvDx9E/
	 GPCUHFVkoS1Unx6OZXfJJ1Vq+IE0rbmT2G6OQeHLi65iKl6JdERAaZ1bJRXF2hz22S
	 vl7GtpyBXdLLSFjhYQXmOrdVVgh7WwStO1Q0JZSINGTAwXILEhWJyEz2tU0p3/lfOl
	 KroXUSvl1cGKA==
Date: Mon, 17 Jun 2024 11:22:55 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Yuntao Liu <liuyuntao12@huawei.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, gustavoars@kernel.org, arnd@arndb.de,
	leobras@redhat.com, broonie@kernel.org, imbrenda@linux.ibm.com,
	pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Message-ID: <202406171122.B5FDA6A@keescook>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBbr2CAqBGDe2aN@J2N7QTR9R3>

On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:
> On Mon, Jun 17, 2024 at 01:37:21PM +0000, Yuntao Liu wrote:
> > Since the offset would be bitwise ANDed with 0x3FF in
> > add_random_kstack_offset(), so just remove AND operation here.
> > 
> > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> 
> The comments in arm64 and x86 say that they're deliberately capping the
> offset at fewer bits than the result of KSTACK_OFFSET_MAX() masking the
> value with 0x3FF.
> 
> Maybe it's ok to expand that, but if that's the case the commit message
> needs to explain why it's safe add extra bits (2 on arm64, 3 on s39 and
> x86), and those comments need to be updated accordingly.
> 
> As-is, I do not think this patch is ok.

Yeah, I agree: the truncation is intentional and tuned to the
architecture.

-- 
Kees Cook
