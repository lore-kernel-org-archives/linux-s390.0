Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C524DCF6;
	Tue,  6 Oct 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246854; cv=none; b=KW+ssU1/dBLaH4wX/flRNJjByI5AxdJ6k4g06K0NWmKzT8gsBn3/SPcmZdfuBXC7h5GWVhgHaU1D8w7pOvF1k9eTYSAe6UdnmdRfKacAt/Ou59AkGEahLXmrGswG0omC9t/jxLuHPoMRhq6xq0L4HxKqaY585ladL10oLwE5s/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246854; c=relaxed/simple;
	bh=Rw1SY8dhu72CSJn6EV/D8V9Op5V/ywvtrqLoUQlLW7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d46qbgVKfXoLDbv79+YBtGyrYJBRb7HStz9x8dvqBDVSXSlI9+vmQjUKLZgTNvBYPAMOvpYVZU2DQhm2pj7cp3fc8VqsvWHMDafftgsYz4yNG9X9RdHBsQIhqyiSiSUQDYyYrZU2cY7qNaF1wM8ZRRzMKwCLwoFxl/DEBAvxLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn9tjIBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn9tjIBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EC81F00893;
	Tue,  6 Oct 2026 00:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246852;
	bh=1+oB4Dk9Nz32SmyUgCyqsv3kV1pN7+4MCshbGeWZ5w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bn9tjIBTxYA8QFZ079ngTgn4FIMWegFShRR2ZSoakVHud6ip4vSVgvW2mMShyf1HA
	 l+SVDWTxVwn6UsYwunbZxhBDemmGybU+WcqO87EscRrATE6cH9/o9/maWnQch6hL3x
	 gBPmRu5g71wUixoyjWv2QM4dQKRwe7e/tsuTgOYfDv0KzGI5scQIw2NIdzyu5mLfkL
	 F6jziGV0I4T+H/97It3ajGEb0EHmfiAjfoH/rUJPEIc9JDu16w2MNLto9iC5RFNKtB
	 WyI6X+Kf4OWeBFCEJ7UXD8bfuvVdTwokvC6WcuvaSsiRbSvANvRcK1hxVFk0GlJMGa
	 21oAOQ9dRgQdQ==
Date: Mon, 5 Oct 2026 17:34:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: netdev-bot+sinfo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] s390/ctcm: Fix timer corruption and
 use-after-free
Message-ID: <20261005173411.0d8d88d1@kernel.org>
In-Reply-To: <8737cb76-a399-4443-9ef6-f251cd23670a@linux.ibm.com>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
	<179075218956.31693.13833464260090345125@kernel.org>
	<8737cb76-a399-4443-9ef6-f251cd23670a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 13:36:13 +0530 Nagamani PV wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> > 
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> > 
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> > 
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.  
> 
> Both issues were identified through static code inspection / automated
> analysis (Sashiko code review) and confirmed by manual code review.
> They have not been triggered in production with an observed stack trace.

To be clear - the question is whether you triggered it _at all_
(validation), not whether they were hit in production (discovery).
If author does not bother to validate the trigger the patches are
usually not worth sending to LTS. Also - the Fixes tag on patch 1
looked sus, I changed it.
