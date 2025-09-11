Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5092299A94;
	Thu, 11 Sep 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623372; cv=none; b=THHyvQrTLENFQ+e3b1n2ZWni841McMrSNKkfPj0zGAV4Qx+szNajNVutSsTPdDO+yNmGuON1FqzLtyVrUa0xLK97Yfm0IbRkagSNJiWS3akpTDykxjo4REtui3RDtJuWss1qz5M9bQkwSWrn3lu7aTKf6wlQ64eFBDIWAnwFG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623372; c=relaxed/simple;
	bh=yKFoksqOnjhdBg3VMJYRRHTOnSUiSHGvaITeCwnt+/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4INiC0PXPPBZ7KXiQEcQK8Fg2beElS7w/wCKQAMWM729J8uEpFXBDPE8rJZM+Sk0LrPHYfE1NxopuPvk8UazcLfvnl/xx+ZSEabT3PWLvlenlaLu8UmkKIMaAGnlV+cJX1mjHvYi5OSDoTZW4NNkn2ous27liZFPROpnyaTztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POQG0Xu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POQG0Xu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E07C4CEF0;
	Thu, 11 Sep 2025 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757623371;
	bh=yKFoksqOnjhdBg3VMJYRRHTOnSUiSHGvaITeCwnt+/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POQG0Xu4BTTEOUBkrGfzOs586UxaKHSuEC1ZpyIEHN4BnWzfAvoMVrykFLk+J0JCk
	 sjCbrGso4NflF90OU+J5O3McLOjzhEdwHyzDGiZe5v8wi4K2ahWqnXzRyF8rcBtO4D
	 Isg/zzjv4Uw+WD4u7Px0ufqHjhcdm3T/LILYhTKobst30BaQLSZn1cPoSfoX0JVSp+
	 hp4FH+EhDhRYw7JXDGq+uG+kRf8uJqDEeltx+3WOtEoUqRNjYmMcW9EU89yOJUZeXI
	 9wVsxNHz21GEGXezklYJ6GKnv7pi/GKCti4oHiE5SPXOmpe6hSVhOkBOBW0RKTrW/r
	 IRjpUeHfZe12w==
Date: Thu, 11 Sep 2025 13:42:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
Message-ID: <20250911204246.GA69679@ax162>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162>
 <20250911145659.8894Dea-hca@linux.ibm.com>
 <20250911184429.GA2395987@ax162>
 <CANiq72kJ9L_Kpv9+z5=xZvbWxLRYXpKS-76XwwvQP+wMWsMJtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kJ9L_Kpv9+z5=xZvbWxLRYXpKS-76XwwvQP+wMWsMJtg@mail.gmail.com>

On Thu, Sep 11, 2025 at 09:04:36PM +0200, Miguel Ojeda wrote:
> On Thu, Sep 11, 2025 at 8:44 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > I do not think anyone really owns compiler_types.h so unless Miguel has
> > any objections from the compiler attributes perspective, I think you can
> > just take this via the s390 tree with the other two changes.
> 
> No objections from me, and thanks for spotting the OpenMP thing above.
> 
> I would say, though, that this is a fairly general and subtle tool to
> have around, so it would be nice to have others chime in. In other
> words, do we want to start using `assume`s? Should we constrain its
> use a bit, e.g. say its use should really be justified etc.? (In the
> Rust side, a tool like this would require a SAFETY comment on top with
> a justification, which may give a developer pause).

I do think justification at the source level (i.e., a comment) would be
a good baseline. I thought I remember a similar discussion around
likely() / unlikely() annotations since those should have some evidence
of benefit behind it. Applying the same policy to __assume() usage would
help ensure there is sufficient justification for adding and maintaining
such annotations, especially if they turn out to cause problems later.
Not sure if there should be a format standard like exists for SAFETY
comments but something is better than nothing.

Cheers,
Nathan
